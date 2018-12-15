import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec
import os, glob, pandas, numpy
try:
    from pycotools import model, viz, tasks
except ImportError:
    print('Warning: Pycotools is not installed. Are you running Python3? ')

import tellurium as te
import seaborn
from collections import OrderedDict


seaborn.set_style('white')
seaborn.set_context('talk', font_scale=1)

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
                 'mTORC1',  'pmTORC1',  'S6K',      'pS6K']

MODEL_INPUTS = ['TGFb', 'Everolimus', 'MK2206', 'AZD', 'GrowthFactors']

MODEL_SPECIES += MODEL_INPUTS

ALL_CONDITIONS = ['D', 'T', 'E', 'E_A_72', 'E_A_48',
                  'E_A_24', 'E_A_1.25', 'A_72', 'A_48',
                  'A_24', 'A_1.25', 'E_M_72',
                  'E_M_48', 'E_M_24', 'E_M_1.25', 'M_72',
                  'M_48', 'M_24', 'M_1.25']



def cross_talk_model_antstr():
    """
    Antimony string model containing the most currect version of
    the CrossTalk model from Katrine and Patricia's project.
    :return:
    """
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
    
    function CompetitiveInhibition(km, ki, kcat, E, I, S)
        kcat * E * S / (km + S + ((km * I )/ ki)  )
    end
    
    model TGFbModule()
        compartment Cell = 1.0
        
        var TGFbR           in Cell  
        var TGFbR_a         in Cell  
        var TGFbR_EE        in Cell
        var TGFbR_Cav       in Cell
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
        const Everolimus       in Cell
    
    
        //TGFb module
        TGF_R1: TGFbR       => TGFbR_a    ; Cell * kTGFbOn       *TGFbR      *TGFb      ;
        TGF_R2: TGFbR_a     => TGFbR      ; Cell * kTGFbOff      *TGFbR_a               ;
        TGF_R3: TGFbR_a     => TGFbR_EE   ; Cell * kTGFbRIntern  *TGFbR_a               ; 
        TGF_R4: TGFbR_EE    => TGFbR_a    ; Cell * kTGFbRRecyc   *TGFbR_EE              ;
        TGF_R5: TGFbR_a     => TGFbR_Cav  ; Cell * kTGFbRIntern  *TGFbR_a               ;
        TGF_R6: TGFbR_Cav   => TGFbR_a    ; Cell * kTGFbRRecyc   *TGFbR_Cav             ;
        TGF_R7: Smad2       => pSmad2     ; Cell * MMWithKcat(kSmad2Phos_km, kSmad2Phos_kcat, Smad2, TGFbR_EE  );
        TGF_R8: pSmad2      => Smad2      ; Cell * MM(kSmad2Dephos_km, kSmad2Dephos_Vmax, pSmad2               );
        
        //MAPK module
        MAPK_R0  : Raf     => pRaf      ; Cell*GrowthFactors*NonCompetitiveInhibition(kRafPhos_km,  kRafPhos_ki, kRafPhos_Vmax, kRafPhos_n, ppErk, Raf);
        MAPK_R1  : pRaf    => Raf       ; Cell*MM(            kRafDephos_km ,   kRafDephosVmax,      pRaf           );
        MAPK_R2  : Mek     => pMek      ; Cell*CompetitiveInhibition(    kMekPhos_km1 , kMekPhos_ki1, kMekPhos_kcat1, pRaf, AZD, Mek       );
        MAPK_R3  : pMek    => ppMek     ; Cell*CompetitiveInhibition(    kMekPhos_km1 , kMekPhos_ki1, kMekPhos_kcat1, pRaf, AZD, pMek     );
        MAPK_R4  : ppMek   => pMek      ; Cell*MM(            kMekDephos_km1,   kMekDephos_Vmax1,     ppMek         );
        MAPK_R5  : pMek    => Mek       ; Cell*MM(            kMekDephos_km1,   kMekDephos_Vmax1,     pMek          );
        MAPK_R6  : Erk     => pErk      ; Cell*MMWithKcat(    kErkPhos_km1,     kErkPhos_kcat1, Erk,  ppMek         );
        MAPK_R7  : pErk    => ppErk     ; Cell*MMWithKcat(    kErkPhos_km1,     kErkPhos_kcat1, pErk, ppMek         );
        MAPK_R8  : ppErk   => pErk      ; Cell*MM(            kErkDephos_km1,   kErkDephos_Vmax1,     ppErk         );
        MAPK_R9  : pErk    => Erk       ; Cell*MM(            kErkDephos_km1,   kErkDephos_Vmax1,     pErk          );

        
        //PI3K Module
        //n(km, ki, kcat, E, I, S)
        PI3K_R1 :   PI3K    => pPI3K    ;  Cell *  kPI3KPhosByGF       *PI3K       *GrowthFactors ;
        PI3K_R2 :   pPI3K   => PI3K     ;   Cell *  kPI3KDephosByS6K    *pPI3K      *pS6K        ;
        PI3K_R3 :   Akt    => pAkt      ;   Cell *  CompetitiveInhibition(kAktPhos_km, kAktPhos_ki, kAktPhos_kcat, pPI3K, MK2206, Akt)              ;
        PI3K_R4 :   pAkt    => Akt      ;   Cell *  MM(kAktDephos_km, kAktDephos_Vmax,pAkt)         ;
        PI3K_R5 :   mTORC1 => pmTORC1   ;   Cell *  CompetitiveInhibition(kmTORC1Phos_km, kmTORC1Phos_ki, kmTORC1Phos_kcat, pAkt, Everolimus, mTORC1)  ;
        PI3K_R6 :   pmTORC1 => mTORC1   ;   Cell *  MM(kmTORC1Dephos_km, kmTORC1Dephos_Vmax, pmTORC1);
        PI3K_R7 :   S6K     => pS6K     ;   Cell *  MMWithKcat(kS6KPhosBymTORC1_km, kS6KPhosBymTORC1_kcat, S6K, pmTORC1) ;
        PI3K_R8 :   pS6K    => S6K      ;   Cell *  MM(kS6KDephos_km,kS6KDephos_Vmax, pS6K)                    ;
        
        // Cross talk reactions
        CrossTalkR1  :    Raf   => pRaf         ;   Cell *  MMWithKcat(kRafPhosByTGFbR_km, kRafPhosByTGFbR_kcat, Raf, TGFbR_Cav)    ;
        CrossTalkR2  :    Raf   => pRaf         ;   Cell *  MMWithKcat(kRafPhosByPI3K_km,kRafPhosByPI3K_kcat, Raf, pPI3K)           ;
        CrossTalkR3  :    PI3K  => pPI3K        ;   Cell *  MMWithKcat(kPI3KPhosByTGFbR_km, kPI3KPhosByTGFbR_kcat, PI3K, TGFbR_Cav) ;
        CrossTalkR4  :    pPI3K   => PI3K       ;   Cell *  kPI3KDephosByErk    *pPI3K      *ppErk        ;
        //CrossTalkR5  :    TGFbR_a => TGFbR_EE ;   Cell *  kTGFbRInternByAkt     *TGFbR_a    *pAkt     ;
        CrossTalkR5  :    Smad2 => pSmad2       ;   Cell *  MMWithKcat(kSmad2PhosByAkt_km, kSmad2PhosByAkt_kcat, Smad2, pAkt)       ;
        
        // These two reactions counteract Everolimus
        // CroosTalkR4:    mTORC1  => pmTORC1  ;   Cell *  kmTORC1PhosByErk    *mTORC1     *ppErk        ;
        // CroosTalkR5:    S6K     => pS6K     ;   Cell *  kS6KPhosByErk       *S6K        *ppErk        ;
 
        // Species initializations:
        TGFbR = 76.8396790634687;
        TGFbR_a = 0.966718661034664;
        TGFbR_EE = 12.55032566215;
        TGFbR_Cav = 9.66718661034664;
        Smad2 = 90.7578601099753;
        pSmad2 = 9.24213988902463;
        Mek = 252.876273823102;
        pMek = 56.0642557607438;
        Erk = 183.331905604514;
        pErk = 117.882228538386;
        PI3K = 99.9603027531632;
        pPI3K = 0.039697246836694;
        Akt = 99.413240815732;
        pAkt = 0.586759181268058;
        mTORC1 = 90.2724562462086;
        pmTORC1 = 9.72754375379144;
        S6K = 90.5069860202662;
        pS6K = 9.49301398073377;
        Raf = 87.932595095561;
        pRaf = 12.0674049063339;
        ppMek = 29.0295122061532;
        ppErk = 43.0862638108839;
        
        // Variable initializations:
        TGFb = 0.005;
        GrowthFactors = 1;
        kTGFbOn = 0.100647860357268;
        kTGFbOff = 0.04;
        kTGFbRIntern = 0.3333333333;
        kTGFbRRecyc = 0.03333333333;
        kSmad2Phos_km = 97.0531;
        kSmad2Phos_kcat = 2;
        kSmad2Dephos_km = 100;
        kSmad2Dephos_Vmax = 58.8712661228653;
        kRafPhos_km = 10;
        kRafPhos_ki = 3.5;
        kRafPhos_Vmax = 9000;
        kRafPhos_n = 1;
        kRafDephos_km = 8;
        kRafDephosVmax = 3602.5;
        kMekPhos_km1 = 15;
        kMekPhos_ki1 = 0.25;
        kMekPhos_kcat1 = 165;
        AZD = 0;
        kMekDephos_km1 = 15;
        kMekDephos_Vmax1 = 2700;
        kErkPhos_km1 = 100;
        kErkPhos_kcat1 = 85.0103161451182;
        kErkDephos_km1 = 15;
        kErkDephos_Vmax1 = 1800;
        kPI3KPhosByGF = 0.239474698704283;
        kPI3KDephosByS6K = 25;
        kAktPhos_km = 15;
        kAktPhos_ki = 0.01;
        kAktPhos_kcat = 2.9215;
        MK2206 = 0;
        kAktDephos_km = 15;
        kAktDephos_Vmax = 31.1252344504785;
        kmTORC1Phos_km = 1;
        kmTORC1Phos_ki = 0.001;
        kmTORC1Phos_kcat = 0.1;
        Everolimus = 0;
        kmTORC1Dephos_km = 100;
        kmTORC1Dephos_Vmax = 1;
        kS6KPhosBymTORC1_km = 10;
        kS6KPhosBymTORC1_kcat = 2.77975221288272;
        kS6KDephos_km = 10;
        kS6KDephos_Vmax = 50;
        kRafPhosByTGFbR_km = 25;
        kRafPhosByTGFbR_kcat = 265;
        kRafPhosByPI3K_km = 50;
        kRafPhosByPI3K_kcat = 50;
        kPI3KPhosByTGFbR_km = 10;
        kPI3KPhosByTGFbR_kcat = 50;
        kPI3KDephosByErk = 5.014;
        //kTGFbRInternByAkt = 0.01;
        kSmad2PhosByAkt_km = 1;
        kSmad2PhosByAkt_kcat = 1;
        

      unit volume = 1 litre;
      unit time_unit = 3600 second;
      unit substance = 1e-9 mole;
        
end
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


def make_condition(model_string, condition):
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
    if condition not in AZD_CONDITIONS.keys() + MK_CONDITIONS.keys():
        raise ValueError('No key. These keys "{}"'.format(AZD_CONDITIONS.keys()+MK_CONDITIONS.keys()))
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
    if condition not in AZD_CONDITIONS.keys() + MK_CONDITIONS.keys():
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
        model_str = cross_talk_model_antstr()

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
    for k, v in conditions.items():
        # p = Process(target=simulate_condition, args=(tuple([cross_talk_model_antstr()] + conditions[k])))
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

def simulate_conditions2(model_str=None, conditions=None):
    """
    Takes output from simulation and plot
    :param df:
    :return:
    """
    if model_str is None:
        model_str = cross_talk_model_antstr()

    if conditions is None:
        conditions = [
            'A_1.25', 'A_24', 'E', 'D', 'M_48', 'M_72',
            'E_M_24', 'E_A_72', 'E_A_48', 'M_1.25', 'E_A_24',
            'M_24', 'T', 'E_M_72', 'E_M_48', 'A_48', 'E_M_1.25',
            'E_A_1.25', 'A_72'
        ]
    # from multiprocessing import Process

    dct = OrderedDict()
    for k in conditions:
        # p = Process(target=simulate_condition, args=(tuple([cross_talk_model_antstr()] + conditions[k])))
        # p.start()
        # p.join()
        df = simulate_condition(model_str, k)
        df = df[df['time'] == 72.0]
        if df.empty:
            raise ValueError("Condition '{}' produces an "
                             "empty data frame".format(k))

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
                    order=MK_CONDITIONS.keys() if type == 'MK2206' else AZD_CONDITIONS.keys()
                    )
    plt.title(y)
    seaborn.despine(fig, top=True, right=True)
    plt.xticks(rotation=90, fontsize=18)
    plt.yticks(fontsize=18)

    if type == 'AZD':
        dire = os.path.join(graphs_directory, 'AZDSimulations')
    else:
        dire = os.path.join(graphs_directory, 'MKSimulations')
    os.makedirs(dire) if not os.path.isdir(dire) else None
    fname = os.path.join(dire, "{}.png".format(y))
    fig.savefig(fname, dpi=300, bbox_inches='tight')
    print('line 485: Figure saved to "{}"'.format(fname))



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
    for k, v in conditions.items():
        df = simulate_condition(cross_talk_model_antstr(), k)
        dct[k] = df
    # print(dct)

    df = pandas.concat(dct)
    df.index = df.index.droplevel(1)
    df = df.set_index('time', append=True)
    df.index = df.index.rename(['condition', 'time'])

    return df


def plot_timecourse_single(vars, condition=None):
    if condition not in AZD_CONDITIONS.keys() + MK_CONDITIONS.keys():
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
        if condition not in MK_CONDITIONS.keys():
            raise ValueError

    elif AZD_or_MK == 'AZD':
        if condition not in AZD_CONDITIONS.keys():
            raise ValueError('"{}" condition is not in "{}"'.format(condition, AZD_CONDITIONS.keys()))

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
        sub_ax = plt.subplot(*multifig_shape + [v+1])
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
        if v == len(vars)-1:
            plt.xlabel('Time(h)')

    plt.setp(sub_ax.get_xticklabels(), visible=True)

    fig.text(0.05, 0.5, 'nmol L$^{-1}$', ha='center', va='center', rotation='vertical')

    return fig


def simulate_inputs_only(AZD_or_MK='AZD'):
    if AZD_or_MK not in ['AZD', 'MK2206']:
        raise ValueError

    dire = os.path.join(graphs_directory, 'InputSimulations')
    os.makedirs(dire) if not os.path.isdir(dire) else None

    if AZD_or_MK == 'AZD':
        conditions = AZD_CONDITIONS.keys()
    elif AZD_or_MK == 'MK2206':
        conditions = MK_CONDITIONS.keys()
    else:
        raise ValueError

    conditions = list(set(conditions))

    for cond in conditions:
        fig = plot_timecourse_multiplot(['TGFb', 'MK2206', 'Everolimus', 'AZD', 'GrowthFactors'],
                                        condition=cond, multifig_shape=[5, 1], AZD_or_MK=AZD_or_MK)

        fname = os.path.join(dire, "{}.png".format(cond))
        fig.savefig(fname, dpi=300, bobx_inches='tight')
        print("Saved to '{}'".format(fname))




def open_condition_with_copasi(model_string, condition):
    """
    Create condition with model string and open with copasi,
    saving to folder while your at it
    :param condition:
    :return:
    """
    mod_string = make_condition(model_string, condition)
    copasi_dir = os.path.join(working_directory, 'copasi_models')
    if not os.path.isdir(copasi_dir):
        os.makedirs(copasi_dir)
    fname = os.path.join(copasi_dir, "{}.cps".format(condition))
    copasi_mod = load_model_with_pyco(mod_string, fname)
    tasks.TimeCourse(copasi_mod, start=0, end=72, step_size=0.1, intervals=720, run=False)
    copasi_mod.open()
    return copasi_mod


def configure_parameter_estimation(model_string, condition):
    mod_string = make_condition(model_string, condition)
    copasi_dir = os.path.join(working_directory, 'copasi_models')
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
                                   overwrite_config_file=False)
    PE.write_config_file()
    PE.setup()
    return PE.model




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
        figsize = (2*len(cond), 3*len(cond))

    cols = seaborn.color_palette("hls", len(vars))*len(cond)
    cols = iter(cols)

    fig = plt.figure(figsize=figsize)
    for i, c in enumerate(cond):
        if c not in list(MK_CONDITIONS.keys()) + list(AZD_CONDITIONS.keys()):
            raise ValueError('condition "{}" not in "{}"'.format(c, MK_CONDITIONS.keys() + AZD_CONDITIONS.keys()))

        model_str = make_condition(cross_talk_model_antstr(), c)
        mod = te.loada(model_str)
        res = mod.simulate(0, 72, 73, ['time'] + vars)
        gs = GridSpec(len(cond), 1, wspace=0.3)
        ax = []
        for j, v in enumerate(vars):
            ax.append(fig.add_subplot(gs[i, 0]))
            ax[-1].plot(res['time'], res[v], label=v, color=next(cols), linewidth=6, **kwargs)

        plt.axvline(0.0  ,   linestyle='--', linewidth=2, color='black',  alpha=0.4)
        plt.axvline(24.0 ,   linestyle='--', linewidth=2, color='black',  alpha=0.4)
        plt.axvline(48.0 ,   linestyle='--', linewidth=2, color='black',  alpha=0.4)
        plt.axvline(70.25,   linestyle='--', linewidth=2, color='green',  alpha=0.4)
        plt.axvline(71.25,   linestyle='--', linewidth=2, color='purple', alpha=0.4)
        plt.axvline(72.0 ,   linestyle='--', linewidth=2, color='black',  alpha=0.4)

        plt.setp(ax[-1].get_xticklabels(), visible=False)
        seaborn.despine(ax=ax[-1], top=True, right=True)
        plt.title(c)
    if i == len(cond):
        plt.xlabel('Time(h)')

    fig.text(0.025, 0.5, 'nmol L$^{-1}$', ha='center', va='center', rotation='vertical')
    plt.legend(loc=[1, 1])
    plt.setp(ax[-1].get_xticklabels(), visible=True)

    dire = os.path.join(graphs_directory, 'TimeSeriesSimulations')
    os.makedirs(dire) if not os.path.isdir(dire) else None
    if filename is None:
        fname = os.path.join(dire, reduce(lambda x, y: "{}__{}".format(x, y), cond) + '.png')
    else:
        fname = os.path.join(dire, filename)

    plt.savefig(fname, dpi=250, bbox_inches='tight')


def get_parameters_from_copasi_in_antimony_format(condition):
    copasi_dir = os.path.join(working_directory, 'copasi_models')
    fname = os.path.join(copasi_dir, "{}.cps".format(condition))
    sbml = os.path.join(copasi_dir, "{}.sbml".format(condition))
    pm = model.Model(fname)
    pm.to_sbml(sbml)
    mod = te.loadSBMLModel(sbml)
    print(mod.getCurrentAntimony())

def get_model_parameters(mod):
    return dict(zip(mod.getGlobalParameterIds(), mod.getGlobalParameterValues()))

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


class InequalityGroup(object):
    def __init__(self, inequalities):
        self.inequalities = inequalities

    def evaluate(self, df):
        eval_dct = OrderedDict()
        for ineq in self.inequalities:
            if not isinstance(ineq, Inequality):
                raise ValueError

            ev = ineq.evaluate(df)



def do_robustness(model_string):
    mod = te.loada(model_string)
    peterb_parameters = OrderedDict({
        'kSmad2Phos_kcat': 2.0,
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
        'kRafPhosByPI3K_kcat': 50.0,
        'kRafPhosByTGFbR_kcat': 265.0,
        'kMekPhos_kcat1': 165.0,
        'kMekPhos_ki1': 0.25,
        'kTGFbOn': 0.100647860357268,
        'kSmad2PhosByAkt_kcat': 1.0,
        'kSmad2Dephos_Vmax': 58.8712661228653,
        'kAktPhos_ki': 0.01,
        'kmTORC1Phos_kcat': 0.1,
    })
    # for k, v in peterb_parameters.items():
    #     print(k, v, new, type(new))
    #     print(setattr)
        # new = numpy.random.normal(0, 0.1*v, 1)[0]
        # setattr(mod, k, v+new)

    delta = 0.01

    df = simulate_conditions2(mod.getCurrentAntimony())
    ineq1 = Inequality(['E', 'pAkt'], '>', ['D', 'pAkt'], 'pAkt')
    ineq2 = Inequality(['E', 'ppErk'], '>', ['D', 'ppErk'], 'pErk')
    e = ineq1.evaluate(df)
    prob_vec = OrderedDict(zip(peterb_parameters.keys(),
                               [1.0 / len(peterb_parameters)] * len(peterb_parameters)))
    res = {}
    for i in range(3):
        choice = numpy.random.choice(peterb_parameters.keys(), p=prob_vec.values())
        new = numpy.random.normal(0, 0.1 * peterb_parameters[choice], 1)[0]
        old = peterb_parameters[choice]
        peterb_parameters[choice] = peterb_parameters[choice] + new
        setattr(mod,  choice, peterb_parameters[choice])
        df = simulate_conditions2(mod.getCurrentAntimony())
        e = ineq.evaluate(df)
        print("Eval to '{0}'. The parameter choice is '{1}'. "
              "The old value of '{1}' is '{2}', new value is '{3}'".format(
            e, choice, old, peterb_parameters[choice]
        ))
        if e:
            res[i] = pandas.DataFrame({
                'prob': prob_vec,
                'param_val': peterb_parameters
            })
            prob_vec[choice] = prob_vec[choice] + delta
            for i in prob_vec.keys():
                if i != choice:
                    prob_vec[i] = prob_vec[i] - delta/(len(prob_vec) - 1)
        else:
            prob_vec[choice] = prob_vec[choice] - delta
            for i in prob_vec.keys():
                if i != choice:
                    prob_vec[i] = prob_vec[i] + delta/(len(prob_vec) - 1)

    df = pandas.concat(res)
    print(df)
    return res

    # print(choice)

    # simulate_conditions
    # print(get_model_parameters(mod))


if __name__ == '__main__':

    working_directory = r'D:\MesiSTRAT\CrossTalkModel'
    copasi_filename = os.path.join(working_directory, 'KatrinesTopology.cps')
    graphs_directory = os.path.join(working_directory, 'SimulationGraphs')

    """
    Set flags to determine which part of the script will run
    """

    def set_flags():
        """
        Dummy function to get clickable button on
        PyCharm structure tab to take me directly to
        the flags
        :return:
        """

    SIMULATE_TIME_SERIES            = False
    SIMULATE_BAR_GRAPHS             = False
    OPEN_CONDITION_WITH_COPASI      = False

    ROBUSTNESS                      = True

    GET_PARAMETERS_FROM_COPASI      = False

    CONFIGURE_PARAMETER_ESTIMATION  = False

    DOSE_RESPONSE_GROWTH_FACTOR     = False
    DOSE_RESPONSE_TGFB              = False
    GET_ODES_WITH_ANTIMONY          = False
    GET_MODEL_AS_SBML               = False
    SIMULATE_INPUTS                 = False

    if GET_PARAMETERS_FROM_COPASI:
        get_parameters_from_copasi_in_antimony_format('E_A_72')

    if OPEN_CONDITION_WITH_COPASI:
        open_condition_with_copasi(cross_talk_model_antstr(), 'E_A_72')

    if CONFIGURE_PARAMETER_ESTIMATION:
        m = configure_parameter_estimation(cross_talk_model_antstr(), 'T')
        m.open()

    phos = ['pErk', 'pAkt', 'pSmad2', 'pRaf', 'ppMek', 'ppErk',
            'pPI3K', 'pPI3K', 'pmTORC1', 'pS6K']
    erk = ['Erk', 'pErk', 'ppErk']
    pSmad2  =   ['pSmad2', 'pErk', 'ppErk', 'pAkt', 'pS6K']

    if SIMULATE_TIME_SERIES:
        for i in pSmad2:
            simulate_model_component_timecourse([i], AZD_CONDITIONS.keys(), filename='AZD_'+i)
            simulate_model_component_timecourse([i], MK_CONDITIONS.keys(), filename='MK_'+i)

    if SIMULATE_BAR_GRAPHS:
        for i in ['AZD', 'MK2206']:
            for j in pSmad2:
                simulate_conditions_and_plot_as_bargraph(j, i)



    if SIMULATE_INPUTS:
        simulate_inputs_only('AZD')
        simulate_inputs_only('MK2206')

    if not os.path.isdir(graphs_directory):
        os.makedirs(graphs_directory)

    if GET_ODES_WITH_ANTIMONY:
        mod = te.loada(cross_talk_model_antstr())
        odes = te.utils.misc.getODEsFromModel(mod)
        print(odes)

    if GET_MODEL_AS_SBML:
        sbml = te.antimonyToSBML(cross_talk_model_antstr())
        print(sbml)

    if DOSE_RESPONSE_TGFB:
        fig = dose_response(cross_talk_model_antstr(), 'TGFb', 0.01, 1000, 100, ['TGFbR'])
        plt.show()


    if ROBUSTNESS:
        model_string = cross_talk_model_antstr()


        do_robustness(model_string)



"""
Sudocode for ML algorithm for optimizing topology with qualitative information.

N = number of iterations

Value = Evaluate objective function for current parameter set and topology
for i=0:N
    x = Propose new parameter set
    evaluate objective function for x
    if better than value:
        value = x
    else
        iterate
end
    



"""


    # f = os.path.join(working_directory, 'KholoPlusVilar.cps')
    # f2 = os.path.join(working_directory, 'KholoPlusVilar.sbml')
    #
    # m = model.Model(f)
    # m.open()
    # m.to_sbml(f2)
    # for i in sorted(dir(te)):
    #     print(i)
    # st = te.sbmlToAntimony(f2)
    # print(st)
    # m = te.loada(cross_talk_model_antstr())
    # pts, lbls, biData = te.analysis.bifurcation.bifurcation(m, 'kPI3KDephosByS6K', 0.001, 100)
    # print(pts, lbls, biData)

    # print(biData.plotBifurcation)

    # open_condition_with_copasi('D')

















