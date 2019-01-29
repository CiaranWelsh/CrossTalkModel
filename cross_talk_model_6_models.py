from constants import *
import site, os, glob
import pandas, numpy
import re
import tellurium as te

site.addsitedir(r'/home/ncw135/Documents/pycotools3')
site.addsitedir(r'D:\pycotools3')
from pycotools3 import model, tasks, viz
from itertools import combinations
import matplotlib.pyplot as plt
import seaborn


class ParameterSet(dict):
    def __init__(self, *args):
        super().__init__(*args)


class CrossTalkModel:
    """
    build a factory that churns out functions that return models and take as argument the
    antimony parameter strings
    """

    def __init__(self, working_directory,
                 parameter_str=None,
                 FIT='1_1',
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
                 upper_bound=1000,
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
            raise ValueError

        self.FIT = FIT
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

        self.model_variant_reactions = {
            1: self._akt_activate_smad2(),
            2: self._akt_inhibits_smad2(),
            3: self._erk_activates_smad2(),
            4: self._erk_inhibits_smad2()
        }

        self.topology_names = {
            1: 'AktActivate',
            2: 'ErkActivate',
            3: 'AktInhibit',
            4: 'ErkInhibit',
        }

        self.model_specific_reactions = self._assembel_model_reactions()[self.topology]
        ## run 33 models per model

        if self.FIT[0] != '1':
            print('WARNING. MAKE SURE YOU HAVE ADDED THE METABOLITES ARGUMENT INTO '
                  'PARAMETER ESTIMATIONS')

    def __str__(self):
        return "CrossTalkModel(topology={})".format(self.topology)

    def __len__(self):
        """
        Subtract 1 for 0 indexed python
        :return:
        """
        return len(list(self._get_combinations())) - 1

    def __iter__(self):
        return self

    def __next__(self):
        if self.topology > len(self):
            raise StopIteration
        else:
            self.topology += 1
            return self.topology - 1

    def __getitem__(self, item):
        if item > len(self):
            raise IndexError

        C = CrossTalkModel(self.working_directory)
        C.topology = item
        C.model_specific_reactions = self._assembel_model_reactions()[item]
        return C

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
        d = os.path.join(self.topology_dir, 'Fit{}'.format(self.FIT))
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

    def plot_bargraphs(self, best_parameters=False):
        import matplotlib
        matplotlib.use('TkAgg')
        seaborn.set_style('white')
        seaborn.set_context(context='talk')
        selections = ['pAkt', 'pS6K', 'ppErk', 'pSmad2']
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

        marker = '_'
        markersize = 3
        for sp in ['pAkt', 'pS6K', 'ppErk', 'pSmad2']:
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

        free_params = [i.name for i in mod.global_quantities if i.name[0] == '_']

        PE = tasks.MultiParameterEstimation(
            mod,
            self.data_files,
            separator=[','] * len(self.data_files),
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
            upper_bound=self.upper_bound
        )
        PE.write_config_file()
        PE.setup()
        PE.run()
        return PE

    def _configure_PE_for_viz(self):
        """
        execute run_parameter_estimation with some kwargs changed so that we can get the
        PE object for passing on to viz module classes
        :return:
        """
        self.copy_number = 1
        self.run_mode = False
        self.randomize_start_values = False
        self.method = 'current_solution_statistics'
        PE = self.run_parameter_estimation()
        print(PE.results_directory)
        return PE

    def likelihood_ranks(self):
        return viz.LikelihoodRanks(self._configure_PE_for_viz(), savefig=True).fig

    def get_param_df(self):
        """
        return pandas.DataFrame of estimated parameters
        :return:
        """
        return viz.Parse(self._configure_PE_for_viz()).data

    def insert_best_parameters_and_open_with_copasi(self):
        parameters = self.get_param_df()
        mod = self._configure_PE_for_viz().model
        mod.insert_parameters(df=parameters, index=0, inplace=True)
        return mod.open()

    def insert_best_parameters(self):
        parameters = self.get_param_df()
        mod = self._configure_PE_for_viz().model
        mod.insert_parameters(df=parameters, index=0, inplace=True)
        return mod

    def get_best_model_parameters_as_antimony(self):
        import re
        parameters = self.get_param_df()
        # print(parameters)
        best_params = parameters.iloc[0].to_dict()
        params = []
        current_params = self._default_parameter_set_as_dict()
        current_params.update(best_params)
        s = ''
        for k, v in current_params.items():
            s += "\t\t{} = {};\n".format(k, v)
        return s

    def _get_number_estimated_model_parameters(self):
        return len(self._configure_PE_for_viz().model.fit_item_order)

    def _get_n(self):
        '''
        get number of observed data points for AIC calculation
        '''
        n = 0
        for exp in self.data_files:
            data = pandas.read_csv(exp, sep=',')
            data = data[['pAkt', 'ppErk', 'pS6K', 'pSmad2']]
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

    def _get_combinations(self):
        perm_list = []
        for i in range(4):
            perm_list += [j for j in combinations([1, 2, 3, 4], i)]

        ## plus the full set
        return enumerate(perm_list + [(1, 2, 3, 4)])

    def _assembel_model_reactions(self):
        """
        assember the model specific reactions
        :return:
        """
        model_specific_reactions = {}
        for i, tup in self._get_combinations():
            model_specific_reactions[i] = '\n'.join([self.model_variant_reactions[x].strip() for x in tup])

        return model_specific_reactions

    def _build_antimony(self, best_parameters=False):
        s = ''
        s += self._functions()
        s += 'model CrossTalkModelTopology{}'.format(self.topology)
        s += self._compartments()
        s += self._reactions(self.model_specific_reactions)
        if best_parameters is False:
            s += self._default_parameter_str()
        else:
            s += self.get_best_model_parameters_as_antimony()
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
        ]

    def _default_parameter_str(self):
        return """
        // Species initializations:
        
        TGFbR = 45
        Smad2 = 45
        Mek = 40
        Erk = 40
        PI3K = 45
        Akt = 45
        mTORC1 = 45
        S6K = 45
        Raf = 45
        ppMek = 45
        TGFbR_a = 5
        pSmad2 = 5
        pMek = 5
        pErk = 5
        pPI3K = 5
        pAkt = 5
        pmTORC1 = 5
        pS6K = 5
        pRaf = 5
        ppErk = 5
        
        // Compartment initializations:
        Cell = 1;
        
        // Variable initializations:
        TGFb = 0.005;
        GrowthFactors = 1;
        ExperimentIndicator = 0;
        AZD = 0;
        MK2206 = 0;
        Everolimus = 0;
        kTGFbRAct_km = 10;
        kTGFbRDephos_km =  100;
        kSmad2Phos_km = 50;
        kSmad2Dephos_km = 30;
        kSmad2Dephos_Vmax = 20;
        kRafPhos_km = 10;
        kRafPhos_Vmax = 9000;
        kRafPhos_n = 1;
        kRafDephos_km = 8;
        kRafDephosVmax = 3602.5;
        kMekPhos_km1 = 15;
        kMekPhos_kcat = 90;
        kMekDephos_km = 15;
        kMekDephos_Vmax = 2700;
        kErkPhos_km = 50;
        kErkPhos_kcat = 200;
        kErkDephos_km = 15;
        kErkDephos_Vmax = 1800;
        kPI3KPhosByGF_km =   50;
        kPI3KDephosByS6K_km = 50;
        kAktPhos_km = 12.5;
        kAktDephos_km = 15;
        kAktDephos_Vmax = 30;
        kmTORC1Phos_km = 50;
        kmTORCPhosBasal_km = 25;
        kmTORC1Dephos_km = 100;
        kmTORC1Dephos_Vmax = 4;
        kS6KPhosBymTORC1_km = 100;
        kS6KDephos_km = 10;
        kS6KDephos_Vmax = 50;
        kRafPhosByTGFbR_km = 25;
        kRafPhosByPI3K_km = 50;
        kPI3KPhosByTGFbR_km = 10;
        kPI3KDephosByErk_km = 10;
        
        kSmad2PhosByAkt_km = 50;
        kSmad2DephosByErk_km = 50;
        kSmad2PhosByAkt_km = 50;
        kSmad2PhosByErk_km = 50;
        kSmad2DephosByErk_km = 50;
        kSmad2DehosByAkt_km = 50;
        kSmad2DephosByAkt_km = 50;
        
        kTGFbRAct_h = 2
        _kTGFbRAct_Vmax = 20;
        _kTGFbRDephos_Vmax  = 150;
        _kSmad2Phos_kcat = 100.643;
        _kRafPhos_ki = 362.567;
        _kMekPhos_ki = 1.01271;
        _kPI3KPhosByGF_kcat     =   0.1;
        _kPI3KDephosByS6K_kcat  =   0.1;
        _kAktPhos_ki = 0.311348;
        _kAktPhos_kcat = 3.84124;
        _kmTORC1Phos_ki = 0.001;
        _kmTORC1Phos_kcat = 0.00100034;
        _kmTORCPhosBasal_Vmax = 17.2123;
        _kS6KPhosBymTORC1_kcat = 21.666;
        _kRafPhosByTGFbR_kcat = 64.4923;
        _kRafPhosByPI3K_kcat = 1000;
        _kPI3KPhosByTGFbR_kcat = 3.66587;
        _kSmad2PhosByAkt_kcat = 140.907;
        _kSmad2DephosByErk_kcat = 587.363;
        _kPI3KDephosByErk_kcat = 50;
        
        _kSmad2PhosByAkt_kcat = 0.1;
        _kSmad2PhosByErk_kcat = 0.1;
        _kSmad2DephosByErk_kcat = 0.1;
        _kSmad2DephosByAkt_kcat = 0.1;
        _kSmad2DephosByAkt_kcat = 0.1;
        """

    def _default_parameter_set_as_dict(self):
        string = self._default_parameter_str()
        # print(string)
        strings = string.split('\n')
        # print(strings)
        dct = OrderedDict()
        for s in strings:
            if '=' in s:
                k, v = s.split('=')
                k = k.strip()
                v = v.replace(';', '')
                v = float(v)
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
        TGF_R2 : TGFbR_a     => TGFbR      ; Cell * MM(kTGFbRDephos_km, _kTGFbRDephos_Vmax, TGFbR_a)               ;
        TGF_R3 : Smad2       => pSmad2     ; Cell * MMWithKcat( kSmad2Phos_km,  _kSmad2Phos_kcat, Smad2, TGFbR_a );
        TGF_R4 : pSmad2      => Smad2      ; Cell * MM(         kSmad2Dephos_km, kSmad2Dephos_Vmax, pSmad2 )

        //MAPK module
        MAPK_R0  : Raf     => pRaf      ; Cell*GrowthFactors*NonCompetitiveInhibition(kRafPhos_km,  _kRafPhos_ki, kRafPhos_Vmax, kRafPhos_n, ppErk, Raf);
        MAPK_R1  : pRaf    => Raf       ; Cell*MM(            kRafDephos_km ,   kRafDephosVmax,      pRaf           );
        MAPK_R2  : Mek     => pMek      ; Cell*CompetitiveInhibitionWithKcat(    kMekPhos_km1 , _kMekPhos_ki, kMekPhos_kcat, pRaf, AZD, Mek       );
        MAPK_R3  : pMek    => ppMek     ; Cell*CompetitiveInhibitionWithKcat(    kMekPhos_km1 , _kMekPhos_ki, kMekPhos_kcat, pRaf, AZD, pMek     );
        MAPK_R4  : ppMek   => pMek      ; Cell*MM(            kMekDephos_km,   kMekDephos_Vmax,     ppMek         );
        MAPK_R5  : pMek    => Mek       ; Cell*MM(            kMekDephos_km,   kMekDephos_Vmax,     pMek          );
        MAPK_R6  : Erk     => pErk      ; Cell*MMWithKcat(    kErkPhos_km,     kErkPhos_kcat, Erk,  ppMek         );
        MAPK_R7  : pErk    => ppErk     ; Cell*MMWithKcat(    kErkPhos_km,     kErkPhos_kcat, pErk, ppMek         );
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
        CrossTalkR1  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByTGFbR_km, _kRafPhosByTGFbR_kcat, Raf, TGFbR_a)    ;
        CrossTalkR2  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByPI3K_km,  _kRafPhosByPI3K_kcat, Raf, pPI3K)           ;
        CrossTalkR3  :    PI3K      => pPI3K     ;   Cell *  MMWithKcat(kPI3KPhosByTGFbR_km, _kPI3KPhosByTGFbR_kcat, PI3K, TGFbR_a) ;
        CrossTalkR4  :    pPI3K     => PI3K      ;   Cell *  MMWithKcat(kPI3KDephosByErk_km, _kPI3KDephosByErk_kcat, pPI3K, ppErk  ) ;
        {}
    """.format(additional_reactions)

    def _events(self):
        """
        // D = 0
        // T = 1
        // AZD at t=1.25 = 2
        // AZD at t=24 = 3
        // AZD at t48= = 4
        // AZD at t72= = 5
        // MK2206 at t=1.25 = 6
        // MK2206 at t=24 = 7
        // MK2206 at t48= = 8
        // MK2206 at t72= = 9
        :return:
        """
        return """
        // events in all simulations
        SerumStarveRemoveTGFb: at (time>70.25): TGFb=0;
        SerumStarveRemoveGrowthFactors: at (time>70.25): GrowthFactors=0;

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
        CrossTalkR5  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByAkt_km, _kSmad2PhosByAkt_kcat, Smad2, pAkt)       ;
        """

    def _erk_activates_smad2(self):
        return """
        CrossTalkR6  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByErk_km, _kSmad2PhosByErk_kcat, Smad2, ppErk)       ;
        """

    def _akt_inhibits_smad2(self):
        return """
        CrossTalkR8  :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DehosByAkt_km, _kSmad2DephosByAkt_kcat, pSmad2, pAkt)       ;
        """

    def _erk_inhibits_smad2(self):
        return """
        CrossTalkR7  :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DephosByErk_km, _kSmad2DephosByErk_kcat, pSmad2, ppErk)       ;
        """


if __name__ == '__main__':

    # FIT = '3_1_ICsAreFixed'
    FIT = '1_1'
    CLUSTER = False
    RUN_PARAMETER_ESTIMATION = False
    PLOT_SIMULATION_GRAPHS = False
    AICs = False
    LIKELIHOOD_RANKS = True
    INSERT_BEST_PARAMETERS = False

    CURRENT_MODEL_ID = 7

    if CLUSTER:
        WORKING_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel'
    else:
        WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'

    C = CrossTalkModel(WORKING_DIRECTORY, FIT=FIT)

    print(C.FIT)
    print(C.fit_dir)

    if RUN_PARAMETER_ESTIMATION:
        for model_id in C:
            C[model_id].run_parameter_estimation()

    if PLOT_SIMULATION_GRAPHS:
        for model_id in C:
            C[model_id].plot_bargraphs(best_parameters=True)

    if INSERT_BEST_PARAMETERS:
        mod = C[CURRENT_MODEL_ID].insert_best_parameters()
        mod.open()

    # C[4].run_parameter_estimation_from_best_estimates()

    # PE = C[4].run_parameter_estimation()
    # PE.model.open()

    # PE = C[2]._configure_PE_for_viz()
    # PE.model.open()

    if LIKELIHOOD_RANKS:
        for model_id in C:
            C[model_id].likelihood_ranks()


    if AICs:
        best_rss = {}
        aic = {}
        for model_id in C:
            data = C[model_id].get_param_df()
            best_rss[model_id] = data.iloc[0]['RSS']
            aic[model_id] = C[model_id].aic(data.iloc[0]['RSS'])
        df = pandas.DataFrame({'RSS': best_rss, 'AICc': aic})
        # print(df)
        df = pandas.concat([C.list_topologies(), df], axis=1)
        fname = os.path.join(WORKING_DIRECTORY, 'ModelSelectionDataFit{}.csv'.format(FIT))
        df.to_csv(fname)
