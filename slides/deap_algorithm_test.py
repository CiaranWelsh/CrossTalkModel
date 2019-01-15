import random
from deap import base, creator, tools
import numpy as np
from copy import deepcopy
import tellurium as te



def get_model_str():
    """
    Encodes an ODE model using the tellurium package
    :return:
    """
    return """
    
    model DeapTests()
        var x1 in Cell
        var x2 in Cell
        
        Cell = 1;
        
        x1 = 5
        x2 = 0
        
        R1: x1 => x2; k1 * x1
        R2: x2 => ; k2 * x2
        
        k1 = 0.01; // 5
        k2 = 0.01; // 1
    end
    """
model_list = []

def load_parameters_from_dict(model, free_params_dct):
    """

    :param model:
    :param free_params_dct:
    :return:
    """
    if not isinstance(free_params_dct, dict):
        raise ValueError('Requires a dict')

    for i in free_params_dct:
        setattr(model, i, free_params_dct[i])

    return model


def evaluate(individual, model):
    """
    a basic sum of squares objective function
    :param individual:
    :param model:
    :return:
    """
    try:
        ## original data was simulated with k1=5 and k2=1
        data = np.array([[0, 5, 3],
                         [0.111111, 2.86877, 4.69131],
                         [0.222222, 1.64596, 5.34938],
                         [0.333333, 0.944369, 5.44745],
                         [0.444444, 0.541832, 5.25363],
                         [0.555556, 0.310876, 4.91862],
                         [0.666667, 0.178365, 4.52615],
                         [0.777778, 0.102337, 4.12177],
                         [0.888889, 0.0587161, 3.72939],
                         [1, 0.0336884, 3.36077]])

        dct = {
            'k1': np.exp(individual[0]),
            'k2': np.exp(individual[1])
        }
        model = load_parameters_from_dict(model, dct)
        sim_data = model.simulate(0, 1, 10)
        # print(sim_data)
        diff = (data[:, 1:] - sim_data[:, 1:])**2
        # mean2 = np.array([diff[:, i] / (np.mean(diff[:, i])**2) for i in range(diff.shape[1])])
        return (diff.sum(), )
    except RuntimeError:
        ## ignore numerical instability by setting output arbitrarily high
        return (1000.0, )


free_params = ['k1', 'k2']

IND_SIZE = len(free_params)
POP_SIZE = 15

## a list is generated for spliting computation between nodes
## using mpi4py in future revisions and more complicated ODE model
for i in range(POP_SIZE):
    model_list.append(te.loada(get_model_str()))

## DEAP code starts here
creator.create("FitnessMin", base.Fitness, weights=(-1.0,))
creator.create("Individual", np.ndarray, fitness=creator.FitnessMin)

toolbox = base.Toolbox()
## generate new parameters from log normal dist
toolbox.register('attribute', np.random.lognormal)
toolbox.register('individual', tools.initRepeat, creator.Individual, toolbox.attribute, n=IND_SIZE)
toolbox.register('population', tools.initRepeat, list, toolbox.individual)

toolbox.register('mate', tools.cxOnePoint)
toolbox.register('mutate', tools.mutGaussian, indpb=0.1)
toolbox.register('select', tools.selTournament)
toolbox.register('evaluate', evaluate)



def main(models, CXPB=0.3, MUTPB=0.01, NGEN=100):
    model_list = []
    pop = toolbox.population(n=POP_SIZE)
    fitnesses = []
    for i in range(POP_SIZE):
        fitnesses.append(toolbox.evaluate(individual=pop[i], model=models[i]))

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit

    for g in range(NGEN):
        offspring = toolbox.select(pop, k=len(pop), tournsize=len(pop)//5)
        offspring = list(map(toolbox.clone, offspring))

        for child1, child2 in zip(offspring[::2], offspring[1::2]):
            if random.random() < CXPB:
                toolbox.mate(child1, child2)
                del child1.fitness.values
                del child2.fitness.values

        for mutant in offspring:
            if random.random() < MUTPB:
                toolbox.mutate(mutant, mu=0, sigma=1)
                del mutant.fitness.values

        invalid_ind = [ind for ind in offspring if not ind.fitness.valid]
        fitnesses = []
        for i in range(POP_SIZE):
            fitnesses.append(toolbox.evaluate(individual=pop[i], model=models[i]))

        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit

        pop[:] = offspring
        fits_for_gen = [ind.fitness.values[0] for ind in pop]

        # print(fits_for_gen)

        print(("Iteration={}, \tlength={}, \tmean={}, \tmin={}, \tmax={}".format(
            g, len(pop), sum(fits_for_gen) / len(pop), min(fits_for_gen), max(fits_for_gen)
        )))
    return pop

print((main(model_list)))
#
# x = model.simulate(0, 1, 10)
# '''
#         time,    [x1],       [x2]
#  [[        0,       5,          0],
#   [ 0.111111, 4.99445, 0.00554939],
#   [ 0.222222,  4.9889,  0.0110864],
#   [ 0.333333, 4.98336,  0.0166112],
#   [ 0.444444, 4.97783,  0.0221237],
#   [ 0.555556,  4.9723,  0.0276239],
#   [ 0.666667, 4.96678,  0.0331119],
#   [ 0.777778, 4.96126,  0.0385876],
#   [ 0.888889, 4.95575,  0.0440511],
#   [        1, 4.95025,  0.0495025]]
# '''
#
# dct = {
#     'k1': 15,
#     'k2': 25
# }
# model = load_parameters_from_dict(model, dct)
# print(model.k1)
# print(model.k2)
# # class DoNothing:
# x = model.simulate(0, 1, 10)
# print(x)
#
#     def __init__(self):
#         pass



# import pickle
#
# f = r'D:\MesiSTRAT\CrossTalkModel\pickle+test.pickle'
#
# do_nothing = DoNothing()
#
# with open(f, 'w') as fle:
#     pickle.dump(do_nothing, fle)
#
#
#     ..


# print(toolbox.population(25))

# ind1 = toolbox.individual()
# print(ind1)
# print(type(ind1))
# print(ind1[0])
# print(ind1.fitness.valid)
#
#
# def evaluate(individual):
#     a = sum(individual)
#     b = len(individual)
#     return a, 1. / b
#
#
# print('after')
# ind1.fitness.values = evaluate(ind1)
# print(ind1.fitness)
# print(ind1.fitness.valid)
