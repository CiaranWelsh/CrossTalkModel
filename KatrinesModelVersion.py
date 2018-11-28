import os, glob, pandas, numpy
from pycotools import model, viz, tasks
import tellurium as te
import seaborn
import matplotlib

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
        R1:                 => TGFbR            ; Cell * kTGFbRProd                             ;
        R2: TGFbR           =>                  ; Cell * kTGFbRDeg      *TGFbR                  ;    
        R3: TGFbR + TGFb    => TGFbR_a          ; Cell * kTGFbOn        *TGFb                   ;
        R4: TGFb            =>                  ; Cell * kTGFRemoval    *TGFb                   ;
        R5: TGFbR_a         => TGFbR + TGFb     ; Cell * kTGFbOff       *TGFbR_a                ;
        R6: Smad2           => pSmad2           ; Cell * kSmad2Phos     *Smad2      *TGFbR_a    ;
        R7: pSmad2          => Smad2            ; Cell * kSmad2Dephos   *pSmad2                 ;
        Rx8:                => Smad7            ; Cell * kSmad7Prod     *pSmad2                 ;
        Rx9: Smad7          =>                  ; Cell * kSmad7Deg      *Smad7                  ;
        Rx10: TGFbR_a + Smad7 =>                  ; Cell * kTGFbRDegBySmad7   *TGFbR_a    *Smad7  ;
        
        //MEK module                   //
        R8_1:   Mek      => pMek     ;   Cell * kMekPhosByPI3K      *Mek    *pPI3K   ;
        R8_2:   Mek      => pMek     ;   Cell * kMekPhosByTGFbR_a   *Mek    *TGFbR_a ;
        R8_3:   Mek      => pMek     ;   Cell * kMekPhosByGFR      *Mek    *pGFR    ;
        R9_1:   pMek     => Mek      ;   Cell * kMekDephosByAkt     *pMek   *pAkt    ;
        R9_2:   pMek     => Mek      ;   Cell * kMekDephosByAZD     *pMek   *AZD     ; 
        R10 :    Erk      => pErk     ;   Cell * kErkPhosByMek       *Erk    *pMek    ;
        R11:    pErk     => Erk      ;   Cell * kErkDephos          *pErk
        
        
        //PI3K Module
        R12:        GFR     => pGFR     ;   Cell *(kGFRPhos_kcat       * GrowthFactors * GFR /(kGFRPhos_km^kGFRPhos_h + GFR^kGFRPhos_h))
        R13:        pGFR    => GFR      ;   Cell *  kGFRDephos         *pGFR                    ;
        R14_1:      PI3K    => pPI3K    ;   Cell *  kPI3KPhosByGFR     *PI3K       *pGFR        ;
        R14_2:      PI3K    => pPI3K    ;   Cell *  kPI3KPhosByMek      *PI3K       *pMek        ;
        R15_1:      pPI3K   => PI3K     ;   Cell *  kPI3KDephosByS6K    *pPI3K      *pS6K        ;
        R15_2:      pPI3K   => PI3K     ;   Cell *  kPI3KDephosByErk    *pPI3K      *pErk        ;
        R16:        Akt     => pAkt     ;   Cell *  kAktPhos            *Akt        *pPI3K       ;
        R17:        pAkt    => Akt      ;   Cell *  kAktDephos          *pAkt       *MK2206      ;
        R18_1:      mTORC1  => pmTORC1  ;   Cell *  kmTORC1PhosByAkt    *mTORC1     *pAkt        ;
        R18_2:      mTORC1  => pmTORC1  ;   Cell *  kmTORC1PhosByErk    *mTORC1     *pErk        ;
        R19_1:      pmTORC1 => mTORC1   ;   Cell *  kmTORC1DephosByEv   *pmTORC1    *Everolimus  ;
        R19_2:      pmTORC1 => mTORC1   ;   Cell *  kmTORC1Dephos       *pmTORC1                 ;
        R20_1:      S6K     => pS6K     ;   Cell *  kS6KPhosBymTORC1    *S6K        *pmTORC1     ;
        R20_2:      S6K     => pS6K     ;   Cell *  kS6KPhosByErk       *S6K        *pErk        ;
        R21:        pS6K    => S6K      ;   Cell *  kS6KDephos          *pS6K                    ;
        
        kTGFbOn             = 0.04
        kTGFbOff            = 0.02
        kTGFbRProd          = 0.1
        kTGFbRDeg           = 0.001
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

    print(res)
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



if __name__ == '__main__':

    working_directory = r'D:\MesiSTRAT\CrossTalkModel'
    copasi_filename = os.path.join(working_directory, 'KatrinesTopology.cps')
    graphs_directory = os.path.join(working_directory, 'SimulationGraphs')

    if not os.path.isdir(graphs_directory):
        os.makedirs(graphs_directory)


    # dose_response_for_growth_factors()
    mod = load_model_with_pyco(cross_talk_model_antstr(), copasi_filename)
    mod.open()

    # mod = te.loada(functions_antstr() + cross_talk_model_antstr())
    # odes = te.utils.misc.getODEsFromModel(mod)
    # print(odes)

    # sbml = te.antimonyToSBML(functions_antstr() + cross_talk_model_antstr())
    # print(sbml)
    i = 'GFR'
    j = 'pGFR'
    # pmid_for_IGF_data = 'PMID: 26217307'
    fig = dose_response(cross_talk_model_antstr(), 'GrowthFactors', 0.1, 1000, 10, [i, j])
    plt.title('Dose Response of {} and \n{} to GrowthFactors'.format(i, j))
    fname = os.path.join(graphs_directory, 'GrowthFactorsDoseResponse{}.png'.format(i))
    fig.savefig(fname, dpi=150, bbox_inches='tight')
    plt.show()

    # print(cross_talk_model_antstr())
    # import re

    # r = re.sub('MA1Mod\( (.*), *(.*), *(.*)\)', '\\1*\\2*\\3', cross_talk_model_antstr())
    # print(r)
    # print(te.getVersionInfo())
    # model_string,
    # scan_parameter,
    # start_value,
    # end_value,
    # number_of_points,
    # selection,
    # log10 = False
    # ):

    # fig = dose_response(functions_antstr() + cross_talk_model_antstr(), 'TGFb', 0.01, 1000, 100, ['TGFbR', 'TGFbR_a'])
    # plt.show()








