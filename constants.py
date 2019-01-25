import os, glob
from collections import OrderedDict
import subprocess

import logging
mpl_logger = logging.getLogger('matplotlib')
mpl_logger.setLevel(logging.WARNING)

CURRENT_MODEL_CODE              = 'A_48'

SIMULATE_TIME_SERIES            = False
SIMULATE_BAR_GRAPHS             = True
OPEN_CONDITION_WITH_COPASI      = False
PARAMETER_ESTIMATION            = False
RUN_PYCOTOOLS_VIZ               = False
GET_PARAMETERS_FROM_COPASI      = False


QUALITATIVE_FITTING             = False



DOSE_RESPONSE_GROWTH_FACTOR     = False
DOSE_RESPONSE_TGFB              = False
GET_ODES_WITH_ANTIMONY          = False
GET_MODEL_AS_SBML               = False
SIMULATE_INPUTS                 = False





CURRENT_SPECIES = [
    'pSmad2', 'pErk', 'ppErk',
    'pAkt', 'pS6K', 'pmTORC1',
]

# CURRENT_SPECIES = ['pSmad2']


"""
These are arguments for the conditions simulation functions. 
    :param GF: starting amount of GrowthFactors
    :param pretreatment: either 'AZD', or 'MK2206'. This is added as an event at the time specified by pretreatment time
    :param pretreatment_time: The time at which the variable specified by 'pretreatment' is added
    :param EV: Starting amount of Everolimus
    :param serum_starve_event: Boolean, whether to remove serum, aka GrowthFactors by event
    :param TGFb_event: Boolean. Whether to add 1 unit TGF at t=-45min (71.75h)

"""

AZD_CONDITIONS = OrderedDict()
AZD_CONDITIONS['D']         =   [1,  None,     None,       0,  True,   False]
AZD_CONDITIONS['T']         =   [1,  None,     None,       0,  True,   True]
AZD_CONDITIONS['E']         =   [1,  None,     None,       1,  True,   True]
AZD_CONDITIONS['E_A_72']    =   [1,  "AZD",    0.0,        1,  True,   True]
AZD_CONDITIONS['E_A_48']    =   [1,  "AZD",    24,         1,  True,   True]
AZD_CONDITIONS['E_A_24']    =   [1,  "AZD",    48.0,       1,  True,   True]
AZD_CONDITIONS['E_A_1.25']  =   [1,  "AZD",    70.75,      1,  True,   True]
AZD_CONDITIONS['A_72']      =   [1,  "AZD",    0.0,        0,  True,   True]
AZD_CONDITIONS['A_48']      =   [1,  "AZD",    24,         0,  True,   True]
AZD_CONDITIONS['A_24']      =   [1,  "AZD",    48.0,       0,  True,   True]
AZD_CONDITIONS['A_1.25']    =   [1,  "AZD",    70.75,      0,  True,   True]

MK_CONDITIONS = OrderedDict()
MK_CONDITIONS['D']          =     [1, None,      None,   0, True, False]
MK_CONDITIONS['T']          =     [1, None,      None,   0, True, True]
MK_CONDITIONS['E']          =     [1, None,      None,   1, True, True]
MK_CONDITIONS['E_M_72']     =     [1, "MK2206",  0.0,    1, True, True]
MK_CONDITIONS['E_M_48']     =     [1, "MK2206",  24.0,   1, True, True]
MK_CONDITIONS['E_M_24']     =     [1, "MK2206",  48.0,   1, True, True]
MK_CONDITIONS['E_M_1.25']   =     [1, "MK2206",  70.75,  1, True, True]
MK_CONDITIONS['M_72']       =     [1, "MK2206",  0.0,    0, True, True]
MK_CONDITIONS['M_48']       =     [1, "MK2206",  24.0,   0, True, True]
MK_CONDITIONS['M_24']       =     [1, "MK2206",  48.0,   0, True, True]
MK_CONDITIONS['M_1.25']     =     [1, "MK2206",  70.75,  0, True, True]


MODEL_SPECIES = ['TGFbR',   'TGFbR_a',  'TGFbR_EE', 'TGFbR_Cav',
                 'Smad2',   'pSmad2',   'Raf',      'pRaf',
                 'Mek',     'pMek',     'ppMek',    'Erk',        'pErk',
                 'ppErk',   'PI3K',     'pPI3K',    'Akt',        'pAkt',
                 'mTORC1',  'pmTORC1',  'S6K',      'pS6K',

                 ]

MODEL_INPUTS = ['TGFb', 'Everolimus', 'MK2206', 'AZD', 'GrowthFactors']

MODEL_SPECIES += MODEL_INPUTS

ALL_CONDITIONS = ['D', 'T', 'E', 'E_A_72', 'E_A_48',
                  'E_A_24', 'E_A_1.25', 'A_72', 'A_48',
                  'A_24', 'A_1.25', 'E_M_72',
                  'E_M_48', 'E_M_24', 'E_M_1.25', 'M_72',
                  'M_48', 'M_24', 'M_1.25']


## linux
WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'
COPASI_FILENAME = os.path.join(WORKING_DIRECTORY, 'KatrinesTopology.cps')
CLUSTER = False

if CLUSTER:
    WORKING_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel'
else:
    WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'

## on windows
# WORKING_DIRECTORY = r'D:\MesiSTRAT\CrossTalkModel'

DATA_DIR = os.path.join(WORKING_DIRECTORY, 'data')
# COPASI_FILENAME = os.path.join(WORKING_DIRECTORY, 'KatrinesTopology.cps')
GRAPHS_DIRECTORY = os.path.join(WORKING_DIRECTORY, 'SimulationGraphs')
# PICKLE_PATH = os.path.join(WORKING_DIRECTORY, 'models.pickle')

COPASI_MODELS_DIR = os.path.join(WORKING_DIRECTORY, 'CopasiModelFiles')

COPASI_DATA_DIR = os.path.join(DATA_DIR, 'CopasiDataFiles')

DATA_FILES = sorted(glob.glob(os.path.join(COPASI_DATA_DIR, '*.csv')))

for i in DATA_FILES:
    assert os.path.isfile(i)


# OTHER_COPASI_MODEL = r'D:\MesiSTRAT\CrossTalkModel\copasi_models\E_A_48_2.cps'
OTHER_COPASI_MODEL = os.path.join(COPASI_MODELS_DIR, 'E/E_other.cps')

# assert os.path.isfile(OTHER_COPASI_MODEL)

# FIT_DIR = os.path.join(WORKING_DIRECTORY, 'fitting')
# FIT1_DIR = os.path.join(FIT_DIR, 'fit1')
# FIT_COPASI_FILE = os.path.join(FIT1_DIR, 'CrossTalkBaseModel.cps')

# BASE_COPASI_MODEL = os.path.join(WORKING_DIRECTORY, 'CrossTalkModelBase.cps')

## maximum values in data files:

PAKT_MAX = 19.72869654
PERK_MAX = 45.73685166
PS6K_MAX = 18.05521872
PSMAD2_MAX = 17.77155917









