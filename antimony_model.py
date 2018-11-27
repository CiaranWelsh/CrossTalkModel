import os, glob, pandas, numpy
from pycotools import model, viz, tasks
import tellurium as te
import seaborn

seaborn.set_context('paper', font_scale=1)

working_directory = r'D:\MesiSTRAT\CrossTalkModel'
copasi_filename = os.path.join(working_directory, 'TGFbModule.cps')
vilar_file = os.path.join(working_directory, 'vilar2006.cps')
vilar_file2 = os.path.join(working_directory, 'vilar2006_2.cps')
kholo_file = os.path.join(working_directory, 'kholodenko2000.cps')
kholo_file2 = os.path.join(working_directory, 'kholodenko2000_2.cps')
comb_file = os.path.join(working_directory, 'KholoPlusVilar.cps')


functions_str = """
function MM(km, S, Vmax)
  Vmax*S / (km + S)
end 

function MMWithKcat(km, S, E, kcat)
  kcat*E*S / (km + S)
end

function NonCompetitiveInhibition(km, Ki, I, E, V, n)
  V*E/((1 + (I/Ki)^n)*(km + E));
end

function FirstOrderMAWithModifier(k, S, M)
    k*M*S
end

function MA0(k)
  k
end

function MA1(k, S)
    k*S
end

function MA2(k, S1, S2)
    k*S1*S2
end

function MA3(k, S1, S2, S3)
    k*S1*S2*S3
end

"""

tgfb_antimony_str = """    
    model TGFbModule()
        compartment Cell = 1.0
        var TGFb        in Cell
        var TGFbR       in Cell
        var TGFbR_a     in Cell
        var Smad2       in Cell
        var pSmad2      in Cell

        kTGFbOn         = 0.1
        kTGFbOff        = 0.001
        kSmad2Phos      = 0.001
        kSmad2Dephos    = 0.1

        const TGFb      = 1
        TGFbR           = 50
        TGFbR_a         = 0
        pSmad2          = 0
        Smad2           = 250
        
        TGFbR_act:      TGFbR   => TGFbR_a  ; Cell*kTGFbOn*TGFbR*TGFb
        TGFbR_inact:    TGFbR_a => TGFbR    ; Cell*FirstOrderMAWithModifier(kTGFbOff,TGFbR_a,pSmad2)
        Smad2_phos:     Smad2   => pSmad2   ; Cell*FirstOrderMAWithModifier(kSmad2Phos,Smad2,TGFbR)
        pSmad2_dephos:  pSmad2  => Smad2    ; Cell*kSmad2Dephos*pSmad2

    end
"""

vilar_string = """
model TGFbModel()

  // Compartments and Species:
  compartment Cell, Cell;
  species R1 in Cell, R2 in Cell, LRC in Cell, LRC_EE in Cell, R1_EE in Cell;
  species R2_EE in Cell;

  // Reactions:
  v1: R2 + R1   => LRC          ; Cell*MA3(ka, R1, R2, ligand);
  v2: LRC       =>              ; Cell*MA1(kcd, LRC);
  v3: LRC       =>              ; Cell*MA1(klid, LRC);
  v4: LRC       => LRC_EE       ; Cell*MA1(ki, LRC);
  v5:           => R1           ; Cell*MA0(pRI);
  v6: R1        =>              ; Cell*MA1(R1, kcd);
  v7: R1        => R1_EE        ; Cell*MA1(R1, ki);
  v8: R1_EE     => R1           ; Cell*MA1(R1_EE, kr);
  v9: LRC_EE    => R1 + R2      ; Cell*MA1(kr, LRC_EE);
  v10:          => R2           ; Cell*MA0(pRII);
  v11: R2       =>              ; Cell*MA1(R2, kcd);
  v12: R2       => R2_EE        ; Cell*MA1(R2, ki);
  v13: R2_EE    => R2           ; Cell*MA1(R2_EE, kr);

  // Events:
  //event_0000001: at 0 after time >= 2500: ligand = 0.01;

  // Species initializations:
  // set to steady state
  R1        = 271.087;
  R2        = 127.087;
  LRC       = 1.69127;
  LRC_EE    = 16.9127;
  R1_EE     = 2710.87;
  R2_EE     = 1270.87;

  // Compartment initializations:
  Cell = 1;
  
  // Variable initializations:
  TGFb      = 0.01 // off state amount of TGFb is 3e-05. On state is 0.01;
  ka        = 1;
  kcd       = 0.0277777778;
  klid      = 0.25;
  ki        = 0.3333333333333;
  pRI       = 8;
  kr        = 0.0333333333333333;
  alpha     = 1;
  pRII      = 4;

  // Other declarations:
  var TGFb;
  const Cell, ka, kcd, klid, ki, pRI, kr, alpha, pRII;

  // Unit definitions:
  unit time_unit = 3600 second;
  unit substance = item;

  // Display Names:
  time_unit is "time";
  Cell      is "Plasma membrane";
  R1        is "Receptor 1";
  R2        is "Receptor 2";
  LRC       is "ligand receptor complex-plasma membrane";
  LRC_EE    is "ligand receptor complex-endosome";
  R1_EE     is "Receptor 1-endosome";
  R2_EE     is "Receptor 2 endosome";
  v1        is "Ligand receptor complex formation";
  v2        is "Ligand receptor complex constitutive degradation";
  v3        is "Ligand independent complex degradation";
  v4        is "Ligand receptor complex internalization";
  v5        is "R1 synthesis";
  v6        is "R1 constitutive degradation";
  v7        is "R1 internalization";
  v8        is "R1 recycling";
  v9        is "Ligand Receptor complex recycling";
  v10       is "R2 synthesis";
  v11       is "R2 constitutive degradation";
  v12       is "R2 internalization";
  v13     is "R2 recycling";
end
"""

kholo_str = """
model MAPKModel()

  // Compartments and Species:
  compartment Cell;
  species MKKK in Cell, MKKK_P in Cell, MKK in Cell, MKK_P in Cell, MKK_PP in Cell;
  species MAPK in Cell, MAPK_P in Cell, MAPK_PP in Cell;

  // Reactions:
  J0: MKKK      => MKKK_P   ; Cell*NonCompetitiveInhibition(J0_K1, J0_Ki, MAPK_PP, MKKK, J0_V1, J0_n);
  J1: MKKK_P    => MKKK     ; Cell*MM(J1_KK2, MKKK_P, J1_V2);
  J2: MKK       => MKK_P    ; Cell*MMWithKcat(J2_KK3, MKK, MKKK_P, J2_k3);
  J3: MKK_P     => MKK_PP   ; Cell*MMWithKcat(J3_KK4, MKKK_P, MKK_P, J3_k4);
  J4: MKK_PP    => MKK_P    ; Cell*MM(J4_KK5, MKK_PP, J4_V5);
  J5: MKK_P     => MKK      ; Cell*MM(J5_KK6, MKK_P, J5_V6);
  J6: MAPK      => MAPK_P   ; Cell*MMWithKcat(J6_KK7, MAPK, MKK_PP, J6_k7);
  J7: MAPK_P    => MAPK_PP  ; Cell*MMWithKcat(J7_KK8, MAPK_P, MKK_PP, J7_k8);
  J8: MAPK_PP   => MAPK_P   ; Cell*MM(J8_KK9, MAPK_PP, J8_V9);
  J9: MAPK_P    => MAPK     ; Cell*MM(J9_KK10,MAPK_P, J9_V10);

  // Species initializations:
  MKKK = 90;
  MKKK_P = 10;
  MKK = 280;
  MKK_P = 10;
  MKK_PP = 10;
  MAPK = 280;
  MAPK_P = 10;
  MAPK_PP = 10;

  // Compartment initializations:
  Cell = 1;

  // Variable initializations:
  J0_K1     = 10;
  J0_Ki     = 9;
  J0_V1     = 2.5;
  J0_n      = 1;
  J1_KK2    = 8;
  J1_V2     = 0.25;
  J2_KK3    = 15;
  J2_k3     = 0.025;
  J3_KK4    = 15;
  J3_k4     = 0.025;
  J4_KK5    = 15;
  J4_V5     = 0.75;
  J5_KK6    = 15;
  J5_V6     = 0.75;
  J6_KK7    = 15;
  J6_k7     = 0.025;
  J7_KK8    = 15;
  J7_k8     = 0.025;
  J8_KK9    = 15;
  J8_V9     = 0.5;
  J9_KK10   = 15;
  J9_V10    = 0.5;

  // Other declarations:
  const Cell;

  // Unit definitions:
  unit substance = 1e-9 mole;

  // Display Names:
  MKKK is "Mos";
  MKKK_P is "Mos-P";
  MKK is "Mek1";
  MKK_P is "Mek1-P";
  MKK_PP is "Mek1-PP";
  MAPK is "Erk2";
  MAPK_P is "Erk2-P";
  MAPK_PP is "Erk2-PP";
  J0 is "MAPKKK activation";
  J1 is "MAPKKK inactivation";
  J2 is "phosphorylation of MAPKK";
  J3 is "phosphorylation of MAPKK-P";
  J4 is "dephosphorylation of MAPKK-PP";
  J5 is "dephosphorylation of MAPKK-P";
  J6 is "phosphorylation of MAPK";
  J7 is "phosphorylation of MAPK-P";
  J8 is "dephosphorylation of MAPK-PP";
  J9 is "dephosphorylation of MAPK-P";
end
"""

comb_str = """
model TGFbPlusMAPK()
    tgfb: TGFbModel();
    mapk: MAPKModel();
end
"""


def load_model(copasi_filename, ant):
    with model.BuildAntimony(copasi_filename) as loader:
        mod = loader.load(
            ant
        )
    return mod

# tgf = load_model(copasi_filename, functions_str+tgfb_antimony_str)
# vilar = model.Model(vilar_file, )
# kho = model.Model(kholo_file)
# vilar = load_model(vilar_file2, functions_str+vilar_string)
# print functions_str+kholo_str
# kho = load_model(kholo_file2, functions_str+kholo_str)

# m = load_model(comb_file, functions_str+vilar_string+kholo_str+comb_str)
# m.open()
# vilar.open()
# kho.open()

# comb = functions_str+kholo_str+vilar_string+"""
# model TGFbAndMAPK()
#     mapk: MAPK();
# end
# """



# def sim_model_te(string, functions_string=func_str):
#     mod = functions_string + string
#     print(mod)
#     m = te.loada(mod)
#     m.simulate(0, 1000, 1000)
#     m.plot()

# sim_model(mod1)
# sim_model(mod2)
# sim_model(mod1 + mod2 + mod3)
# sim_model(combstr, functions_string="")



# sim_model(combstr, functions_string="")














