import unittest
import os, pandas, glob, numpy, re
from cross_talk_model_6_models import CrossTalkModel

import tellurium as te


class TestModel1(unittest.TestCase):

    def setUp(self):
        self.working_directory = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel'
        self.build_location = os.path.join(self.working_directory, 'copasi_models')

        if not os.path.isdir(self.build_location):
            os.makedirs(self.build_location)

        self.copasi_file = os.path.join(self.working_directory, 'test_copasi_file.cps')

    def test_that_a_model_builds(self):
        C = CrossTalkModel()
        self.assertIsInstance(C._build_antimony(), str)

    def test_combinations(self):
        C = CrossTalkModel()
        self.assertEqual(len(C), 16)

    def test_get_topology(self):
        C = CrossTalkModel()
        C = C[3]
        self.assertEqual(C.topology, 3)

    def test_list_topologies(self):
        C = CrossTalkModel()
        l = C.list_topologies()
        self.assertEqual(l.loc[6, 'Topology'], 'AktActivate_AktInhibit')

    def test_model_selection_dir(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(working_directory=os.path.dirname(ms))
        self.assertEqual(C.model_selection_dir, ms)

    def test_topology_dir(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(working_directory=os.path.dirname(ms))
        self.assertEqual(C.topology_dir, r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology0')

    def test_topology_dir_changes_correctly(self):
        ms = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection'
        C = CrossTalkModel(working_directory=os.path.dirname(ms))
        self.assertEqual(C[6].topology_dir, r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/ModelSelection/Topology6')

    def test_number_of_data_files(self):
        C = CrossTalkModel()
        self.assertEqual(len(C.data_files), 22)

    def test_iter(self):
        C = CrossTalkModel(r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel')
        for i in C:
            print(i)
            C[i]



    # def test_that_a_global_variable_is_removed_from_the_correct_model(self):
    #     C = CrossTalkModel()

    # def test(self):
    #     C = CrossTalkModel()
    #     mod = C[4].to_copasi(self.copasi_file)
    #     print(C.list_topologies())
    #     mod.open()


if __name__ == '__main__':
    unittest.main()
