import unittest
import os, pandas, glob, numpy, re
from cross_talk_model_combinations import CrossTalkModel

import tellurium as te


class TestModel1(unittest.TestCase):

    def setUp(self):
        self.working_directory = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'
        self.build_location = os.path.join(self.working_directory, 'copasi_models')

        if not os.path.isdir(self.build_location):
            os.makedirs(self.build_location)

        self.copasi_file = os.path.join(self.working_directory, 'test_copasi_file.cps')

    def test_that_a_model_builds(self):
        C = CrossTalkModel(self.working_directory)
        C[1].to_copasi().open()
        self.assertIsInstance(C._build_antimony(), str)

    def test_combinations(self):
        C = CrossTalkModel(self.working_directory)
        self.assertEqual(len(C), 16)

    def test_get_topology(self):
        C = CrossTalkModel(self.working_directory)
        C = C[3]
        self.assertEqual(C.topology, 3)

    def test_list_topologies(self):
        C = CrossTalkModel(self.working_directory)
        l = C.list_topologies()
        self.assertEqual(l.loc[6, 'Topology'], 'AktActivate_AktInhibit')

    def test_model_selection_dir(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(problem_dir=os.path.dirname(ms))
        self.assertEqual(C.model_selection_dir, ms)

    def test_topology_dir(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(problem_dir=os.path.dirname(ms))
        self.assertEqual(C.topology_dir, r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology0')

    def test_topology_dir_changes_correctly(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(problem_dir=os.path.dirname(ms))
        self.assertEqual(C[6].topology_dir, r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology6')

    def test_number_of_data_files(self):
        C = CrossTalkModel(self.working_directory)
        self.assertEqual(len(C.data_files), 22)

    def test_insert_best_parameters_and_open_with_copasi(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(problem_dir=os.path.dirname(ms))

        print(C[2].insert_best_parameters_and_open_with_copasi())

    def test_iter(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        count = 0
        for i in C:
            count += 1
        self.assertEqual(count, 16)

    def test_getitem(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        # print (C[6].to_copasi().open())
        for i in C:
            C = C[i]
        self.assertEqual(C[i].topology, 15)

    def test_topology_changes(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        current_topology = C.topology
        C = C[4]
        self.assertEqual(C.topology, 4)

    def test_get_n(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        self.assertEqual(C[1]._get_n(), 88)

    def test_get_data(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        self.assertIsInstance(C.get_experimental_data(), pandas.DataFrame)

    def test_get_experimental_conditions(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        for i in range(C.get_experimental_conditions().shape[0]):
            self.assertEqual(C.get_experimental_conditions().iloc[i]['GrowthFactors'], 1)

    def test_get_experimental_conditions2(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        df = C.get_experimental_conditions()
        fname = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/cond.csv'
        # df.to_csv(fname)
        # for i in range(C.get_experimental_conditions().shape[0]):
        #     print(C.get_experimental_conditions())
        # self.assertEqual(C.get_experimental_conditions().iloc[i]['GrowthFactors'], 1)

    def test_simulate_conditions(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        C.simulate_conditions()

    def test_plot_bargraphs(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        C.plot_bargraphs()

    def test_default_parameter_set_as_dict(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        self.assertIsInstance(C._default_parameter_set_as_dict(), dict)

    def test_get_model_parameters_as_antimony(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        v = 0.333757
        p = '_kAktPhos_ki'
        s = C.get_best_model_parameters_as_antimony()
        self.assertIn("{} = {}".format(p, v), s)

    def test_get_model_parameters_as_antimony2(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        s = C[7].plot_bargraphs(best_parameters=True)


    def test_fit_dir(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel',
                           run_mode=False
                           )
        print(C.fit_dir)
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
