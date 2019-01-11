import os, glob
from collections import OrderedDict

MODEL_CODE                      = 'E_A_48'

CURRENT_SPECIES = [
    'pSmad2Tot', 'pSmad2', 'pSmad2n', 'Smad2n', 'Smad2Tot',
    'pErk', 'ppErk', 'pAkt', 'pS6K', 'pmTORC1',
]

CURRENT_SPECIES = [
    'pSmad2',
    'pErk', 'ppErk', 'pAkt', 'pS6K', 'pmTORC1',
]
# CURRENT_SPECIES = ['pSmad2Tot']
# CURRENT_SPECIES = [
#     'pSmad2Tot', 'pSmad2', 'pSmad2n', 'Smad2n', 'Smad2Tot',
#
# ]

SIMULATE_TIME_SERIES            = False
SIMULATE_BAR_GRAPHS             = True
OPEN_CONDITION_WITH_COPASI      = False
CONFIGURE_PARAMETER_ESTIMATION  = False
GET_PARAMETERS_FROM_COPASI      = False

QUALITATIVE_FITTING             = False



DOSE_RESPONSE_GROWTH_FACTOR     = False
DOSE_RESPONSE_TGFB              = False
GET_ODES_WITH_ANTIMONY          = False
GET_MODEL_AS_SBML               = False
SIMULATE_INPUTS                 = False

FREE_PARAMETERS = OrderedDict({
            'kmTORC1Phos_ki': 0.001,
            'kPI3KPhosByTGFbR_kcat': 50.0,
            'kAktDephos_Vmax': 31.1252344504785,
            'kPI3KDephosByErk': 5.014,
            'kS6KPhosBymTORC1_kcat': 2.77975221288272,
            'kPI3KPhosByGF': 0.239474698704283,
            'kPI3KDephosByS6K': 25.0,
            'kErkPhos_kcat1': 85.0103161451182,
            'kmTORC1Dephos_Vmax': 1.0,
            'kS6KDephos_Vmax': 50.0,
            'kAktPhos_kcat': 2.9215,
            'kRafPhos_ki': 3.5,
            'kRafPhosByTGFbR_kcat': 265.0,
            'kRafPhosByPI3K_kcat': 50.0,
            'kMekPhos_kcat1': 149.5209856,
            'kMekPhos_ki1': 0.25,
            'kTGFbOn': 0.100647860357268,
            'kSmad2PhosByAkt_kcat': 1.0,
            'kpSmad2Dephos_Vmax': 58.8712661228653,
            'kAktPhos_ki': 0.01,
            'kmTORC1Phos_kcat': 0.1,
        })

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
                 'pSmad2Tot', 'pSmad2n', 'Smad2Tot', 'Smad2n'
                 ]

MODEL_INPUTS = ['TGFb', 'Everolimus', 'MK2206', 'AZD', 'GrowthFactors']

MODEL_SPECIES += MODEL_INPUTS

ALL_CONDITIONS = ['D', 'T', 'E', 'E_A_72', 'E_A_48',
                  'E_A_24', 'E_A_1.25', 'A_72', 'A_48',
                  'A_24', 'A_1.25', 'E_M_72',
                  'E_M_48', 'E_M_24', 'E_M_1.25', 'M_72',
                  'M_48', 'M_24', 'M_1.25']


WORKING_DIRECTORY = r'D:\MesiSTRAT\CrossTalkModel'
COPASI_FILENAME = os.path.join(WORKING_DIRECTORY, 'KatrinesTopology.cps')
GRAPHS_DIRECTORY = os.path.join(WORKING_DIRECTORY, 'SimulationGraphs')
PICKLE_PATH = os.path.join(WORKING_DIRECTORY, 'models.pickle')

COPASI_DATA_DIR = os.path.join(WORKING_DIRECTORY, 'CopasiDataFiles')

DATA_FILES = glob.glob(os.path.join(COPASI_DATA_DIR, '*.csv'))

for i in DATA_FILES:
    assert os.path.isfile(i)


OTHER_COPASI_MODEL = r'D:\MesiSTRAT\CrossTalkModel\copasi_models\E_A_48_2.cps'










