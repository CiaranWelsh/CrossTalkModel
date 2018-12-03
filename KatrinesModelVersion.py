import os, glob, pandas, numpy
from pycotools import model, viz, tasks
import tellurium as te
import seaborn
import matplotlib
from collections import OrderedDict

matplotlib.use('TkAgg')
import matplotlib.pyplot as plt

seaborn.set_style('white')
seaborn.set_context('talk', font_scale=1)


def cross_talk_model_antstr():
    """
    Antimony string model containing the most currect version of
    the CrossTalk model from Katrine and Patricia's project.
    :return:
    """
    return """
    model TGFbModule()
        compartment Cell = 1.0
        
        var TGFbR       in Cell  
        var TGFbR_a     in Cell  
        var Smad2       in Cell  
        var pSmad2      in Cell  
        var Smad7       in Cell
        var Mek         in Cell
        var pMek        in Cell  
        var Erk         in Cell
        var pErk        in Cell  
        var GFR         in Cell  
        var pGFR        in Cell  
        var PI3K        in Cell  
        var pPI3K       in Cell  
        var Akt         in Cell
        var pAkt        in Cell  
        var mTORC1      in Cell  
        var pmTORC1     in Cell  
        var S6K         in Cell
        var pS6K        in Cell  
        
        
        var TGFb             in Cell
        var AZD              in Cell
        var GrowthFactors    in Cell
        var MK2206           in Cell
        var Everolimus       in Cell
    
        
        //TGFb module
        R1: TGFbR + TGFb    => TGFbR_a          ; Cell * kTGFbOn        *TGFb                   ;
        R2: TGFbR_a         => TGFbR + TGFb     ; Cell * kTGFbOff       *TGFbR_a                ;
        R3: TGFb            =>                  ; Cell * kTGFRemoval    *TGFb                   ;
        R4: Smad2           => pSmad2           ; Cell * kSmad2Phos     *Smad2      *TGFbR_a    ;
        R5: pSmad2          => Smad2            ; Cell * kSmad2Dephos   *pSmad2                 ;
        R6:                => Smad7            ; Cell * kSmad7Prod     *pSmad2                 ;
        R7: Smad7          =>                  ; Cell * kSmad7Deg      *Smad7                  ;
        R8: TGFbR_a + Smad7 =>                  ; Cell * kTGFbRDegBySmad7   *TGFbR_a    *Smad7  ;
        
        //TGF_1: R2 + R1   => LRC          ; Cell*ka*R1*R2*ligand;
        //TGF_2: LRC       =>              ; Cell*kcd*LRC;
        //TGF_3: LRC       =>              ; Cell*klid*LRC;
        //TGF_4: LRC       => LRC_EE       ; Cell*ki*LRC;
        //TGF_5:           => R1           ; Cell*pRI;
        //TGF_6: R1        =>              ; Cell*R1*kcd;
        //TGF_7: R1        => R1_EE        ; Cell*R1*ki;
        //TGF_8: R1_EE     => R1           ; Cell*R1_EE*kr;
        //TGF_9: LRC_EE    => R1 + R2      ; Cell*kr*LRC_EE;
        //TGF_10:          => R2           ; Cell*pRII;
        //TGF_11: R2       =>              ; Cell*R2*kcd;
        //TGF_12: R2       => R2_EE        ; Cell*R2*ki;
        //TGF_13: R2_EE    => R2           ; Cell*R2_EE*kr;
        
        //MEK module                   //
        R9_1:   Mek      => pMek     ;   Cell * kMekPhosByPI3K      *Mek    *pPI3K   ;
        R9_2:   Mek      => pMek     ;   Cell * kMekPhosByTGFbR_a   *Mek    *TGFbR_a ;
        R9_3:   Mek      => pMek     ;   Cell * kMekPhosByGFR      *Mek    *pGFR    ;
        R10_1:   pMek     => Mek      ;   Cell * kMekDephosByAkt     *pMek   *pAkt    ;
        R10_2:   pMek     => Mek      ;   Cell * kMekDephosByAZD     *pMek   *AZD     ; 
        R11 :    Erk      => pErk     ;   Cell * kErkPhosByMek       *Erk    *pMek    ;
        R12:    pErk     => Erk      ;   Cell * kErkDephos          *pErk
        
        
        //PI3K Module
        R13:        GFR     => pGFR     ;   Cell *(kGFRPhos_kcat       * GrowthFactors * GFR /(kGFRPhos_km^kGFRPhos_h + GFR^kGFRPhos_h))
        R14:        pGFR    => GFR      ;   Cell *  kGFRDephos         *pGFR                    ;
        R15_1:      PI3K    => pPI3K    ;   Cell *  kPI3KPhosByGFR     *PI3K       *pGFR        ;
        R15_2:      PI3K    => pPI3K    ;   Cell *  kPI3KPhosByMek      *PI3K       *pMek        ;
        R15_1:      pPI3K   => PI3K     ;   Cell *  kPI3KDephosByS6K    *pPI3K      *pS6K        ;
        R16_2:      pPI3K   => PI3K     ;   Cell *  kPI3KDephosByErk    *pPI3K      *pErk        ;
        R17:        Akt     => pAkt     ;   Cell *  kAktPhos            *Akt        *pPI3K       ;
        R18:        pAkt    => Akt      ;   Cell *  kAktDephos          *pAkt       *MK2206      ;
        R19_1:      mTORC1  => pmTORC1  ;   Cell *  kmTORC1PhosByAkt    *mTORC1     *pAkt        ;
        R19_2:      mTORC1  => pmTORC1  ;   Cell *  kmTORC1PhosByErk    *mTORC1     *pErk        ;
        R20_1:      pmTORC1 => mTORC1   ;   Cell *  kmTORC1DephosByEv   *pmTORC1    *Everolimus  ;
        R20_2:      pmTORC1 => mTORC1   ;   Cell *  kmTORC1Dephos       *pmTORC1                 ;
        R21_1:      S6K     => pS6K     ;   Cell *  kS6KPhosBymTORC1    *S6K        *pmTORC1     ;
        R21_2:      S6K     => pS6K     ;   Cell *  kS6KPhosByErk       *S6K        *pErk        ;
        R22:        pS6K    => S6K      ;   Cell *  kS6KDephos          *pS6K                    ;
        
        kTGFbOn             = 0.04
        kTGFbOff            = 0.02
        kTGFRemoval         = 0.1
        kSmad2Phos          = 0.01
        kSmad2Dephos        = 0.01
        kTGFbOff            = 0.01
        kSmad2Phos          = 0.01
        kSmad2Dephos        = 0.01  
        kSmad7Prod          = 0.01
        kSmad7Deg           = 0.01
        kTGFbRDegBySmad7    = 0.01
          
        kMekPhosByPI3K      = 0.01    
        kMekPhosByTGFbR_a   = 0.01        
        kMekPhosByGFR       = 0.01    
        kMekDephosByAkt     = 0.01    
        kMekDephosByAZD     = 0.01    
        kErkPhosByMek       = 0.01    
        kErkDephos          = 0.01
        
        kGFRPhos_kcat      = 10
        kGFRPhos_km        = 25
        kGFRPhos_h         = 2
        kGFRDephos         = 1
        kPI3KPhosByGFR     = 0.01    
        kPI3KPhosByMek      = 0.01    
        kPI3KDephosByS6K    = 0.01        
        kPI3KDephosByErk    = 0.01      
        kAktPhos            = 0.1
        kAktDephos          = 0.01
        kmTORC1PhosByAkt    = 0.001         
        kmTORC1PhosByErk    = 0.001        
        kmTORC1Dephos       = 0.01   
        kmTORC1DephosByEv   = 0.01 
        kS6KPhosBymTORC1    = 0.001        
        kS6KPhosByErk       = 0.001    
        kS6KDephos          = 0.01
    
        TGFb                    = 1
        AZD                     = 0
        GrowthFactors           = 100
        MK2206                  = 0
        Everolimus              = 0
        
        TGFbR                   = 100
        TGFbR_a                 = 0
        Smad2                   = 100
        pSmad2                  = 0
        Smad7                   = 0
        Mek                     = 100
        pMek                    = 0
        Erk                     = 100
        pErk                    = 0
        GFR                     = 100
        pGFR                    = 0
        PI3K                    = 100
        pPI3K                   = 0
        Akt                     = 100
        pAkt                    = 0
        mTORC1                  = 100
        pmTORC1                 = 0
        S6K                     = 100
        pS6K                    = 0
    
      unit volume = 1 litre;
      unit time_unit = 3600 second;
      unit substance = 1e-9 mole;
        
    end;
"""


def load_model_with_pyco(ant, copasi_filename):
    """
    Load an antimony model into copasi using Pycotools wrapper around
    tellurium functions
    :param copasi_filename:
    :param ant:
    :return:
    """
    with model.BuildAntimony(copasi_filename) as loader:
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


def dose_response_for_growth_factors():
    """
    Use the dose repsonse function to see the effect of changing the
    initial concentration of GrowthFactors. Plot some output
    :return:
    """
    model_species = ['TGFbR', 'TGFbR_a',
                     'Smad2', 'pSmad2',
                     'Mek', 'pMek', 'Erk',
                     'pErk', 'GFR', 'pGFR',
                     'PI3K', 'pPI3K', 'Akt',
                     'pAkt', 'mTORC1', 'pmTORC1',
                     'S6K', 'pS6K', 'TGFb']
    mod = te.loada(cross_talk_model_antstr())

    l = [
        ['PI3K', 'pPI3K'],
        ['Mek', 'pMek'],
        ['Erk', 'pErk'],
        ['Akt', 'pAkt'],
        ['S6K', 'pS6K'],
        ['GFR', 'pGFR']
    ]

    for i, j in l:
        # print(mod.model.keys())
        fig = dose_response(cross_talk_model_antstr(), 'GrowthFactors', 1, 10000, 1000, [i, j])
        plt.title('Dose Response of {} and \n{} to GrowthFactors (log10 nM)'.format(i, j))
        fname = os.path.join(graphs_directory, 'GrowthFactorsDoseResponse{}.png'.format(i))
        fig.savefig(fname, dpi=150, bbox_inches='tight')
        # plt.show()


def add_event(model_string, event_str):
    model_string = model_string[:-5]
    event_str = "    " + event_str
    model_string += event_str
    model_string += "\nend;"
    return model_string


def add_serum_starve_event(model_string):
    """
    Set growth factors to 0 at t=70.25 minutes
    :param model_string:
    :return:
    """
    event_str = "RemoveGrowthFactors: at (time>70.25): GrowthFactors=0;\n"
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


def simulate_condition(model_string, GF=0, TGF=0, pretreatment=None,
                       pretreatment_time=None, EV=0,
                       serum_starve_event=False, TGFb_event=False, open_with_copasi=False):
    if serum_starve_event:
        model_string = add_serum_starve_event(model_string)

    if TGFb_event:
        model_string = add_TGFb_event(model_string)
    if pretreatment is not None:
        if pretreatment == 'AZD':
            model_string = add_AZD_event(model_string, pretreatment_time)
        elif pretreatment == 'MK2206':
            model_string = add_MK_event(model_string, pretreatment_time)
        else:
            raise ValueError

    mod = te.loada(model_string)
    mod.TGFb = TGF
    mod.GrowthFactors = GF
    # mod.AZD = AZD
    # mod.MK = MK
    mod.Everolimus = EV

    ## Add 1 to intervals for 0 indexed python
    res = mod.simulate(0, 72, 73)
    colnames = []
    for i in res.colnames:
        if i != "time":
            colnames.append(i[1:-1])
        else:
            colnames.append(i)
    df = pandas.DataFrame(res, columns=colnames)

    if open_with_copasi:
        copasi_mod = load_model_with_pyco(model_string, copasi_filename)
        copasi_mod.open()

    return df


def simulate_azd_conditions_and_plot(y):
    """
    Takes output from simulation and plot
    :param df:
    :return:

    model_string, GF=0, TGF=0, pretreatment=None,
                       pretreatment_time=None, EV=0,
                       serum_starve_event=False, TGFb_event=False


    """
    conditions = OrderedDict({
        # 'NULL':         [0  , 0, None   , None,     0, False, False],
        'D': [100, 1, None, None, 0, True, False],
        'T': [100, 1, None, None, 0, True, True],
        'T_E': [100, 1, None, None, 1, True, True],
        'T_A_E_0': [100, 1, "AZD", 0.0, 1, True, True],
        'T_A_E_24': [100, 1, "AZD", 24, 1, True, True],
        'T_A_E_48': [100, 1, "AZD", 48.0, 1, True, True],
        'T_A_E_70.75': [100, 1, "AZD", 70.75, 1, True, True],
        'T_A_0': [100, 1, "AZD", 0.0, 0, True, True],
        'T_A_24': [100, 1, "AZD", 24, 0, True, True],
        'T_A_48': [100, 1, "AZD", 48.0, 0, True, True],
        'T_A_70.75': [100, 1, "AZD", 70.75, 0, True, True],
    })

    dct = OrderedDict()
    for k, v in conditions.items():
        df = simulate_condition(cross_talk_model_antstr(), *conditions[k])
        dct[k] = df[df['time'] == 72.0]

    df = pandas.concat(dct)
    df.index = df.index.droplevel(1)
    df = df.drop('time', axis=1)
    df = df.reset_index()
    df = df.rename(columns={'index': 'Condition'})

    if y not in df.columns:
        raise ValueError('The variable "{}" does not appear in your model'.format(y))

    fig = plt.figure()
    seaborn.barplot(x='Condition', y=y, data=df,
                    palette=['yellow'] * 2 + ['white'] * 1 + ['red'] * 4 + ['green'] * 4,
                    )
    seaborn.despine(fig, top=True, right=True)
    plt.xticks(rotation=90)

    azd_dir = os.path.join(graphs_directory, 'AZDSimulations')
    os.makedirs(azd_dir) if not os.path.isdir(azd_dir) else None
    fname = os.path.join(azd_dir, "{}.png".format(y))
    fig.savefig(fname, dpi=150, bbox_inches='tight')


def simulate_mk_conditions_and_plot(y):
    """
    Takes output from simulation and plot
    :param df:
    :return:

    model_string, GF=0, TGF=0, pretreatment=None,
                       pretreatment_time=None, EV=0,
                       serum_starve_event=False, TGFb_event=False


    """
    conditions = OrderedDict({
        # 'NULL':         [0  , 0, None   , None,     0, False, False],
        'D': [100, 1, None, None, 0, True, False],
        'T': [100, 1, None, None, 0, True, True],
        'T_E': [100, 1, None, None, 1, True, True],
        'T_M_E_0': [100, 1, "MK2206", 0.0, 1, True, True],
        'T_M_E_24': [100, 1, "MK2206", 24.0, 1, True, True],
        'T_M_E_48': [100, 1, "MK2206", 48.0, 1, True, True],
        'T_M_E_70.75': [100, 1, "MK2206", 70.75, 1, True, True],
        'T_M_0': [100, 1, "MK2206", 0.0, 0, True, True],
        'T_M_24': [100, 1, "MK2206", 24.0, 0, True, True],
        'T_M_48': [100, 1, "MK2206", 48.0, 0, True, True],
        'T_M_70.75': [100, 1, "MK2206", 70.75, 0, True, True],
    })

    dct = OrderedDict()
    for k, v in conditions.items():
        df = simulate_condition(cross_talk_model_antstr(), *conditions[k])
        dct[k] = df[df['time'] == 72.0]

    df = pandas.concat(dct)
    df.index = df.index.droplevel(1)
    df = df.drop('time', axis=1)
    df = df.reset_index()
    df = df.rename(columns={'index': 'Condition'})

    if y not in df.columns:
        raise ValueError('The variable "{}" does not appear in your model'.format(y))

    fig = plt.figure()
    seaborn.barplot(x='Condition', y=y, data=df,
                    palette=['yellow'] * 2 + ['white'] * 1 + ['red'] * 4 + ['green'] * 4,
                    )
    seaborn.despine(fig, top=True, right=True)
    plt.xticks(rotation=90)

    mk_dir = os.path.join(graphs_directory, 'MKSimulations')
    os.makedirs(mk_dir) if not os.path.isdir(mk_dir) else None
    fname = os.path.join(mk_dir, "{}.png".format(y))
    fig.savefig(fname, dpi=150, bbox_inches='tight')

    # plt.show()

def plot_all():
    """
    Plot all bar graphs from simulations
    :return:
    """
    model_species = ['TGFb', 'TGFbR', 'TGFbR_a', 'Smad2',
                     'pSmad2', 'Smad7', 'Mek', 'pMek',
                     'Erk', 'pErk', 'GFR', 'pGFR', 'PI3K',
                     'pPI3K', 'Akt', 'pAkt', 'mTORC1',
                     'pmTORC1', 'S6K', 'pS6K']

    for i in model_species:
        simulate_azd_conditions_and_plot(i)
        # simulate_mk_conditions_and_plot(i)



if __name__ == '__main__':

    working_directory = r'D:\MesiSTRAT\CrossTalkModel'
    copasi_filename = os.path.join(working_directory, 'KatrinesTopology.cps')
    graphs_directory = os.path.join(working_directory, 'SimulationGraphs')

    if not os.path.isdir(graphs_directory):
        os.makedirs(graphs_directory)

    # dose_response_for_growth_factors()
    # mod = load_model_with_pyco(cross_talk_model_antstr(), copasi_filename)
    # mod.open()

    # mod = te.loada(functions_antstr() + cross_talk_model_antstr())
    # odes = te.utils.misc.getODEsFromModel(mod)
    # print(odes)

    # sbml = te.antimonyToSBML(functions_antstr() + cross_talk_model_antstr())
    # print(sbml)
    # i = 'GFR'
    # j = 'pGFR'
    # pmid_for_IGF_data = 'PMID: 26217307'
    # fig = dose_response(cross_talk_model_antstr(), 'GrowthFactors', 0.1, 1000, 50, [i, j])
    # plt.title('Dose Response of {} and \n{} to GrowthFactors'.format(i, j))
    # fname = os.path.join(graphs_directory, 'GrowthFactorsDoseResponse{}.png'.format(i))
    # fig.savefig(fname, dpi=150, bbox_inches='tight')
    # plt.show()

    # fig = dose_response(cross_talk_model_antstr(), 'TGFb', 0.01, 1000, 100, ['TGFbR'])
    # plt.show()

    # string = add_serum_starve_event(cross_talk_model_antstr())
    # mod = te.loada(string)
    # mod.simulate(0, 5000, 5000, ['time', 'GrowthFactors'])
    # mod.plot()

    ## GF=0, TGF=0, AZD=0, MK=0, EV=0, serum_starve_event=False, TGFb_event=False):
    # df = simulate_condition(cross_talk_model_antstr(), *azd_conditions['D'])
    # plot_condition(df)
    # plot_azd()

    # mod = te.loada(cross_talk_model_antstr())
    #
    # print(mod.getFloatingSpeciesIds())

    # for i in sorted(dir(mod)):
    #     print(i)

    azd_conditions = OrderedDict({
        # 'NULL':         [0  , 0, None   , None,     0, False, False],
        'D': [100, 1, None, None, 0, True, False],
        'T': [100, 1, None, None, 0, True, True],
        'T_E': [100, 1, None, None, 1, True, True],
        'T_A_0': [100, 1, "AZD", 0.0, 0, True, True],
        'T_A_24': [100, 1, "AZD", 24.0, 0, True, True],
        'T_A_48': [100, 1, "AZD", 48.0, 0, True, True],
        'T_A_70.75': [100, 1, "AZD", 70.75, 0, True, True],
        'T_A_E_0': [100, 1, "AZD", 0.0, 1, True, True],
        'T_A_E_24': [100, 1, "AZD", 24.0, 1, True, True],
        'T_A_E_48': [100, 1, "AZD", 48.0, 1, True, True],
        'T_A_E_70.75': [100, 1, "AZD", 70.75, 1, True, True],
    })

    simulate_condition(cross_talk_model_antstr(), *azd_conditions['T_E'],
                       open_with_copasi=True)

    mk_conditions = OrderedDict({
        # 'NULL':         [0  , 0, None   , None,     0, False, False],
        'D': [100, 1, None, None, 0, True, False],
        'T': [100, 1, None, None, 0, True, True],
        'T_E': [100, 1, None, None, 1, True, True],
        'T_M_0': [100, 1, "MK2206", 0.0, 0, True, True],
        'T_M_24': [100, 1, "MK2206", 24.0, 0, True, True],
        'T_M_48': [100, 1, "MK2206", 48.0, 0, True, True],
        'T_M_70.75': [100, 1, "MK2206", 70.75, 0, True, True],
        'T_M_E_0': [100, 1, "MK2206", 0.0, 1, True, True],
        'T_M_E_24': [100, 1, "MK2206", 24.0, 1, True, True],
        'T_M_E_48': [100, 1, "MK2206", 48.0, 1, True, True],
        'T_M_E_70.75': [100, 1, "MK2206", 70.75, 1, True, True],
    })

    # plot_all()












































