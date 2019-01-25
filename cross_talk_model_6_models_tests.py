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
        C = CrossTalkModel(0)
        self.assertIsInstance(C.build(), str)

    def test_that_the_right_model_builds(self):
        C = CrossTalkModel(0)
        mod = te.loada(C.build())
        print(mod)













if __name__ == '__main__':
    unittest.main()





















































