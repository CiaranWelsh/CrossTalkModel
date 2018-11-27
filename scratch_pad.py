import os, glob, pandas, numpy
from pycotools import model, viz, tasks
import tellurium as te

working_directory = r'D:\MesiSTRAT\CrossTalkModel'
copasi_filename = os.path.join(working_directory, 'simple_model.cps')

def open_with_copasi(antimony_str, copasi_filename):
    """
    Helper function that opens sbml model in copasi
    :return:
    """
    with model.BuildAntimony(copasi_filename) as m:
        mod = m.load(antimony_str)

    mod.open()

def print_sbml(antimony_str):
    sbml = te.antimonyToSBML(antimony_str)
    print(sbml)
    return sbml

functions_str = """
function MA1(k, s)
    k*s
end

function MA2(k, s1, s2)
    k*s1*s2
end

function MA1Mod(k, s, m)
    k*m*s
end

function MA2Mod(k, s1, s2, m)
    k*m*s1*s2
end
"""


mod1_str = """
model mod1()
    compartment Cell = 1
    A in Cell
    B in Cell
    
    R1: A => B ;  Cell*MA1(k1, A)
    R2: B => A ;  Cell*MA1(k2, B)
    
    k1=0.01
    k2=0.01
    
    A = 1;
    B = 0;
end

"""


mod2_str = """
model mod2()
    compartment Cell = 1
    A in Cell
    B in Cell
    C in Cell
    D in Cell
    E in Cell
    F in Cell

    R1: A => B ;  Cell*MA1(k1, A)
    R2: B => A ;  Cell*MA1Mod(k2, B, C)
    R3: C => A ;  Cell*MA1Mod(k3, C, B)
    
    // D to E with F as modifier
    R4: D => E ;  Cell*MA1Mod(k3, D, F)

    k1=0.01
    k2=0.01
    k3=0.01

    A = 1;
    B = 1;
    C = 1;
    E = 1;
    F = 1;
end

"""

mod1_str = functions_str + mod1_str
mod2_str = functions_str + mod2_str

# print_sbml(mod1_str)
# open_with_copasi(mod1_str, copasi_filename)
open_with_copasi(mod2_str, copasi_filename)
print_sbml(mod2_str)






# open_with_copasi(mod2_str, copasi_filename)

# with open(sbml_file, 'w') as f:
#     f.write(sbml)

# print(te.sbmlToAntimony(sbml_file))

# m = te.loada(test_model_str)
# print()
# print(te.getODEsFromModel(m))
# m = te.loada(ant_str)
#
# m.simulate(0, 100, 100)
# m.plot()


























