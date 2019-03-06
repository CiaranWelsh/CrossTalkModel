"""
A script to extract data from the excel files
that were gives to me by Kathrin's lab into a usage format

"""

import pandas, os, glob
import xlrd
import numpy


class GetData:

    new_names = {
        'D': 'DMSO',
        'T': 'TGFB',
        'E':  'TGFB +Everolimus',
        'EA72':	'TGFB + Everolimus+ AZD 3',
        'EA48':	'TGFB + Everolimus+ AZD 2',
        'EA24':	'TGFB + Everolimus+ AZD 1',
        'EA1.25': 'TGFB + Everolimus+ AZD 30 mins',
        'A72': 'TGFB + AZD 3',
        'A48': 'TGFB + AZD  2',
        'A24': 'TGFB + AZD 1',
        'A1.25': 'TGFB + AZD 30mins',
        'EM72':	'TGFB + Everolimus+ MK 3',
        'EM48':	'TGFB + Everolimus+ MK2',
        'EM24':	'TGFB + Everolimus+ MK 1',
        'EM1.25':	'TGFB + Everolimus+ MK30 mins',
        'M72':	'TGFB + MK 3',
        'M48':	'TGFB + MK 2',
        'M24':	'TGFB + MK 1',
        'M1.25': 'TGFB + MK 30mins',
    }
    new_names = {v: k for k, v in new_names.items()}

    col_indices = [1, 3, 5, 7, 9]

    def __init__(self, workbook):
        self.workbook = xlrd.open_workbook(workbook)

    def get_sheet_names(self):
        return self.workbook.sheet_names()

    def get_data_from_sheet(self, sheet):
        sheet = self.workbook.sheet_by_name(sheet)
        names = sheet.col_slice(0, 30, 40)

        data = [sheet.col_slice(i, 30, 40) for i in self.col_indices]

        df = pandas.DataFrame(data).transpose()
        df['condition'] = names
        for i in range(df.shape[0]):
            for j in range(df.shape[1]):
                if df.iloc[i, j].ctype == 5:
                    df.iloc[i, j] = numpy.nan
                else:
                    df.iloc[i, j] = df.iloc[i, j].value

        condition_code = []
        for i in df['condition']:
            if i not in self.new_names.keys():
                raise ValueError
            condition_code.append(self.new_names[i])

        df['condition_code'] = condition_code
        df = df.set_index('condition_code')
        df = df.drop('condition', axis=1)
        return df

    def get_data(self):
        df_dct = {i: self.get_data_from_sheet(i) for i in self.get_sheet_names()}
        return pandas.concat(df_dct).stack().unstack(level=1)

def do_stats(data):
    mean_dct = {}
    sd_dct = {}
    for label, df in data.groupby(level=0):
        mean_dct[label] = df.mean()
        sd_dct[label] = df.std()

    mean = pandas.concat(mean_dct, axis=1, sort=False).transpose()
    sd = pandas.concat(sd_dct, axis=1, sort=False).transpose()
    return {
        'mean': mean,
        'sd': sd
    }

def add_v3_to_v2_data(v2, v3):
    """
    I was given multiple verison of data file. Version 2 v2 was superseeded
    by v3 but contains less data. This function starts with v2 then adds
    any dataset that is present in v3 but not v2 or overwrites. This is necessary
    as the data was cleaned in v2

    :param v3: dataframe. version 3
    :param v2: dataframe. version2 2
    :return: cleaned df
    """

    v3 = v3.transpose()
    v2 = v2.transpose()
    for i in v3:
        print('i', i)
        v2[i] = v3[i]
    return v2.transpose()

def configure_for_mra(dataset):
    which = ['D', 'T', 'E'] + [i for i in dataset.columns if '1.25' in i]
    data = dataset[which].transpose()
    data = data.drop(['TSC2', 'PRAS40-pS183'], axis=1)
    data.columns = [i.split('-')[0] for i in data.columns]

    new_names = {
        '4E': '4EBP1',
        '4EBP': '4EBP1',
        'ERK': 'Erk',
        'SMAD2': 'Smad2',
        'mTOR': 'mTORC1',
    }
    data = data.rename(columns=new_names)

    data.columns = ['DV:'+i for i in data.columns]
    data['DA:ALL'] = 0

    tr = ['TGFb', 'Everolimus', 'AZD', 'MK']
    treatment_names = ['TGFb', 'mTORC1i', 'Meki', 'Akti']
    treatment_names = ['TR:'+i for i in treatment_names]
    treatments = {
        'D':      [0, 0, 0, 0],
        'T':      [1, 0, 0, 0],
        'E':      [1, 1, 0, 0],
        'EM1.25': [1, 1, 1, 0],
        'EA1.25': [1, 1, 0, 1],
    }
    tr_df = pandas.DataFrame(treatments, index=treatment_names).transpose()
    return pandas.concat([tr_df, data], sort=False, axis=1)



if __name__ == '__main__':
    wd = os.path.dirname(__file__)
    data_file = os.path.join(wd, 'HardCopy')
    mra_data_dir = os.path.join(wd, 'MRA_data')
    if not os.path.isdir(mra_data_dir):
        os.makedirs(mra_data_dir)

    azd_data_file_v2 = os.path.join(data_file, 'AZD_calculations - v2.xlsx')
    mk_data_file_v2 = os.path.join(data_file, 'MK2206_calculations - v2.xlsx')
    azd_data_file_v3 = os.path.join(data_file, 'AZD_calculations - v3.xlsx')
    mk_data_file_v3 = os.path.join(data_file, 'MK2206_calculations - v3.xlsx')

    azd_v2 = GetData(azd_data_file_v2).get_data()
    mk_v2 = GetData(mk_data_file_v2).get_data()
    azd_v3 = GetData(azd_data_file_v3).get_data()
    mk_v3 = GetData(mk_data_file_v3).get_data()

    azd = add_v3_to_v2_data(azd_v2, azd_v3)
    ##tests
    assert azd.loc['ERK-pT202', 'D'][2] == 2.3408405823934477
    assert 'S6K-pT389' in azd.index.get_level_values(0)

    mk = add_v3_to_v2_data(mk_v2, mk_v3)
    ##tests
    assert mk.loc['ERK-pT202', 'D'][2] == 0.45171227837786126, mk.loc['ERK-pT202', 'D'][2]
    assert 'S6K-pT389' in mk.index.get_level_values(0)

    azd_fname = os.path.join(mra_data_dir, 'azd_data_with_repeats.csv')
    mk_fname = os.path.join(mra_data_dir, 'mk_data_with_repeats.csv')
    azd.to_csv(azd_fname)
    mk.to_csv(mk_fname)

    azd_means_fname = os.path.join(mra_data_dir, 'azd_means.csv')
    mk_means_fname = os.path.join(mra_data_dir, 'mk_means.csv')

    azd_sd_fname = os.path.join(mra_data_dir, 'azd_sd.csv')
    mk_sd_fname = os.path.join(mra_data_dir, 'mk_sd.csv')



    azd_stats = do_stats(azd)
    mk_stats = do_stats(mk)

    dct = {}
    azd_mra_data = configure_for_mra(azd_stats['mean'])
    azd_mra_err = configure_for_mra(azd_stats['sd'])
    mk_mra_data = configure_for_mra(mk_stats['mean'])
    mk_mra_err = configure_for_mra(mk_stats['sd'])


    azd_mra_data_fname = os.path.join(mra_data_dir, 'azd1_25_data.csv')
    mk_mra_data_fname = os.path.join(mra_data_dir, 'mk1_25_data.csv')

    azd_mra_err_fname = os.path.join(mra_data_dir, 'azd1_25_err.csv')
    mk_mra_err_fname = os.path.join(mra_data_dir, 'mk1_25_err.csv')


    # mra_data = azd_mra_data
    # mra_err = azd_mra_err
    # print(mk_mra_data)
    # print(mra_data)

    # mra_data = pandas.concat([azd_mra_data, mk_mra_data])
    # mra_err= pandas.concat([azd_mra_err, mk_mra_err])

    # print(mra_data)

    azd_mra_data.to_csv(azd_mra_data_fname)
    azd_mra_err.to_csv(azd_mra_err_fname)

    mk_mra_data.to_csv(mk_mra_data_fname)
    mk_mra_err.to_csv(mk_mra_err_fname)

    # print(azd_mra_data)

    # azd_stats['mean'].to_csv(azd_means_fname)
    # azd_stats['sd'].to_csv(azd_sd_fname)
    # mk_stats['mean'].to_csv(mk_means_fname)
    # mk_stats['sd'].to_csv(mk_sd_fname)















