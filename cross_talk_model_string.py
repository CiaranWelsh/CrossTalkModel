from constants import *
import site, os, glob
import pandas, numpy

site.addsitedir(r'/home/ncw135/Documents/pycotools3')
site.addsitedir(r'D:\pycotools3')
from pycotools3 import model, tasks, viz

manual_parameter_set = """
//// Species initializations:
TGFbR       = 76.8396790634687;
TGFbR_a     = 0.966718661034664;
TGFbR_EE    = 12.55032566215;
TGFbR_Cav   = 9.66718661034664;
Smad2       = 49.6779
pSmad2      = 0.500563;
Smad2Tot    := pSmad2 + Smad2 
Mek         = 252.876273823102;
pMek        = 56.0642557607438;
Erk         = 183.331905604514;
pErk        = 117.882228538386;
PI3K        = 99.9603027531632;
pPI3K       = 0.039697246836694;
Akt         = 99.413240815732;
pAkt        = 0.586759181268058;
mTORC1      = 90.2724562462086;
pmTORC1     = 9.72754375379144;
S6K         = 90.5069860202662;
pS6K        = 9.49301398073377;
Raf         = 87.932595095561;
pRaf        = 12.0674049063339;
ppMek       = 29.0295122061532;
ppErk       = 43.0862638108839;

// Variable initializations:                    
TGFb                    = 0.005;                    
GrowthFactors           = 1;                    
kTGFbOff                = 1;                 
_kTGFbRIntern_EE            = 0.33;
kTGFbRRecyc_EE            = 0.033;
kSmad2Phos_km           = 50;                  
kSmad2PhosByAkt_km      = 40;                  
_kSmad2PhosByAkt_kcat    = 10;                   
kSmad2Dephos_km         = 30;                 
kSmad2Dephos_Vmax       = 1.5;
kSmad2DephosByErk_km    = 30;                   
_kSmad2DephosByErk_kcat  = 1.5;   
kRafPhos_km             = 10;                   
_kRafPhos_ki             = 3.5;                  
kRafPhos_Vmax           = 9000;                 
kRafPhos_n              = 1;                    
kRafDephos_km           = 8;                    
kRafDephosVmax          = 3602.5;                   
kMekPhos_km1            = 15;                   
kMekPhos_kcat          = 90;                  
AZD                     = 0;                    
kMekDephos_km          = 15;                   
kMekDephos_Vmax        = 2700;                 
kErkPhos_km1            = 50;                  
kErkPhos_kcat          = 200;                 
kErkDephos_km          = 15;                   
kErkDephos_Vmax        = 1800;                 
kAktPhos_km             = 12.5;                 
MK2206                  = 0;                    
kAktDephos_km           = 15;                   
kAktDephos_Vmax         = 30;                   
kmTORC1Phos_km          = 50;                    
Everolimus              = 0;                    
kmTORC1Dephos_km        = 100;                  
kS6KPhosBymTORC1_km     = 100;                  
kS6KDephos_km           = 10;                   
kS6KDephos_Vmax         = 50;                   
kRafPhosByTGFbR_km      = 25;                   
kRafPhosByPI3K_km       = 50;                   
kPI3KPhosByTGFbR_km     = 10;                   
kmTORC1Dephos_Vmax      = 4;                    
kmTORCPhosBasal_km      = 25;    
_kTGFbOn                 = 0.1;                  
_kSmad2Phos_kcat         = 20;                    
_kMekPhos_ki            = 0.02;  //original 0.25                 
_kPI3KPhosByGF           = 0.239474698704283;                    
_kPI3KDephosByS6K        = 25;                   
_kAktPhos_ki             = 0.01;                 
_kAktPhos_kcat           = 1.5; // original: 2.9215;                 
_kmTORC1Phos_ki          = 0.005;                    
_kmTORC1Phos_kcat        = 100;   
_kmTORCPhosBasal_Vmax    = 10; 
_kS6KPhosBymTORC1_kcat   = 0.5;                  
_kRafPhosByTGFbR_kcat    = 265;                  
_kRafPhosByPI3K_kcat     = 5;                    
_kPI3KPhosByTGFbR_kcat   = 50;                   
_kPI3KDephosByErk        = 0.5; 
"""

## RSS 118.877. All parameters were estimated
parameter_set_RSS_is_118 = """
  // Species initializations:
  TGFbR = 160.723975099309;
  TGFbR_a = 60.0745906927462;
  TGFbR_EE = 25.2677960853035;
  TGFbR_Cav = 13.3451979324513;
  Smad2 = 0.00279424956709169;
  pSmad2 = 111.129982782822;
  Mek = 144.98797753726;
  pMek = 219.905965930344;
  Erk = 0.00136994978775602;
  pErk = 0.408456936718464;
  PI3K = 52.1748919166331;
  pPI3K = 36.8487942910792;
  Akt = 24.9588961331608;
  pAkt = 6.16998904409413;
  mTORC1 = 131.815979577975;
  pmTORC1 = 74.8940883967868;
  S6K = 2.76684957133672;
  pS6K = 9.54156852174108;
  Raf = 0.722875888006073;
  pRaf = 27.086795803489;
  ppMek = 0.00100025984503145;
  ppErk = 169.352973762433;

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
  _kTGFbOn = 12.1993;
  _kTGFbRIntern_EE = 292.979;
  _kSmad2Phos_kcat = 123.087;
  _kRafPhos_ki = 65.5292;
  _kMekPhos_ki = 0.883282;
  _kPI3KPhosByGF = 998.691;
  _kPI3KDephosByS6K = 68.9254;
  _kAktPhos_ki = 0.25287;
  _kAktPhos_kcat = 4.92652;
  _kmTORC1Phos_ki = 0.001;
  _kmTORC1Phos_kcat = 0.00616213;
  _kmTORCPhosBasal_Vmax = 16.227;
  _kS6KPhosBymTORC1_kcat = 21.8415;
  _kRafPhosByTGFbR_kcat = 64.0384;
  _kRafPhosByPI3K_kcat = 999.995;
  _kPI3KPhosByTGFbR_kcat = 10.4489;
  _kPI3KDephosByErk = 0.0039678;
  _kSmad2PhosByAkt_kcat = 118.428;
  _kSmad2DephosByErk_kcat = 431.472;
"""

## RSS 113.161. 41 of 80 parameters estimated
parameter_set_RSS_is_113 = """
  // Species initializations:
  TGFbR = 160.723975099309;
  TGFbR_a = 60.0745906927462;
  TGFbR_EE = 25.2677960853035;
  TGFbR_Cav = 13.3451979324513;
  Smad2 = 0.00279424956709169;
  pSmad2 = 111.129982782822;
  Mek = 144.98797753726;
  pMek = 219.905965930344;
  Erk = 0.00136994978775602;
  pErk = 0.408456936718464;
  PI3K = 52.1748919166331;
  pPI3K = 36.8487942910792;
  Akt = 24.9588961331608;
  pAkt = 6.16998904409413;
  mTORC1 = 131.815979577975;
  pmTORC1 = 74.8940883967868;
  S6K = 2.76684957133672;
  pS6K = 9.54156852174108;
  Raf = 0.722875888006073;
  pRaf = 27.086795803489;
  ppMek = 0.00100025984503145;
  ppErk = 169.352973762433;

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
  _kTGFbOn = 12.1993;
  _kTGFbRIntern_EE = 292.979;
  _kSmad2Phos_kcat = 123.087;
  _kRafPhos_ki = 65.5292;
  _kMekPhos_ki = 0.883282;
  _kPI3KPhosByGF = 998.691;
  _kPI3KDephosByS6K = 68.9254;
  _kAktPhos_ki = 0.25287;
  _kAktPhos_kcat = 4.92652;
  _kmTORC1Phos_ki = 0.001;
  _kmTORC1Phos_kcat = 0.00616213;
  _kmTORCPhosBasal_Vmax = 16.227;
  _kS6KPhosBymTORC1_kcat = 21.8415;
  _kRafPhosByTGFbR_kcat = 64.0384;
  _kRafPhosByPI3K_kcat = 999.995;
  _kPI3KPhosByTGFbR_kcat = 10.4489;
  _kPI3KDephosByErk = 0.0039678;
  _kSmad2PhosByAkt_kcat = 118.428;
  _kSmad2DephosByErk_kcat = 431.472;
"""

parameter_set_RSS_is_112 = """
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

CROSS_TALK_MODEL = """
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

    model CrossTalkModel()
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
        TGF_R1 : TGFbR       => TGFbR_a    ; Cell * _kTGFbOn       *TGFbR      *TGFb      ;
        TGF_R2 : TGFbR_a     => TGFbR      ; Cell * kTGFbOff      *TGFbR_a               ;
<<<<<<< HEAD
        TGF_R3 : TGFbR_a     => TGFbR_EE   ; Cell * kTGFbRIntern  *TGFbR_a               ; 
        TGF_R4 : TGFbR_EE    => TGFbR_a    ; Cell * kTGFbRRecyc   *TGFbR_EE              ;
        TGF_R5 : TGFbR_a     => TGFbR_Cav  ; Cell * kTGFbRIntern  *TGFbR_a               ;
        TGF_R6 : TGFbR_Cav   => TGFbR_a    ; Cell * kTGFbRRecyc   *TGFbR_Cav             ;
        
        // TGF_R7 : Smad2       => pSmad2     ; Cell * MMWithKcat(kSmad2Phos_km, kSmad2Phos_kcat, Smad2, TGFbR_EE );
        // TGF_R10: pSmad2      => pSmad2n    ; Cell  * MM(kpSmad2Imp_km, kpSmad2Imp_Vmax, pSmad2                  );
        // TGF_R11: pSmad2n     => pSmad2     ; Cell * MM(kSmad2Exp_km, kSmad2Exp_Vmax, pSmad2n                 );
        // TGF_R12: Smad2       => Smad2n     ; Cell  * MM(kSmad2Imp_km, kSmad2Imp_Vmax, Smad2                     );
        // TGF_R13: Smad2n      => Smad2      ; Cell * MM(kSmad2Exp_km, kSmad2Exp_Vmax, Smad2n                    );
        // TGF_R14: pSmad2n     => Smad2n     ; Cell  * MM(kpSmad2Dephos_km, kpSmad2Dephos_Vmax, pSmad2n);

=======
        TGF_R3 : TGFbR_a     => TGFbR_EE   ; Cell * _kTGFbRIntern_EE  *TGFbR_a               ; 
        TGF_R4 : TGFbR_EE    => TGFbR_a    ; Cell * kTGFbRRecyc_EE   *TGFbR_EE              ;
        TGF_R5 : TGFbR_a     => TGFbR_Cav  ; Cell * _kTGFbRIntern_Cav  *TGFbR_a               ;
        TGF_R6 : TGFbR_Cav   => TGFbR_a    ; Cell * kTGFbRRecyc_Cav   *TGFbR_Cav             ;
        TGF_R8 : Smad2       => pSmad2     ; Cell * MMWithKcat(kSmad2Phos_km, _kSmad2Phos_kcat, Smad2, TGFbR_EE );
        TGF_R9 : pSmad2      => Smad2      ; Cell * MM(kSmad2Dephos_km, kSmad2Dephos_Vmax, pSmad2 )
        
>>>>>>> AktActivateErkInhibitTopology2
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
<<<<<<< HEAD
        CrossTalkR1  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByTGFbR_km, kRafPhosByTGFbR_kcat, Raf, TGFbR_Cav)    ;
        CrossTalkR2  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByPI3K_km,kRafPhosByPI3K_kcat, Raf, pPI3K)           ;
        CrossTalkR3  :    PI3K      => pPI3K     ;   Cell *  MMWithKcat(kPI3KPhosByTGFbR_km, kPI3KPhosByTGFbR_kcat, PI3K, TGFbR_Cav) ;
        CrossTalkR4  :    pPI3K     => PI3K      ;   Cell *  kPI3KDephosByErk    *pPI3K      *ppErk        ;
        CrossTalkR5  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByAkt_km, kSmad2PhosByAkt_kcat, Smad2, pAkt)       ;
        CrossTalkR6  :    pSmad2n   =>  Smad2n   ;   Cell *  MMWithKcat(kSmad2DephosByErk_km, kSmad2DephosByErk_kcat, pSmad2n, ppErk)       ;

        // Species initializations:
        TGFbR       = 76.8396790634687;
        TGFbR_a     = 0.966718661034664;
        TGFbR_EE    = 12.55032566215;
        TGFbR_Cav   = 9.66718661034664;
        Smad2       = 49.6779
        pSmad2      = 0.500563;
        pSmad2n     = 0.0447836;
        Smad2n      = 49.7768;
        Smad2Tot    := pSmad2 + Smad2 + pSmad2n + Smad2n
        pSmad2Tot   := pSmad2 + pSmad2n;
        Mek         = 252.876273823102;
        pMek        = 56.0642557607438;
        Erk         = 183.331905604514;
        pErk        = 117.882228538386;
        PI3K        = 99.9603027531632;
        pPI3K       = 0.039697246836694;
        Akt         = 99.413240815732;
        pAkt        = 0.586759181268058;
        mTORC1      = 90.2724562462086;
        pmTORC1     = 9.72754375379144;
        S6K         = 90.5069860202662;
        pS6K        = 9.49301398073377;
        Raf         = 87.932595095561;
        pRaf        = 12.0674049063339;
        ppMek       = 29.0295122061532;
        ppErk       = 43.0862638108839;

        // Variable initializations:                    
        TGFb                    = 0.005;                    
        GrowthFactors           = 1;                    
        kTGFbOn                 = 0.1;                  
        kTGFbOff                = 0.04;                 
        kTGFbRIntern            = 0.3333333333;                 
        kTGFbRRecyc             = 0.03333333333;                    

        // kSmad2Phos_km           = 50;                  
        // kSmad2Phos_kcat         = 0.1;                    
        // kSmad2PhosByAkt_km      = 40;                  
        // kSmad2PhosByAkt_kcat    = 0.1;                   
        // kpSmad2Dephos_km         = 60;                 
        // kpSmad2Dephos_Vmax       = 65;
        // kSmad2DephosByErk_km    = 30;                   
        // kSmad2DephosByErk_kcat  = 7.5;   

        // mul = 3
        // kSmad2Imp_km           = 90;
        // kpSmad2Imp_km         := kSmad2Imp_km 
        // kpSmad2Imp_Vmax       := kSmad2Imp_Vmax * mul
        // kSmad2Imp_Vmax         = 38.466;
        // kSmad2Exp_km           = 20;
        // kSmad2Exp_Vmax         = 20;

        kRafPhos_km             = 10;                   
        kRafPhos_ki             = 3.5;                  
        kRafPhos_Vmax           = 9000;                 
        kRafPhos_n              = 1;                    
        kRafDephos_km           = 8;                    
        kRafDephosVmax          = 3602.5;                   
        kMekPhos_km1            = 15;                   
        kMekPhos_ki1            = 0.25;  //original 0.25                 
        kMekPhos_kcat1          = 90;                  
        AZD                     = 0;                    
        kMekDephos_km1          = 15;                   
        kMekDephos_Vmax1        = 2700;                 
        kErkPhos_km1            = 50;                  
        kErkPhos_kcat1          = 200;                 
        kErkDephos_km1          = 15;                   
        kErkDephos_Vmax1        = 1800;                 
        kPI3KPhosByGF           = 0.239474698704283;                    
        kPI3KDephosByS6K        = 25;                   
        kAktPhos_km             = 12.5;                 
        kAktPhos_ki             = 0.01;                 
        kAktPhos_kcat           = 1.5; // original: 2.9215;                 
        MK2206                  = 0;                    
        kAktDephos_km           = 15;                   
        kAktDephos_Vmax         = 30;                   
        kmTORC1Phos_km          = 3;                    
        kmTORC1Phos_ki          = 0.001;                    
        kmTORC1Phos_kcat        = 0.35;        
        Everolimus              = 0;                    
        kmTORC1Dephos_km        = 100;                  
        kmTORC1Dephos_Vmax      = 1;                    
        kS6KPhosBymTORC1_km     = 100;                  
        kS6KPhosBymTORC1_kcat   = 0.5;                  
        kS6KDephos_km           = 10;                   
        kS6KDephos_Vmax         = 50;                   
        kRafPhosByTGFbR_km      = 25;                   
        kRafPhosByTGFbR_kcat    = 265;                  
        kRafPhosByPI3K_km       = 50;                   
        kRafPhosByPI3K_kcat     = 5;                    
        kPI3KPhosByTGFbR_km     = 10;                   
        kPI3KPhosByTGFbR_kcat   = 50;                   
        kPI3KDephosByErk        = 0.5;                  
        //kTGFbRInternByAkt     = 0.01;           
=======
        CrossTalkR1  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByTGFbR_km, _kRafPhosByTGFbR_kcat, Raf, TGFbR_Cav)    ;
        CrossTalkR2  :    Raf       => pRaf      ;   Cell *  MMWithKcat(kRafPhosByPI3K_km,_kRafPhosByPI3K_kcat, Raf, pPI3K)           ;
        CrossTalkR3  :    PI3K      => pPI3K     ;   Cell *  MMWithKcat(kPI3KPhosByTGFbR_km, _kPI3KPhosByTGFbR_kcat, PI3K, TGFbR_Cav) ;
        CrossTalkR4  :    pPI3K     => PI3K      ;   Cell *  _kPI3KDephosByErk    *pPI3K      *ppErk        ;
        CrossTalkR5  :    Smad2     => pSmad2    ;   Cell *  MMWithKcat(kSmad2PhosByAkt_km, _kSmad2PhosByAkt_kcat, Smad2, pAkt)       ;
        CrossTalkR6  :    pSmad2     => Smad2    ;   Cell *  MMWithKcat(kSmad2DephosByErk_km, _kSmad2DephosByErk_kcat, pSmad2, Erk)       ;
>>>>>>> AktActivateErkInhibitTopology2

        
        {}
        
        ExperimentIndicator = 0; 
        
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
        
        //// ExperimentIndicator Codes
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
        
        
        
        unit volume = 1 litre;
        unit time_unit = 3600 second;
        unit substance = 1e-9 mole;

end
""".format(parameter_set_RSS_is_112)


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
                                        separator=[',']*len(DATA_FILES),
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
