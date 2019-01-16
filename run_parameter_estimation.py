import os, glob
import site
site.addsitedir(r'/home/ncw135/Documents/pycotools3')
from pycotools3 import model, viz, tasks

from cross_talk_model_string import CROSS_TALK_MODEL



FIT = 3


CLUSTER = False

if CLUSTER:
    WORKING_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel'
else:
    WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'
# print(WORKING_DIRECTORY)


DATA_DIR = os.path.join(WORKING_DIRECTORY, 'data')
GRAPHS_DIRECTORY = os.path.join(WORKING_DIRECTORY, 'SimulationGraphs')
COPASI_MODELS_DIR = os.path.join(WORKING_DIRECTORY, 'CopasiModelFiles')

FIT_DIR = os.path.join(COPASI_MODELS_DIR, 'Fit{}'.format(FIT))
if not os.path.isdir(FIT_DIR):
    os.makedirs(FIT_DIR)


COPASI_DATA_DIR = os.path.join(DATA_DIR, 'CopasiDataFiles')

DATA_FILES = glob.glob(os.path.join(COPASI_DATA_DIR, '*.csv'))

for i in DATA_FILES:
    assert os.path.isfile(i)


# OTHER_COPASI_MODEL = r'D:\MesiSTRAT\CrossTalkModel\copasi_models\E_A_48_2.cps'
FIT_MODEL = os.path.join(FIT_DIR, 'E.cps')

with model.BuildAntimony(FIT_MODEL) as loader:
    copasi_mod = loader.load(CROSS_TALK_MODEL)


copasi_mod = model.Model(FIT_MODEL)

global_params = copasi_mod.global_quantities
free_params = [i.name for i in global_params if i.name[0] == '_']

# copasi_mod.open()
PE = tasks.MultiParameterEstimation(copasi_mod,
                                    DATA_FILES,
                                    copy_number=1,
                                    pe_number=1,
                                    # metabolites=['pAkt', 'pErk', 'ppErk', 'Erk', 'Akt',
                                    #              'Smad2', 'pSmad2', 'S6k', 'pS6K',
                                    #              'pPI3K', 'PI3K', 'mTORC1', 'pmTORC1'],
                                    # global_quantities=free_params,
                                    run_mode='slurm',
                                    randomize_start_values=False,
                                    method='particle_swarm',
                                    # method='genetic_algorithm',
                                    number_of_generations=500,
                                    population_size=50,
                                    iteration_limit=500,
                                    swarm_size=75,
                                    overwrite_config_file=True,
                                    lower_bound=0.001,
                                    upper_bound=1000
                                    )
PE.write_config_file()
PE.setup()
# PE.run()

# PE.model.open()
#
# viz.LikelihoodRanks(PE, savefig=True)
# viz.Boxplots(PE, savefig=True, log10=True, num_per_plot=50, truncate_mode='ranks',
#              theta=range(150))


data = viz.Parse(PE).data
print (data)
copasi_mod.insert_parameters(
    df=data, index=0, inplace=True)
ant = PE.model.to_antimony()
print(ant)
# copasi_mod.open()


# copasi_mod.open()


















