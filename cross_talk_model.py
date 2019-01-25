import matplotlib
from functools import reduce
<<<<<<< HEAD
=======

>>>>>>> AktActivateErkInhibitTopology2
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec
import os, glob, pandas, numpy
import pickle
import site

site.addsitedir(r'/home/ncw135/Documents/pycotools3')
site.addsitedir(r'D:\pycotools3')

try:
    from pycotools import model, viz, tasks
except ImportError:
    from pycotools3 import model, viz, tasks

import tellurium as te
import seaborn
from collections import OrderedDict
from itertools import cycle
from decimal import Decimal, getcontext
from multiprocessing import Process, Pool, cpu_count
from collections import Counter

from cross_talk_model_string import CROSS_TALK_MODEL
from constants import *

"""
Idea: Simulate 100 models with random parameters. Record whether each model satisifies each condition. Or better 
yet, compute a semi RSS. Then use the values of the parameters to classify neural network for prediction of 
best parameters for satisfying certain conditions. 

Classifications = range(1, len(conditions)

"""

seaborn.set_style('white')
seaborn.set_context('talk', font_scale=1)


def load_model_with_pyco(ant, COPASI_FILENAME):
    """
    Load an antimony model into copasi using Pycotools wrapper around
    tellurium functions
    :param COPASI_FILENAME:
    :param ant:
    :return:
    """
    with model.BuildAntimony(COPASI_FILENAME) as loader:
        mod = loader.load(
            ant
        )
    return mod


def dose_response(model_string,
                  scan_parameter,
                  start_value,
                  end_value,
                  number_of_points,
                  selection,
                  log10=False
                  ):
    """
    Compute a dose response curve for the antimony model in `model_string`.
    :param model_string: Antimony model
    :param scan_parameter: Which model component to use as scan variable
    :param start_value: Starting value of scan
    :param end_value: End value of scan
    :param number_of_points: Number of intervals
    :param selection: Which model components to track. This is a list of model components. Strings are automatically
    converted into a 1 element list.
    :return:
    """
    mod = te.loada(model_string)
    mod.conservedMoietyAnalysis = True
    if not isinstance(selection, list):
        selection = [selection]

    p = te.SteadyStateScan(mod,
                           value=scan_parameter,
                           startValue=start_value,
                           endValue=end_value,
                           numberOfPoints=number_of_points,
                           selection=selection
                           )
    res = p.steadyStateSim()
    if log10:
        res[:, 0] = numpy.log10(res[:, 0])

    # print(res)
    fig = plt.figure()
    for i in range(len(selection)):
        plt.plot(res[:, 0], res[:, i + 1], label=selection[i], marker='o')
    seaborn.despine(fig=fig, top=True, right=True)
    plt.xlabel('Initial Conc. of {}'.format(scan_parameter))
    plt.ylabel(r'$nmol L^{-1}$')
    plt.legend(loc='best')
    return fig


def __dep__dose_response_for_growth_factors():
    """
    Now deprecated since GrowthFactors is now boolean
    Use the dose repsonse function to see the effect of changing the
    initial concentration of GrowthFactors. Plot some output
    :return:
    """
    l = [
        ['PI3K', 'pPI3K'],
        ['Mek', 'pMek'],
        ['Erk', 'pErk'],
        ['Akt', 'pAkt'],
        ['S6K', 'pS6K'],
    ]

    for i, j in l:
        # print(mod.model.keys())
        fig = dose_response(CROSS_TALK_MODEL, 'GrowthFactors', 1, 10000, 1000, [i, j])
        plt.title('Dose Response of {} and \n{} to GrowthFactors (log10 nM)'.format(i, j))
        fname = os.path.join(GRAPHS_DIRECTORY, 'GrowthFactorsDoseResponse{}.png'.format(i))
        fig.savefig(fname, dpi=150, bbox_inches='tight')
        # plt.show()


def add_event(model_string, event_str):
    model_string = model_string[:-5]
    event_str = "    " + event_str
    model_string += event_str
    model_string += "\nend;"
    return model_string


def add_serum_starve_event_remove_growth_factors(model_string):
    """
    Set growth factors to 0 at t=70.25 minutes
    :param model_string:
    :return:
    """
    event_str = "SerumStarveRemoveGrowthFactors: at (time>70.25): GrowthFactors=0;\n"
    model_string = add_event(model_string, event_str)
    return model_string


def add_serum_starve_event_remove_basal_TGFb(model_string):
    """
    Set growth factors to 0 at t=70.25 minutes
    :param model_string:
    :return:
    """
    event_str = "SerumStarveRemoveTGFb: at (time>70.25): TGFb=0;\n"
    model_string = add_event(model_string, event_str)
    return model_string


def add_TGFb_event(model_string):
    """
    Put 1 TGFb into simulation at t=4275
    :param model_string:
    :return:
    """
    event_str = "AddTGFb: at (time>71.250): TGFb=1;\n"
    model_string = add_event(model_string, event_str)
    return model_string


def add_MK_event(model_string, time):
    """
    Put 1 TGFb into simulation at t=4275
    :param model_string:
    :return:
    """
    event_str = "AddMK2206: at (time>{}): MK2206=1;\n".format(time)
    model_string = add_event(model_string, event_str)
    return model_string


def add_AZD_event(model_string, time):
    """
    Put 1 TGFb into simulation at t=4275
    :param model_string:
    :return:
    """
    event_str = "AddAZD: at (time>{}): AZD=1;\n".format(time)
    model_string = add_event(model_string, event_str)
    return model_string


def make_condition(model_string, condition, from_pickle=False):
    """
    Take the model string and create condition

    :param model_string: antimony model string
    :param GF: starting amount of GrowthFactors
    :param TGF: starting amount of tgf
    :param pretreatment: either 'AZD', or 'MK2206'. This is added as an event at the time specified by pretreatment time
    :param pretreatment_time: The time at which the variable specified by 'pretreatment' is added
    :param EV: Starting amount of Everolimus
    :param serum_starve_event: Boolean, whether to remove serum, aka GrowthFactors by event
    :param TGFb_event: Boolean. Whether to add 1 unit TGF at t=-45min (71.75h)
    :param open_with_copasi: open the model with copasi
    :return:
    """
    if from_pickle:
        if not os.path.isfile(PICKLE_PATH):
            raise ValueError('pickle path "{}" does not exist.'.format(PICKLE_PATH))

        with open(PICKLE_PATH, 'r') as f:
            models_dct = f.load()
        return models_dct[condition]

    if condition not in list(AZD_CONDITIONS.keys()) + list(MK_CONDITIONS.keys()):
<<<<<<< HEAD
        raise ValueError('No key. These keys "{}"'.format(list(AZD_CONDITIONS.keys())+list(MK_CONDITIONS.keys())))
=======
        raise ValueError('No key. These keys "{}"'.format(list(AZD_CONDITIONS.keys()) + list(MK_CONDITIONS.keys())))
>>>>>>> AktActivateErkInhibitTopology2
    try:
        GF, pretreatment, pretreatment_time, EV, serum_starve_event, TGFb_event = AZD_CONDITIONS[condition]
    except KeyError:
        GF, pretreatment, pretreatment_time, EV, serum_starve_event, TGFb_event = MK_CONDITIONS[condition]

    if serum_starve_event:
        model_string = add_serum_starve_event_remove_basal_TGFb(model_string)
        model_string = add_serum_starve_event_remove_growth_factors(model_string)

    if TGFb_event:
        model_string = add_TGFb_event(model_string)
    if pretreatment is not None:
        if pretreatment_time != 0:
            if pretreatment == 'AZD':
                model_string = add_AZD_event(model_string, pretreatment_time)
            elif pretreatment == 'MK2206':
                model_string = add_MK_event(model_string, pretreatment_time)
            else:
                raise ValueError

    mod = te.loada(model_string)
    # mod.model['init([TGFb])'] = TGF
    mod.Everolimus = EV
    mod.GrowthFactors = GF

    if pretreatment_time == 0:
        if pretreatment == 'AZD':
            mod.AZD = 1
        elif pretreatment == 'MK2206':
            mod.MK2206 = 1

    return mod.getCurrentAntimony()


def simulate_condition(model_string, condition):
    """
    :param model_string: antimony model string
    :param GF: starting amount of GrowthFactors
    :param pretreatment: either 'AZD', or 'MK2206'. This is added as an event at the time specified by pretreatment time
    :param pretreatment_time: The time at which the variable specified by 'pretreatment' is added
    :param EV: Starting amount of Everolimus
    :param serum_starve_event: Boolean, whether to remove serum, aka GrowthFactors by event
    :param TGFb_event: Boolean. Whether to add 1 unit TGF at t=-45min (71.75h)
    :return:
    """
    if condition not in list(AZD_CONDITIONS.keys()) + list(MK_CONDITIONS.keys()):
        raise ValueError

    model_string = make_condition(model_string, condition)
    mod = te.loada(model_string)
    ## Add 1 to intervals for 0 indexed python
    start = 0
    end = 75
    num = 751
    time = numpy.linspace(start, end, num)

    if 72.0 not in time:
        raise ValueError("Simulating conditions requires an output at exactly "
                         "72h after the first inhibitor. The current time steps "
                         "do not 'land' on 72.0 exactly - so pick different "
                         "simulation parameters. Also, remember that Python is "
                         "0 indexed, so try adding 1 to the number of "
                         " data points collected. To help, here is the current"
                         " time vector \n\n{}".format(time))

    res = mod.simulate(start, end, num, ['time'] + MODEL_SPECIES)

    df = pandas.DataFrame(res, columns=['time'] + MODEL_SPECIES)
    return df


def simulate_conditions(model_str=None, type='azd'):
    """
    Takes output from simulation and plot
    :param df:
    :return:
    """
    if model_str is None:
        model_str = CROSS_TALK_MODEL

    seaborn.set_context('talk', font_scale=2)
    if type not in ['AZD', 'MK2206']:
        raise ValueError

    if type == 'AZD':
        conditions = AZD_CONDITIONS
    elif type == 'MK2206':
        conditions = MK_CONDITIONS
    else:
        raise ValueError

    # from multiprocessing import Process

    dct = OrderedDict()
    for k, v in list(conditions.items()):
        # p = Process(target=simulate_condition, args=(tuple([CROSS_TALK_MODEL] + conditions[k])))
        # p.start()
        # p.join()
        df = simulate_condition(model_str, k)
        df = df[df['time'] == 72.0]
        if df.empty:
            raise ValueError("Condition '{}' with values '{}' produces an "
                             "empty data frame".format(k, v))

        dct[k] = df

    df = pandas.concat(dct)
    df.index = df.index.droplevel(1)
    df = df.drop('time', axis=1)

    return df


def simulate_conditions_and_plot_as_bargraph(y, type='AZD'):
    """
    Takes output from simulation and plot
    :param df:
    :return:
    """

    df = simulate_conditions(type=type)
    if y not in df.columns:
        raise ValueError('The variable "{}" does not appear in your model'.format(y))
    df = df.reset_index()
    df = df.rename(columns={'index': 'Condition'})

    fig = plt.figure()
    seaborn.barplot(x='Condition', y=y, data=df,
                    palette=['yellow'] * 2 + ['white'] * 1 + ['red'] * 4 + ['green'] * 4,
                    edgecolor='black', linewidth=2,
                    order=list(MK_CONDITIONS.keys()) if type == 'MK2206' else list(AZD_CONDITIONS.keys())
                    )
    plt.title(y)
    seaborn.despine(fig, top=True, right=True)
    plt.xticks(rotation=90, fontsize=18)
    plt.yticks(fontsize=18)

    if type == 'AZD':
        dire = os.path.join(GRAPHS_DIRECTORY, 'AZDSimulations')
    else:
        dire = os.path.join(GRAPHS_DIRECTORY, 'MKSimulations')
    os.makedirs(dire) if not os.path.isdir(dire) else None
    fname = os.path.join(dire, "{}.png".format(y))
    fig.savefig(fname, dpi=300, bbox_inches='tight')
    print(('line 485: Figure saved to "{}"'.format(fname)))
<<<<<<< HEAD

=======
>>>>>>> AktActivateErkInhibitTopology2


def simulate_all_conditions_and_plot_as_bargraphs():
    """
    Plot all bar graphs from simulations
    :return:
    """
    model_species = MODEL_SPECIES
    for i in model_species:
        simulate_conditions_and_plot_as_bargraph(i, 'AZD')
        simulate_conditions_and_plot_as_bargraph(i, 'MK2206')


def simulate_timecourse(type='MK2206'):
    """
    Events are used throughout the simulations.
    This function is for visualising the model inputs
    to visualise whether the events are correctly configured.
    :return:
    """
    if type not in ['AZD', 'MK2206']:
        raise ValueError

    if type == 'AZD':
        conditions = AZD_CONDITIONS
    elif type == 'MK2206':
        conditions = MK_CONDITIONS
    else:
        raise ValueError

    dct = OrderedDict()
    for k, v in list(conditions.items()):
        df = simulate_condition(CROSS_TALK_MODEL, k)
        dct[k] = df
    # print(dct)

    df = pandas.concat(dct)
    df.index = df.index.droplevel(1)
    df = df.set_index('time', append=True)
    df.index = df.index.rename(['condition', 'time'])

    return df


def plot_timecourse_single(vars, condition=None):
    if condition not in list(AZD_CONDITIONS.keys()) + list(MK_CONDITIONS.keys()):
        raise ValueError

    df = simulate_timecourse()
    for i in vars:
        if i not in df.columns:
            raise ValueError("Variable '{}' is not in '{}'".format(i, df.columns))
    df = df[vars]

    df = df.reset_index()

    if condition is None:
        condition = df['condition'].unique()

    df = df[df['condition'] == condition]

    fig_dct = {}

    for v in range(len(vars)):
        fig = plt.figure()
        seaborn.despine(fig=fig, top=True, right=True)
        plt.title("{} in {} condition".format(vars[v], condition))
        plt.xlabel('Time(h)')
        plt.ylabel('nmol L$^{-1}$')
        plt.plot(df['time'], df[vars[v]], label=vars[v])

        fig_dct["{}_{}".format(vars[v], condition)] = fig

    return fig


def plot_timecourse_multiplot(vars, condition=None, multifig_shape=None, AZD_or_MK='AZD'):
    # if condition not in AZD_CONDITIONS.keys() + MK_CONDITIONS.keys():
    #     raise ValueError

    if multifig_shape is not None:
        assert len(multifig_shape) == 2
        assert isinstance(multifig_shape, (tuple, list))

    if multifig_shape is None:
        multifig_shape = [vars, 1]

    if AZD_or_MK not in ['AZD', 'MK2206']:
        raise ValueError

    if AZD_or_MK == 'MK2206':
        if condition not in list(MK_CONDITIONS.keys()):
            raise ValueError

    elif AZD_or_MK == 'AZD':
        if condition not in list(AZD_CONDITIONS.keys()):
            raise ValueError('"{}" condition is not in "{}"'.format(condition, list(AZD_CONDITIONS.keys())))

    df = simulate_timecourse(AZD_or_MK)

    for i in vars:
        if i not in df.columns:
            raise ValueError("Variable '{}' is not in '{}'".format(i, df.columns))

    df = df[vars]

    df = df.reset_index()

    if condition is None:
        condition = df['condition'].unique()

    df = df[df['condition'] == condition]

    fig = plt.figure()
    ax = plt.subplot2grid(multifig_shape, [0, 0])

    cols = seaborn.color_palette("hls", len(vars))
    cols = iter(cols)

    for v in range(len(vars)):
        seaborn.set_context('talk')
        sub_ax = plt.subplot(*multifig_shape + [v + 1])
        plt.setp(sub_ax.get_xticklabels(), visible=False)
        # box = sub_ax.get_position()
        # sub_ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])

        seaborn.despine(ax=sub_ax, top=True, right=True)
        plt.yticks(fontsize=12)
        plt.suptitle(condition)
        plt.plot(df['time'], df[vars[v]], label=vars[v], color=next(cols))
        plt.legend(loc=(0.75, 0.5), bbox_to_anchor=(1.0, 0.5), fontsize=10)
        plt.xticks(numpy.arange(0, 72, 5.0), fontsize=12, rotation=90)

        plt.subplots_adjust(bottom=0.2, left=0.2, right=0.7)
        if v == len(vars) - 1:
            plt.xlabel('Time(h)')

    plt.setp(sub_ax.get_xticklabels(), visible=True)

    fig.text(0.05, 0.5, 'nmol L$^{-1}$', ha='center', va='center', rotation='vertical')

    return fig


def simulate_inputs_only(AZD_or_MK='AZD'):
    if AZD_or_MK not in ['AZD', 'MK2206']:
        raise ValueError

    dire = os.path.join(GRAPHS_DIRECTORY, 'InputSimulations')
    os.makedirs(dire) if not os.path.isdir(dire) else None

    if AZD_or_MK == 'AZD':
        conditions = list(AZD_CONDITIONS.keys())
    elif AZD_or_MK == 'MK2206':
        conditions = list(MK_CONDITIONS.keys())
    else:
        raise ValueError

    conditions = list(set(conditions))

    for cond in conditions:
        fig = plot_timecourse_multiplot(['TGFb', 'MK2206', 'Everolimus', 'AZD', 'GrowthFactors'],
                                        condition=cond, multifig_shape=[5, 1], AZD_or_MK=AZD_or_MK)

        fname = os.path.join(dire, "{}.png".format(cond))
        fig.savefig(fname, dpi=300, bobx_inches='tight')
        print(("Saved to '{}'".format(fname)))


def open_condition_with_copasi(model_string, condition):
    """
    create condition in copasi and open with CopasiUI
    :param condition:
    :return:
    """
    copasi_mod = create_condition_with_copasi(model_string, condition)
    params = get_parameters_from_copasi(copasi_mod)
    print(params)

    copasi_mod.open()


def create_condition_with_copasi(model_string, condition):
    """
    create copasi model from antimony string. Additionally
    setup a time course simulation
    :param model_string:
    :param condition:
    :return:
    """
    copasi_dir = os.path.join(COPASI_MODELS_DIR, condition)
    if not os.path.isdir(copasi_dir):
        os.makedirs(copasi_dir)

    copasi_file = os.path.join(copasi_dir, condition + '.cps')


    mod_string = make_condition(model_string, condition)
    copasi_mod = load_model_with_pyco(mod_string, copasi_file)

    global_params = copasi_mod.global_quantities
    free_params = [i.name for i in global_params if i.name[0] == '_']
    tasks.TimeCourse(copasi_mod, start=0, end=72, step_size=0.1, intervals=720, run=False)
    for i in DATA_FILES:
        print(i)

    PE = tasks.MultiParameterEstimation(copasi_mod,
                                        DATA_FILES,
                                        copy_number=1,
                                        pe_number=1,
                                        metabolites=['pAkt', 'Erk', 'Akt','Smad2','S6K', 'mTORC1',
                                                     'Raf', 'PI3K', 'Mek', 'pErk', 'ppErk',
                                                     'pSmad2', 'pS6K', 'pPI3K', 'pmTORC1',
                                                     'pMek', 'ppMek', 'pRaf'],
                                        global_quantities=free_params,
                                        run_mode=False,
                                        randomize_start_values=False,
                                        method='genetic_algorithm',
                                        # method='genetic_algorithm',
                                        number_of_generations=500,
                                        population_size=50,
                                        iteration_limit=500,
                                        swarm_size=75,
                                        overwrite_config_file=True,
                                        lower_bound=0.01,
                                        upper_bound=100
                                        )
    PE.write_config_file()
    PE.setup()
    # PE.run()

    # PE.model.open()
    copasi_mod = PE.model

    return copasi_mod


def configure_parameter_estimation_fake_steady_state(model_string, condition):
    mod_string = make_condition(model_string, condition)
    copasi_dir = os.path.join(WORKING_DIRECTORY, 'copasi_models')
    if not os.path.isdir(copasi_dir):
        os.makedirs(copasi_dir)
    fname = os.path.join(copasi_dir, "{}.cps".format(condition))
    copasi_mod = load_model_with_pyco(mod_string, fname)
    tasks.TimeCourse(copasi_mod, start=0, end=72, step_size=0.1, intervals=720, run=False)
    f1 = r'D:\MesiSTRAT\CrossTalkModel\copasi_models\fakeSteadyStateData.txt'
    f2 = r'D:\MesiSTRAT\CrossTalkModel\copasi_models\Smad2.txt'
    assert os.path.isfile(f1)
    assert os.path.isfile(f2)
    # copasi_mod.open()
    PE = tasks.ParameterEstimation(copasi_mod, [f1, f2], metabolites=[], run_mode=False,
                                   experiment_type=['steadystate', 'steadystate'],
                                   overwrite_config_file=False,
                                   )
    PE.write_config_file()
    PE.setup()
    return PE.model


def configure_parameter_estimation(copasi_mod,
                                   copy_number=1,
                                   pe_number=1,
                                   method='genetic_algorithm',
                                   population_size=200,
                                   overwrite_config_file=True,
                                   number_of_generations=500):
    if isinstance(copasi_mod, str):
        copasi_mod = model.Model(copasi_mod)
    elif isinstance(copasi_mod, model.Model):
        pass
    else:
        raise ValueError

    global_params = copasi_mod.global_quantities
    free_params = [i.name for i in global_params if i.name[0] == '_']

    # copasi_mod.open()
    PE = tasks.MultiParameterEstimation(copasi_mod,
                                        DATA_FILES,
                                        copy_number=copy_number,
                                        pe_number=pe_number,
                                        metabolites=[],
                                        global_quantities=free_params,
                                        run_mode=False,
                                        method=method,
                                        number_of_generations=number_of_generations,
                                        population_size=population_size,
                                        overwrite_config_file=overwrite_config_file,
                                        lower_bound=0.001,
                                        upper_bound=1000
                                        )
    PE.write_config_file()
    PE.setup()
    PE.run()
    return PE

def run_pycotools_viz(copasi_file):
    PE = configure_parameter_estimation(copasi_file, run_mode=False)
    # viz.Boxplots(PE, savefig=True, log10=True, num_per_plot=30)
    # viz.LikelihoodRanks(PE, savefig=True)
    PE.model.insert_parameters(parameter_path=PE.results_directory, index=0, inplace=True)
    PE.model.open()


def simulate_model_component_timecourse(vars, cond, filename=None, **kwargs):
    """
    Simulate variables in vars in conditions in cond and plot on one plot
    :param var:
    :param cond:
    :return:
    """
    seaborn.set_context('talk', font_scale=2)
    if isinstance(vars, str):
        vars = [vars]

    if isinstance(cond, str):
        cond = [cond]

    for i in vars:
        if i not in MODEL_SPECIES:
            raise ValueError("model species '{}' is not in '{}'".format(i, MODEL_SPECIES))

    if kwargs.get('figsize') is not None:
        figsize = kwargs['figsize']
        del kwargs['figsize']
    else:
        figsize = (2 * len(cond), 3 * len(cond))

    cols = seaborn.color_palette("hls", len(vars)) * len(cond)
    cols = iter(cols)

    fig = plt.figure(figsize=figsize)
    for i, c in enumerate(cond):
        if c not in list(MK_CONDITIONS.keys()) + list(AZD_CONDITIONS.keys()):
<<<<<<< HEAD
            raise ValueError('condition "{}" not in "{}"'.format(c, list(MK_CONDITIONS.keys()) + list(AZD_CONDITIONS.keys())))
=======
            raise ValueError(
                'condition "{}" not in "{}"'.format(c, list(MK_CONDITIONS.keys()) + list(AZD_CONDITIONS.keys())))
>>>>>>> AktActivateErkInhibitTopology2

        model_str = make_condition(CROSS_TALK_MODEL, c)
        mod = te.loada(model_str)
        res = mod.simulate(0, 72, 73, ['time'] + vars)
        gs = GridSpec(len(cond), 1, wspace=0.3)
        ax = []
        for j, v in enumerate(vars):
            ax.append(fig.add_subplot(gs[i, 0]))
            ax[-1].plot(res['time'], res[v], label=v, color=next(cols), linewidth=6, **kwargs)

        plt.axvline(0.0, linestyle='--', linewidth=2, color='black', alpha=0.4)
        plt.axvline(24.0, linestyle='--', linewidth=2, color='black', alpha=0.4)
        plt.axvline(48.0, linestyle='--', linewidth=2, color='black', alpha=0.4)
        plt.axvline(70.25, linestyle='--', linewidth=2, color='green', alpha=0.4)
        plt.axvline(71.25, linestyle='--', linewidth=2, color='purple', alpha=0.4)
        plt.axvline(72.0, linestyle='--', linewidth=2, color='black', alpha=0.4)

        plt.setp(ax[-1].get_xticklabels(), visible=False)
        seaborn.despine(ax=ax[-1], top=True, right=True)
        plt.title(c)
    if i == len(cond):
        plt.xlabel('Time(h)')

    fig.text(0.025, 0.5, 'nmol L$^{-1}$', ha='center', va='center', rotation='vertical')
    plt.legend(loc=[1, 1])
    plt.setp(ax[-1].get_xticklabels(), visible=True)

    dire = os.path.join(GRAPHS_DIRECTORY, 'TimeSeriesSimulations')
    os.makedirs(dire) if not os.path.isdir(dire) else None
    if filename is None:
        fname = os.path.join(dire, reduce(lambda x, y: "{}__{}".format(x, y), cond) + '.png')
    else:
        fname = os.path.join(dire, filename)

    plt.savefig(fname, dpi=250, bbox_inches='tight')


def get_parameters_from_copasi_in_antimony_format(condition):
    copasi_dir = os.path.join(WORKING_DIRECTORY, 'copasi_models')
    fname = os.path.join(copasi_dir, "{}.cps".format(condition))
    sbml = os.path.join(copasi_dir, "{}.sbml".format(condition))
    pm = model.Model(fname)
    pm.to_sbml(sbml)
    mod = te.loadSBMLModel(sbml)
    print((te.getCurrentAntimony(mod)))
<<<<<<< HEAD

def get_model_parameters(mod):
    return dict(list(zip(mod.getGlobalParameterIds(), mod.getGlobalParameterValues())))
=======


def get_parameters_from_copasi(mod):
    # make_condition(CROSS_TALK_MODEL, CURRENT_MODEL_CODE )
    # pm = model.Model(copasi_file)
    assert isinstance(mod, model.Model)
    sbml = mod.copasi_file[:-4] + '.sbml'
    mod.to_sbml(sbml)
    mod = te.loadSBMLModel(sbml)
    print((mod, type(mod)))
    print((mod.getCurrentAntimony()))
    # print(te.getCurrentAntimony(mod))


def get_model_parameters(mod):
    return dict(list(zip(mod.getGlobalParameterIds(), mod.getGlobalParameterValues())))

>>>>>>> AktActivateErkInhibitTopology2

class Inequality(object):
    def __init__(self, left, operator, right, name):
        """

        :param left: [cond, species]
        :param operator: '>' or '<'
        :param right: [cond, species]
        """
        self.left = left
        self.operator = operator
        self.right = right
        self.name = name

    def evaluate(self, df):
        left = df.loc[self.left[0], self.left[1]]
        right = df.loc[self.right[0], self.right[1]]
        if self.operator == '>':
            return left > right
        elif self.operator == '<':
            return left < right

    def __str__(self):
        return 'Inequality(left="{}", operator="{}", right="{}", name="{}")'.format(
            self.left, self.operator, self.right, self.name
        )

    def __repr__(self):
        return self.__str__()


class InequalityGroup(object):
    def __init__(self, inequalities):
        self.inequalities = inequalities

        for ineq in self.inequalities:
            self.__dict__[ineq.name] = ineq

    def __iter__(self):
        return self

    def __getitem__(self, item):
        return self.__dict__[item]

    def __setitem__(self, key, value):
        self.__dict__[key] = value

    def __delitem__(self, key):
        del self.__dict__[key]

    def __next__(self):
        count = 0
        if count > self.__len__():
            raise StopIteration
        else:
            count += 1
            return list(self.inequalities.keys())[count]

    def inequality_keys(self):
        return cycle(list(range(len(self))))

    @property
    def names(self):
        return [i.name for i in self.inequalities]

    def evaluate(self, df):
        eval_dct = OrderedDict()
        for ineq in self.inequalities:
            if not isinstance(ineq, Inequality):
                raise ValueError

            ev = ineq.evaluate(df)
            eval_dct[ineq.name] = ev

        return eval_dct

    def __len__(self):
        return len(self.inequalities)


class OptimizeQualitative(object):
    pandas.set_option('precision', 24)
    getcontext().prec = 24

    @property
    def condition_list(self):
        return cycle(self.inequality_group.names)

    def __init__(self, model_string, free_parameters,
                 inequality_group, exp_data, delta, iterations=10
                 ):
        self.model_string = model_string
        self.free_parameters = free_parameters
        self.exp_data = exp_data
        self.inequality_group = inequality_group
        self.delta = delta
        self.fname_param = os.path.join(WORKING_DIRECTORY, 'parameters.csv')
        self.fname_prob = os.path.join(WORKING_DIRECTORY, 'prob.csv')
        self.iterations = iterations

        self.mod = self.load_model()

    def load_model(self):
        return te.loada(self.model_string)

    @staticmethod
    def simulate_condition(model_string, condition):
        if condition not in list(AZD_CONDITIONS.keys()) + list(MK_CONDITIONS.keys()):
            raise ValueError

        model_string = make_condition(model_string, condition)
        mod = te.loada(model_string)
        ## Add 1 to intervals for 0 indexed python
        start = 0
        end = 75
        num = 751
        time = numpy.linspace(start, end, num)

        if 72.0 not in time:
            raise ValueError("Simulating conditions requires an output at exactly "
                             "72h after the first inhibitor. The current time steps "
                             "do not 'land' on 72.0 exactly - so pick different "
                             "simulation parameters. Also, remember that Python is "
                             "0 indexed, so try adding 1 to the number of "
                             " data points collected. To help, here is the current"
                             " time vector \n\n{}".format(time))

        res = mod.simulate(start, end, num, ['time'] + MODEL_SPECIES)

        df = pandas.DataFrame(res, columns=['time'] + MODEL_SPECIES)
        df = df[df['time'] == 72.0]
        if df.empty:
            raise ValueError("Condition '{}' produces an "
                             "empty data frame".format(condition))
        return df

    def _simulate_conditions(self, model_str, conditions=None):
        """
        Takes output from simulation and plot
        :param df:
        :return:
        """
        if conditions is None:
            conditions = list(set(list(AZD_CONDITIONS.keys()) + list(MK_CONDITIONS.keys())))

        dct = OrderedDict()
        for cond in conditions:
            df = self.simulate_condition(model_str, cond)
            df = df[df['time'] == 72.0]
            dct[cond] = df

        df = pandas.concat(dct)
        df.index = df.index.droplevel(1)
        df = df.drop('time', axis=1)
        return df

    def _evaluate_inequalities(self, df):
        self.inequality_group.evaluate(df)
        return self.inequality_group.memory

    def _check_if_all_conditions_eval_to_true(self, inequality_dct):
        if inequality_dct is None:
            return None

        if not isinstance(inequality_dct, (dict, None)):
            raise TypeError("Argument should be a dictionary. Got a '{}' instead.".format(type(inequality_dct)))

        if all(inequality_dct.values()):
            ## return if all values are True
            print('all conditions are met')
            print((self.free_parameters))
            return True
        else:
            return False

    def _peterb_parameter(self, mod, param):
        old = self.free_parameters[param]
        peterb_amount = numpy.random.normal(0, 0.1 * old, 1)[0]
        assert peterb_amount < old, "peterb amount must be smaller than old value otherwise risk getting negative values"
        new_parameter_value = old + peterb_amount
        assert new_parameter_value > 0, "Be positive"
        setattr(mod, param, new_parameter_value)
        print(('old parameter value is "{}". New is "{}"'.format(old, new_parameter_value)))
        return mod, new_parameter_value

    def _load_parameters_from_dict(self, free_params):
        for i in free_params:
            setattr(self.mod, i, free_params[i])

    def fit(self):
        """

        :return:
        """
        ## if all conditions are satisified, return
        df = self._simulate_conditions(self.model_string)
        ineq_memory = self._evaluate_inequalities(df)
        if self._check_if_all_conditions_eval_to_true(ineq_memory['new']):
            self.save_parameters_and_prob_to_file()
            return self.free_parameters, self.probability_matrix

        # mod = te.loada(self.model_string)
        for i in range(self.iterations):
            print(('\nIteration {}'.format(i)))
            ## load self.free_parameters back into the model
            self._load_parameters_from_dict(self.free_parameters)
            # print(zip(self.mod.getGlobalParameterIds(), self.mod.getGlobalParameterValues()))
            current_condition = next(self.condition_list)
            ## choose one parameter to peterb, based on probabilities
            choice = numpy.random.choice(list(self.free_parameters.keys()),
                                         p=self.probability_matrix[current_condition].values)

            # print('Current choice is "{}", value "{}"'.format(choice, getattr(self.mod, choice)))
            self.mod, new_parameter_value = self._peterb_parameter(self.mod, choice)
            df = self._simulate_conditions(self.mod.getCurrentAntimony())
            ineq_memory = self._evaluate_inequalities(df)

            if self._check_if_all_conditions_eval_to_true(ineq_memory['new']):
                self.save_parameters_and_prob_to_file()
                return self.free_parameters, self.probability_matrix

            for k in list(ineq_memory['old'].keys()):
                if ineq_memory['old'][k] != ineq_memory['new'][k]:
<<<<<<< HEAD
                    print(('ineq "{}" changed from "{}" to "{}"'.format(k, ineq_memory['old'][k], ineq_memory['new'][k])))
=======
                    print(
                        ('ineq "{}" changed from "{}" to "{}"'.format(k, ineq_memory['old'][k], ineq_memory['new'][k])))
>>>>>>> AktActivateErkInhibitTopology2

            print(('old count: {}'.format(Counter(list(ineq_memory['old'].values())))))
            print(('new count: {}'.format(Counter(list(ineq_memory['new'].values())))))

            old_parameter_value = self.free_parameters[choice]

            for cond, boolean in list(ineq_memory['new'].items()):
                # print ('cond={}, cond {}, ineq_memory old "{}", ineq_memory new "{}" eq {}'.format(
                #     cond,
                #     boolean,
                #     ineq_memory['old'][cond],
                #     ineq_memory['new'][cond],
                #     (ineq_memory['old'][cond] == False) and (ineq_memory['old'][cond] == True)
                # ))
                if (ineq_memory['old'][cond] == False) and (ineq_memory['new'][cond] == True):
                    print(("Positively reinforcing '{}' parameter as changing it from '{}' to '{}' "
<<<<<<< HEAD
                          "changed the '{}' condition from False to True".format(
=======
                           "changed the '{}' condition from False to True".format(
>>>>>>> AktActivateErkInhibitTopology2
                        choice, old_parameter_value, new_parameter_value, cond
                    )))
                    self._update_probabilities(cond, choice, 'positive_reinforcement')
                    self.free_parameters[choice] = new_parameter_value

                elif (ineq_memory['old'][cond] == True) and (ineq_memory['new'][cond] == False):
                    print(("Negatively reinforcing '{}' parameter as changing it from '{}' to '{}' "
<<<<<<< HEAD
                          "changed the '{}' condition from True to False".format(
=======
                           "changed the '{}' condition from True to False".format(
>>>>>>> AktActivateErkInhibitTopology2
                        choice, old_parameter_value, new_parameter_value, cond
                    )))
                    self._update_probabilities(cond, choice, 'negative_reinforcement')

        self.save_parameters_and_prob_to_file()
        print((self.free_parameters))
        return self.free_parameters, self.probability_matrix


class Mapping(object):
    def __init__(self, experimental, simulation):
        self.experimental = experimental
        self.simulation = simulation

    def __str__(self):
        return ("({}, {})".format(self.experimental, self.simulation))


# class MappingGroup(object):
#     def __init__(self, mappings):
#         self.mappings = mappings
#
#     def __iter__(self):
#         return self
#
#     def __nex


class RSS(object):
    def __init__(self, simulated_data, experimental_data, mappings):
        self.simulated_data = simulated_data
        self.experimental_data = experimental_data
        self.mappings = mappings

        # self.residuals = self._compute()
        # self.rss = self.residuals.sum().sum()

    def _compute(self):
        dct = OrderedDict()
        for i in self.mappings:
            exp = i.experimental
            sim = i.simulation
            # print(sim, exp)
            experimental = self.experimental_data[exp]
            # print(experimental)
            simulated = self.simulated_data[sim]
            # print(simulated)
            dct[sim] = (experimental - simulated) ** 2
        return pandas.concat(dct, axis=1)


class QualitativeObj(object):
    """

    """

    def __init__(self, simulated_data, inequalities):
        self.simulated_data = simulated_data
        self.inequalities = inequalities
        # print(self.simulated_data)
        # print(self.inequalities)

        self.residuals = self._compute()
        self.residual_values = numpy.array(list(self.residuals.values()))
        self.negative_loss = sum([i for i in self.residual_values if i < 0])
        self.positive_loss = sum([i for i in self.residual_values if i > 0])

    def __str__(self):
        return 'QualitativeObj(positive_loss={}, negative_loss={})'.format(self.positive_loss, self.negative_loss)

    def __repr__(self):
        return self.__str__()

    def _compute(self):
        """
        Value of 0 means that inequality is satisified
        +ve value means that left is bigger than right
        -ve value means that left is smaller than right
        :return:
        """
        obj = OrderedDict()
        dct = self.inequalities.evaluate(self.simulated_data)
        for k, v in list(dct.items()):

            if v == True:
                obj[k] = 0
            else:
                ineq = self.inequalities[k]
                ## left is always small
                if ineq.operator == '<':
                    left = self.simulated_data.loc[ineq.right[0], ineq.right[1]]
                    right = self.simulated_data.loc[ineq.left[0], ineq.left[1]]
                else:
                    left = self.simulated_data.loc[ineq.left[0], ineq.left[1]]
                    right = self.simulated_data.loc[ineq.right[0], ineq.right[1]]

                obj[k] = right - left
        return obj


class RandomSimulation(object):
    """

    I am trying to produce some simulation data for anaysis with a neural net.

    To do this I need to:
        1) simulate data with parameter set
        2) evaluate truth of inequalities
            - Also compute the qualitative objecctive function
            - 0 if True and +/- if not
        3) return dataset including the parameters and the inequality results.


    """

    def __init__(self, model_string, exp_data, inequalities, mappings, free_parameters, iterations):
        self.model_string = model_string
        self.exp_data = exp_data
        self.inequalities = inequalities
        self.mappings = mappings
        self.free_parameters = free_parameters
        self.iterations = iterations

        self.model = self._load_model()

        self.params = {}
        self.resid = {}

        self.fname_params = os.path.join(WORKING_DIRECTORY, 'parameters.csv')
        self.fname_resid = os.path.join(WORKING_DIRECTORY, 'residuals.csv')

    def _load_model(self):
        return te.loada(self.model_string)

    def _simulate_condition(self, condition):
        if condition not in list(AZD_CONDITIONS.keys()) + list(MK_CONDITIONS.keys()):
            raise ValueError

        model_string = make_condition(self.model.getCurrentAntimony(), condition)
        mod = te.loada(model_string)
        ## Add 1 to intervals for 0 indexed python
        start = 0
        end = 72
        num = 73
        time = numpy.linspace(start, end, num)

        if 72.0 not in time:
            raise ValueError("Simulating conditions requires an output at exactly "
                             "72h after the first inhibitor. The current time steps "
                             "do not 'land' on 72.0 exactly - so pick different "
                             "simulation parameters. Also, remember that Python is "
                             "0 indexed, so try adding 1 to the number of "
                             " data points collected. To help, here is the current"
                             " time vector \n\n{}".format(time))

        res = mod.simulate(start, end, num, ['time'] + MODEL_SPECIES)

        df = pandas.DataFrame(res, columns=['time'] + MODEL_SPECIES)
        df = df[df['time'] == 72.0]
        if df.empty:
            raise ValueError("Condition '{}' produces an "
                             "empty data frame".format(condition))
        return df

    def _simulate_conditions(self, conditions=None):
        """
        Takes output from simulation and plot
        :param df:
        :return:
        """
        if conditions is None:
            conditions = list(set(list(AZD_CONDITIONS.keys()) + list(MK_CONDITIONS.keys())))

        dct = OrderedDict()
        for cond in conditions:
            df = self._simulate_condition(cond)
            df = df[df['time'] == 72.0]
            dct[cond] = df

        df = pandas.concat(dct)
        df.index = df.index.droplevel(1)
        df = df.drop('time', axis=1)
        return df

    def _compute_obj_fun(self, sim_data):
        sim_names = [i.simulation for i in self.mappings]
        exp_names = [i.experimental for i in self.mappings]
        sim_data = sim_data[sim_names]
        qual = QualitativeObj(sim_data, self.inequalities)
        return qual

    @staticmethod
    def _load_parameters_from_dict(mod, free_params):
        if not isinstance(free_params, dict):
            raise TypeError
        for i in free_params:
            setattr(mod, i, free_params[i])
        return mod

    def fit1(self, i):
        # params = {}
        # resid = {}
        new_params = numpy.random.uniform(0.01, 1000, len(self.free_parameters))
        new_params = OrderedDict(list(zip(list(self.free_parameters.keys()), new_params)))
        self.model = self._load_parameters_from_dict(self.model, new_params)
        sim_data = self._simulate_conditions()
        obj = self._compute_obj_fun(sim_data)
        # params[i] = new_params
        # resid[i] = obj.residuals
        return new_params, obj.residuals  # params, resid

    def to_file(self, params, resid):
        if os.path.isfile(self.fname_params):
            with open(self.fname_params, 'a') as f:
                params.to_csv(f, header=False)
        else:
            params.to_csv(self.fname_params)

        if os.path.isfile(self.fname_resid):
            with open(self.fname_resid, 'a') as f:
                resid.to_csv(f, header=False)
        else:
            resid.to_csv(self.fname_resid)

        print(('parameters saved to "{}"'.format(self.fname_params)))
        print(('residuals saved to "{}"'.format(self.fname_resid)))
<<<<<<< HEAD

=======
>>>>>>> AktActivateErkInhibitTopology2

    def fit(self):
        import time
        resid = {}
        params = {}

        try:
            for i in (j for j in range(self.iterations)):
                print(('iteration {}'.format(i)))
                now = time.clock()
                params[i], resid[i] = self.fit1(i)
                print(("loop took '{}' seconds".format(time.clock() - now)))

        except KeyboardInterrupt:
            print('Warning: Keyboard Interupt. Saving progress.')

        params = pandas.DataFrame(params).transpose()
        resid = pandas.DataFrame(resid).transpose()

        self.to_file(params, resid)

        return params, resid


if __name__ == '__main__':
    """
    Set flags to determine which part of the script will run
    """

    if GET_PARAMETERS_FROM_COPASI:
        # get_parameters_from_copasi_in_antimony_format(MODEL_CODE)
        print('These parameters are from "{}"'.format(OTHER_COPASI_MODEL))
        mod = model.Model(OTHER_COPASI_MODEL)
        get_parameters_from_copasi(mod)

    if OPEN_CONDITION_WITH_COPASI:
        open_condition_with_copasi(CROSS_TALK_MODEL, CURRENT_MODEL_CODE)

    if PARAMETER_ESTIMATION:

        mod = create_condition_with_copasi(CROSS_TALK_MODEL, CURRENT_MODEL_CODE)
        assert isinstance(mod, model.Model)
        PE = configure_parameter_estimation(
            mod,
            copy_number=250
        )
        PE.model.open()


    if RUN_PYCOTOOLS_VIZ:
        run_pycotools_viz(FIT_COPASI_FILE)
        mod = create_condition_with_copasi(CROSS_TALK_MODEL,CURRENT_MODEL_CODE)


    if SIMULATE_TIME_SERIES:
        for i in CURRENT_SPECIES:
<<<<<<< HEAD
            simulate_model_component_timecourse([i], list(AZD_CONDITIONS.keys()), filename='AZD_'+i)
            simulate_model_component_timecourse([i], list(MK_CONDITIONS.keys()), filename='MK_'+i)
=======
            simulate_model_component_timecourse([i], list(AZD_CONDITIONS.keys()), filename='AZD_' + i)
            simulate_model_component_timecourse([i], list(MK_CONDITIONS.keys()), filename='MK_' + i)
>>>>>>> AktActivateErkInhibitTopology2

    if SIMULATE_BAR_GRAPHS:
        # for i in ['AZD', 'MK2206']:
        for i in ['MK2206', 'AZD']:
            for j in CURRENT_SPECIES:
                simulate_conditions_and_plot_as_bargraph(j, i)

    if SIMULATE_INPUTS:
        simulate_inputs_only('AZD')
        simulate_inputs_only('MK2206')

    if not os.path.isdir(GRAPHS_DIRECTORY):
        os.makedirs(GRAPHS_DIRECTORY)

    if GET_ODES_WITH_ANTIMONY:
        mod = te.loada(CROSS_TALK_MODEL)
        odes = te.utils.misc.getODEsFromModel(mod)
        print(odes)

    if GET_MODEL_AS_SBML:
        sbml = te.antimonyToSBML(CROSS_TALK_MODEL)
        print(sbml)

    if DOSE_RESPONSE_TGFB:
        fig = dose_response(CROSS_TALK_MODEL, 'TGFb', 0.01, 1000, 100, ['TGFbR'])
        plt.show()

    if QUALITATIVE_FITTING:
        model_string = CROSS_TALK_MODEL

        azd_data = os.path.join(WORKING_DIRECTORY, r'data\HardCopy\AZD_calculations - v3.xlsx')
        mk_data = os.path.join(WORKING_DIRECTORY, r'data\HardCopy\MK2206_calculations - v3.xlsx')

        assert os.path.isfile(azd_data)
        assert os.path.isfile(mk_data)

        azd_data = pandas.read_excel(azd_data, sheet_name='AZDAverage', index_col='Condition')
        mk_data = pandas.read_excel(mk_data, sheet_name='MKAverage', index_col='Condition')

        mk_data = mk_data.iloc[3:]

        exp_data = pandas.concat([azd_data, mk_data])

        # for i in free_parameters:
        #     free_parameters[i] = numpy.random.uniform(0, 100, 1)[0]

        delta = 0.01
        akt_ineq1 = Inequality(['E', 'pAkt'], '>', ['D', 'pAkt'], 'pAkt_1')
        akt_ineq2 = Inequality(['E_A_72', 'pAkt'], '>', ['E', 'pAkt'], 'pAkt_2')
        akt_ineq3 = Inequality(['A_72', 'pAkt'], '<', ['E', 'pAkt'], 'pAkt_3')
        akt_ineq4 = Inequality(['A_72', 'pAkt'], '<', ['E_A_72', 'pAkt'], 'pAkt_4')
        akt_ineq5 = Inequality(['E_M_72', 'pAkt'], '<', ['D', 'pAkt'], 'pAkt_5')
        akt_ineq6 = Inequality(['E_M_72', 'pAkt'], '<', ['T', 'pAkt'], 'pAkt_6')
        akt_ineq7 = Inequality(['E_M_72', 'pAkt'], '<', ['E', 'pAkt'], 'pAkt_7')
        akt_ineq8 = Inequality(['M_72', 'pAkt'], '<', ['D', 'pAkt'], 'pAkt_8')
        akt_ineq9 = Inequality(['M_72', 'pAkt'], '<', ['T', 'pAkt'], 'pAkt_9')
        akt_ineq10 = Inequality(['M_72', 'pAkt'], '<', ['E', 'pAkt'], 'pAkt_10')

        akt = [
            akt_ineq1,
            akt_ineq2,
            akt_ineq3,
            akt_ineq4,
            akt_ineq5,
            akt_ineq6,
            akt_ineq7,
            akt_ineq8,
            akt_ineq9,
            akt_ineq10,
        ]

        erk_ineq1 = Inequality(['E', 'ppErk'], '>', ['D', 'ppErk'], 'ppErk_1')
        erk_ineq2 = Inequality(['E', 'ppErk'], '>', ['T', 'ppErk'], 'ppErk_2')
        erk_ineq3 = Inequality(['E_A_72', 'ppErk'], '<', ['E', 'ppErk'], 'ppErk_3')
        erk_ineq4 = Inequality(['E_A_72', 'ppErk'], '<', ['D', 'ppErk'], 'ppErk_4')
        erk_ineq5 = Inequality(['E_A_72', 'ppErk'], '<', ['T', 'ppErk'], 'ppErk_5')
        erk_ineq6 = Inequality(['A_72', 'ppErk'], '<', ['E', 'ppErk'], 'ppErk_6')
        erk_ineq7 = Inequality(['A_72', 'ppErk'], '<', ['D', 'ppErk'], 'ppErk_7')
        erk_ineq8 = Inequality(['A_72', 'ppErk'], '<', ['T', 'ppErk'], 'ppErk_8')
        erk_ineq9 = Inequality(['E_M_72', 'ppErk'], '>', ['E', 'ppErk'], 'ppErk_9')
        erk_ineq10 = Inequality(['M_72', 'ppErk'], '<', ['E_M_72', 'ppErk'], 'ppErk_10')

        erk = [
            erk_ineq1,
            erk_ineq2,
            erk_ineq3,
            erk_ineq4,
            erk_ineq5,
            erk_ineq6,
            erk_ineq7,
            erk_ineq8,
            erk_ineq9,
            erk_ineq10,
        ]
        s6k_ineq1 = Inequality(['E', 'pS6K'], '<', ['T', 'pS6K'], 'pS6K_1')
        s6k_ineq2 = Inequality(['E', 'pS6K'], '<', ['D', 'pS6K'], 'pS6K_2')
        s6k_ineq3 = Inequality(['E_A_72', 'pS6K'], '<', ['T', 'pS6K'], 'pS6K_3')
        s6k_ineq4 = Inequality(['E_A_72', 'pS6K'], '<', ['D', 'pS6K'], 'pS6K_4')
        s6k_ineq5 = Inequality(['E_A_72', 'pS6K'], '<', ['A_72', 'pS6K'], 'pS6K_5')
        s6k_ineq6 = Inequality(['E_M_72', 'pS6K'], '<', ['D', 'pS6K'], 'pS6K_6')
        s6k_ineq7 = Inequality(['E_M_72', 'pS6K'], '<', ['T', 'pS6K'], 'pS6K_7')
        s6k_ineq8 = Inequality(['M_72', 'pS6K'], '>', ['E_M_72', 'pS6K'], 'pS6K_8')

        s6k = [
            s6k_ineq1,
            s6k_ineq2,
            s6k_ineq3,
            s6k_ineq4,
            s6k_ineq5,
            s6k_ineq6,
            s6k_ineq7,
            s6k_ineq8,
        ]
        smad2_ineq1 = Inequality(['T', 'pSmad2'], '>', ['D', 'pSmad2'], 'pSmad1_1')
        smad2_ineq2 = Inequality(['E', 'pSmad2'], '>', ['T', 'pSmad2'], 'pSmad1_2')
        smad2_ineq3 = Inequality(['A_72', 'pSmad2'], '>', ['A_1.25', 'pSmad2'], 'pSmad1_3')
        smad2_ineq4 = Inequality(['E_M_72', 'pSmad2'], '<', ['E', 'pSmad2'], 'pSmad1_4')
        smad2_ineq5 = Inequality(['E_M_72', 'pSmad2'], '<', ['E_M_1.25', 'pSmad2'], 'pSmad1_5')
        smad2_ineq6 = Inequality(['M_72', 'pSmad2'], '<', ['E', 'pSmad2'], 'pSmad1_6')

        smad = [
            smad2_ineq1,
            smad2_ineq2,
            smad2_ineq3,
            smad2_ineq4,
            smad2_ineq5,
            smad2_ineq6,
        ]
        all_ineq = akt + erk + s6k + smad
        ineq = InequalityGroup(all_ineq)

        # SemiRSS()
        akt_mapping = Mapping('pAkt', 'pAkt')
        erk_mapping = Mapping('pErk', 'ppErk')
        s6k_mapping = Mapping('pS6K', 'pS6K')
        smad2_mapping = Mapping('pSmad2', 'pSmad2')

        mappings = [akt_mapping, erk_mapping, s6k_mapping, smad2_mapping]

        O = RandomSimulation(
            CROSS_TALK_MODEL, exp_data=exp_data, inequalities=ineq, mappings=mappings,
            free_parameters=free_parameters, iterations=1000
        )

        O.fit()
