import unittest
from cross_talk_model import *


class TestTGFbQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('AZD')

    def test_pAkt(self):
        self.assertAlmostEqual(self.df.loc['D', 'pAkt'], self.df.loc['T', 'pAkt'], 1)

    def test_ppErk(self):
        self.assertAlmostEqual(self.df.loc['D', 'ppErk'], self.df.loc['T', 'ppErk'], 1)

    def test_pSmad2(self):
        """
        assert pSmad2 in T > pSmad2 in D
        :return:
        """
        self.assertGreater(self.df.loc['T', 'pSmad2'], self.df.loc['D', 'pSmad2'], 1)

    def test_pS6k(self):
        self.assertAlmostEqual(self.df.loc['D', 'pS6K'], self.df.loc['T', 'pS6K'], 1)


class TestEverolimusQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('AZD')

    def test_pAkt(self):
        self.assertGreater(self.df.loc['E', 'pAkt'], self.df.loc['T', 'pAkt'])

    def test_ppErk_vs_T(self):
        self.assertGreater(self.df.loc['E', 'ppErk'], self.df.loc['T', 'ppErk'])

    def test_pSmad2(self):
        self.assertGreater(self.df.loc['E', 'pSmad2'], self.df.loc['T', 'pSmad2'])

    def test_pS6k(self):
        self.assertLess(self.df.loc['E', 'pS6K'], self.df.loc['T', 'pS6K'])


class TestAZDbQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('AZD')

    def test_pAkt(self):
        self.assertAlmostEqual(self.df.loc['T', 'pAkt'], self.df.loc['A_72', 'pAkt'], 1)

    def test_ppErk(self):
        self.assertGreater(self.df.loc['T', 'ppErk'], self.df.loc['A_72', 'ppErk'])

    def test_pSmad2(self):
        self.assertAlmostEqual(self.df.loc['T', 'pSmad2'], self.df.loc['A_72', 'pSmad2'], 1)

    def test_pS6k1(self):
        self.assertLess(self.df.loc['A_72', 'pS6K'], self.df.loc['T', 'pS6K'])

    def test_pS6k2(self):
        self.assertGreater(self.df.loc['A_72', 'pS6K'], self.df.loc['E', 'pS6K'], 1)


class TestMKQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('MK2206')

    def test_pAkt(self):
        self.assertAlmostEqual(self.df.loc['T', 'pAkt'], self.df.loc['M_72', 'pAkt'], 1)

    def test_ppErk(self):
        self.assertAlmostEqual(self.df.loc['T', 'ppErk'], self.df.loc['M_72', 'ppErk'], 1)

    def test_pSmad2(self):
        self.assertAlmostEqual(self.df.loc['T', 'pSmad2'], self.df.loc['M_72', 'pSmad2'], 1)

    def test_pS6k(self):
        self.assertAlmostEqual(self.df.loc['T', 'pS6K'], self.df.loc['M_72', 'pS6K'], 1)




class TestAZDPlusEvQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('AZD')

    def test_pAkt(self):
        self.assertLess(self.df.loc['T', 'pAkt'], self.df.loc['E_A_72', 'pAkt'])

    def test_ppErk(self):
        self.assertLess(self.df.loc['T', 'ppErk'], self.df.loc['E_A_72', 'ppErk'])

    def test_pSmad2(self):
        self.assertGreater(self.df.loc['E_A_72', 'pSmad2'], self.df.loc['T', 'pSmad2'])

    def test_pS6k_1(self):
        self.assertLess(self.df.loc['E_A_72', 'pS6K'], self.df.loc['T', 'pS6K'])

    def test_pS6k_2(self):
        self.assertAlmostEqual(self.df.loc['E_A_72', 'pS6K'], self.df.loc['E', 'pS6K'], 1)


class TestMKPlusEvQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('MK2206')

    def test_pAkt(self):
        self.assertLess(self.df.loc['E_M_72', 'pAkt'], self.df.loc['T', 'pAkt'])

    def test_ppErk_1(self):
        self.assertGreater(self.df.loc['E_M_72', 'ppErk'], self.df.loc['T', 'ppErk'])

    def test_ppErk_2(self):
        self.assertGreater(self.df.loc['E_M_72', 'ppErk'], self.df.loc['E', 'ppErk'])

    def test_pSmad2_1(self):
        self.assertLess(self.df.loc['E_M_72', 'pSmad2'], self.df.loc['E', 'pSmad2'])

    def test_pSmad2_2(self):
        self.assertAlmostEqual(self.df.loc['E', 'pSmad2'], self.df.loc['T_E_1.25', 'pSmad2'], 1)

    def test_pS6k_1(self):
        self.assertLess(self.df.loc['E_A_72', 'pS6K'], self.df.loc['T', 'pS6K'])

    def test_pS6k_2(self):
        self.assertAlmostEqual(self.df.loc['E_A_72', 'pS6K'], self.df.loc['E', 'pS6K'], 1)

if __name__ == '__main__':
    unittest.main()
