from constants import *
import site, os, glob
import pandas, numpy
import re
import tellurium as te
site.addsitedir(r'/home/ncw135/Documents/pycotools3')
site.addsitedir(r'D:\pycotools3')
from pycotools3 import model, tasks, viz


class CrossTalkModel:
    """
    build a factory that churns out functions that return models and take as argument the
    antimony parameter strings
    """

    def __init__(self, variant, parameter_str=None):
        """

        :param variant: int. 1 to 7. ID of topology
        :param parameter_str: parameter set for the model as antimony string
        """
        self.variant = variant
        self.parameter_str = parameter_str

        model_variants = {
            0: CrossTalkModel.null(),
            1: CrossTalkModel.akt_activate_smad2(),
            2: CrossTalkModel.erk_activates_smad2(),
            3: CrossTalkModel.both_akt_and_erk_activate_smad2(),
            4: CrossTalkModel.akt_activates_and_erk_inhibits_smad2(),
            5: CrossTalkModel.akt_inhibits_and_erk_activates_smad2(),
            6: CrossTalkModel.akt_activates_and_inhibits_smad2(),
            7: CrossTalkModel.akt_and_erk_activate_smad2_and_erk_inhibits_smad2(),
        }

        self.variant = model_variants[self.variant]

    def build(self):
        s = ''
        s += self.functions()
        s += 'model CrossTalkModelVariant{}'.format(self.variant)
        s += self.compartments()
        s += self.reactions()
        if self.parameter_str is None:
            s += self.default_parameter_str()
        else:
            s += self.parameter_str
        s += self.events()
        s += self.units()
        s += "\nend"

        ## now remove any parameters that belong to other models
        for useless_parameter in self.model_specific_parameter_list:
            if useless_parameter not in self.reactions():
                s = re.sub(".*{}.*".format(useless_parameter), "", s)

        return s

    def to_copasi(self, cps):
        with model.BuildAntimony(cps) as loader:
            mod = loader.load(self.build())
        return mod

    def to_tellurium(self):
        return te.loada(self.build())

    @property
    def model_specific_parameter_list(self):
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

    def default_parameter_str(self):
        return """
        // Species initializations:
        
        TGFbR = 160.147975188548;
        TGFbR_a = 60.3222906543705;
        TGFbR_EE = 26.6769958669786;
        TGFbR_Cav = 14.5595977443064;
        Smad2 = 0.00104406983824404;
        pSmad2 = 601.154906864097;
        Mek = 64.1726900578347;
        pMek = 116.940981882533;
        Erk = 0.000999999845071731;
        pErk = 0.00295956954147894;
        PI3K = 18.8295970827627;
        pPI3K = 38.1999940817402;
        Akt = 25.5011960491432;
        pAkt = 6.11081905326124;
        mTORC1 = 131.732979590834;
        pmTORC1 = 74.4413884669228;
        S6K = 2.66365958732377;
        pS6K = 9.64125850629628;
        Raf = 0.85554386745205;
        pRaf = 27.2883957722554;
        ppMek = 0.00108663983164875;
        ppErk = 148.615976975181;
        
        // Compartment initializations:
        Cell = 1;
        
        // Variable initializations:
        TGFb = 0.005;
        GrowthFactors = 1;
        ExperimentIndicator = 0;
        AZD = 0;
        MK2206 = 0;
        Everolimus = 0;
        kTGFbOff = 1;
        kTGFbRRecyc_EE = 0.033;
        kTGFbRRecyc_Cav = 0.033;
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
        kErkPhos_km1 = 50;
        kErkPhos_kcat = 200;
        kErkDephos_km = 15;
        kErkDephos_Vmax = 1800;
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
        kSmad2PhosByAkt_km = 40;
        kSmad2DephosByErk_km = 30;
        
        kSmad2PhosByAkt_km = 0.1;
        kSmad2PhosByErk_km = 0.1;
        kSmad2DephosByErk_km = 0.1;
        kSmad2DehosByAkt_km = 0.1;
        kSmad2DephosByAkt_km = 0.1;
        
        _kSmad2PhosByAkt_kcat = 0.1;
        _kSmad2PhosByErk_kcat = 0.1;
        _kSmad2DephosByErk_kcat = 0.1;
        _kSmad2DephosByAkt_kcat = 0.1;
        _kSmad2DephosByAkt_kcat = 0.1;
        
        _kTGFbOn = 86.1703;
        _kTGFbRIntern_EE = 870;
        _kTGFbRIntern_Cav = 870;
        _kSmad2Phos_kcat = 100.643;
        _kRafPhos_ki = 362.567;
        _kMekPhos_ki = 1.01271;
        _kPI3KPhosByGF = 999.09;
        _kPI3KDephosByS6K = 19.351;
        _kAktPhos_ki = 0.311348;
        _kAktPhos_kcat = 3.84124;
        _kmTORC1Phos_ki = 0.001;
        _kmTORC1Phos_kcat = 0.00100034;
        _kmTORCPhosBasal_Vmax = 17.2123;
        _kS6KPhosBymTORC1_kcat = 21.666;
        _kRafPhosByTGFbR_kcat = 64.4923;
        _kRafPhosByPI3K_kcat = 1000;
        _kPI3KPhosByTGFbR_kcat = 3.66587;
        _kPI3KDephosByErk = 0.00100012;
        _kSmad2PhosByAkt_kcat = 140.907;
        _kSmad2DephosByErk_kcat = 587.363;
        
        ExperimentIndicator = 0

          """

    def functions(self):
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
        """

    def compartments(self):
        """

        :return:
        """
        return """
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
        const Everolimus       in Cell"""

    def reactions(self):
        return """
        //TGFb module
        TGF_R1 : TGFbR       => TGFbR_a    ; Cell * _kTGFbOn       *TGFbR      *TGFb      ;
        TGF_R2 : TGFbR_a     => TGFbR      ; Cell * kTGFbOff      *TGFbR_a               ;
        TGF_R3 : TGFbR_a     => TGFbR_EE   ; Cell * _kTGFbRIntern_EE  *TGFbR_a               ; 
        TGF_R4 : TGFbR_EE    => TGFbR_a    ; Cell * kTGFbRRecyc_EE   *TGFbR_EE              ;
        TGF_R5 : TGFbR_a     => TGFbR_Cav  ; Cell * _kTGFbRIntern_Cav  *TGFbR_a               ;
        TGF_R6 : TGFbR_Cav   => TGFbR_a    ; Cell * kTGFbRRecyc_Cav   *TGFbR_Cav             ;
        TGF_R8 : Smad2       => pSmad2     ; Cell * MMWithKcat(kSmad2Phos_km, _kSmad2Phos_kcat, Smad2, TGFbR_EE );
        TGF_R9 : pSmad2      => Smad2      ; Cell * MM(kSmad2Dephos_km, kSmad2Dephos_Vmax, pSmad2 )

        //MAPK module
        MAPK_R0  : Raf     => pRaf      ; Cell*GrowthFactors*NonCompetitiveInhibition(kRafPhos_km,  _kRafPhos_ki, kRafPhos_Vmax, kRafPhos_n, ppErk, Raf);
        MAPK_R1  : pRaf    => Raf       ; Cell*MM(            kRafDephos_km ,   kRafDephosVmax,      pRaf           );
        MAPK_R2  : Mek     => pMek      ; Cell*CompetitiveInhibitionWithKcat(    kMekPhos_km1 , _kMekPhos_ki, kMekPhos_kcat, pRaf, AZD, Mek       );
        MAPK_R3  : pMek    => ppMek     ; Cell*CompetitiveInhibitionWithKcat(    kMekPhos_km1 , _kMekPhos_ki, kMekPhos_kcat, pRaf, AZD, pMek     );
        MAPK_R4  : ppMek   => pMek      ; Cell*MM(            kMekDephos_km,   kMekDephos_Vmax,     ppMek         );
        MAPK_R5  : pMek    => Mek       ; Cell*MM(            kMekDephos_km,   kMekDephos_Vmax,     pMek          );
        MAPK_R6  : Erk     => pErk      ; Cell*MMWithKcat(    kErkPhos_km1,     kErkPhos_kcat, Erk,  ppMek         );
        MAPK_R7  : pErk    => ppErk     ; Cell*MMWithKcat(    kErkPhos_km1,     kErkPhos_kcat, pErk, ppMek         );
        MAPK_R8  : ppErk   => pErk      ; Cell*MM(            kErkDephos_km,   kErkDephos_Vmax,     ppErk         );
        MAPK_R9  : pErk    => Erk       ; Cell*MM(            kErkDephos_km,   kErkDephos_Vmax,     pErk          );


        //PI3K Module
        //n(km, ki, kcat, E, I, S)
        PI3K_R1 :   PI3K    => pPI3K    ;  Cell *  _kPI3KPhosByGF       *PI3K       *GrowthFactors ;
        PI3K_R2 :   pPI3K   => PI3K     ;   Cell *  _kPI3KDephosByS6K    *pPI3K      *pS6K        ;
        PI3K_R3 :   Akt    => pAkt      ;   Cell *  CompetitiveInhibitionWithKcat(kAktPhos_km, _kAktPhos_ki, _kAktPhos_kcat, pPI3K, MK2206, Akt)              ;
        PI3K_R4 :   pAkt    => Akt      ;   Cell *  MM(kAktDephos_km, kAktDephos_Vmax,pAkt)         ;
        PI3K_R5_1 :   mTORC1 => pmTORC1   ;   Cell *  CompetitiveInhibitionWithKcat(kmTORC1Phos_km, _kmTORC1Phos_ki, _kmTORC1Phos_kcat, pAkt, Everolimus, mTORC1)  ;
        PI3K_R5_2 :   mTORC1 => pmTORC1   ;   Cell *  CompetitiveInhibition(_kmTORCPhosBasal_Vmax, kmTORCPhosBasal_km, _kmTORC1Phos_ki, Everolimus, mTORC1);

        PI3K_R6 :   pmTORC1 => mTORC1   ;   Cell *  MM(kmTORC1Dephos_km, kmTORC1Dephos_Vmax, pmTORC1);
        PI3K_R7 :   S6K     => pS6K     ;   Cell *  MMWithKcat(kS6KPhosBymTORC1_km, _kS6KPhosBymTORC1_kcat, S6K, pmTORC1) ;
        PI3K_R8 :   pS6K    => S6K      ;   Cell *  MM(kS6KDephos_km,kS6KDephos_Vmax, pS6K)                    ;

        // Cross talk reactions
        CrossTalkR1  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByTGFbR_km, _kRafPhosByTGFbR_kcat, Raf, TGFbR_Cav)    ;
        CrossTalkR2  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByPI3K_km,_kRafPhosByPI3K_kcat, Raf, pPI3K)           ;
        CrossTalkR3  :    PI3K      => pPI3K     ;   Cell *  MMWithKcat(kPI3KPhosByTGFbR_km, _kPI3KPhosByTGFbR_kcat, PI3K, TGFbR_Cav) ;
        CrossTalkR4  :    pPI3K     => PI3K      ;   Cell *  _kPI3KDephosByErk    *pPI3K      *ppErk        ;
        
        // model specific reactions
        {}
    """.format(self.variant)

    def events(self):
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


        """

    def units(self):
        return """
        unit volume = 1 litre;
        unit time_unit = 3600 second;
        unit substance = 1e-9 mole;
        """

    @staticmethod
    def null():
        return ""

    @staticmethod
    def akt_activate_smad2():
        """

        :return:
        """
        return """
        
        CrossTalk5  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByAkt_km, _kSmad2PhosByAkt_kcat, Smad2, pAkt)       ;
        """

    @staticmethod
    def erk_activates_smad2():
        return """
        CrossTalkR6  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByErk_km, _kSmad2PhosByErk_kcat, Smad2, ppErk)       ;
        """

    @staticmethod
    def both_akt_and_erk_activate_smad2():
        return """
        {}
        {}
        """.format(CrossTalkModel.akt_activate_smad2(),
                   CrossTalkModel.erk_activates_smad2())

    @staticmethod
    def akt_activates_and_erk_inhibits_smad2():
        return """
        {}
        CrossTalkR7  :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DephosByErk_km, _kSmad2DephosByErk_kcat, pSmad2, ppErk)       ;
        """.format(CrossTalkModel.akt_activate_smad2())

    @staticmethod
    def akt_inhibits_and_erk_activates_smad2():
        return """
        CrossTalkR8  :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DehosByAkt_km, _kSmad2DephosByAkt_kcat, pSmad2, pAkt)       ;
        CrossTalkR9  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByErk_km, _kSmad2PhosByErk_kcat, Smad2, ppErk)       ;
        
        """

    @staticmethod
    def akt_activates_and_inhibits_smad2():
        return """
        {}
        CrossTalkR10 :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DephosByAkt_km, _kSmad2DephosByAkt_kcat, pSmad2, pAkt)       ;
        
        """.format(CrossTalkModel.akt_activate_smad2())

    @staticmethod
    def erk_activates_and_inhibits_smad2():
        return """
        {}
        CrossTalkR11 :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DephosByErk_km, _kSmad2DephosByErk_kcat, pSmad2, ppErk)       ;

        """.format(CrossTalkModel.erk_activates_smad2())

    @staticmethod
    def akt_and_erk_activate_smad2_and_erk_inhibits_smad2():
        return """
        {}
        {}
        """.format(CrossTalkModel.akt_activate_smad2(),
                   CrossTalkModel.erk_activates_and_inhibits_smad2(),
                   )


parameters = """

  // Species initializations:

  TGFbR = 160.147975188548;
  TGFbR_a = 60.3222906543705;
  TGFbR_EE = 26.6769958669786;
  TGFbR_Cav = 14.5595977443064;
  Smad2 = 0.00104406983824404;
  pSmad2 = 601.154906864097;
  Mek = 64.1726900578347;
  pMek = 116.940981882533;
  Erk = 0.000999999845071731;
  pErk = 0.00295956954147894;
  PI3K = 18.8295970827627;
  pPI3K = 38.1999940817402;
  Akt = 25.5011960491432;
  pAkt = 6.11081905326124;
  mTORC1 = 131.732979590834;
  pmTORC1 = 74.4413884669228;
  S6K = 2.66365958732377;
  pS6K = 9.64125850629628;
  Raf = 0.85554386745205;
  pRaf = 27.2883957722554;
  ppMek = 0.00108663983164875;
  ppErk = 148.615976975181;

  // Compartment initializations:
  Cell = 1;

  // Variable initializations:
  TGFb = 0.005;
  GrowthFactors = 1;
  ExperimentIndicator = 0;
  AZD = 0;
  MK2206 = 0;
  Everolimus = 0;
  kTGFbOff = 1;
  kTGFbRRecyc_EE = 0.033;
  kTGFbRRecyc_Cav = 0.033;
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
  kErkPhos_km1 = 50;
  kErkPhos_kcat = 200;
  kErkDephos_km = 15;
  kErkDephos_Vmax = 1800;
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
  kSmad2PhosByAkt_km = 40;
  kSmad2DephosByErk_km = 30;
  kSmad2PhosByAkt_km = 0.1;
  kSmad2PhosByErk_km = 0.1;
  kSmad2DephosByErk_km = 0.1;
  kSmad2DehosByAkt_km = 0.1;
  kSmad2DephosByAkt_km = 0.1;
  
  _kSmad2PhosByAkt_kcat = 0.1;
  _kSmad2PhosByErk_kcat = 0.1;
  _kSmad2DephosByErk_kcat = 0.1;
  _kSmad2DephosByAkt_kcat = 0.1;
  _kSmad2DephosByAkt_kcat = 0.1;
  
  _kTGFbOn = 86.1703;

  _kSmad2Phos_kcat = 100.643;
  _kRafPhos_ki = 362.567;
  _kMekPhos_ki = 1.01271;
  _kPI3KPhosByGF = 999.09;
  _kPI3KDephosByS6K = 19.351;
  _kAktPhos_ki = 0.311348;
  _kAktPhos_kcat = 3.84124;
  _kmTORC1Phos_ki = 0.001;
  _kmTORC1Phos_kcat = 0.00100034;
  _kmTORCPhosBasal_Vmax = 17.2123;
  _kS6KPhosBymTORC1_kcat = 21.666;
  _kRafPhosByTGFbR_kcat = 64.4923;
  _kRafPhosByPI3K_kcat = 1000;
  _kPI3KPhosByTGFbR_kcat = 3.66587;
  _kPI3KDephosByErk = 0.00100012;
  _kSmad2PhosByAkt_kcat = 140.907;
  _kSmad2DephosByErk_kcat = 587.363;

  """


def create_fit_dir(FIT):
    FIT_DIR = os.path.join(COPASI_MODELS_DIR, 'Fit{}'.format(FIT))

    os.makedirs(FIT_DIR) if not os.path.isdir(FIT_DIR) else None

    cps = os.path.join(FIT_DIR, 'CrossTalkModel.cps')

    with model.BuildAntimony(cps) as loader:
        copasi_mod = loader.load(CROSS_TALK_MODEL)

    return FIT_DIR, copasi_mod


def insert_best_parameters(PE, open=True):
    data = viz.Parse(PE).data
    params = data.iloc[0]
    print(params)

    PE.model.insert_parameters(df=data,
                               index=0,
                               inplace=True)
    #

    print(PE.model.to_antimony())

    if open:
        PE.model.open()

    return PE.model


def get_rank_of_fim(fim_file, param_file):
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


def analyse_fim(fim_file, param_file):
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


def analyse_correlations(corr_file, param_file, gl=0.7):
    """

    :param corr_file: Correlation matrix. Output from copasi parameter estimation talk
    :param param_file: Parameter file. Output from copasi parameter estimation task. Used for labelling matrix
    :param gl: greater than. The cut off.
    :return:
    """
    if gl > 1 or gl < 0:
        raise ValueError

    df = pandas.read_csv(corr_file, header=None)
    params = pandas.read_csv(param_file, index_col=0)
    df.columns = params.index
    df.index = params.index
    import itertools
    comb = itertools.combinations(list(df.columns), 2)
    print(comb)
    # print(len(comb))
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
    fname = os.path.join(os.path.dirname(corr_file), 'correlations_gl_70')
    df.to_csv(fname)
    print('filtered correlations now in "{}"'.format(fname))


if __name__ == '__main__':

    FIT = '3_2_all_parameters'

    CLUSTER = False

    if CLUSTER:
        WORKING_DIRECTORY = r'/mnt/nfs/home/b3053674/WorkingDirectory/CrossTalkModel'
    else:
        WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'

    ## on windows
    # WORKING_DIRECTORY = r'D:\MesiSTRAT\CrossTalkModel'

    DATA_DIR = os.path.join(WORKING_DIRECTORY, 'data')

    COPASI_MODELS_DIR = os.path.join(WORKING_DIRECTORY, 'CopasiModelFiles')

    COPASI_DATA_DIR = os.path.join(DATA_DIR, 'CopasiDataFiles')

    DATA_FILES = sorted(glob.glob(os.path.join(COPASI_DATA_DIR, '*.csv')))

    for i in DATA_FILES:
        assert os.path.isfile(i)

    FIT_DIR, copasi_mod = create_fit_dir(FIT)

    global_params = copasi_mod.global_quantities

    tasks.TimeCourse(copasi_mod, start=0, end=72, step_size=0.1, intervals=720, run=False)

    run_mode = 'slurm'
    # run_mode = True
    copy_number = 1
    randomize_start_values = False
    overwrite_config_file = True
    method = 'particle_swarm'
    population_size = 75
    swarm_size = 75
    iteration_limit = 500
    number_of_generations = 500
    lower_bound = 0.001
    upper_bound = 1000

    # analyse_correlations(CORR_FILE, PARAM_FILE)

    #
    # exclude = ['TGFb', 'AZD', 'MK2206', 'GrowthFactors', 'Everolimus', 'ExperimentIndicator']
    # PE = tasks.MultiParameterEstimation(copasi_mod,
    #                                     DATA_FILES,
    #                                     separator=[',']*len(DATA_FILES),
    #                                     copy_number=copy_number,
    #                                     pe_number=1,
    #                                     global_quantities=[i.name for i in global_params if i not in exclude],
    #                                     run_mode=run_mode,
    #                                     randomize_start_values=randomize_start_values,
    #                                     method=method,
    #                                     number_of_generations=number_of_generations,
    #                                     population_size=population_size,
    #                                     iteration_limit=iteration_limit,
    #                                     swarm_size=swarm_size,
    #                                     overwrite_config_file=overwrite_config_file,
    #                                     lower_bound=lower_bound,
    #                                     upper_bound=upper_bound
    #                                     )
    # PE.write_config_file()
    # PE.setup()
    # # PE.run()
    #
    # # viz.Scatters(PE, x='all', y='all', dpi=50, savefig=True, log10=True)
    # viz.LikelihoodRanks(PE, savefig=True)
    # #
    # insert_best_parameters(PE)

    FIT = '3_2_some_fixed'
    FIT_DIR, copasi_mod = create_fit_dir(FIT)
    # CORR_FILE = os.path.join(FIT_DIR, 'Correlations.csv')
    # PARAM_FILE = os.path.join(FIT_DIR, 'parameters_rss_112.csv')
    # FIM_unscaled_FILE = os.path.join(FIT_DIR, 'FIMUnscaled.csv')
    # FIM_scaled_FILE = os.path.join(FIT_DIR, 'FIMScaled.csv')
    # rank = get_rank_of_fim(FIM_unscaled_FILE, PARAM_FILE)
    # print(rank)

    # analyse_fim(FIM_unscaled_FILE, PARAM_FILE)
    # analyse_correlations(CORR_FILE, PARAM_FILE)

    #
    free_params = [i.name for i in global_params if i.name[0] == '_']
    PE = tasks.MultiParameterEstimation(copasi_mod,
                                        DATA_FILES,
                                        separator=[','] * len(DATA_FILES),
                                        copy_number=copy_number,
                                        pe_number=1,
                                        global_quantities=free_params,
                                        run_mode=run_mode,
                                        randomize_start_values=randomize_start_values,
                                        method=method,
                                        number_of_generations=number_of_generations,
                                        population_size=population_size,
                                        iteration_limit=iteration_limit,
                                        swarm_size=swarm_size,
                                        overwrite_config_file=overwrite_config_file,
                                        lower_bound=lower_bound,
                                        upper_bound=upper_bound
                                        )

    PE.write_config_file()
    PE.setup()
    # PE.run()
    viz.LikelihoodRanks(PE, savefig=True)
    # viz.Scatters(PE, x=['pPI3K'], y=['_kAktPhos_kcat'], dpi=50, savefig=True, log10=True,
    #              show=True, truncate_mode='ranks', theta=range(150))

    insert_best_parameters(PE)

    # PE.model.open()
    #
    # viz.LikelihoodRanks(PE, savefig=True)

    # FIM_FILE = os.path.join(FIT_DIR, 'FIM.txt')
    # FIM = pandas.read_csv(FIM_FILE, header=None, sep='\t')
    # FIM = FIM.iloc[:, 1:]
    # FIM.columns = list(params.index)[:-1]
    # FIM.index = FIM.columns

    # l = []
    # for i in FIM.columns:
    #     c_ii = FIM.loc[i, i]
    #     chi2 = 15.815
    #     confidence = numpy.sqrt(chi2 * c_ii)
    #     l.append([i, params.loc[i], confidence])
    #
    #     # print('Parameter "{}" \t\t = {} +/- {}'.format(i, params.loc[i], ))
    # conf = pandas.DataFrame(l)
    # conf.columns = ['Parameter', 'Estimated Value', '+/- (at chi2 alpha=0.995 and 33 df)']
    # print(conf)
    # conf.to_csv(os.path.join(FIT_DIR, 'confidence_intervals.csv'))

    # print(FIM)
    # print(data.iloc[0], )
