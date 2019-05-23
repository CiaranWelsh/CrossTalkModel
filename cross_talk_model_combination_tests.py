import unittest
import os, pandas, glob, numpy, re
import matplotlib.pyplot as plt
from cross_talk_model_combinations import CrossTalkModel, WORKING_DIRECTORY

import tellurium as te

# WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT'

# class TestDirectories(unittest.TestCase):
#
#     def setUp(self) -> None:
#         C = CrossTalkModel()

class TestModel1(unittest.TestCase):

    def setUp(self):
        self.working_directory = WORKING_DIRECTORY
        self.build_location = os.path.join(self.working_directory, 'copasi_models')

        if not os.path.isdir(self.build_location):
            os.makedirs(self.build_location)

        self.copasi_file = os.path.join(self.working_directory, 'test_copasi_file.cps')

    def test_get_combinations(self):
        C = CrossTalkModel(self.working_directory,
                           mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        expected = 16-4 # 16 is total. 4 is num containing both hypothesis
        comb = [i for i in C._get_combinations()]
        self.assertEqual(expected, len(comb))

    def test_build_reactions(self):
        C = CrossTalkModel(self.working_directory,
                           mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        reactions = C[11]._build_reactions()
        l = ['CrossTalkR2', 'CrossTalkR3', 'CrossTalkR4']
        for i in l:
            self.assertIn(i, reactions)

    def test_len(self):
        C = CrossTalkModel(self.working_directory,
                           mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        self.assertEqual(len(C), 12)

    def test_get_topology(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        C = C[3]
        self.assertEqual(C.topology, 3)

    def test_list_topologies(self):
        C = CrossTalkModel(self.working_directory,
                           mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        l = C.list_topologies()
        expected = 'ErkActivateSmad2AktInhibit'
        self.assertEqual(expected, l.loc[4, 'Topology'])

    def test_model_selection_dir(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(problem_directory=os.path.dirname(ms))
        self.assertEqual(C.model_selection_dir, ms)

    def test_topology_dir(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(problem_directory=os.path.dirname(ms))
        self.assertEqual(C.topology_dir, r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology0')

    def test_topology_dir_changes_correctly(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(problem_directory=os.path.dirname(ms))
        self.assertEqual(C[6].topology_dir, r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology6')

    def test_iter(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        count = 0
        for i in C:
            count += 1
        self.assertEqual(count, 12)

    def test_topology_changes(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        C = C[4]
        self.assertEqual(C.topology, 4)

    def test_data(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        expected = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/all_data/D.csv'
        self.assertEqual(expected, C.data_files[1])


    def test_get_n(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        self.assertEqual(28, C[1]._get_n())

    def test_get_data(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        self.assertIsInstance(C.get_experimental_data(), pandas.DataFrame)

    def test_get_experimental_conditions(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        for i in range(C.get_experimental_conditions().shape[0]):
            self.assertEqual(C.get_experimental_conditions().iloc[i]['GrowthFactors'], 1)

    def test_build_reactions(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        additional_reactions = C[9]._get_combinations()[C[9]._topology]
        additional_reactions = [C[9].model_variant_reactions[i] for i in additional_reactions]
        additional_reactions = [str(i) for i in additional_reactions]
        reactions = C[9]._build_reactions().split('\n')
        reactions = [i.strip() for i in reactions]
        for i in additional_reactions:
            self.assertIn(str(i).strip(),  reactions)

    def test_get_all_parameters_as_list(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        expected = 38
        self.assertEqual(expected, len(C.get_all_parameters_as_list()))

    def test_build_antimony(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        x = C._build_antimony()
        self.assertIsInstance(x, str)

    def test_simulate_conditions(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        sim_data = C.simulate_conditions()
        actual = sorted(list(sim_data.index.levels[0]))
        expected = ['A72', 'D', 'E', 'EA72', 'EM72', 'M72', 'T']
        self.assertListEqual(expected, actual)

    def test_simulate_conditions2(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        sim_data = C.simulate_conditions()
        print(sim_data)
        # actual = sorted(list(sim_data.index.levels[0]))
        # expected = ['A72', 'D', 'E', 'EA72', 'EM72', 'M72', 'T']
        # self.assertListEqual(expected, actual)

    def test_plot_bargraphs(self):
        C = CrossTalkModel(self.working_directory, mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])
        C[5].plot_bargraphs()

    # def test_default_parameter_set_as_dict(self):
    #     C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
    #     self.assertIsInstance(C._default_parameter_set_as_dict(), dict)
    #
    # def test_get_model_parameters_as_antimony(self):
    #     C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
    #     v = 0.333757
    #     p = '_kAktPhos_ki'
    #     s = C.get_best_model_parameters_as_antimony()
    #     self.assertIn("{} = {}".format(p, v), s)
    #
    # def test_get_model_parameters_as_antimony2(self):
    #     C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
    #     s = C[7].plot_bargraphs(best_parameters=True)
    #
    #
    # def test_fit_dir(self):
    #     C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel',
    #                        run_mode=False
    #                        )
    #     print(C.fit_dir)
        # C[7].insert_best_parameters_and_open_with_copasi()
        # mod = C.to_copasi(best_parameters=True,)
        # C[7].run_parameter_estimation(mod).model.open()

    # def test_that_a_global_variable_is_removed_from_the_correct_model(self):
    #     C = CrossTalkModel()

    # def test(self):
    #     C = CrossTalkModel()
    #     mod = C[4].to_copasi(self.copasi_file)
    #     print(C.list_topologies())
    #     mod.open()


if __name__ == '__main__':
    unittest.main()
