


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
        var pSmad2n         in Cell
        var Smad2n          in Cell 
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
        TGF_R1 : TGFbR       => TGFbR_a    ; Cell * kTGFbOn       *TGFbR      *TGFb      ;
        TGF_R2 : TGFbR_a     => TGFbR      ; Cell * kTGFbOff      *TGFbR_a               ;
        TGF_R3 : TGFbR_a     => TGFbR_EE   ; Cell * kTGFbRIntern  *TGFbR_a               ; 
        TGF_R4 : TGFbR_EE    => TGFbR_a    ; Cell * kTGFbRRecyc   *TGFbR_EE              ;
        TGF_R5 : TGFbR_a     => TGFbR_Cav  ; Cell * kTGFbRIntern  *TGFbR_a               ;
        TGF_R6 : TGFbR_Cav   => TGFbR_a    ; Cell * kTGFbRRecyc   *TGFbR_Cav             ;
        TGF_R8 : Smad2       => pSmad2     ; Cell * MMWithKcat(kSmad2Phos_km, kSmad2Phos_kcat, Smad2, TGFbR_EE );
        TGF_R9 : pSmad2      => Smad2      ; Cell * MM(kSmad2Dephos_km, kSmad2Dephos_Vmax, pSmad2 )
        
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
        PI3K_R5_1 :   mTORC1 => pmTORC1   ;   Cell *  CompetitiveInhibition(kmTORC1Phos_km, kmTORC1Phos_ki, kmTORC1Phos_kcat, pAkt, Everolimus, mTORC1)  ;
        //PI3K_R5_2 :   mTORC1 => pmTORC1   ;   Cell *  kmTORC1PhosByTSCs * mTORC1  ;
        PI3K_R6 :   pmTORC1 => mTORC1   ;   Cell *  MM(kmTORC1Dephos_km, kmTORC1Dephos_Vmax, pmTORC1);
        PI3K_R7 :   S6K     => pS6K     ;   Cell *  MMWithKcat(kS6KPhosBymTORC1_km, kS6KPhosBymTORC1_kcat, S6K, pmTORC1) ;
        PI3K_R8 :   pS6K    => S6K      ;   Cell *  MM(kS6KDephos_km,kS6KDephos_Vmax, pS6K)                    ;

        // Cross talk reactions
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
        // TGFb                    = 0.005;                    
        // GrowthFactors           = 1;                    
        // kTGFbOn                 = 0.1;                  
        // kTGFbOff                = 0.04;                 
        // kSmad2Phos_km           = 50;                  
        // kSmad2Phos_kcat         = 0.1;                    
        // kSmad2PhosByAkt_km      = 40;                  
        // kSmad2PhosByAkt_kcat    = 0.1;                   
        // kSmad2Dephos_km         = 60;                 
        // kSmad2Dephos_Vmax       = 65;
        // kSmad2DephosByErk_km    = 30;                   
        // kSmad2DephosByErk_kcat  = 7.5;   
        // kRafPhos_km             = 10;                   
        // kRafPhos_ki             = 3.5;                  
        // kRafPhos_Vmax           = 9000;                 
        // kRafPhos_n              = 1;                    
        // kRafDephos_km           = 8;                    
        // kRafDephosVmax          = 3602.5;                   
        // kMekPhos_km1            = 15;                   
        // kMekPhos_ki1            = 0.25;  //original 0.25                 
        // kMekPhos_kcat1          = 90;                  
        // AZD                     = 0;                    
        // kMekDephos_km1          = 15;                   
        // kMekDephos_Vmax1        = 2700;                 
        // kErkPhos_km1            = 50;                  
        // kErkPhos_kcat1          = 200;                 
        // kErkDephos_km1          = 15;                   
        // kErkDephos_Vmax1        = 1800;                 
        // kPI3KPhosByGF           = 0.239474698704283;                    
        // kPI3KDephosByS6K        = 25;                   
        // kAktPhos_km             = 12.5;                 
        // kAktPhos_ki             = 0.01;                 
        // kAktPhos_kcat           = 1.5; // original: 2.9215;                 
        // MK2206                  = 0;                    
        // kAktDephos_km           = 15;                   
        // kAktDephos_Vmax         = 30;                   
        // kmTORC1Phos_km          = 3;                    
        // kmTORC1Phos_ki          = 0.001;                    
        // kmTORC1Phos_kcat        = 0.35;        
        // Everolimus              = 0;                    
        // kmTORC1Dephos_km        = 100;                  
        // kmTORC1Dephos_Vmax      = 1;                    
        // kS6KPhosBymTORC1_km     = 100;                  
        // kS6KPhosBymTORC1_kcat   = 0.5;                  
        // kS6KDephos_km           = 10;                   
        // kS6KDephos_Vmax         = 50;                   
        // kRafPhosByTGFbR_km      = 25;                   
        // kRafPhosByTGFbR_kcat    = 265;                  
        // kRafPhosByPI3K_km       = 50;                   
        // kRafPhosByPI3K_kcat     = 5;                    
        // kPI3KPhosByTGFbR_km     = 10;                   
        // kPI3KPhosByTGFbR_kcat   = 50;                   
        // kPI3KDephosByErk        = 0.5;                  
        // //kTGFbRInternByAkt     = 0.01;   
        
        
        // Variable initializations:
        TGFb = 0.005;
        GrowthFactors = 1;
        AZD = 0;
        kTGFbOn = 0.1;
        kTGFbOff = 0.04;
        kTGFbRIntern = 0.3333333333;
        kTGFbRRecyc = 0.03333333333;
        kSmad2Phos_km = 50;
        kSmad2Phos_kcat = 0.00183203009996919;
        kSmad2Dephos_km = 60;
        kSmad2Dephos_Vmax = 0.00987092971652532;
        kRafPhos_km = 10;
        kRafPhos_ki = 3.5;
        kRafPhos_Vmax = 9000;
        kRafPhos_n = 1;
        kRafDephos_km = 8;
        kRafDephosVmax = 3602.5;
        kMekPhos_km1 = 15;
        kMekPhos_ki1 = 0.25;
        kMekPhos_kcat1 = 0.00182215174221624;
        kMekDephos_km1 = 15;
        kMekDephos_Vmax1 = 2700;
        kErkPhos_km1 = 50;
        kErkPhos_kcat1 = 4.07362596011106;
        kErkDephos_km1 = 15;
        kErkDephos_Vmax1 = 1800;
        kPI3KPhosByGF = 0.0236645824440146;
        kPI3KDephosByS6K = 14.2862646598184;
        kAktPhos_km = 12.5;
        kAktPhos_ki = 0.25387984777501;
        kAktPhos_kcat = 35.3455388284589;
        MK2206 = 0;
        kAktDephos_km = 15;
        kAktDephos_Vmax = 30;
        kmTORC1Phos_km = 14.7957493443283;
        kmTORC1Phos_ki = 0.0816473300345048;
        kmTORC1Phos_kcat = 0.35;
        Everolimus = 1;
        kmTORC1Dephos_km = 100;
        kmTORC1Dephos_Vmax = 1;
        kS6KPhosBymTORC1_km = 100;
        kS6KPhosBymTORC1_kcat = 0.564311306278601;
        kS6KDephos_km = 10;
        kS6KDephos_Vmax = 50;
        kRafPhosByTGFbR_km = 25;
        kRafPhosByTGFbR_kcat = 0.00615817757384104;
        kRafPhosByPI3K_km = 50;
        kRafPhosByPI3K_kcat = 0.00688252172627295;
        kPI3KPhosByTGFbR_km = 10;
        kPI3KPhosByTGFbR_kcat = 3.39066745271944;
        kPI3KDephosByErk = 0.112816289516761;
        kSmad2PhosByAkt_km = 40;
        kSmad2PhosByAkt_kcat = 0.0139866934761631;
        kSmad2DephosByErk_km = 30;
        kSmad2DephosByErk_kcat = 58.4701016813085;        

        unit volume = 1 litre;
        unit time_unit = 3600 second;
        unit substance = 1e-9 mole;

end
"""