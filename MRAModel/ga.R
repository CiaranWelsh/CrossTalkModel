## script to try MRA on cross talk dataset
library(STASNet)

working_directory = '/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/MRA'

data_dir = '/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/MRA_data'

##get datset
dataset_filename = file.path(data_dir, 'mra_means1_25h.csv')
errors_filename = file.path(data_dir, 'mra_sds_1_25h.csv')

read_data = function(f){
  data = read.csv(f, check.names = F)
  rownames(data) = 1:dim(data)[1]
  data = data[2:dim(data)[2]]
  return(data)
}

data = read_data(dataset_filename)
errors = read_data(errors_filename)
data
errors

interactions = rbind(
  c('TGFb', 'Smad2'),
  c('TGFb', 'Akt'),
  c('TGFb', 'Mek'),
  c('Akt', 'mTORC1'),
  c('mTORC1', 'S6K'),
  c('Mek', 'Erk')
  # extended reactions
)
interactions = data.frame(interactions)
colnames(interactions) = c('FROM', 'TO')

interactions
## basal activity vecotr 
basal = c('TGFb', 'Smad2', 'Akt', 'Erk', 'TSC2', 'mTORC1', 'S6K', '4EBP1', 'PRAS40', 'Mek', 'PI3K', 
                    'PDK1', 'Raf')



model_variables = unlist(list(interactions[, 1]), interactions[,2])

do = function(interactions, basal, data, errors, inits=100, n=6, count=0, reduce_prob=0.5){
  count = count + 1
  print(paste('running iteration ', count))
  model = createModel(model_links = interactions,
                      basal_file = basal,
                      data.stimulation = data,
                      data.variation = errors,
                      inits = inits,
                      model_name = "SDErrorModel", nb_cores=8)
  if (runif(1) < reduce_prob){
    print('reducing the model befor extending')
    model = selectMinimalModel(model)
  }
  print('extending model')
  ext_mat = suggestExtension(model, parallel=T, padjust_method = 'fdr')
  ext_mat = ext_mat[ext_mat$adj_pval < 0.05, ]
  
  if (dim(ext_mat)[1] == 0){
    print('Empty extention matrix. Returning the current model instead of extending.')
    return (list(model=model, interactions=interactions))
  }
  idx = sample(dim(ext_mat)[1], 1)
  from = as.character(ext_mat[idx, 2])
  to = as.character(ext_mat[idx, 3])
  new_connection = c(from, to)
  interactions = rbind(interactions, new_connection)
  if (count == n){
    return (list(model=model, interactions=interactions))
  }
  do(interactions = interactions, basal=basal, data=data, errors=errors, inits=inits, n=n, count=count)
}

#res = do(interactions, basal, data, errors, 100, n=20)



## choose k individuals from the population and select the best from them
tournament_selection = function(pop, k){
  best = 0
  for (i in 1:k){
    random_selection = sample(pop, k)
    ind = pop[sample(length(pop), 1)]
    if (best == 0 | ind$model$bestfit > best$model$bestfit ){
      best = ind
    }
  }
  return (best)
}

crossover = function(parent1, parent2){
  ## get size of networks
  size1 = dim(parent1$interactions)[1] ##data.frames
  size2 = dim(parent2$interactions)[1]
  
  ## set the smaller network to parent 1
  if (size1 > size2){
    tmp = parent1
    parent1 = parent2
    parent2 = tmp
  }
  ##randomize ordering in both parents
  parent1$interactions = parent1$interactions[sample(size1), ]
  parent2$interactions = parent2$interactions[sample(size2), ]
  
  ##pick a random number between 1 and size1
  crossover_point = sample(size1, 1)
  child1 = list()
  child2 = list()
  child1['interactions'] = rbind(parent1$interactions[1:crossover_point, ], parent2$interactions[crossover_point:size2, ])
  child2['interactions'] = rbind(parent2$interactions[1:crossover_point, ], parent1$interactions[crossover_point:size1, ])
  return(list(child1=child1, child2=child2))
}

mutation = function(ind){
  #unlist(list(facs[1 : 3], facs[4 : 5]))
  nodes = unlist(list(ind$interactions[,1 ], ind$interactions[, 2]))
  random = sample(nodes, 2)
  return (list(from=random[1], to=random[2]))
}

## initialise a population of models of size n by the lazily named `do function above. 
init_extended_population = function(n){
  pop = list()
  for (i in 1:n){
    pop[i] = do(interactions, basal, data, errors, inits=100, n=n, count=0)
  }
  return (pop)
}

init_random_population = function(n, components, num_starting_reactions=5, 
                                  inits=100){
  pop = list()
  for (i in 1:n){
    ind = list()
    for (j in 1:num_starting_reactions){
      random_nodes = sample(components, 2)
      from = random_nodes[1]
      to = random_nodes[2]
      ind = rbind(ind, c(from, to))
    }
    ind = data.frame(ind)
    colnames(ind) = c('FROM', 'TO')
    pop[[i]] = createModel(model_links = ind,
                            basal_file = basal,
                            data.stimulation = data,
                            data.variation = errors,
                            inits = inits,
                            nb_cores=8)
  }
  return (pop)
}
#levels(model_variables)


pop = init_random_population(5, levels(model_variables), num_starting_reactions = 5)
pop
genetic_alg = function(pop, N=5, iterations=10, mutation_prob=0.1){
  done = FALSE
  iter_count = 0
  while (iter_count < iterations){
    print(paste('running iteration', iter_count))

    iter_count = iter_count + 1
    children = list()
    while (length(children) < N){

      parent1 = tournament_selection(pop, 2)
  #     parent2 = tournament_selection(pop, 2)
  #     child = crossover(parent1, parent2)
  #     child1 = child$child1
  #     child2 = child$child2
  #     if (runif(1) < mutation_prob){
  #       mutation_reaction = mutation(child)
  #       child1$interactions = rbind(child1$interactions, c(mutation_reaction$from, mutation_reaction$to))
  #       child2$interactions = rbind(child2$interactions, c(mutation_reaction$from, mutation_reaction$to))
      }
  #     
  #     child1['model'] = createModel(model_links = child1, basal_file = basal,
  #                                   data.stimulation = data, data.variation = errors,
  #                                   inits = inits, nb_cores=8)
  #     child2['model'] = createModel(model_links = child2, basal_file = basal,
  #                                   data.stimulation = data, data.variation = errors,
  #                                   inits = inits, nb_cores=8)
  #     children[length(children)+1] = child1
  #     children[length(children)+1] = child2
  #   }
  #   pop = children
    }
}

result = genetic_alg(pop)

# N = population size
# P = create parent population by randomly creating N individuals
# while not done
# C = create empty child population
# while not enough individuals in C
# parent1 = select parent   ***** HERE IS WHERE YOU DO TOURNAMENT SELECTION *****
#   parent2 = select parent   ***** HERE IS WHERE YOU DO TOURNAMENT SELECTION *****
#   child1, child2 = crossover(parent1, parent2)
# mutate child1, child2
# evaluate child1, child2 for fitness
# insert child1, child2 into C
# end while
# P = combine P and C somehow to get N new individuals
# end while










