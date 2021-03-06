import site, os, glob
import pandas, numpy
import re
import tellurium as te

# site.addsitedir(r'/home/ncw135/Documents/pycotools3')
# site.addsitedir(r'D:\pycotools3')
from pycotools3 import model, tasks, viz
from itertools import combinations
from collections import OrderedDict
import matplotlib.pyplot as plt
import seaborn
import yaml
import logging

mpl_logger = logging.getLogger('matplotlib')
mpl_logger.setLevel(logging.WARNING)

logging.basicConfig(level=logging.INFO)
LOG = logging.getLogger(__name__)



class HypothesisExtension:

    def __init__(self, name, reaction, rate_law, mode='additive', to_repalce=None):
        self.name = name
        self.reaction = reaction
        self.rate_law = rate_law
        self.mode = mode
        self.to_replace = to_repalce

        for i in [self.name, self.reaction, self.rate_law, self.mode]:
            if not isinstance(i, str):
                raise ValueError('attribute "{}" should be a string, not {}'.format(i, type(i)))

    def __str__(self):
        return f'{self.name}: {self.reaction}; {self.rate_law}'

    def __repr__(self):
        return self.__str__()


class CrossTalkModel:
    """
    build a factory that churns out functions that return models and take as argument the
    antimony parameter strings
    """

    def __init__(self, problem_directory, data_directory,
                 mutually_exclusive_reactions=[],
                 parameter_str=None,
                 fit='1_1',
                 run_mode='slurm',
                 copy_number=33,
                 randomize_start_values=True,
                 overwrite_config_file=True,
                 method='particle_swarm',
                 population_size=75,
                 swarm_size=50,
                 iteration_limit=2000,
                 number_of_generations=500,
                 lower_bound=0.001,
                 upper_bound=10000,
                 use_best_parameters=False
                 ):
        self.mutually_exclusive_reactions = mutually_exclusive_reactions
        if self.mutually_exclusive_reactions is not None:
            if not isinstance(self.mutually_exclusive_reactions, list):
                raise TypeError('expecting list but got {}'.format(type(self.mutually_exclusive_reactions)))
            for i in self.mutually_exclusive_reactions:
                if not isinstance(i, tuple):
                    raise TypeError('expecting tuple but got {}'.format(type(self.mutually_exclusive_reactions)))

        self.parameter_str = parameter_str
        self._topology = 0
        self.problem_directory = problem_directory
        if not os.path.isdir(self.problem_directory):
            os.makedirs(self.problem_directory)
        self.data_dir = data_directory
        if not os.path.isdir(self.data_dir):
            raise ValueError(f'{self.data_dir} is not a directory')

        self.fit = fit
        self.run_mode = run_mode
        self.copy_number = copy_number
        self.randomize_start_values = randomize_start_values
        self.overwrite_config_file = overwrite_config_file
        self.method = method
        self.population_size = population_size
        self.swarm_size = swarm_size
        self.iteration_limit = iteration_limit
        self.number_of_generations = number_of_generations
        self.lower_bound = lower_bound
        self.upper_bound = upper_bound
        self.use_best_parameters = use_best_parameters

        self.cps_file = os.path.join(self.topology_dir, 'Topology{}'.format(self.topology))

        # dict of reactions that vary with topologies and another dict with corresponding hypothesis names
        self.model_variant_reactions, self.topology_names = self._model_variant_reactions()

        # self.model_specific_reactions = self._assembel_model_reactions()[self.topology]

    def _model_variant_reactions(self):
        """
        Get all methods that begin with 'extension_hypothesis' and return their values in a dict[number] = reaction_string

        This assembles the reactions that are not in every model and will later be combinatorially combined with the
        core model.

        Returns:

        """
        hypothesis_reactions = []
        hypothesis_reaction_names = []
        for i in dir(self):
            if i.startswith('extension_hypothesis'):
                hypothesis_reactions.append(getattr(self, i)())
                hypothesis_reaction_names.append(i.replace('extension_hypothesis_', ''))

        dct = OrderedDict()
        names = OrderedDict()
        for i in range(len(hypothesis_reactions)):
            dct[i] = hypothesis_reactions[i]
            names[i] = hypothesis_reaction_names[i]
        return dct, names

    def __str__(self):
        return "CrossTalkModel(topology={})".format(self.topology)

    def __len__(self):
        """
        Subtract 1 for 0 indexed python
        :return:
        """
        return len(list(self._get_combinations()))

    def __iter__(self):

        while self.topology < len(self):
            yield self.topology
            self.topology += 1

    def __getitem__(self, item):
        if not isinstance(item, int):
            raise TypeError('"item" should be of type int. Got "{}" instead'.format(type(item)))

        self.topology = item
        # self.model_specific_reactions = self._assembel_model_reactions()[item]
        return self

    @property
    def topology(self):
        return self._topology

    @topology.setter
    def topology(self, new):
        assert isinstance(new, int)
        self._topology = new

    @property
    def model_selection_dir(self):
        d = os.path.join(self.problem_directory, 'ModelSelection')
        if not os.path.isdir(d):
            os.makedirs(d)
        return d

    @property
    def topology_dir(self):
        d = os.path.join(self.model_selection_dir, 'Topology{}'.format(self.topology))
        if not os.path.isdir(d):
            os.makedirs(d)
        return d

    @property
    def fit_dir(self):
        d = os.path.join(self.topology_dir, 'Fit{}'.format(self.fit))
        if not os.path.isdir(d):
            os.makedirs(d)
        return d

    @property
    def graphs_dir(self):
        d = os.path.join(self.fit_dir, 'Graphs')
        if not os.path.isdir(d):
            os.makedirs(d)
        return d

    @property
    def time_course_graphs(self):
        d = os.path.join(self.graphs_dir, 'TimeCourseSimulations')
        if not os.path.isdir(d):
            os.makedirs(d)
        return d

    @property
    def data_files(self):
        # /home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/all_data
        #
        path = os.path.join(self.data_dir, '*.csv')
        files = glob.glob(path)
        if files == []:
            raise ValueError('No data files in {}'.format(path))

        lst = []
        for i in files:
            dire, fle = os.path.split(i)
            if os.path.splitext(fle)[0] not in self.included_conditions:
                continue
            lst.append(i)

        return lst

    @property
    def included_conditions(self):
        fle = os.path.join(self.model_selection_dir, 'included_conditions.yaml')
        if not os.path.isfile(fle):
            raise ValueError(f'{fle} is not a file')
        # Read YAML file
        with open(fle, 'r') as stream:
            cond = yaml.load(stream, Loader=yaml.SafeLoader)
        cond = cond[0]['included_conditions']
        return cond

    def get_experimental_data(self):
        df_dct = {}
        for i in self.data_files:
            dire, fle = os.path.split(i)
            if os.path.splitext(fle)[0] not in self.included_conditions:
                continue
            df_dct[fle[:-4]] = pandas.read_csv(i)
        df = pandas.concat(df_dct)
        df.index = df.index.droplevel(1)
        df = df.drop('Time', axis=1)
        return df

    def get_errors2(self):
        """
        Keep AZD data for D, T and E
        :return:
        """
        dirname = os.path.join(WORKING_DIRECTORY, 'CrossTalkModel/data')
        mk_se = os.path.join(dirname, 'mk_se.csv')
        azd_se = os.path.join(dirname, 'azd_se.csv')

        assert os.path.isfile(mk_se)
        assert os.path.isfile(azd_se)
        mk = pandas.read_csv(mk_se, index_col=0)
        azd = pandas.read_csv(azd_se, index_col=0)

        exp_data = self.get_experimental_data()
        exclude = ['Time', 'GrowthFactors_indep',
                   'TGFb_indep', 'Everolimus_indep',
                   'AZD_indep', 'MK2206_indep',
                   'ExperimentIndicator_indep']
        vars = list(set(exp_data.columns).difference(set(exclude)))

        labels_dct = {
            'pAkt': 'Akt-pT308',
            'pErk': 'ERK-pT202',
            'pS6K': 'S6K-pT389',
            'pSmad2': 'SMAD2-pS465-467'
        }
        keys = [labels_dct[i] for i in vars]
        mk = mk[keys]
        mk = mk.rename(columns={j: i for i, j in labels_dct.items()})
        azd = azd.rename(columns={j: i for i, j in labels_dct.items()})
        mk = mk.drop(['D', 'T', 'E'], axis=0)
        df = pandas.concat([azd, mk], sort=False)
        return df

    def get_errors(self):
        """
        Keep AZD data for D, T and E
        :return:
        """
        se = os.path.join(os.path.dirname(os.path.dirname(self.data_dir)), 'se.csv')
        df = pandas.read_csv(se).set_index('condition_code')
        labels_dct = {
            'pAkt': 'Akt-pT308',
            'pErk': 'ERK-pT202',
            'pS6K': 'S6K-pT389',
            'pSmad2': 'SMAD2-pS465-467'
        }
        df = df.rename(columns={v: k for k, v in labels_dct.items()})
        return df

    def get_experiment_names(self):
        return list(set(self.get_experimental_data().index.get_level_values(0)))

    def get_experimental_conditions(self):
        """
        returns pandas dataframe of experimental conditions as independent vars.
        :return:
        """
        cond = {}
        experimental_data = self.get_experimental_data()
        for name in self.get_experiment_names():
            data = experimental_data.loc[name]
            iconds = {}
            iconds['AZD'] = data.loc['AZD_indep']
            iconds['Everolimus'] = data.loc['Everolimus_indep']
            iconds['GrowthFactors'] = data.loc['GrowthFactors_indep']
            iconds['MK2206'] = data.loc['MK2206_indep']
            iconds['TGFb'] = data.loc['TGFb_indep']
            iconds['ExperimentIndicator'] = data.loc['ExperimentIndicator_indep']
            cond[name] = iconds

        df = pandas.DataFrame(cond).transpose()
        return df

    def simulate_conditions(self, selection=['pAkt', 'pErk', 'pS6K', 'pSmad2'], best_parameters=False):
        mod = self.to_tellurium(best_parameters=best_parameters)
        conditions = self.get_experimental_conditions()
        simulation_data = {}
        for cond in conditions.index:
            for variable in conditions.columns:
                value = conditions.loc[cond, variable]
                setattr(mod, variable, value)
            # ensure we are starting at the initial conditions every time
            mod.reset()
            df = pandas.DataFrame(mod.simulate(0, 72, 73, selection))
            df.columns = selection
            simulation_data[cond] = df

        return pandas.concat(simulation_data)

    def plot_bargraphs(self, best_parameters=False, selections=['pAkt', 'pS6K', 'pErk', 'pSmad2']):
        """
        Plot simulation vs experimental datagraphs

        Args:
            best_parameters:
            selections:

        Returns:

        """
        marker = '_'
        markersize = 10
        import matplotlib
        matplotlib.use('Qt5Agg')
        seaborn.set_style('white')
        seaborn.set_context(context='talk')
        sim_data = self.simulate_conditions(best_parameters=best_parameters)
        sim_data = sim_data.reset_index(level=1)
        sim_data = sim_data.rename(columns={'level_1': 'Time'})
        sim_data = sim_data[sim_data['Time'] == 72]
        del sim_data['Time']
        sim_data.index = [i.replace('72', '') for i in sim_data.index]

        err_data = self.get_errors()
        err_data.index = [i.replace('72', '') for i in err_data.index]
        err_data = pandas.DataFrame(err_data.loc[list(sim_data.index)])

        exp_data = self.get_experimental_data()[selections]
        exp_data.index = [i.replace('72', '') for i in exp_data.index]
        sim_data = pandas.DataFrame(sim_data.stack())
        exp_data = pandas.DataFrame(exp_data.stack())
        err_data = pandas.DataFrame(err_data.stack())
        sim_data.columns = ['Sim']
        exp_data.columns = ['Exp']
        err_data.columns = ['Err']
        df = pandas.concat([exp_data, err_data, sim_data], axis=1)

        df = df.reset_index()
        df.columns = ['Condition', 'Protein', 'Exp', 'Err', 'Sim']
        order = ['D', 'T', 'A', 'M', 'E', 'EA', 'EM']
        conds = list(set(df['Condition']))
        order = [i for i in order if i in conds]
        df['Condition'] = df['Condition'].astype('category')
        df['Condition'].cat.set_categories(order, inplace=True)
        df.sort_values('Condition', inplace=True)

        fig = plt.figure(figsize=(10, 5))
        b = seaborn.barplot(data=df, x='Protein', y='Sim', hue='Condition', zorder=0)
        plt.legend(loc=(1, 0.5))
        x_list = []
        for patch in b.patches:
            x_list.append(patch.get_xy()[0] + (patch._width / 2))
        #
        plt.errorbar(x_list, df['Exp'], yerr=df['Err'],
                     marker='_', mec='blue', zorder=1, elinewidth=1, capsize=2, ecolor='blue',
                     linestyle="None", markersize=10
                     )
        seaborn.despine(ax=b, top=True, right=True)
        plt.ylabel('AU')

        fname = os.path.join(self.graphs_dir, 'simulations.png')
        plt.savefig(fname, dpi=150, bbox_inches='tight')
        LOG.info(f'saved image to "{fname}"')
        #

    @property
    def copasi_file(self):
        return os.path.join(self.fit_dir, 'topology{}.cps'.format(self.topology))

    def list_topologies(self):
        topologies = OrderedDict()
        comb = self._get_combinations()

        for i in comb:
            if i == ():
                topologies[i] = 'Null'
            else:
                topologies[i] = '_'.join([self.topology_names[x].strip() for x in i])
        # print(topologies)
        df = pandas.DataFrame(topologies, index=['Topology']).transpose().reset_index(drop=True)
        df.index.name = 'ModelID'
        return df

    def to_copasi(self, best_parameters=False):
        with model.BuildAntimony(self.copasi_file) as loader:
            mod = loader.load(self._build_antimony(best_parameters=best_parameters))
        return mod

    def to_tellurium(self, best_parameters):
        return te.loada(self._build_antimony(best_parameters=best_parameters))

    def to_antimony(self, best_parameters):
        return self._build_antimony(best_parameters=best_parameters)

    def configure_timecourse(self):
        pass

    def run_parameter_estimation(self, mod=None):
        if mod is None:
            mod = self.to_copasi(best_parameters=self.use_best_parameters)
        else:
            assert isinstance(mod, model.Model)

        if self.use_best_parameters:
            self.randomize_start_values = False

        free_params = [i.name for i in mod.global_quantities if i.name[0] == '_']
        exclude = ['TGFb', 'ExperimentIndicator',
                   'GrowthFactors', 'Everolimus',
                   'MK2206', 'AZD']

        PE = tasks.MultiParameterEstimation(
            mod,
            self.data_files,
            separator=[','] * len(self.data_files),
            weight_method=['value_scaling'] * len(self.data_files),
            metabolites=[],
            # metabolites=[i.name for i in mod.metabolites if i.name not in exclude],
            copy_number=self.copy_number,
            pe_number=1,
            global_quantities=free_params,
            run_mode=self.run_mode,
            randomize_start_values=self.randomize_start_values,
            method=self.method,
            number_of_generations=self.number_of_generations,
            population_size=self.population_size,
            iteration_limit=self.iteration_limit,
            swarm_size=self.swarm_size,
            overwrite_config_file=self.overwrite_config_file,
            lower_bound=self.lower_bound,
            upper_bound=self.upper_bound,
            # results_directory=self.old_results_directory,
        )
        PE.write_config_file()
        PE.setup()

        PE.run()
        return PE

    def run_parameter_estimation_from_parameter_set(self, param_str=None,
                                                    run_mode=None):
        if not isinstance(param_str, str):
            raise TypeError

        if self.run_mode is False:
            if run_mode is None:
                raise ValueError('self.run_mode is false and run_mode '
                                 'is None. This means that no parameter '
                                 'estimations will be conducted. To set '
                                 'parameter estimations running, set the '
                                 'run_mode argument to run_parameter_estimation_from_parameter_set '
                                 'to True, slurm or sge.')
            else:
                self.run_mode = run_mode

        if param_str is None:
            mod = self.to_copasi()
        else:
            mod = self.to_copasi(best_parameters=best_params)
            self.randomize_start_values = False

        free_params = [i.name for i in mod.global_quantities if i.name[0] == '_']

        PE = tasks.MultiParameterEstimation(
            mod,
            self.data_files,
            separator=[','] * len(self.data_files),
            weight_method=['value_scaling'] * len(self.data_files),
            metabolites=[],
            copy_number=self.copy_number,
            pe_number=1,
            global_quantities=free_params,
            run_mode=self.run_mode,
            randomize_start_values=self.randomize_start_values,
            method=self.method,
            number_of_generations=self.number_of_generations,
            population_size=self.population_size,
            iteration_limit=self.iteration_limit,
            swarm_size=self.swarm_size,
            overwrite_config_file=self.overwrite_config_file,
            lower_bound=self.lower_bound,
            upper_bound=self.upper_bound,
        )

        LOG.info('pe run mode', PE.run_mode)
        PE.write_config_file()
        PE.setup()
        PE.run()
        return PE

    def _configure_PE_for_viz(self, mod=None):
        """
        execute run_parameter_estimation with some kwargs changed so that we can get the
        PE object for passing on to viz module classes
        :return:
        """
        from copy import deepcopy
        ## take copies of variables
        copy_number = deepcopy(self.copy_number)
        run_mode = deepcopy(self.run_mode)
        randomize_start_Values = deepcopy(self.randomize_start_values)
        method = deepcopy(self.method)

        ## set new values for variables
        self.copy_number = 1
        self.run_mode = False
        self.randomize_start_values = False
        self.method = 'current_solution_statistics'

        ## create PE class instance
        PE = self.run_parameter_estimation(mod=None)

        ## put the original variables back
        self.copy_number = copy_number
        self.run_mode = run_mode
        self.randomize_start_values = randomize_start_Values
        self.method = method

        return PE

    def likelihood_ranks(self):
        return viz.LikelihoodRanks(self._configure_PE_for_viz(), savefig=True)

    def get_param_df(self):
        """
        return pandas.DataFrame of estimated parameters
        :return:
        """
        if not os.path.isdir(self.fit_dir):
            raise ValueError('"{}" is not a file'.format(self.fit_dir))
        PE = self._configure_PE_for_viz()

        parse = viz.Parse(PE)

        if not os.path.isdir(PE.results_directory):
            raise ValueError('"{}" is not a file'.format(PE.results_directory))
        LOG.info('pe results directory {}'.format(PE.results_directory))
        return parse.data

    def insert_best_parameters_and_open_with_copasi(self):
        parameters = self.get_param_df()
        mod = self._configure_PE_for_viz().model
        mod.insert_parameters(df=parameters, index=0, inplace=True)
        return mod.open()

    def insert_best_parameters(self):

        try:
            parameters = self.get_param_df()
            mod = self._configure_PE_for_viz().model
        except ValueError:
            LOG.warning('ValueError was raised. Cannot get parameters')
            mod = self._configure_PE_for_viz().model
            return mod
        LOG.debug(f'best parameters are \n{parameters.iloc[0]}')
        LOG.debug(f'best parameters shape\n{parameters.iloc[0].shape}')
        mod.insert_parameters(df=parameters, index=0, inplace=True)
        mod.save()
        return mod

    def insert_parameters(self, params):
        return self.to_copasi().insert_parameters(params)

    def get_best_model_parameters_as_antimony(self):
        parameters = self.get_param_df()
        best_params = parameters.iloc[0].to_dict()
        current_params = self._default_parameter_set_as_dict()
        current_params.update(best_params)
        all_reactions = self._build_reactions()
        ## to include global variables not involved in reactions but needed for events
        all_reactions_plus_events = all_reactions + '\n' + self._events()
        s = ''
        for k, v in current_params.items():
            ## this is a mechanism for not including parameters that are not in the model
            ## in the antimony string
            if k in all_reactions_plus_events:
                s += "\t\t{} = {};\n".format(k, v)
        return s

    def _get_number_estimated_model_parameters(self):
        mod = self.to_copasi()
        lst = [i for i in mod.parameters.columns if i.startswith('_')]
        return len(lst)

    def _get_n(self):
        n = 0
        for exp in self.data_files:
            data = pandas.read_csv(exp, sep=',')
            data = data[['pAkt', 'pErk', 'pS6K', 'pSmad2']]
            data = data.iloc[0]
            n += len(data)
        return n

    def aic(self, RSS):
        """
        Calculate the corrected AIC:

            AICc = -2*ln(RSS/n) + 2*K + (2*K*(K+1))/(n-K-1)

            or if likelihood function used instead of RSS

            AICc = -2*ln(likelihood) + 2*K + (2*K*(K+1))/(n-K-1)

        Where:
            RSS:
                Residual sum of squares for model fit
            n:
                Number of observations collectively in all data files

            K:
                Number of model parameters
        """
        n = self._get_n()
        K = self._get_number_estimated_model_parameters()
        return n * numpy.log((RSS / n)) + 2 * K + (2 * K * (K + 1)) / (n - K - 1)

    def compute_all_aics(self, overwrite=False):
        fname = os.path.join(C.model_selection_dir, 'ModelSelectionDataFit{}.csv'.format(FIT))
        if os.path.isfile(fname) and not overwrite:
            return pandas.read_csv(fname, index_col=0), fname
        best_rss = {}
        aic = {}
        num_est_params = {}
        for model_id in self:
            data = C[model_id].get_param_df()
            try:
                best_rss[model_id] = data.iloc[0]['RSS']
                aic[model_id] = C[model_id].aic(data.iloc[0]['RSS'])
                num_est_params[model_id] = C[model_id]._get_number_estimated_model_parameters()
            except ValueError:
                best_rss[model_id] = data.iloc[0]['RSS']
                num_est_params[model_id] = C[model_id]._get_number_estimated_model_parameters()
                aic[model_id] = None
            except ZeroDivisionError:
                num_est_params[model_id] = C[model_id]._get_number_estimated_model_parameters()
                best_rss[model_id] = data.iloc[0]['RSS']
                aic[model_id] = None
        df = pandas.DataFrame({'RSS': best_rss, 'AICc': aic, '# Estimated Parameters': num_est_params})
        df = pandas.concat([C.list_topologies(), df], axis=1)
        df = df.sort_values(by='AICc')
        df['AICc Rank'] = range(df.shape[0])
        df = df.sort_values(by='RSS')
        df['RSS Rank'] = range(df.shape[0])
        df = df.sort_index()
        df.to_csv(fname)

        return df, fname

    def _get_combinations(self):
        # convert mutually exclusive reactions to numerical value
        l = []
        for mi1, mi2 in self.mutually_exclusive_reactions:
            l2 = []
            for k, v in self.model_variant_reactions.items():
                # print(mi1, mi2, k, v)
                mi1_match = re.findall(mi1, str(v))
                mi2_match = re.findall(mi2, str(v))

                if mi1_match != []:
                    l2.append(k)

                if mi2_match != []:
                    l2.append(k)

            l.append(l2)

        perm_list = [()]
        for i in range(len(self.model_variant_reactions)):
            perm_list += [j for j in combinations(range(len(self.model_variant_reactions)), i)]

        perm_list2 = [()]
        for i in perm_list:
            if i == ():
                continue
            for j, k in l:
                if j in i and k in i:
                    continue
                else:
                    perm_list2.append(i)
        ## plus the full set
        return perm_list2  # + [tuple(range(1, len(self.model_variant_reactions)+1))])

    def _build_reactions(self):
        """
        Build reactions using two mechanisms. 1) additive. When a HypothesisExtension class is marked as
        additive we can simply add the reaction to the bottom of the list of reactions. 2) replace. Alternatively
        we can replace an existing reaction with the hypothesis
        Returns:

        """
        reactions = self._reactions().split('\n')
        reactions = [i.strip() for i in reactions]
        # print(reactions)
        # get additional reactions for current topology

        hypotheses_needed = self._get_combinations()[self._topology]
        hypotheses_needed = [self.model_variant_reactions[i] for i in hypotheses_needed]
        replacements = [i.to_replace for i in hypotheses_needed]
        s = ''
        for reaction in reactions:
            ## reaction name is always the first word, without the colon
            reaction_name = re.findall('^\w+', reaction)

            if reaction_name == []:
                s += '\t\t' + reaction + '\n'
                # continue

            elif reaction_name[0] in replacements:
                # get index of the reaction we want to replace
                idx = replacements.index(reaction_name[0])
                replacement_reaction = hypotheses_needed[idx]
                s += '\t\t' + str(replacement_reaction) + '\n'
            elif reaction_name[0] not in replacements:
                s += '\t\t' + reaction + '\n'
            else:
                raise ValueError('This should not happen')

        # now add the additional extention hypotheses marked as additive
        for i in hypotheses_needed:
            if i.mode == 'additive':
                s += str(i) + '\n'
        return s

    def get_all_parameters_as_list(self):
        all_parameters = self._default_parameter_str().split('\n')
        all_parameters = [i.strip() for i in all_parameters]
        all_parameters = [re.findall('^\w+', i) for i in all_parameters]
        all_parameters = [i for i in all_parameters if i != []]
        all_parameters = [i[0] for i in all_parameters]
        return all_parameters

    def _build_antimony(self, best_parameters=False):
        """

        :param best_parameters: If False, use default parameters. If
            True, use the best parameters from current fit dir. If a string,
            then it is a parameter set as antimony string
        :return:
        """
        s = ''
        s += self._functions()
        s += 'model CrossTalkModelTopology{}'.format(self.topology)
        s += self._compartments()
        s += self._build_reactions()

        if best_parameters is False:
            s += self._default_parameter_str()
        elif best_parameters is True:
            s += self.get_best_model_parameters_as_antimony()
            # LOG.debug('The best parameters are \n{}'.format(self.get_best_model_parameters_as_antimony()))
            # elif isinstance(best_parameters, str):
            #     LOG.debug('best_parameters is a string:\n{}'.format(best_parameters))

        else:
            raise ValueError
        s += self._events()
        s += self._units()
        s += "\nend"

        # we now need to remove any global parameters that are not used in the current model topology
        exclude_list = ['Cell', 'ExperimentIndicator']  # we want to keep these
        for useless_parameter in self.get_all_parameters_as_list():
            if useless_parameter not in self._build_reactions():
                if useless_parameter not in exclude_list:
                    s = re.sub(useless_parameter + '.*\n', '', s)
        return s

    def _default_parameter_set_as_dict(self):
        string = self._default_parameter_str()
        strings = string.split('\n')
        dct = OrderedDict()
        for s in strings:
            if s.strip() == '':
                continue
            if ':=' in s:
                k, v = s.split(':=')
            elif '=' in s:
                k, v = s.split('=')

            k = k.strip()
            v = v.replace(';', '')
            try:
                dct[k] = float(v)
            except ValueError:
                dct[k] = v

        return dct

    def _functions(self):
        return """
        function MM(km, Vmax, S)
                Vmax * S / (km + S)
            end

            function MMWithKcat(km, kcat, S, E)
                kcat * E * S / (km + S)
            end


            function NonCompetitiveInhibition(km, ki, Vmax, n, I, S)
                Vmax * S / ( (km + S) * (1 + (I / ki)^n ) )
            end
            
            function NonCompetitiveInhibitionWithKcat(km, ki, kcat, E, n, I, S)
                kcat * E * S / ( (km + S) * (1 + (I / ki)^n ) )
            end
            
            function NonCompetitiveInhibitionWithKcatAndExtraActivator(km, ki, kcat, E1, E2, n, I, S)
                kcat * E1 * E2 * S / ( (km + S) * (1 + (I / ki)^n ) )
            end


            function MA1(k, S)
                k * S
            end

            function MA2(k, S1, S2)
                k * S1 * S2
            end

            function MA1Mod(k, S, M)
                k * S * M
            end

            function MA2Mod(k, S1, S2, M)
                k * S1 * S2 * M
            end

            function CompetitiveInhibitionWithKcat(km, ki, kcat, E, I, S)
                kcat * E * S / (km + S + ((km * I )/ ki)  )
            end    

            function CompetitiveInhibition(Vmax, km, ki, I, S)
                Vmax * S / (km + S + ((km * I )/ ki)  )
            end
            
            function Hill(km, kcat, L, S, h)
                kcat * L * (S / km)^h  /   1 + (S / km)^h 
            end
        """

    def _compartments(self):
        """

        :return:
        """
        return """
        compartment Cell = 1.0

        var Smad2           in Cell  
        var pSmad2          in Cell  
        var Erk             in Cell
        var pErk            in Cell  
        var Akt             in Cell
        var pAkt            in Cell  
        var S6K             in Cell
        var pS6K            in Cell  

        const TGFb             in Cell
        const AZD              in Cell
        const GrowthFactors    in Cell
        const MK2206           in Cell
        const Everolimus       in Cell"""

    def _reactions(self):
        return """
        //TGFb module
        TGFbR1: Smad2 => pSmad2 ; _kSmad2PhosByTGFb*Smad2*TGFb;
        TGFbR2: pSmad2 => Smad2 ; _kSmad2Dephos*pSmad2;

        //MAPK module
        MAPKR1: Erk => pErk ; kErkPhosByGF*Erk*GrowthFactors;
        MAPKR2: Erk => pErk ; CompetitiveInhibitionWithKcat(_kErkPhosByTGFb_km, _kErkPhosByTGFb_ki, _kErkPhosByTGFb_kcat, TGFb, AZD, Erk);     //(km, ki, kcat, E, I, S)
        MAPKR3: pErk => Erk ; _kErkDephos*pErk;

        //Akt Module
        PI3KR1: Akt => pAkt ; kAktPhosByGF*Akt*GrowthFactors; 
        PI3KR2: Akt => pAkt ; NonCompetitiveInhibitionWithKcat(_kAktPhosByTGFb_km, _kAktPhosByTGFb_km, _kAktPhosByTGFb_kcat, TGFb, 1, MK2206, Akt);  //(km, ki, kcat, E, n, I, S)
        PI3KR3: pAkt => Akt  ; _kAktDephos*pAkt*pS6K;
        PI3KR4: S6K => pS6K ; CompetitiveInhibitionWithKcat(_kS6KPhosByAkt_km, _kS6KPhosByAkt_ki, _kS6KPhosByAkt_kcat, pAkt, Everolimus, S6K); //(km, ki, kcat, E, I, S)
        PI3KR5: pS6K => S6K ; _kS6KDephos*pS6K;

        // Cross talk reactions
    """

    def _default_parameter_str(self):
        return """        
        Akt = 45.000013943547444;
		Erk = 80.0000247885287;
		S6K = 45.000013943547444;
		Smad2 = 45.000013943547444;
		pAkt = 5.000001549283042;
		pErk = 10.000003098566063;
		pS6K = 5.000001549283042;
		pSmad2 = 5.000001549283042;
		Cell = 1.0;
		AZD = 0.0;
		Everolimus = 0.0;
		ExperimentIndicator = 0.0;
		GrowthFactors = 1.0;
		MK2206 = 0.0;
		TGFb = 0.005;
		
        kErkPhosByGF           = 0.1;
        kAktPhosByGF           = 0.1;
		_kSmad2PhosByTGFb      = 0.1;
        _kSmad2Dephos          = 0.1;
        _kErkPhosByTGFb_km     = 0.1;
        _kErkPhosByTGFb_ki     = 0.1;
        _kErkPhosByTGFb_kcat   = 0.1;
        _kErkDephos            = 0.1;
        _kAktPhosByTGFb_km     = 0.1;
        _kAktPhosByTGFb_km     = 0.1;
        _kAktPhosByTGFb_kcat   = 0.1;
        _kAktDephos            = 0.1;
        _kS6KPhosByAkt_km      = 0.1;
        _kS6KPhosByAkt_ki      = 0.1;
        _kS6KPhosByAkt_kcat    = 0.1;
        _kS6KDephos            = 0.1;
        _kAktPhosSmad2_km      = 0.1;
        _kAktPhosSmad2_ki      = 0.1;
        _kAktPhosSmad2_kcat    = 0.1;
        _kErkPhosSmad2_km      = 0.1;
        _kErkPhosSmad2_ki      = 0.1;
        _kErkPhosSmad2_kcat    = 0.1;
        _kAktActivateErk       = 0.1;
        _kS6KActivateErk       = 0.1;
		
		"""

    def extension_hypothesis_AktActivateSmad2ErkInhibit(self):
        """
        This reaction must replace:
            TGFbR1: Smad2 => pSmad2 ; _kSmad2PhosByTGFb*Smad2*TGFb;
        Args:
            type:
            replacement_reaction:

        Returns:

        """
        return HypothesisExtension(
            name='CrossTalkR1',
            reaction='Smad2 => pSmad2',
            rate_law='NonCompetitiveInhibitionWithKcatAndExtraActivator(_kAktPhosSmad2_km, _kAktPhosSmad2_ki, _kAktPhosSmad2_kcat, TGFb, pAkt, 1, pErk, Smad2)',
            mode='replace',
            to_repalce='TGFbR1'
        )

    def extension_hypothesis_ErkActivateSmad2AktInhibit(self):
        return HypothesisExtension(
            name='CrossTalkR2',
            reaction='Smad2 => pSmad2',
            rate_law='NonCompetitiveInhibitionWithKcatAndExtraActivator(_kErkPhosSmad2_km, _kErkPhosSmad2_ki, _kErkPhosSmad2_kcat, TGFb, pErk, 1, pAkt, Smad2);  //(km, ki, kcat, E, n, I, S)',
            mode='replace',
            to_repalce='TGFbR1'
        )

    def extension_hypothesis_AktActivateErk(self):
        return HypothesisExtension(
            name='CrossTalkR3',
            reaction='Erk => pErk',
            rate_law='_kAktActivateErk*Erk*pAkt',
            mode='additive',
            to_repalce=None
        )

    def extension_hypothesis_S6KActivateErk(self):
        return HypothesisExtension(
            name='CrossTalkR4',
            reaction='Erk => pErk',
            rate_law='_kS6KActivateErk*Erk*pS6K',
            mode='additive',
            to_repalce=None
        )
    def extension_hypothesis_ErkActivatesS6K(self):
        return HypothesisExtension(
            name='CrossTalkR5',
            reaction='S6K => pS6K',
            rate_law='_ErkActivateS6K*pErk*S6K',
            mode='additive',
            to_repalce=None
        )

    def _events(self):
        """
        D = 0
        T = 1
        AZD at t=1.25 == 2
        AZD at t=24 == 3
        AZD at t=48 == 4
        AZD at t=72 == 5
        MK2206 at t=1.25 == 6
        MK2206 at t=24 == 7
        MK2206 at t=48 == 8
        MK2206 at t=72 == 9
        MK2206 and AZD at t=24  == 10
        MK2206 and AZD at t=48 == 11
        MK2206 and AZD at t=72 == 12

        :return:
        """
        return """
        // events in all simulations
        SerumStarveRemoveTGFb: at (time>70.25): TGFb=0.00005;
        SerumStarveRemoveGrowthFactors: at (time>70.25): GrowthFactors=0.005;

        // these events are dependent on the experiment indicated by the ExperimentIndicator Variable
        AddTGFb:        at (time>71.25  and ExperimentIndicator >  0):   TGFb=1;
        AddAZD_1_25:    at (time>70.75  and ExperimentIndicator == 2):   AZD=1;
        AddAZD_24:      at  (time>48    and ExperimentIndicator == 3):   AZD=1;
        AddAZD_48:      at  (time>24    and ExperimentIndicator == 4):   AZD=1;
        AddAZD_72:      at  (time>0     and ExperimentIndicator == 5):   AZD=1;
        AddMK_1_25:     at (time>70.75  and ExperimentIndicator == 6):   MK2206=1;
        AddMK_24:       at (time>48     and ExperimentIndicator == 7):   MK2206=1;
        AddMK_48:       at (time>24     and ExperimentIndicator == 8):   MK2206=1;
        AddMK_72:       at (time>0      and ExperimentIndicator == 9):   MK2206=1;
        AddAZDAndMK_24: at (time>48     and ExperimentIndicator == 10):  MK2206=1, AZD=1;
        AddAZDAndMK_48: at (time>24     and ExperimentIndicator == 11):  MK2206=1, AZD=1;
        AddAZDAndMK_72: at (time>0      and ExperimentIndicator == 12):  MK2206=1, AZD=1;
        """

    def _units(self):
        return """
        unit volume = 1 litre;
        unit time_unit = 3600 second;
        unit substance = 1e-9 mole;
        """

    def get_best_parameters_from_last_fit(self, last_fit):
        from copy import deepcopy
        current_fit = deepcopy(self.fit)
        self.fit = last_fit
        best_parameters_antimony = self.get_best_model_parameters_as_antimony()
        self.fit = current_fit
        return best_parameters_antimony

    def get_rank_of_fim(self, fim_file, param_file):
        """
        The rank of the FIM close to an optimum determines the number
        of linearly independent rows/columns.

        The scaled FIM is full rank but the unscaled FIM is not.
        I suspect that to calculate the RANK you should use the
        unscaled matrix while for analysing the curvature of
        parameter space around the optimum we should use the
        scaled version.

        :param fim_file:
        :param param_file:
        :return:
        """
        df = pandas.read_csv(fim_file, header=None)
        params = pandas.read_csv(param_file, index_col=0)
        df.columns = params.index
        df.index = params.index
        rank = numpy.linalg.matrix_rank(df.values)
        return rank

    def analyse_fim(self, fim_file, param_file):
        """

        :param fim_file:
        :param param_file:
        :return:
        """
        df = pandas.read_csv(fim_file, header=None)
        params = pandas.read_csv(param_file, index_col=0)
        df.columns = params.index
        df.index = params.index
        import sympy
        sym_mat = sympy.Matrix(df.values)

    def get_parameters_from_copasi(self, mod):
        """
        get parameters from copasi model
        :param mod:
        :return:
        """
        dct = {i.name: i.initial_value for i in mod.global_quantities}
        metab = {i.name: i.concentration for i in mod.metabolites}
        vol = {i.name: i.initial_value for i in mod.compartments}
        s = ''
        for k in sorted(metab):
            s += "        {} = {};\n".format(k, metab[k])

        for k in sorted(vol):
            s += "        {} = {};\n".format(k, vol[k])

        for k in sorted(dct):
            s += "        {} = {};\n".format(k, dct[k])

        return dct, s

    def analyse_correlations(self, gl=0.7):
        """

        :param corr_file: Correlation matrix. Output from copasi parameter estimation talk
        :param param_file: Parameter file. Output from copasi parameter estimation task. Used for labelling matrix
        :param gl: greater than. The cut off.
        :return:
        """
        corr_file = os.path.join(self.fit_dir, 'correlation_matrix.csv')
        if not os.path.isfile(corr_file):
            raise ValueError('"{}" is not a file. You need to '
                             'run a current solution statistics '
                             'parameter estimation with the '
                             'calculate statistics button turned on '
                             'and a regular "Parameter Estimation" '
                             'report defined. Then extract the '
                             'correlation matrix, save it in a '
                             'csv file called "correlation_matrix.csv" in '
                             'your current fit dir, i.e. "{}"'.format(
                corr_file, self.fit_dir
            ))

        if gl > 1 or gl < 0:
            raise ValueError

        df = pandas.read_csv(corr_file, header=None)
        params = self._configure_PE_for_viz().model.fit_item_order
        df.columns = params
        df.index = params
        import itertools
        comb = itertools.combinations(list(df.columns), 2)
        l = []
        for i, j in comb:
            if df.loc[i, j] > gl:
                l.append([i, j, df.loc[i, j]])
            elif df.loc[i, j] < -gl:
                l.append([i, j, df.loc[i, j]])

        df = pandas.DataFrame(l)
        df.columns = ['param1', 'param2', 'correlation']
        df.sort_values(by='correlation', inplace=True)
        fname = os.path.join(os.path.dirname(corr_file), 'filtered_correlation_matrix_gl_0.7.csv')
        df.to_csv(fname)
        LOG.info('filtered correlations now in "{}"'.format(fname))


    def plot_timecourse(self, selection=['pAkt', 'pErk', 'pS6K', 'pSmad2']):
        """

        :return:
        """
        import matplotlib
        matplotlib.use('Qt5Agg')
        seaborn.set_context('talk')
        df = self.simulate_conditions(selection=selection, best_parameters=True)
        cond = sorted(list(set(df.index.get_level_values(0))))
        proteins = df.columns
        for c in cond:
            fig = plt.figure()
            plt.title(c)
            for p in proteins:
                plt.plot(df.loc[c].index, df.loc[c, p], label=p)
            plt.legend(loc=(1, 0.1))
            seaborn.despine(fig=fig, top=True, right=True)
            fname = os.path.join(self.graphs_dir, 'timeseries_{}.png'.format(c))
            fig.savefig(fname, dpi=200, bbox_inches='tight')
            LOG.info('saving timeseries object to "{}"'.format(fname))

    def get_euclidean(self, best_parameters=True):
        exp = self.get_experimental_data()
        exp = exp[['pAkt', 'pSmad2', 'pErk', 'pS6K']]
        exp.index = exp.index.droplevel(1)

        sim_data = self.simulate_conditions(best_parameters=best_parameters)
        sim_data = sim_data.reset_index(level=1)
        sim_data = sim_data.rename(columns={'level_1': 'Time'})
        sim_data = sim_data[sim_data['Time'] == 72]
        del sim_data['Time']

        return (exp - sim_data) ** 2

    def plot_performance_matrix(self, cmap):
        import matplotlib
        matplotlib.use('Qt5Agg')
        seaborn.set_style('white')
        seaborn.set_context('talk', font_scale=1)

        eucl = self.get_euclidean()
        eucl.index = [i.replace('72', '') for i in eucl.index]
        # print(eucl)

        fig = plt.figure()
        seaborn.heatmap(numpy.log10(eucl), cmap=cmap, annot=True,
                        linecolor='black', linewidths=3, cbar_kws={'label': r'log$_{10}$ Euclidean Distance'})
        plt.title(f'"{self.list_topologies().loc[self.topology, "Topology"].replace("_", ",")}" topology',
                  fontsize=16)
        plt.yticks(rotation=0)
        # heatmap_dir = os.path.join(self.model_selection_dir, 'PerformanceMatrix')
        # if not os.path.isdir(heatmap_dir):
        #     os.makedirs(heatmap_dir)
        fname = os.path.join(self.graphs_dir, f'topology{self.topology}.png')
        fig.savefig(fname, dpi=300, bbox_inches='tight')
        LOG.info(fname)
        LOG.info(self.list_topologies())

    @staticmethod
    def plot_competitive_inhibition_rate_law():
        """
        kcat * A * S / (km + S + (km * A / S))
        Returns:
        """
        import sympy
        from mpl_toolkits.mplot3d import Axes3D
        import matplotlib
        matplotlib.use('Qt5Agg')
        seaborn.set_context(context='talk')

        kcat = 300
        km = 75
        ki = 5
        s = 50

        def eq(kcat, A, S, km, I, ki):
            return kcat * A * S / (km + S + (km * I / ki))

        fig = plt.figure()
        ax = fig.add_subplot(111, projection='3d')
        x = y = numpy.arange(0.001, 50, 0.05)
        X, Y = numpy.meshgrid(x, y)
        zs = numpy.array(eq(kcat, numpy.ravel(X), s, km, numpy.ravel(Y), ki))
        Z = zs.reshape(X.shape)

        ax.plot_surface(X, Y, Z)

        ax.set_xlabel('Activator (x)')
        ax.set_ylabel('Inhibitor (y)')
        ax.set_zlabel('Reaction Rate (z)')

        plt.show()

    def extract_graphs(self, to=None):
        dest = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelectionProblems/graphs'
        dest = os.path.join(self.problem_directory, 'graphs_extraction')
        if not os.path.isdir(dest):
            os.makedirs(dest)

        # problem_to_include = [40, 41, 42, 43, 44, 45]
        # conds = ['all', 'DTE', 'PlusA', 'PlusM', 'PlusEA', 'PlusEM']
        # l = ['{}{}'.format(problem_to_include[i], conds[i]) for i in range(problem_to_include)]
        # problem_dirs = [os.path.join(dest, 'Problem{}'.format(i)) for i in problem_to_include]

        graphs_f = glob.glob(os.path.join(self.graphs_dir, '*.png'))[0]
        topology_name = self.list_topologies().loc[self.topology, 'Topology']

        fname = os.path.join(dest, '{}{}.png'.format(self.topology, topology_name))

        import shutil
        shutil.copy(graphs_f, fname)

        # print(self.graphs_dir)

        # print(graphs_f)

        # new_name =

        # print(topology_name)


if __name__ == '__main__':

    # problem 62 is the model selection problem where we reduced the network
    for i in range(68, 69):

        PROBLEM = i
        ## Which model is the current focus of analysis
        CURRENT_MODEL_ID = 10

        FIT = '1'

        CLUSTER = False

        ## True, False, 'slurm' or 'sge'. Passed onto parameter estimation class
        RUN_MODE = False

        ## Configure and run the parameter estimations
        RUN_PARAMETER_ESTIMATION = False

        RUN_PARAMETER_ESTIMATION_FROM_BEST_PARAMETERS = False

        PLOT_CURRENT_SIMULATION_GRAPHS_WITH_COPASI_PARAMETERS = False

        ## iterate over all models and plot comparison between model and simulation
        PLOT_ALL_SIMULATION_GRAPHS = False

        ## plot performance matrix
        PLOT_PERFORMANCE_MATRIX = False

        ## plot comparison between model and simulation for the current model ID
        PLOT_ALL_BARGRAPHS_WITH_BEST_PARAMETERS = False

        ## Plot current simulation graphs with the default parameter instead of best estimated
        PLOT_CURRENT_SIMULATION_GRAPHS_WITH_DEAULT_PARAMETERS = False

        # Use CURRENT_MODEL_ID to determine which time series is plotted
        PLOT_TIMESERIES_WITH_CURRENT_MODEL = False

        #
        PLOT_ALL_TIMESERIES_WITH_BEST_PARAMETERS = False

        ## extract best RSS per model and compute AICc
        AICs = False

        ## Plot likelihood ranks plots
        LIKELIHOOD_RANKS = True

        ## get the best parameter set as a dict and antimony format from the model pointed to by CURRENT_MODEL_ID
        GET_BEST_PARAMETERS = False

        ## open the model currently pointed to by CURRENT_MODEL_ID
        OPEN_WITH_COPASI = False

        ## open the model currently pointed to by CURRENT_MODEL_ID with the best estimated parameters from FIT
        OPEN_WITH_COPASI_WITH_BEST_PARAMETERS = False

        ##
        OPEN_WITH_COPASI_AND_CONFIGURE_PARAMETER_ESTIMATION_BUT_DONT_RUN = False

        ## Produce the parameters already present in the COPASI model pointed to by CURRENT_MODEL_ID in antimony format.
        GET_PARAMETERS_FROM_COPASI = False

        ## insert the best parameters from current fit into the models
        INSERT_BEST_PARAMETERS_INTO_ALL_COPASI_FILES = False

        INSERT_BEST_PARAMETERS_FROM_LAST_FIT_AND_PLOT = False

        ## analyse correlations
        ANALYSE_CORRELATIONS = False


        PLOT_COMPETITIVE_INHIBITION_RATE_LAW = False

        EXTRACT_GRAPHS = False

        ##===========================================================================================

        if CLUSTER == 'slurm':
            WORKING_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel'
            DATA_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel/data/CopasiDataFiles/all_data'
            PROBLEM_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel/ModelSelectionProblems/Problem{}'.format(
                PROBLEM)

        elif CLUSTER == 'sge':
            PROBLEM_DIRECTORY = r'/sharedlustre/users/b3053674/2019/CrossTalkModel/ModelSelectionProblems/Problem{}'.format(
                PROBLEM)

        elif CLUSTER == False:
            WORKING_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel'
            DATA_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/all_data'
            PROBLEM_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelectionProblems/Problem{}'.format(
                PROBLEM)

        else:
            raise ValueError

        C = CrossTalkModel(PROBLEM_DIRECTORY, DATA_DIRECTORY, fit=FIT,
                           mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')],
                           method='particle_swarm',
                           copy_number=100,
                           run_mode=RUN_MODE,
                           iteration_limit=3000,
                           swarm_size=100,
                           population_size=50,
                           number_of_generations=300,
                           overwrite_config_file=True,
                           lower_bound=0.000001,
                           upper_bound=1000000,
                           )
        # print(C[0]._build_antimony())

        LOG.info(f'the size of your model selection problem is {len(C)}')
        LOG.info('num of estimated parameters={}'.format(C._get_number_estimated_model_parameters()))
        # C[CURRENT_MODEL_ID].plot_bargraphs2(best_parameters=True)
        # plt.show()
        # C[CURRENT_MODEL_ID].get_errors2()

        if EXTRACT_GRAPHS:
            for i in C:
                C[i].extract_graphs()

        if PLOT_COMPETITIVE_INHIBITION_RATE_LAW:
            CrossTalkModel.plot_competitive_inhibition_rate_law()

        if PLOT_PERFORMANCE_MATRIX:
            cmaps = ['Greens', 'Blues', 'Reds', 'Oranges']
            for i in range(len(C)):
                C[i].plot_performance_matrix('Greens')

        if GET_PARAMETERS_FROM_COPASI:
            mod = model.Model(C[CURRENT_MODEL_ID].copasi_file)
            dct = {i.name: i.initial_value for i in mod.global_quantities}
            metab = {i.name: i.concentration for i in mod.metabolites}
            vol = {i.name: i.initial_value for i in mod.compartments}
            s = ''
            for k in sorted(metab):
                s += "        {} = {};\n".format(k, metab[k])

            for k in sorted(vol):
                s += "        {} = {};\n".format(k, vol[k])

            for k in sorted(dct):
                s += "        {} = {};\n".format(k, dct[k])
            LOG.info(dct)
            LOG.info(s)

        if OPEN_WITH_COPASI:
            mod = C[CURRENT_MODEL_ID].to_copasi()
            mod.open()

        if OPEN_WITH_COPASI_WITH_BEST_PARAMETERS:
            mod = C[CURRENT_MODEL_ID].insert_best_parameters()
            LOG.debug(C[CURRENT_MODEL_ID].get_best_model_parameters_as_antimony())

            mod = tasks.TimeCourse(mod, end=75, intervals=75 * 100, step_size=0.01, run=False).model
            mod = tasks.Scan(mod, variable='Everolimus', minimum=0, maximum=1, number_of_steps=1,
                             subtask='time_course').model

            mod.open()

        if OPEN_WITH_COPASI_AND_CONFIGURE_PARAMETER_ESTIMATION_BUT_DONT_RUN:
            pe = C[CURRENT_MODEL_ID]._configure_PE_for_viz()
            pe.model.open()


        if RUN_PARAMETER_ESTIMATION:
            for model_id in C:
                C[model_id].run_parameter_estimation()

        if RUN_PARAMETER_ESTIMATION_FROM_BEST_PARAMETERS:
            for model_id in C:
                best_params = C[model_id].get_best_parameters_from_last_fit(LAST_FIT)
                LOG.info('best parameters\n'.format(
                    best_params
                ))
                PE = C[model_id].run_parameter_estimation_from_parameter_set(best_params, run_mode=RUN_MODE)
                # PE.model.open()

        if PLOT_ALL_SIMULATION_GRAPHS:
            for model_id in range(len(C)):
                LOG.info('plotting model {}'.format(model_id))
                # try:
                C[model_id].plot_bargraphs(best_parameters=True)
                # except ValueError:
                #     LOG.info("model '{}' skipped! No data to plot".format(model_id))
                #     continue
                # except RuntimeError:
                #     LOG.info("model '{}' skipped! RunTimeError".format(model_id))
                #     continue

        if PLOT_ALL_BARGRAPHS_WITH_BEST_PARAMETERS:
            LOG.info('fit dir: {}'.format(C[CURRENT_MODEL_ID].fit_dir))
            C[CURRENT_MODEL_ID].plot_bargraphs(best_parameters=True)

        if PLOT_CURRENT_SIMULATION_GRAPHS_WITH_DEAULT_PARAMETERS:
            LOG.info('fit dir', C[CURRENT_MODEL_ID].fit_dir)
            C[CURRENT_MODEL_ID].plot_bargraphs(best_parameters=False)

        # if PLOT_CURRENT_SIMULATION_GRAPHS_WITH_COPASI_PARAMETERS:
        #     copasi_file = '/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelectionProblems/Problem3/ModelSelection/Topology77/Fit1/topology77_for_playing_with.cps'
        #     mod = model.Model(copasi_file)
        #     # LOG.info(C[CURRENT_MODEL_ID].fit_dir)
        #     dct, ant = C[CURRENT_MODEL_ID].get_parameters_from_copasi(mod)
        #     # LOG.info(ant)
        #     C[CURRENT_MODEL_ID].plot_bargraphs(best_parameters=ant)

        if GET_BEST_PARAMETERS:
            ant = C[CURRENT_MODEL_ID].get_best_model_parameters_as_antimony()
            dct = C[CURRENT_MODEL_ID].get_param_df().iloc[0].to_dict()
            LOG.info(ant)
            LOG.info(dct)

        # C[4].run_parameter_estimation_from_best_estimates()

        # PE = C[4].run_parameter_estimation()
        # PE.model.open()

        # PE = C[2]._configure_PE_for_viz()
        # PE.model.open()

        if LIKELIHOOD_RANKS:
            for model_id in C:
                C[model_id].likelihood_ranks()

        if AICs:
            df, fname = C.compute_all_aics(overwrite=True)

        if INSERT_BEST_PARAMETERS_INTO_ALL_COPASI_FILES:
            for i in C:
                LOG.info(C[i].insert_best_parameters())

        if INSERT_BEST_PARAMETERS_FROM_LAST_FIT_AND_PLOT:
            """
            Used in Problem3 fit 3 because the second parameter estimation 
            I ran was a subproblem of the first 
            """
            # for model_id in C:
            prev_best_params = C[CURRENT_MODEL_ID].get_best_parameters_from_last_fit(LAST_FIT)
            C[CURRENT_MODEL_ID].insert_parameters(prev_best_params)
            current_best_params = C[CURRENT_MODEL_ID].get_best_model_parameters_as_antimony()
            C[CURRENT_MODEL_ID].plot_bargraphs(best_parameters=current_best_params)

        if ANALYSE_CORRELATIONS:
            C[CURRENT_MODEL_ID].analyse_correlations()

        if PLOT_TIMESERIES_WITH_CURRENT_MODEL:
            C[CURRENT_MODEL_ID].plot_timecourse()

        if PLOT_ALL_TIMESERIES_WITH_BEST_PARAMETERS:
            for i in C:
                C[i].plot_timecourse()

# make sure you are simulating from start condition. add reset to appriopriate plate .
