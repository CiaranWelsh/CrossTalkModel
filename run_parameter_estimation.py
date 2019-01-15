import os, glob
import site
site.addsitedir(r'/home/ncw135/Documents/pycotools3')
from pycotools3 import model, viz, tasks






CLUSTER = False

if CLUSTER:
    WORKING_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel'
else:
    WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'
print(WORKING_DIRECTORY)


DATA_DIR = os.path.join(WORKING_DIRECTORY, 'data')
GRAPHS_DIRECTORY = os.path.join(WORKING_DIRECTORY, 'SimulationGraphs')
COPASI_MODELS_DIR = os.path.join(WORKING_DIRECTORY, 'CopasiModelFiles')

COPASI_DATA_DIR = os.path.join(DATA_DIR, 'CopasiDataFiles')

DATA_FILES = glob.glob(os.path.join(COPASI_DATA_DIR, '*.csv'))

for i in DATA_FILES:
    assert os.path.isfile(i)


# OTHER_COPASI_MODEL = r'D:\MesiSTRAT\CrossTalkModel\copasi_models\E_A_48_2.cps'
OTHER_COPASI_MODEL = os.path.join(COPASI_MODELS_DIR, 'E_A_48/E_A_48.cps')


copasi_mod = model.Model(OTHER_COPASI_MODEL)

global_params = copasi_mod.global_quantities
free_params = [i.name for i in global_params if i.name[0] == '_']

# copasi_mod.open()
PE = tasks.MultiParameterEstimation(copasi_mod,
                                    DATA_FILES,
                                    copy_number=8,
                                    pe_number=1,
                                    metabolites=[],
                                    global_quantities=free_params,
                                    run_mode='parallel',
                                    method='genetic_algorithm',
                                    number_of_generations=500,
                                    population_size=50,
                                    overwrite_config_file=True,
                                    lower_bound=0.001,
                                    upper_bound=1000
                                    )
PE.write_config_file()
PE.setup()
PE.run()

PE.model.open()
























