from constants import *
import site, os, glob
import pandas, numpy
import re
import tellurium as te

# site.addsitedir(r'/home/ncw135/Documents/pycotools3')
# site.addsitedir(r'D:\pycotools3')
from pycotools3 import model, tasks, viz
from itertools import combinations
import matplotlib.pyplot as plt
import seaborn


class ParameterSet(dict):
    def __init__(self, *args):
        super().__init__(*args)


parameter_set_rss_174_topology_7 = """
		TGFbR = 45.0;
		Smad2 = 45.0;
		Mek = 40.0;
		Erk = 40.0;
		PI3K = 45.0;
		Akt = 45.0;
		mTORC1 = 45.0;
		S6K = 45.0;
		Raf = 45.0;
		ppMek = 45.0;
		TGFbR_a = 5.0;
		pSmad2 = 5.0;
		pMek = 5.0;
		pErk = 5.0;
		pPI3K = 5.0;
		pAkt = 5.0;
		pmTORC1 = 5.0;
		pS6K = 5.0;
		pRaf = 5.0;
		ppErk = 5.0;
		Cell = 1.0;
		TGFb = 0.005;
		GrowthFactors = 1.0;
		ExperimentIndicator = 0.0;
		AZD = 0.0;
		MK2206 = 0.0;
		Everolimus = 0.0;
		kTGFbRAct_km = 10.0;
		kTGFbRDephos_km = 100.0;
		kSmad2Phos_km = 50.0;
		kSmad2Dephos_km = 30.0;
		kSmad2Dephos_Vmax = 20.0;
		kRafPhos_km = 10.0;
		kRafPhos_Vmax = 9000.0;
		kRafPhos_n = 1.0;
		kRafDephos_km = 8.0;
		kRafDephosVmax = 3602.5;
		kMekPhos_km1 = 15.0;
		kMekDephos_km = 15.0;
		kMekDephos_Vmax = 2700.0;
		kErkPhos_km = 50.0;
		kErkDephos_km = 15.0;
		kErkDephos_Vmax = 1800.0;
		kPI3KPhosByGF_km = 50.0;
		kPI3KDephosByS6K_km = 50.0;
		kAktPhos_km = 12.5;
		kAktDephos_km = 15.0;
		kAktDephos_Vmax = 30.0;
		kmTORC1Phos_km = 50.0;
		kmTORCPhosBasal_km = 25.0;
		kmTORC1Dephos_km = 100.0;
		kmTORC1Dephos_Vmax = 4.0;
		kS6KPhosBymTORC1_km = 100.0;
		kS6KDephos_km = 10.0;
		kS6KDephos_Vmax = 50.0;
		kRafPhosByTGFbR_km = 25.0;
		kRafPhosByPI3K_km = 50.0;
		kPI3KPhosByTGFbR_km = 10.0;
		kPI3KDephosByErk_km = 10.0;
		kSmad2PhosByAkt_km = 50.0;
		kSmad2DephosByErk_km = 50.0;
		kSmad2PhosByErk_km = 50.0;
		kSmad2DehosByAkt_km = 50.0;
		kSmad2DephosByAkt_km = 50.0;
		kTGFbRAct_h = 2.0;
		_kTGFbRAct_Vmax = 733.115;
		kTGFbRDephos_Vmax = 999.999;
		_kSmad2Phos_kcat = 0.30301500000000003;
		_kRafPhos_ki = 853.3789999999998;
		_kMekPhos_ki = 0.679746;
		_kMekPhos_kcat = 317.451;
		_kErkPhos_kcat = 200.957;
		_kPI3KPhosByGF_kcat = 0.00117777;
		_kPI3KDephosByS6K_kcat = 56.8181;
		_kAktPhos_ki = 0.381168;
		_kAktPhos_kcat = 0.435405;
		_kmTORC1Phos_ki = 0.0203352;
		_kmTORC1Phos_kcat = 0.00100084;
		_kmTORCPhosBasal_Vmax = 46.4378;
		_kS6KPhosBymTORC1_kcat = 1.97702;
		_kRafPhosByTGFbR_kcat = 0.00262984;
		_kRafPhosByPI3K_kcat = 77.1417;
		_kPI3KPhosByTGFbR_kcat = 23.8593;
		_kSmad2PhosByAkt_kcat = 0.950982;
		_kSmad2DephosByErk_kcat = 0.00100003;
		_kPI3KDephosByErk_kcat = 0.00100024;
		_kSmad2PhosByErk_kcat = 0.1;
		_kSmad2DephosByAkt_kcat = 0.1;
"""


class CrossTalkModel:
    """
    build a factory that churns out functions that return models and take as argument the
    antimony parameter strings
    """

    def __init__(self, working_directory,
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
        """
        :param variant: int. 1 to 7. ID of topology
        :param parameter_str: parameter set for the model as antimony string
        """
        self.parameter_str = parameter_str
        self._topology = 0
        self.working_directory = working_directory



        if not os.path.isdir(self.working_directory):
            os.makedirs(self.working_directory)

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

        self.old_model_variant_reactions = {
            1: self._akt_activate_smad2(),
            2: self._akt_inhibits_smad2(),
            3: self._erk_activates_smad2(),
            4: self._erk_inhibits_smad2()
        }

        self.model_variant_reactions = {
            1: self.raf_phos_by_TGFbR(),
            2: self.pi3k_phos_by_TGFbR(),
            3: self.raf_phos_by_PI3K(),
            4: self.pi3k_dephos_by_erk(),
            5: self.mek_phos_by_pi3k(),
            6: self.pi3k_phos_by_mek(),
            7: self.mek_dephos_by_akt(),
        }

        self.old_topology_names = {
            1: 'AktActivate',
            2: 'ErkActivate',
            3: 'AktInhibit',
            4: 'ErkInhibit',
        }
        self.topology_names = {
            1: 'RafPhosByTGFbR',
            2: 'PI3KPhosByTGFbR',
            3: 'RafPhosByPI3K',
            4: 'PI3KDephosByErk',
            5: 'MekPhosByPI3K',
            6: 'PI3KPhosByMek',
            7: 'MekDephosByAkt',
        }

        print(self.topology)
        self.model_specific_reactions = self._assembel_model_reactions()[self.topology]
        ## run 33 models per model

        # for i in self._get_combinations():
        #     print(i)

    def __str__(self):
        return "CrossTalkModel(topology={})".format(self.topology)

    def __len__(self):
        """
        Subtract 1 for 0 indexed python
        :return:
        """
        # print('len', len(self._get_combinations()))
        return len(list(self._get_combinations())) - 1

    def __iter__(self):

        while self.topology < len(self) + 1:
            yield self.topology
            self.topology += 1

    def __getitem__(self, item):
        if not isinstance(item, int):
            raise TypeError('"item" should be of type int. Got "{}" instead'.format(type(item)))

        self.topology = item
        self.model_specific_reactions = self._assembel_model_reactions()[item]
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
        d = os.path.join(self.working_directory, 'ModelSelection')
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
    def data_dir(self):
        return os.path.join(self.working_directory, 'data/CopasiDataFiles')

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
    def old_results_directory(self):
        return os.path.join(self.fit_dir, 'MultipleParameterEstimationResults')

    @property
    def data_files(self):
        return glob.glob(os.path.join(self.data_dir, '*.csv'))

    def get_experimental_data(self):
        df_dct = {}
        for i in self.data_files:
            dire, fle = os.path.split(i)
            df_dct[fle[:-4]] = pandas.read_csv(i)
        return pandas.concat(df_dct)

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
            iconds['AZD'] = data.loc[0, 'AZD_indep']
            iconds['Everolimus'] = data.loc[0, 'Everolimus_indep']
            iconds['GrowthFactors'] = data.loc[0, 'GrowthFactors_indep']
            iconds['MK2206'] = data.loc[0, 'MK2206_indep']
            iconds['TGFb'] = data.loc[0, 'TGFb_indep']
            iconds['ExperimentIndicator'] = data.loc[0, 'ExperimentIndicator_indep']
            cond[name] = iconds

        df = pandas.DataFrame(cond).transpose()
        return df

    def simulate_conditions(self, selection=['pAkt', 'ppErk', 'pS6K', 'pSmad2'], best_parameters=False):
        mod = self.to_tellurium(best_parameters=best_parameters)
        conditions = self.get_experimental_conditions()
        # print(conditions)
        simulation_data = {}
        for cond in conditions.index:
            for variable in conditions.columns:
                value = conditions.loc[cond, variable]
                setattr(mod, variable, value)
            df = pandas.DataFrame(mod.simulate(0, 72, 73, selection))
            df.columns = selection
            simulation_data[cond] = df

        return pandas.concat(simulation_data)

    def plot_bargraphs(self, best_parameters=False, selections=['pAkt', 'pS6K', 'ppErk']):
        import matplotlib
        matplotlib.use('TkAgg')
        seaborn.set_style('white')
        seaborn.set_context(context='talk')
        # , 'pSmad2']
        sim_data = self.simulate_conditions(best_parameters=best_parameters)
        sim_data = sim_data.reset_index(level=1)
        sim_data = sim_data.rename(columns={'level_1': 'Time'})
        sim_data = sim_data[sim_data['Time'] == 72]
        del sim_data['Time']

        exp_data = self.get_experimental_data()[selections]
        exp_data.index = exp_data.index.droplevel(1)

        azd_conditions = ['D', 'T', 'E',
                          'E_A_72', 'E_A_48', 'E_A_24', 'E_A_1.25',
                          'A_72', 'A_48', 'A_24', 'A_1.25']
        mk_conditions = ['D', 'T', 'E', 'E_M_72', 'E_M_48', 'E_M_24',
                         'E_M_1.25', 'M_72', 'M_48', 'M_24', 'M_1.25']
        both_conditions = ['D', 'T', 'E', 'E_A_M_72', 'E_A_M_48', 'E_A_M_24']

        azd_sim = sim_data.loc[azd_conditions].reset_index()
        mk_sim = sim_data.loc[mk_conditions].reset_index()
        both_sim = sim_data.loc[both_conditions].reset_index()

        azd_exp = exp_data.loc[azd_conditions].reset_index()
        mk_exp = exp_data.loc[mk_conditions].reset_index()
        both_exp = exp_data.loc[both_conditions].reset_index()

        print(sim_data)

        marker = '_'
        markersize = 3
        for sp in selections:
            fig, ax = plt.subplots()
            seaborn.barplot(x='index', y=sp, data=azd_sim, ax=ax,
                            palette=['yellow'] * 2 + ['white'] + ['red'] * 4 + ['green'] * 4,
                            edgecolor='black', zorder=0)

            seaborn.pointplot(x='index', y=sp, data=azd_exp, join=False,
                              color='blue', zorder=1, markers=marker, ax=ax,
                              markersize=markersize, legend=False,
                              mec='black')

            # for i in azd_exp
            plt.title(sp)
            plt.xlabel('')

            plt.xticks(rotation=90)
            seaborn.despine(fig=fig, top=True, right=True)
            fname = os.path.join(self.graphs_dir, 'AZD_' + sp + '.png')
            plt.savefig(fname, dpi=150, bbox_inches='tight')

            fig, ax = plt.subplots()
            seaborn.barplot(x='index', y=sp, data=mk_sim,
                            palette=['yellow'] * 2 + ['white'] + ['red'] * 4 + ['green'] * 4,
                            edgecolor='black', ax=ax, zorder=0)
            seaborn.pointplot(x='index', y=sp, data=mk_exp, join=False,
                              color='blue', markers=marker,
                              zorder=1, markersize=markersize, ax=ax,
                              legend=False)
            plt.xlabel('')
            plt.xticks(rotation=90)
            seaborn.despine(fig=fig, top=True, right=True)
            plt.title(sp)

            fname = os.path.join(self.graphs_dir, 'MK_' + sp + '.png')
            plt.savefig(fname, dpi=150, bbox_inches='tight')

            fig, ax = plt.subplots()
            seaborn.barplot(x='index', y=sp, data=both_sim,
                            palette=['yellow'] * 2 + ['white'] + ['red'] * 4 + ['green'] * 4,
                            edgecolor='black', ax=ax, zorder=0)
            seaborn.pointplot(x='index', y=sp, data=both_exp, join=False,
                              color='blue', markers=marker, ax=ax,
                              zorder=1, markersize=markersize,
                              legend=False)

            plt.xlabel('')
            plt.xticks(rotation=90)
            seaborn.despine(fig=fig, top=True, right=True)
            plt.title(sp)

            fname = os.path.join(self.graphs_dir, 'MK_AZD_' + sp + '.png')
            plt.savefig(fname, dpi=150, bbox_inches='tight')

    @property
    def copasi_file(self):
        return os.path.join(self.fit_dir, 'topology{}.cps'.format(self.topology))

    def list_topologies(self):
        topologies = OrderedDict()
        for i, tup in self._get_combinations():
            if i == 0:
                topologies[i] = 'Null'
            else:
                topologies[i] = '_'.join([self.topology_names[x].strip() for x in tup])
        df = pandas.DataFrame(topologies, index=['Topology']).transpose()
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
            weight_method=['value_scaling']*len(self.data_files),
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

        print('pe run mode', PE.run_mode)
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
        return viz.LikelihoodRanks(self._configure_PE_for_viz(), savefig=True).fig

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
        print('pe results directory', PE.results_directory)
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
            mod = self._configure_PE_for_viz().model
            return mod
        print(parameters.iloc[0])
        print(parameters.iloc[0].shape)
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
        all_reactions = self._reactions(self.model_specific_reactions)
        ## to include global variables not involved in reactions but needed for events
        all_reactions_plus_events = all_reactions+'\n'+self._events()
        s = ''
        for k, v in current_params.items():
            ## this is a mechanism for not including parameters that are not in the model
            ## in the antimony string
            if k in all_reactions_plus_events :
                s += "\t\t{} = {};\n".format(k, v)
        return s

    def _get_number_estimated_model_parameters(self):
        return len(self._configure_PE_for_viz().model.fit_item_order)

    def _get_n(self):
        '''
        get number of observed data points for AIC calculation
        '''
        print('WARNING. REMEMBER TO ADD SMAD2 BACK INTO THE AICC CALCULATION')
        n = 0
        for exp in self.data_files:
            data = pandas.read_csv(exp, sep=',')
            data = data[['pAkt', 'ppErk', 'pS6K']]  # , 'pSmad2']]
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
        for model_id in self:
            try:
                print(C[model_id])
                data = C[model_id].get_param_df()
                best_rss[model_id] = data.iloc[0]['RSS']
                aic[model_id] = C[model_id].aic(data.iloc[0]['RSS'])
            except ValueError:
                best_rss[model_id] = None
                aic[model_id] = None
        df = pandas.DataFrame({'RSS': best_rss, 'AICc': aic})
        df = pandas.concat([C.list_topologies(), df], axis=1)
        df = df.sort_values(by='AICc')
        df['AICc Rank'] = range(df.shape[0])
        df = df.sort_values(by='RSS')
        df['RSS Rank'] = range(df.shape[0])
        df = df.sort_index()
        df['f'] = df['RSS'] * df['RSS Rank'] * df['AICc Rank']
        df.to_csv(fname)

        return df, fname

    def _get_combinations(self):
        perm_list = [()]
        # print(range(1, len(self.model_variant_reactions)))
        for i in range(1, len(self.model_variant_reactions) + 1):
            perm_list += [j for j in combinations(range(1, len(self.model_variant_reactions) + 1), i)]

        ## plus the full set
        return enumerate(perm_list)  # + [tuple(range(1, len(self.model_variant_reactions)+1))])

    def _assembel_model_reactions(self):
        """
        assember the model specific reactions
        :return:
        """
        model_specific_reactions = {}
        for i, tup in self._get_combinations():
            model_specific_reactions[i] = '\n'.join([self.model_variant_reactions[x].strip() for x in tup])
            # print(i, tup, '\n\n', model_specific_reactions[i])
        return model_specific_reactions

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
        s += self._reactions(self.model_specific_reactions)
        if best_parameters is False:
            print('best_parameters is False')
            s += self._default_parameter_str()
        elif best_parameters is True:
            print('best_parameters is True')
            s += self.get_best_model_parameters_as_antimony()
            print('The best parameters are \n{}'.format(self.get_best_model_parameters_as_antimony()))
        # elif best_parameters == 'current_model_parameters':
        #     print('Building model with the parameters already in the copasi model')
        #     s += self.get_parameters_from_copasi()[1] ## returns (dct, antimony)
        elif isinstance(best_parameters, str):
            print('best_parameters is a string:\n{}'.format(best_parameters))

            s += best_parameters
        else:
            raise ValueError
        s += self._events()
        s += self._units()
        s += "\nend"

        ## now remove any parameters that belong to other models
        for useless_parameter in self._model_specific_parameter_list:
            if useless_parameter not in self._reactions(self.model_specific_reactions):
                s = re.sub(".*{}.*".format(useless_parameter), "", s)

        return s

    @property
    def _model_specific_parameter_list(self):
        """
        returns a list of parameters that do not appear in every version
        of the model - i.e. the smad topology module

        You could get these parameters automatically by
        looking at the combinatorial reactions
        :return:
        """
        return [
            'kSmad2PhosByAkt_km',
            'kSmad2DephosByErk_km',
            'kSmad2PhosByAkt_km',
            'kSmad2PhosByErk_km',
            'kSmad2DephosByErk_km',
            'kSmad2DehosByAkt_km',
            'kSmad2DephosByAkt_km',
            '_kSmad2PhosByAkt_kcat',
            '_kSmad2PhosByErk_kcat',
            '_kSmad2DephosByErk_kcat',
            '_kSmad2DephosByAkt_kcat',
            '_kSmad2DephosByAkt_kcat',

            'kRafPhosByTGFbR_km',
            '_kRafPhosByTGFbR_kcat',
            'kPI3KPhosByTGFbR_km',
            '_kPI3KPhosByTGFbR_kcat',
            'kRafPhosByPI3K_km',
            '_kRafPhosByPI3K_kcat',
            'kPI3KDephosByErk_km',
            '_kPI3KDephosByErk_kcat',
            'kMekPhosByPI3K_km',
            '_kMekPhosByPI3K_kcat',
            'kPI3KPhosByMek_km',
            '_kPI3KPhosByMek_kcat',
            'kMekDephosByAkt_km',
            '_kMekDephosByAkt_kcat',
        ]

    def _default_parameter_str(self):
        return """        
        
        Akt = 45.00002091532272;
        Erk = 80.00003718279595;
        Mek = 80.00002478852963;
        PI3K = 45.00002091532272;
        Raf = 90.00002788709588;
        S6K = 45.00002091532272;
        Smad2 = 45.00002091532272;
        TGFbR = 45.00002091532272;
        TGFbR_a = 5.000002323924742;
        mTORC1 = 45.00002091532272;
        pAkt = 5.000002323924742;
        pErk = 10.000004647849504;
        pMek = 10.000003098566165;
        pPI3K = 5.000002323924742;
        pRaf = 10.000001549282924;
        pS6K = 5.000002323924742;
        pSmad2 = 5.000002323924742;
        pmTORC1 = 5.000002323924742;
        ppErk = 10.000004647849504;
        ppMek = 10.000015492832484;
        Cell = 1.0;
        AZD = 0.0;
        Everolimus = 0.0;
        ExperimentIndicator = 0.0;
        GrowthFactors = 1.0;
        MK2206 = 0.0;
        TGFb = 0.005;
        _kAktPhos_kcat = 2.21547;
        _kAktPhos_ki = 0.00968628;
        _kErkPhos_kcat1 = 6158.96;
        _kErkPhos_kcat2 = 24.2457;
        _kMekPhosByPI3K_kcat = 0.0483388;
        _kMekPhos_kcat1 = 0.103558;
        _kMekPhos_kcat2 = 9999.96;
        _kMekPhos_ki = 0.14348699999999998;
        _kPI3KDephosByS6K_kcat = 1618.6;
        _kPI3KPhosByGF_kcat = 9999.74;
        _kPI3KPhosByMek_kcat = 18.6056;
        _kRafPhosByPI3K_kcat = 41.1749;
        _kRafPhosByTGFbR_kcat = 227.81799999999998;
        _kRafPhos_ki = 0.001;
        _kS6KPhosBymTORC1_kcat = 1.99046;
        _kSmad2Phos_kcat = 103.65299999999999;
        _kTGFbRAct_Vmax = 0.00218219;
        _kmTORC1Phos_kcat = 164.519;
        _kmTORC1Phos_ki = 0.00100008;
        _kmTORCPhosBasal_Vmax = 16.5066;
        kAktDephos_Vmax = 30.0;
        kAktDephos_km = 15.0;
        kAktPhos_km = 12.5;
        kErkDephos_Vmax = 1800.0;
        kErkDephos_km = 15.0;
        kErkPhos_km1 = 50.0;
        kErkPhos_km2 = 50.0;
        kMekDephos_Vmax = 2700.0;
        kMekDephos_km = 15.0;
        kMekPhosByPI3K_km = 50.0;
        kMekPhos_km1 = 15.0;
        kMekPhos_km2 = 15.0;
        kPI3KDephosByS6K_km = 50.0;
        kPI3KPhosByGF_km = 50.0;
        kPI3KPhosByMek_km = 50.0;
        kRafDephosVmax = 3602.5;
        kRafDephos_km = 8.0;
        kRafPhosByPI3K_km = 50.0;
        kRafPhosByTGFbR_km = 25.0;
        kRafPhos_Vmax = 9000.0;
        kRafPhos_km = 10.0;
        kRafPhos_n = 1.0;
        kS6KDephos_Vmax = 50.0;
        kS6KDephos_km = 10.0;
        kS6KPhosBymTORC1_km = 100.0;
        kSmad2Dephos_Vmax = 20.0;
        kSmad2Dephos_km = 30.0;
        kSmad2Phos_km = 50.0;
        kTGFbRAct_h = 2.0;
        kTGFbRAct_km = 10.0;
        kTGFbRDephos_Vmax = 15.0;
        kTGFbRDephos_km = 100.0;
        kmTORC1Dephos_Vmax = 15.0;
        kmTORC1Dephos_km = 100.0;
        kmTORC1Phos_km = 50.0;
        kmTORCPhosBasal_km = 25.0;
        
        //Akt = 45.000013943547444;
		//Erk = 80.0000247885287;
		//Mek = 80.00001239426435;
		//PI3K = 45.000013943547444;
		//Raf = 90.00001394354744;
		//S6K = 45.000013943547444;
		//Smad2 = 45.000013943547444;
		//TGFbR = 45.000013943547444;
		//TGFbR_a = 5.000001549283042;
		//mTORC1 = 45.000013943547444;
		//pAkt = 5.000001549283042;
		//pErk = 10.000003098566063;
		//pMek = 10.000001549283041;
		//pPI3K = 5.000001549283042;
		//pRaf = 10.0;
		//pS6K = 5.000001549283042;
		//pSmad2 = 5.000001549283042;
		//pmTORC1 = 5.000001549283042;
		//ppErk = 10.000003098566063;
		//ppMek = 10.000013943547444;
		//Cell = 1.0;
		//AZD = 0.0;
		//Everolimus = 0.0;
		//ExperimentIndicator = 0.0;
		//GrowthFactors = 1.0;
		//MK2206 = 0.0;
		//TGFb = 0.005;
		//_kAktPhos_kcat = 0.683533;
		//_kAktPhos_ki = 0.0028897;
		//_kMekPhos_ki = 0.06851139999999999;
		//_kPI3KDephosByS6K_kcat = 17.0599;
		//_kPI3KPhosByGF_kcat = 477.571;
		//_kRafPhosByTGFbR_kcat = 8444.06;
		//_kRafPhos_ki = 1295.69;
		//_kS6KPhosBymTORC1_kcat = 2.01081;
		//_kSmad2Phos_kcat = 9470.66;
		//_kTGFbRAct_Vmax = 0.00209677;
		//_kmTORC1Phos_kcat = 212.249;
		//_kmTORC1Phos_ki = 0.001;
		//_kmTORCPhosBasal_Vmax = 139.66;
		//_kMekPhos_kcat1 = 0.345291; //0.345291;
		//_kMekPhos_kcat2 = 9999.88; //9999.88;
		//_kErkPhos_kcat1 = 9993.67; //9993.67;
		//_kErkPhos_kcat2 = 25; //12.5468;
		//kAktDephos_Vmax = 30.0;
		//kAktDephos_km = 15.0;
		//kAktPhos_km = 12.5;
		//kErkDephos_Vmax = 1800.0;
		//kErkDephos_km = 15.0;
		//kErkPhos_km1 = 50.0;
		//kErkPhos_km2 =   kErkPhos_km1;
		//kMekDephos_Vmax = 2700.0;
		//kMekDephos_km = 15.0;
		//kMekPhos_km1 = 15.0;
		//kMekPhos_km2 =   kMekPhos_km1;
		//kPI3KDephosByS6K_km = 50.0;
		//kPI3KPhosByGF_km = 50.0;
		//kRafDephosVmax = 3602.5;
		//kRafDephos_km = 8.0;
		//kRafPhosByTGFbR_km = 25.0;
		//kRafPhos_Vmax = 9000.0;
		//kRafPhos_km = 10.0;
		//kRafPhos_n = 1.0;
		//kS6KDephos_Vmax = 50.0;
		//kS6KDephos_km = 10.0;
		//kS6KPhosBymTORC1_km = 100.0;
		//kSmad2Dephos_Vmax = 20.0;
		//kSmad2Dephos_km = 30.0;
		//kSmad2Phos_km = 50.0;
		//kTGFbRAct_h = 2.0;
		//kTGFbRAct_km = 10.0;
		//kTGFbRDephos_Vmax = 15.0;
		//kTGFbRDephos_km = 100.0;
		//kmTORC1Dephos_Vmax = 15.0;
		//kmTORC1Dephos_km = 100.0;
		//kmTORC1Phos_km = 50.0;
		//kmTORCPhosBasal_km = 25.0;
		//kPI3KPhosByMek_km = 50.0;
		//_kPI3KPhosByMek_kcat = 0.335106;
		//
		//kPI3KPhosByTGFbR_km = 50;
		//
		//kRafPhosByPI3K_km = 50;
		//kPI3KDephosByErk_km = 50;
		//_kRafPhosByPI3K_kcat = 0.1;
		//_kPI3KDephosByErk_kcat = 0.5;
		//kMekPhosByPI3K_km = 50;
		//kMekDephosByAkt_km = 50;
		
		"""

    def _default_parameter_set_as_dict(self):
        string = self._default_parameter_str()
        # print(string)
        strings = string.split('\n')
        # print(strings)
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

        var TGFbR           in Cell  
        var TGFbR_a         in Cell  
        var Smad2           in Cell  
        var pSmad2          in Cell  
        var Mek             in Cell
        var pMek            in Cell  
        var Erk             in Cell
        var pErk            in Cell  
        var PI3K            in Cell  
        var pPI3K           in Cell  
        var Akt             in Cell
        var pAkt            in Cell  
        var mTORC1          in Cell  
        var pmTORC1         in Cell  
        var S6K             in Cell
        var pS6K            in Cell  
        var Raf             in Cell
        var pRaf            in Cell
        var pMek            in Cell
        var ppMek           in Cell
        var pMek            in Cell
        var pErk            in Cell
        var ppErk           in Cell

        const TGFb             in Cell
        const AZD              in Cell
        const GrowthFactors    in Cell
        const MK2206           in Cell
        const Everolimus       in Cell"""

    def _reactions(self, additional_reactions):
        return """
        //TGFb module
        TGF_R1 : TGFbR       => TGFbR_a    ; Cell * Hill(kTGFbRAct_km, _kTGFbRAct_Vmax, TGFb, TGFbR, kTGFbRAct_h)      ;
        TGF_R2 : TGFbR_a     => TGFbR      ; Cell * MM(kTGFbRDephos_km, kTGFbRDephos_Vmax, TGFbR_a)               ;
        TGF_R3 : Smad2       => pSmad2     ; Cell * MMWithKcat( kSmad2Phos_km,  _kSmad2Phos_kcat, Smad2, TGFbR_a );
        TGF_R4 : pSmad2      => Smad2      ; Cell * MM(         kSmad2Dephos_km, kSmad2Dephos_Vmax, pSmad2 )

        //MAPK module
        MAPK_R0  : Raf     => pRaf      ; Cell*GrowthFactors*NonCompetitiveInhibition(kRafPhos_km,  _kRafPhos_ki, kRafPhos_Vmax, kRafPhos_n, ppErk, Raf);
        MAPK_R1  : pRaf    => Raf       ; Cell*MM(            kRafDephos_km ,   kRafDephosVmax,      pRaf           );
        MAPK_R2  : Mek     => pMek      ; Cell*CompetitiveInhibitionWithKcat(    kMekPhos_km1 , _kMekPhos_ki, _kMekPhos_kcat1, pRaf, AZD, Mek       );
        MAPK_R3  : pMek    => ppMek     ; Cell*CompetitiveInhibitionWithKcat(    kMekPhos_km2 , _kMekPhos_ki, _kMekPhos_kcat2, pRaf, AZD, pMek     );
        MAPK_R4  : ppMek   => pMek      ; Cell*MM(            kMekDephos_km,   kMekDephos_Vmax,     ppMek         );
        MAPK_R5  : pMek    => Mek       ; Cell*MM(            kMekDephos_km,   kMekDephos_Vmax,     pMek          );
        MAPK_R6  : Erk     => pErk      ; Cell*MMWithKcat(    kErkPhos_km2,     _kErkPhos_kcat1, Erk,  ppMek         );
        MAPK_R7  : pErk    => ppErk     ; Cell*MMWithKcat(    kErkPhos_km1,     _kErkPhos_kcat2, pErk, ppMek         );
        MAPK_R8  : ppErk   => pErk      ; Cell*MM(            kErkDephos_km,   kErkDephos_Vmax,     ppErk         );
        MAPK_R9  : pErk    => Erk       ; Cell*MM(            kErkDephos_km,   kErkDephos_Vmax,     pErk          );


        //PI3K Module
        PI3K_R1 :   PI3K    => pPI3K        ; Cell *  MMWithKcat(kPI3KPhosByGF_km, _kPI3KPhosByGF_kcat,  PI3K, GrowthFactors) ;
        PI3K_R2 :   pPI3K   => PI3K         ; Cell *  MMWithKcat(kPI3KDephosByS6K_km, _kPI3KDephosByS6K_kcat, pPI3K, pS6K)        ;
        PI3K_R3 :   Akt    => pAkt          ; Cell *  CompetitiveInhibitionWithKcat(kAktPhos_km, _kAktPhos_ki, _kAktPhos_kcat, pPI3K, MK2206, Akt)              ;
        PI3K_R4 :   pAkt    => Akt          ; Cell *  MM(kAktDephos_km, kAktDephos_Vmax, pAkt)         ;
        PI3K_R5_1 :   mTORC1 => pmTORC1     ; Cell *  CompetitiveInhibitionWithKcat(kmTORC1Phos_km, _kmTORC1Phos_ki, _kmTORC1Phos_kcat, pAkt, Everolimus, mTORC1)  ;
        PI3K_R5_2 :   mTORC1 => pmTORC1     ; Cell *  CompetitiveInhibition(_kmTORCPhosBasal_Vmax, kmTORCPhosBasal_km, _kmTORC1Phos_ki, Everolimus, mTORC1);
        PI3K_R6 :   pmTORC1 => mTORC1       ; Cell *  MM(kmTORC1Dephos_km, kmTORC1Dephos_Vmax, pmTORC1);
        PI3K_R7 :   S6K     => pS6K         ; Cell *  MMWithKcat(kS6KPhosBymTORC1_km, _kS6KPhosBymTORC1_kcat, S6K, pmTORC1) ;
        PI3K_R8 :   pS6K    => S6K          ; Cell *  MM(kS6KDephos_km, kS6KDephos_Vmax, pS6K)                    ;

        // Cross talk reactions
        
        
        {}
    """.format(additional_reactions)

    def raf_phos_by_TGFbR(self):
        return """
        CrossTalkR1  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByTGFbR_km, _kRafPhosByTGFbR_kcat, Raf, TGFbR_a)    ;
        """

    def pi3k_phos_by_TGFbR(self):
        return """
        CrossTalkR2  :    PI3K      => pPI3K     ;   Cell *  MMWithKcat(kPI3KPhosByTGFbR_km, _kPI3KPhosByTGFbR_kcat, PI3K, TGFbR_a) ;
        """

    def raf_phos_by_PI3K(self):
        return """
        CrossTalkR3  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByPI3K_km,  _kRafPhosByPI3K_kcat, Raf, pPI3K)           ;
        """

    def pi3k_dephos_by_erk(self):
        return """
        CrossTalkR4  :    pPI3K     => PI3K      ;   Cell *  MMWithKcat(kPI3KDephosByErk_km, _kPI3KDephosByErk_kcat, pPI3K, ppErk  ) ;
        """

    def mek_phos_by_pi3k(self):
        return """
        CrossTalkR5_1 :     Mek => pMek       ; Cell * MMWithKcat(kMekPhosByPI3K_km, _kMekPhosByPI3K_kcat, Mek, pPI3K);
        CrossTalkR5_2 :     pMek => ppMek       ; Cell * MMWithKcat(kMekPhosByPI3K_km, _kMekPhosByPI3K_kcat, pMek, pPI3K);
        """

    def pi3k_phos_by_mek(self):
        return """
        CrossTalkR6 :     PI3K => pPI3K       ; Cell * MMWithKcat(kPI3KPhosByMek_km, _kPI3KPhosByMek_kcat, PI3K, ppMek);
        """

    def mek_dephos_by_akt(self):
        return """
        CrossTalkR7_1:    ppMek => pMek     ; Cell * MMWithKcat(kMekDephosByAkt_km, _kMekDephosByAkt_kcat, ppMek, pAkt)
        CrossTalkR7_2:    pMek => Mek     ; Cell * MMWithKcat(kMekDephosByAkt_km, _kMekDephosByAkt_kcat, pMek, pAkt)
        """

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

    def _akt_activate_smad2(self):
        """
        CompetitiveInhibitionWithKcat(km, ki, kcat, E, I, S)
        :return:
        """
        return """
        CrossTalkR8  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByAkt_km, _kSmad2PhosByAkt_kcat, Smad2, pAkt)       ;
        """

    def _erk_activates_smad2(self):
        return """
        CrossTalkR9  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByErk_km, _kSmad2PhosByErk_kcat, Smad2, ppErk)       ;
        """

    def _akt_inhibits_smad2(self):
        return """
        CrossTalkR10  :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DehosByAkt_km, _kSmad2DephosByAkt_kcat, pSmad2, pAkt)       ;
        """

    def _erk_inhibits_smad2(self):
        return """
        CrossTalkR11  :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DephosByErk_km, _kSmad2DephosByErk_kcat, pSmad2, ppErk)       ;
        """

    def plot_model_selection_criteria(self, model_selection_criteria_file=None):
        if model_selection_criteria_file is None:

            model_selection_criteria_file = self.aic()

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
        print(sym_mat)
        print(sym_mat.rref(simplify=False))

        # print(df)

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
        print(df)
        import itertools
        comb = itertools.combinations(list(df.columns), 2)
        print(comb)
        # # print(len(comb))
        l = []
        for i, j in comb:
            if df.loc[i, j] > gl:
                l.append([i, j, df.loc[i, j]])
            elif df.loc[i, j] < -gl:
                l.append([i, j, df.loc[i, j]])

        df = pandas.DataFrame(l)
        df.columns = ['param1', 'param2', 'correlation']
        print(df.shape)
        df.sort_values(by='correlation', inplace=True)
        fname = os.path.join(os.path.dirname(corr_file), 'filtered_correlation_matrix_gl_0.7.csv')
        df.to_csv(fname)
        print('filtered correlations now in "{}"'.format(fname))

    def plot_timecourse(self, selection=['pAkt', 'ppErk', 'pS6K', 'pSmad2']):
        """

        :return:
        """
        import matplotlib
        matplotlib.use('TkAgg')
        seaborn.set_context('talk')
        df = self.simulate_conditions(selection=selection, best_parameters=True)
        # df = df.reset_index()
        # df = df.rename(columns={'level_0': 'Condition', 'level_1': 'Time'})

        conditions = set(list(df.index.get_level_values(0)))

        print(len(conditions))

        mk_cond = ['D', 'T', 'E', 'E_M_72', 'E_M_48', 'E_M_24',
                   'E_M_1.25', 'M_72', 'M_48', 'M_24', 'M_1.25']

        azd_cond = ['D', 'T', 'E', 'E_A_72', 'E_A_48', 'E_A_24',
                    'E_A_1.25', 'A_72', 'A_48', 'A_24', 'A_1.25']

        both = ['E_A_M_24', 'E_A_M_48', 'E_A_M_72']

        cond_dct = {'MK': mk_cond,
                    'AZD': azd_cond,
                    'Both': both}

        cols = seaborn.color_palette("hls", len(selection))
        cols = iter(cols)

        from matplotlib import gridspec

        print(len(conditions))

        for v in range(len(selection)):
            for cond in cond_dct:
                f = cond_dct[cond]
                fig = plt.figure(constrained_layout=True, figsize=(10, 15))
                spec = gridspec.GridSpec(nrows=len(f), ncols=1, figure=fig)
                ax_num = 0

                for cond in f:
                    df_selection = df.loc[cond]

                    ax = fig.add_subplot(spec[ax_num, 0])
                    seaborn.despine(ax=ax, top=True, right=True)
                    ax_num +=1
                    plt.plot(list(df_selection.index), df_selection[selection[v]], label=cond)
                    plt.setp(ax.get_xticklabels(), visible=False)
                    plt.title(cond)

                plt.setp(ax.get_xticklabels(), visible=True)
                plt.suptitle(selection[v])
                plt.xlabel('Time(h)')
                plt.ylabel('Conc.')
                fname = os.path.join(self.time_course_graphs, "{}_{}.png".format(cond, selection[v]))
                fig.savefig(fname, bbox_inches='tight', dpi=100)
                print('saving "{}"'.format(fname))
        # plt.show()
            # fig = plt.figure(figsize=(5, 15))
            #
            #
            #
            # for i in range(len(conditions)):
            #     condition = list(conditions)[i]
            #     ax = fig.add_subplot(len(conditions), 1, i+1)
            #     ax_count += 1
            #     df_selection = df.loc[condition]
            #     time = list(df_selection.index)
            #
            #     seaborn.set_context('talk')
            #     ax_count += 1
            #     # plt.setp(ax.get_xticklabels(), visible=False)
            #     # box = sub_ax.get_position()
            #     # sub_ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])
            #
            #     # seaborn.despine(ax=ax, top=True, right=True)
            #     # plt.yticks(fontsize=12)
            #     # # print(df_selection[selection[v]])
            #     # plt.suptitle(condition)
            #     plt.plot(time, df_selection[selection[v]], label=condition)
                # plt.legend(loc=(0.75, 0.5), bbox_to_anchor=(1.0, 0.5), fontsize=10)
                # plt.xticks(numpy.arange(0, 72, 5.0), fontsize=12, rotation=90)
                #
                # plt.subplots_adjust(bottom=0.2, left=0.2, right=0.7)
                # if v == len(selection) - 1:
                #     plt.xlabel('Time(h)')

            # plt.setp(sub_ax.get_xticklabels(), visible=True)

            # fig.text(0.05, 0.5, 'nmol L$^{-1}$', ha='center', va='center', rotation='vertical')
            # plt.tight_layout()
        # plt.show()
        # return fig


if __name__ == '__main__':

    PROBLEM = 3
    ## Which model is the current focus of analysis
    CURRENT_MODEL_ID = 77

    ## Label for previous fit. Used to take best parameters for another parameter estimation
    ## and so must be the actual label for the previous fit
    # LAST_FIT = '2_all_params'

    ## A label for the current fit directory
    FIT = '1'

    ## either False, 'slurm' or 'sge'. Determines the main working directory
    ## for easy switching between environments
    CLUSTER = False

    ## True, False, 'slurm' or 'sge'. Passed onto parameter estimation class
    RUN_MODE = False

    ## Configure and run the parameter estimations
    RUN_PARAMETER_ESTIMATION = False

    RUN_PARAMETER_ESTIMATION_FROM_BEST_PARAMETERS = False

    ## plot comparison between model and simulation for the current model ID
    PLOT_CURRENT_SIMULATION_GRAPHS = False

    ## Plot current simulation graphs with the default parameter instead of best estimated
    PLOT_CURRENT_SIMULATION_GRAPHS_WITH_DEAULT_PARAMETERS = True

    PLOT_CURRENT_SIMULATION_GRAPHS_WITH_COPASI_PARAMETERS = False

    ## iterate over all models and plot comparison between model and simulation
    PLOT_ALL_SIMULATION_GRAPHS = False

    ## extract best RSS per model and compute AICc
    AICs = False

    ## Plot likelihood ranks plots
    LIKELIHOOD_RANKS = False

    ## get the best parameter set as a dict and antimony format from the model pointed to by CURRENT_MODEL_ID
    GET_BEST_PARAMETERS = False

    ## open the model currently pointed to by CURRENT_MODEL_ID
    OPEN_WITH_COPASI = False

    ## open the model currently pointed to by CURRENT_MODEL_ID with the best estimated parameters from FIT
    OPEN_WITH_COPASI_WITH_BEST_PARAMETERS = False

    ## Produce the parameters already present in the COPASI model pointed to by CURRENT_MODEL_ID in antimony format.
    GET_PARAMETERS_FROM_COPASI = False

    ## insert the best parameters from current fit into the models
    INSERT_BEST_PARAMETERS_INTO_ALL_COPASI_FILES = False

    INSERT_BEST_PARAMETERS_FROM_LAST_FIT_AND_PLOT = False

    ## analyse correlations
    ANALYSE_CORRELATIONS = False

    PLOT_TIMESERIES_WITH_CURRENT_MODEL = False

    ##===========================================================================================

    if CLUSTER == 'slurm':
        WORKING_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel/ModelSelectionProblems/Problem{}'.format(PROBLEM)

    elif CLUSTER == 'sge':
        WORKING_DIRECTORY = r'/sharedlustre/users/b3053674/2019/CrossTalkModel/ModelSelectionProblems/Problem{}'.format(PROBLEM)

    elif CLUSTER == False:
        WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelectionProblems/Problem{}'.format(PROBLEM)

    else:
        raise ValueError

    C = CrossTalkModel(WORKING_DIRECTORY, fit=FIT,
                       method='particle_swarm',
                       copy_number=3,
                       run_mode=RUN_MODE,
                       iteration_limit=2500,
                       swarm_size=75,
                       overwrite_config_file=True,
                       lower_bound=0.01,
                       upper_bound=10000,
                       )

    # print('fit_dir', C.fit_dir)
    # C[CURRENT_MODEL_ID].get_param_df()

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
        print(dct)
        print(s)

    if OPEN_WITH_COPASI:
        mod = C[CURRENT_MODEL_ID].to_copasi()
        mod.open()

    if OPEN_WITH_COPASI_WITH_BEST_PARAMETERS:
        mod = C[CURRENT_MODEL_ID].insert_best_parameters()
        print(C[CURRENT_MODEL_ID].get_best_model_parameters_as_antimony())

        mod = tasks.TimeCourse(mod, end=75, intervals=75*100, step_size=0.01, run=False).model
        mod = tasks.Scan(mod, variable='Everolimus', minimum=0, maximum=1, number_of_steps=1,
                         subtask='timecourse').model


        mod.open()

    if RUN_PARAMETER_ESTIMATION:
        for model_id in C:
            C[model_id].run_parameter_estimation()

    if RUN_PARAMETER_ESTIMATION_FROM_BEST_PARAMETERS:
        for model_id in C:
            best_params = C[model_id].get_best_parameters_from_last_fit(LAST_FIT)
            print('best parameters\n'.format(
                best_params
            ))
            PE = C[model_id].run_parameter_estimation_from_parameter_set(best_params, run_mode=RUN_MODE)
            # PE.model.open()

    if PLOT_ALL_SIMULATION_GRAPHS:
        for model_id in range(len(C)):
            try:
                C[model_id].plot_bargraphs(best_parameters=True)
            except ValueError:
                print("model '{}' skipped! No data to plot".format(model_id))
                continue
            except RuntimeError:
                print("model '{}' skipped! RunTimeError".format(model_id))
                continue


    if PLOT_CURRENT_SIMULATION_GRAPHS:
        print('fit dir', C[CURRENT_MODEL_ID].fit_dir)
        C[CURRENT_MODEL_ID].plot_bargraphs(best_parameters=True)


    if PLOT_CURRENT_SIMULATION_GRAPHS_WITH_DEAULT_PARAMETERS:
        print('fit dir', C[CURRENT_MODEL_ID].fit_dir)
        C[CURRENT_MODEL_ID].plot_bargraphs(best_parameters=False)

    # if PLOT_CURRENT_SIMULATION_GRAPHS_WITH_COPASI_PARAMETERS:
    #     copasi_file = '/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelectionProblems/Problem3/ModelSelection/Topology77/Fit1/topology77_for_playing_with.cps'
    #     mod = model.Model(copasi_file)
    #     # print(C[CURRENT_MODEL_ID].fit_dir)
    #     dct, ant = C[CURRENT_MODEL_ID].get_parameters_from_copasi(mod)
    #     # print(ant)
    #     C[CURRENT_MODEL_ID].plot_bargraphs(best_parameters=ant)


    if GET_BEST_PARAMETERS:
        ant = C[CURRENT_MODEL_ID].get_best_model_parameters_as_antimony()
        dct = C[CURRENT_MODEL_ID].get_param_df().iloc[0].to_dict()
        print(ant)
        print(dct)

    # C[4].run_parameter_estimation_from_best_estimates()

    # PE = C[4].run_parameter_estimation()
    # PE.model.open()

    # PE = C[2]._configure_PE_for_viz()
    # PE.model.open()

    if LIKELIHOOD_RANKS:
        for model_id in C:
            C[model_id].likelihood_ranks()

    if AICs:
        df, fname = C.compute_all_aics()

        hypo = [
            'RafPhosByTGFbR',
            'PI3KPhosByTGFbR',
            'RafPhosByPI3K',
            'PI3KDephosByErk',
            'MekPhosByPI3K',
            'PI3KPhosByMek',
            'MekDephosByAkt'
            ]

        print(df)
        print('csv file at "{}"'.format(fname))
        dct = {}
        for h in hypo:
            dct[h] = 0
            for t in df['Topology']:
                if h in t:
                    number = float(df[df['Topology'] == t]['f'])
                    dct[h] += number

        for h in dct:
            dct[h] = dct[h] / df['f'].sum()

        df2 = pandas.DataFrame(dct, index=[0])
        print(df2.transpose().sort_values(by=0))

        """
                                0
        RafPhosByTGFbR   0.163642
        RafPhosByPI3K    0.255940
        PI3KPhosByMek    0.469784
        MekPhosByPI3K    0.473941
        PI3KPhosByTGFbR  0.479514
        PI3KDephosByErk  0.527216
        MekDephosByAkt   0.583209
        
        """



    if INSERT_BEST_PARAMETERS_INTO_ALL_COPASI_FILES:
        for i in C:
            print(C[i].insert_best_parameters())

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


















