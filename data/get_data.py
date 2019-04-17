"""
A script to extract data from the excel files
that were gives to me by Kathrin's lab into a usage format

"""

import pandas, os, glob
import xlrd
import numpy
import matplotlib.pyplot as plt
import seaborn

class GetData:
    new_names = {
        'D': 'DMSO',
        'T': 'TGFB',
        'E': 'TGFB +Everolimus',
        'EA72': 'TGFB + Everolimus+ AZD 3',
        'EA48': 'TGFB + Everolimus+ AZD 2',
        'EA24': 'TGFB + Everolimus+ AZD 1',
        'EA1.25': 'TGFB + Everolimus+ AZD 30 mins',
        'A72': 'TGFB + AZD 3',
        'A48': 'TGFB + AZD  2',
        'A24': 'TGFB + AZD 1',
        'A1.25': 'TGFB + AZD 30mins',
        'EM72': 'TGFB + Everolimus+ MK 3',
        'EM48': 'TGFB + Everolimus+ MK2',
        'EM24': 'TGFB + Everolimus+ MK 1',
        'EM1.25': 'TGFB + Everolimus+ MK30 mins',
        'M72': 'TGFB + MK 3',
        'M48': 'TGFB + MK 2',
        'M24': 'TGFB + MK 1',
        'M1.25': 'TGFB + MK 30mins',
    }
    new_names = {v: k for k, v in new_names.items()}

    col_indices = [1, 3, 5, 7]

    def __init__(self, workbook):
        self.workbook = xlrd.open_workbook(workbook)

    def get_sheet_names(self):
        return self.workbook.sheet_names()

    def get_data_from_sheet(self, sheet):
        sheet = self.workbook.sheet_by_name(sheet)
        names = sheet.col_slice(0, 30, 41)

        data = [sheet.col_slice(i, 30, 41) for i in self.col_indices]

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

    data.columns = ['DV:' + i for i in data.columns]
    data['DA:ALL'] = 0

    tr = ['TGFb', 'Everolimus', 'AZD', 'MK']
    treatment_names = ['TGFb', 'mTORC1i', 'Meki', 'Akti']
    treatment_names = ['TR:' + i for i in treatment_names]
    treatments = {
        'D': [0, 0, 0, 0],
        'T': [1, 0, 0, 0],
        'E': [1, 1, 0, 0],
        'EM1.25': [1, 1, 1, 0],
        'EA1.25': [1, 1, 0, 1],
    }
    tr_df = pandas.DataFrame(treatments, index=treatment_names).transpose()
    return pandas.concat([tr_df, data], sort=False, axis=1)

def combine_two_datasets(azd_file, mk_file):
    # azd_v2 = GetData(azd_data_file_v2).get_data()
    # mk_v2 = GetData(mk_data_file_v2).get_data()
    azd_v3 = GetData(azd_file).get_data()
    mk_v3 = GetData(mk_file).get_data()

    azd_v3 = azd_v3.replace('', numpy.nan)
    mk_v3 = mk_v3.replace('', numpy.nan)
    # azd_v3 = azd_v3 * 10
    # mk_v3 = mk_v3 * 10

    mk_dte = mk_v3[['D', 'T', 'E']]
    mk_dte.reset_index(level=1, inplace=True)
    mk_dte.loc[:, 'level_1'] = mk_dte.loc[:, 'level_1'] + 4
    mk_dte = mk_dte.set_index('level_1', append=True)

    # print(mk_dte)
    mk_v3 = mk_v3.drop(['D', 'T', 'E'], axis=1)
    mk_v3 = pandas.concat([mk_dte, mk_v3], axis=1)
    mk_v3.index.names = ['protein', 'repeat']
    azd_v3.index.names = ['protein', 'repeat']

    # mk_v3.iloc[[0, 1, 2, 3], [0, 1, 2]] = azd_v3.iloc[[0, 1, 2, 3], [0, 1, 2]]

    return mk_v3.combine_first(azd_v3)

def plot_barplot(data, title):
    # seaborn.set_context(context='paper')
    conds = ['D', 'T', 'E', 'A72', 'M72', 'EA72', 'EM72']
    stacked = pandas.DataFrame(data[conds].stack())
    stacked.columns = ['AU']
    fig = plt.figure(figsize=(10, 5))
    seaborn.barplot(data=stacked.reset_index(), hue='condition_code', y='AU', x='protein',
                    n_boot=10000, errcolor='black',
                    errwidth=1, edgecolor='k', capsize=0.04,
                    )
    seaborn.despine(fig=fig, top=True, right=True)
    plt.legend(loc=(1, 0.5))
    plt.xlabel('')
    fname = os.path.join(wd, f'{title}.png')
    plt.title(title)

    plt.savefig(fname, bbox_inches='tight', dpi=300)

    plt.show()

def calc_mean_and_sem(data):
    mean = {}
    se = {}

    for label, df in data.groupby(level=0):
        mean[label] = df.mean()
        se[label] = df.sem()

    mean = pandas.concat(mean, axis=1)
    se = pandas.concat(se, axis=1)
    rename_dct = {
        'Akt-pT308': 'pAkt',
        'ERK-pT202': 'ppErk',
        'S6K-pT389': 'pS6K',
        'SMAD2-pS465-467': 'pSmad2',
    }
    mean = mean.rename(columns=rename_dct)
    se = se.rename(columns=rename_dct)


if __name__ == '__main__':
    wd = os.path.dirname(__file__)
    data_file = os.path.join(wd, 'HardCopy')
    mra_data_dir = os.path.join(wd, 'MRA_data')
    if not os.path.isdir(mra_data_dir):
        os.makedirs(mra_data_dir)

    # azd_data_file_v2 = os.path.join(data_file, 'AZD_calculations - v2.xlsx')
    # mk_data_file_v2 = os.path.join(data_file, 'MK2206_calculations - v2.xlsx')
    azd_data_file_ev = os.path.join(data_file, 'AZD_calculations - v5_norm_to_ev.xlsx')
    mk_data_file_ev = os.path.join(data_file, 'MK2206_calculations - v5_norm_to_ev.xlsx')

    azd_data_file_sum = os.path.join(data_file, 'AZD_calculations - v5_norm_to_sum.xlsx')
    mk_data_file_sum = os.path.join(data_file, 'MK2206_calculations - v5_norm_to_sum.xlsx')

    azd_data_file_max = os.path.join(data_file, 'AZD_calculations - v5_norm_to_max.xlsx')
    mk_data_file_max = os.path.join(data_file, 'MK2206_calculations - v5_norm_to_max.xlsx')

    azd_data_file_av = os.path.join(data_file, 'AZD_calculations - v5_norm_to_average.xlsx')
    mk_data_file_av = os.path.join(data_file, 'MK2206_calculations - v5_norm_to_average.xlsx')

    azd_data_file_dmso = os.path.join(data_file, 'AZD_calculations - v5_norm_to_dmso.xlsx')
    mk_data_file_dmso = os.path.join(data_file, 'MK2206_calculations - v5_norm_to_dmso.xlsx')

    ev_data = combine_two_datasets(azd_data_file_ev, mk_data_file_ev)
    max_data = combine_two_datasets(azd_data_file_max, mk_data_file_max)
    sum_data = combine_two_datasets(azd_data_file_sum, mk_data_file_sum)
    dmso_data = combine_two_datasets(azd_data_file_dmso, mk_data_file_dmso)
    av_data = combine_two_datasets(azd_data_file_av, mk_data_file_av)

    # ev_data = ev_data[['D', 'T', 'E', 'A72', 'M72', 'EA72', 'EM72']]
    # print(ev_data)
    # print(ev_data.loc['Akt-pT308'])

    # print(ev_data)

    # plot_barplot(ev_data, 'Norm to Everolimus Condition')
    # plot_barplot(max_data, 'Norm to Condition with Max Value')
    # plot_barplot(sum_data, 'Norm to Sum of All Conditions')
    # plot_barplot(dmso_data, 'Norm to DMSO Condition')
    # plot_barplot(av_data, 'Norm to Average of All Conditions')

    #
    mean = {}
    se = {}
    c = ['D', 'T', 'E', 'A72', 'M72', 'EA72', 'EM72']
    for label, df in ev_data.groupby(level=0):
        mean[label] = df.mean()
        se[label] = df.sem()

    order = ['Akt-pT308',  'SMAD2-pS465-467', 'ERK-pT202',  'S6K-pT389',  ]
    mean = pandas.DataFrame(mean).loc[c]
    se = pandas.DataFrame(se).loc[c]
    mean = mean[order]
    se = se[order]

    print(mean)

    #
    # mk_mean = pandas.DataFrame(mk_mean)
    # mk_se = pandas.DataFrame(mk_se)
    #
    # print(azd_m)

    dire = '/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data'
    means_fname = os.path.join(dire, 'means.csv')
    se_fname = os.path.join(dire, 'se.csv')



    # print(data)

    mean.to_csv(means_fname)
    se.to_csv(se_fname)
    # mk_mean.to_csv(mk_means_fname)
    # mk_se.to_csv(mk_se_fname)

    # azd = add_v3_to_v2_data(azd_v2, azd_v3)
    # ##tests
    # assert azd.loc['ERK-pT202', 'D'][2] == 2.3408405823934477
    # assert 'S6K-pT389' in azd.index.get_level_values(0)
    #
    # mk = add_v3_to_v2_data(mk_v2, mk_v3)
    # ##tests
    # assert mk.loc['ERK-pT202', 'D'][2] == 0.45171227837786126, mk.loc['ERK-pT202', 'D'][2]
    # assert 'S6K-pT389' in mk.index.get_level_values(0)
    # #
    # azd_fname = os.path.join(mra_data_dir, 'azd_data_with_repeats.csv')
    # mk_fname = os.path.join(mra_data_dir, 'mk_data_with_repeats.csv')
    # azd.to_csv(azd_fname)
    # mk.to_csv(mk_fname)
    #
    #
    #
    #
    # azd_stats = do_stats(azd)
    # mk_stats = do_stats(mk)
    #
    # azd_stats['mean'].to_csv(azd_means_fname)
    # azd_stats['sd'].to_csv(azd_sd_fname)
    # mk_stats['mean'].to_csv(mk_means_fname)
    # mk_stats['sd'].to_csv(mk_sd_fname)
    #
    # #
    # # dct = {}
    # # azd_mra_data = configure_for_mra(azd_stats['mean'])
    # # azd_mra_err = configure_for_mra(azd_stats['sd'])
    # # mk_mra_data = configure_for_mra(mk_stats['mean'])
    # # mk_mra_err = configure_for_mra(mk_stats['sd'])
    # #
    # #
    # azd_mra_data_fname = os.path.join(mra_data_dir, 'azd1_25_data.csv')
    # mk_mra_data_fname = os.path.join(mra_data_dir, 'mk1_25_data.csv')
    #
    # azd_mra_err_fname = os.path.join(mra_data_dir, 'azd1_25_err.csv')
    # mk_mra_err_fname = os.path.join(mra_data_dir, 'mk1_25_err.csv')
    #
    # # azd_stats['mean'].to_csv(azd_means_fname)
    # # azd_stats['sd'].to_csv(azd_sd_fname)
    # # mk_stats['mean'].to_csv(mk_means_fname)
    # # mk_stats['sd'].to_csv(mk_sd_fname)
    # #
    # #
    # # mra_data = azd_mra_data
    # # mra_err = azd_mra_err
    # # print(mk_mra_data)
    # # print(mra_data)
    #
    # # mra_data = pandas.concat([azd_mra_data, mk_mra_data])
    # # mra_err= pandas.concat([azd_mra_err, mk_mra_err])
    #
    # # print(mra_data)
    # #
    # # azd_mra_data.to_csv(azd_mra_data_fname)
    # # azd_mra_err.to_csv(azd_mra_err_fname)
    # #
    # # mk_mra_data.to_csv(mk_mra_data_fname)
    # # mk_mra_err.to_csv(mk_mra_err_fname)
    #
    # # print(azd_mra_data)
