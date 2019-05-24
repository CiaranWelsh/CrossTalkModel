import unittest
import os, pandas, glob, numpy, re
import matplotlib.pyplot as plt
from cross_talk_model_combinations import CrossTalkModel

import tellurium as te


WORKING_DIRECTORY = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'

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
        self.data_dir = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/all_data'

        self.C = CrossTalkModel(self.working_directory, self.data_dir,
                           mutually_exclusive_reactions=[('CrossTalkR1', 'CrossTalkR2')])

    def test_get_combinations(self):
        expected = 16 - 4  # 16 is total. 4 is num containing both hypothesis
        comb = [i for i in self.C._get_combinations()]
        self.assertEqual(expected, len(comb))

    def test_build_reactions(self):
        reactions = self.C[11]._build_reactions()
        l = ['CrossTalkR2', 'CrossTalkR3', 'CrossTalkR4']
        for i in l:
            self.assertIn(i, reactions)

    def test_len(self):
        self.assertEqual(len(self.C), 12)

    def test_get_topology(self):
        self.C = self.C[3]
        self.assertEqual(self.C.topology, 3)

    def test_list_topologies(self):
        l = self.C.list_topologies()
        expected = 'ErkActivateSmad2AktInhibit'
        self.assertEqual(expected, l.loc[4, 'Topology'])

    def test_topology_dir(self):
        self.assertEqual(self.C.topology_dir, r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology0')

    def test_topology_dir_changes_correctly(self):
        self.assertEqual(self.C[6].topology_dir, r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology6')

    def test_iter(self):
        count = 0
        for i in self.C:
            count += 1
        self.assertEqual(count, 12)

    def test_topology_changes(self):
        self.C = self.C[4]
        self.assertEqual(self.C.topology, 4)

    def test_data(self):
        expected = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/all_data/D.csv'
        self.assertEqual(expected, self.C.data_files[1])

    def test_get_n(self):
        self.assertEqual(28, self.C[1]._get_n())

    def test_get_data(self):
        self.assertIsInstance(self.C.get_experimental_data(), pandas.DataFrame)

    def test_get_experimental_conditions(self):
        for i in range(self.C.get_experimental_conditions().shape[0]):
            self.assertEqual(self.C.get_experimental_conditions().iloc[i]['GrowthFactors'], 1)

    def test_build_reactions(self):
        additional_reactions = self.C[9]._get_combinations()[self.C[9]._topology]
        additional_reactions = [self.C[9].model_variant_reactions[i] for i in additional_reactions]
        additional_reactions = [str(i) for i in additional_reactions]
        reactions = self.C[9]._build_reactions().split('\n')
        reactions = [i.strip() for i in reactions]
        for i in additional_reactions:
            self.assertIn(str(i).strip(), reactions)

    def test_build_antimony_correctly_builds_events(self):
        self.C._build_antimony()
        # additional_reactions = self.C[9]._get_combinations()[self.C[9]._topology]
        # additional_reactions = [self.C[9].model_variant_reactions[i] for i in additional_reactions]
        # additional_reactions = [str(i) for i in additional_reactions]
        # reactions = self.C[9]._build_reactions().split('\n')
        # reactions = [i.strip() for i in reactions]
        # for i in additional_reactions:
        #     self.assertIn(str(i).strip(), reactions)

    def test_get_all_parameters_as_list(self):
        expected = 39
        self.assertEqual(expected, len(self.C.get_all_parameters_as_list()))

    def test_build_antimony(self):
        x = self.C._build_antimony()
        self.assertIsInstance(x, str)

    def test_simulate_conditions(self):
        sim_data = self.C.simulate_conditions()
        actual = sorted(list(sim_data.index.levels[0]))
        expected = ['A72', 'D', 'E', 'EA72', 'EM72', 'M72', 'T']
        self.assertListEqual(expected, actual)

    def test_get_experimental_data(self):
        df = self.C.get_experimental_data()
        expected = (7, 10)  # 6 indep vars columns
        self.assertEqual(expected, df.shape)

    def test_get_errors(self):
        df = self.C.get_errors()
        expected = (7, 4)  # no independent variables
        self.assertEqual(expected, df.shape)

    def test_get_experimental_conditions2(self):
        df = self.C.get_experimental_conditions()
        expected = (7, 6)
        self.assertEqual(expected, df.shape)

    def test_plot_bargraphs(self):
        fname = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology5/Fit1_1/Graphs/simulations.png'
        self.C[5].plot_bargraphs()
        plt.show()
        self.assertTrue(os.path.isfile(fname))

    def test_open_as_copasi(self):
        mod = self.C[0].to_copasi()
        from pycotools3.model import Model
        self.assertIsInstance(mod, Model)

    def test_default_parameter_set_as_dict(self):
        self.assertIsInstance(self.C._default_parameter_set_as_dict(), dict)

    # def test_get_model_parameters_as_antimony(self):
    #     self.C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
    #     v = 0.333757
    #     p = '_kAktPhos_ki'
    #     s = self.C.get_best_model_parameters_as_antimony()
    #     self.assertIn("{} = {}".format(p, v), s)

    # def test_get_model_parameters_as_antimony2(self):
    #     self.C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
    #     s = self.C[7].plot_bargraphs(best_parameters=True)
    #
    #
    # def test_fit_dir(self):
    #     self.C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel',
    #                        run_mode=False
    #                        )
    #     print(self.C.fit_dir)
    # self.C[7].insert_best_parameters_and_open_with_copasi()
    # mod = self.C.to_copasi(best_parameters=True,)
    # self.C[7].run_parameter_estimation(mod).model.open()

    # def test_that_a_global_variable_is_removed_from_the_correct_model(self):
    #     self.C = CrossTalkModel()

    # def test(self):
    #     self.C = CrossTalkModel()
    #     mod = self.C[4].to_copasi(self.copasi_file)
    #     print(self.C.list_topologies())
    #     mod.open()


if __name__ == '__main__':
    unittest.main()
