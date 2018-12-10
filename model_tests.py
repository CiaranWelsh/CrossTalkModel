import unittest
from KatrinesModelVersion import *


class TestTGFbQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('AZD')

    def test_pAkt(self):
        self.assertAlmostEqual(self.df.loc['D', 'pAkt'], self.df.loc['T', 'pAkt'], 2)

    def test_pErk(self):
        self.assertAlmostEqual(self.df.loc['D', 'pErk'], self.df.loc['T', 'pErk'], 2)

    def test_pSmad2(self):
        """
        assert pSmad2 in T > pSmad2 in D
        :return:
        """
        self.assertGreater(self.df.loc['T', 'pSmad2'], self.df.loc['D', 'pSmad2'], 2)


class TestEverolimusQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('AZD')

    def test_pAkt(self):
        self.assertGreater(self.df.loc['E', 'pAkt'], self.df.loc['T', 'pAkt'])

    def test_pErk_vs_T(self):
        self.assertGreater(self.df.loc['E', 'pErk'], self.df.loc['T', 'pErk'])

    def test_pSmad2(self):
        self.assertGreater(self.df.loc['E', 'pSmad2'], self.df.loc['T', 'pSmad2'])


class TestAZDbQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('AZD')

    def test_pAkt(self):
        self.assertAlmostEqual(self.df.loc['T', 'pAkt'], self.df.loc['A_72', 'pAkt'], 2)

    def test_pErk(self):
        self.assertGreater(self.df.loc['T', 'pErk'], self.df.loc['A_72', 'pErk'])

    def test_pSmad2(self):
        self.assertAlmostEqual(self.df.loc['T', 'pSmad2'], self.df.loc['A_72', 'pSmad2'], 2)


class TestMKQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('MK2206')

    def test_pAkt(self):
        self.assertAlmostEqual(self.df.loc['T', 'pAkt'], self.df.loc['M_72', 'pAkt'], 2)

    def test_pErk(self):
        self.assertAlmostEqual(self.df.loc['T', 'pErk'], self.df.loc['M_72', 'pErk'], 2)

    def test_pSmad2(self):
        self.assertAlmostEqual(self.df.loc['T', 'pSmad2'], self.df.loc['M_72', 'pSmad2'], 2)


class TestAZDPlusEvQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('AZD')

    def test_pAkt(self):
        self.assertLess(self.df.loc['T', 'pAkt'], self.df.loc['E_A_72', 'pAkt'])

    def test_pErk(self):
        self.assertLess(self.df.loc['T', 'pErk'], self.df.loc['E_A_72', 'pErk'])

    def test_pSmad2(self):
        self.assertGreater(self.df.loc['E_A_72', 'pSmad2'], self.df.loc['T', 'pSmad2'])


class TestMKPlusEvQualitative(unittest.TestCase):
    def setUp(self):
        self.df = simulate_conditions('MK2206')

    def test_pAkt(self):
        self.assertLess(self.df.loc['M_E_72', 'pAkt'], self.df.loc['T', 'pAkt'])

    def test_pErk_1(self):
        self.assertGreater(self.df.loc['E_M_72', 'pErk'], self.df.loc['T', 'pErk'])

    def test_pErk_2(self):
        self.assertGreater(self.df.loc['E_M_72', 'pErk'], self.df.loc['T_E', 'pErk'])

    def test_pSmad2_1(self):
        self.assertLess(self.df.loc['E_M_72', 'pSmad2'], self.df.loc['T_E', 'pSmad2'])

    def test_pSmad2_2(self):
        self.assertAlmostEqual(self.df.loc['E', 'pSmad2'], self.df.loc['T_E_1.25', 'pSmad2'], 2)


if __name__ == '__main__':
    unittest.main()
