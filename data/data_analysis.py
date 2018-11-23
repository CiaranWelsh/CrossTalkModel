import os, glob, pandas, numpy
import seaborn
import matplotlib.pyplot as plt
from scipy.stats import ttest_ind

seaborn.set_context(context='talk')
seaborn.set_style('white')


def parse_data(data_file):
    data = pandas.read_excel(data_file, sheet='data')

    data = data.drop(['Original Description', 'New Description', 'Time (min)', 'Donor'], axis=1)
    data['Time (h)'] = data['Time (h)'] * -1
    # data['Time (h)'] = data['Time (min)'] + 4320
    # data['Time (min)'] = (data['Time (min)'] + 4320) / 60

    new_order = [
        'Antibody',
        'Donor ID',
        'Condition ID',
        'DMSO',
        'TGFB',
        'Everolimus',
        'AZD',
        'MK',
        # 'Original Time (hin)',
        # 'Time (min)',
        'Time (h)',
        'Raw Data',
        'GAPDH',
    ]

    # ##get list of unique antibodies
    # antibodies = data['Antibody'].unique()
    # print(antibodies)

    data = data[new_order]
    data = data.set_index(new_order[:-2])
    return data


def plot_raw_gapdh(data):
    assert 'GAPDH' in data.columns
    print(data)
    data = numpy.log10(data)
    data = data.reset_index()
    fig = plt.figure()
    seaborn.boxplot(x='Condition ID', y='GAPDH', data=data)
    plt.ylabel('$Log_{10}(AU)$')
    plt.xticks(rotation=90, fontsize=14)
    seaborn.despine(fig, top=True, right=True)
    plt.title('Distribution of GAPDH Raw Intensities\nPer Condition')
    fname = os.path.join(graph_dir, 'raw_gapdh_distributions.png')
    plt.savefig(fname, dpi=150, bbox_inches='tight')
    plt.show()


def plot_raw_data(data):
    assert 'GAPDH' in data.columns
    print(data)
    data = numpy.log10(data)
    data = data.reset_index()
    fig = plt.figure()
    seaborn.boxplot(x='Condition ID', y='Raw Data', data=data)
    plt.ylabel('$Log_{10}(AU)$')
    plt.xticks(rotation=90, fontsize=14)
    seaborn.despine(fig, top=True, right=True)
    plt.title('Distribution of Raw Intensities \nPer Condition')
    fname = os.path.join(graph_dir, 'raw_combined_antibody_distributions.png')
    plt.savefig(fname, dpi=150, bbox_inches='tight')
    plt.show()


def normalise(data_raw):
    """
    Takes outout from parse and normalise the data
    :param data_raw:
    :return:
    """
    df_dct = {}
    for label, df in data_raw.groupby(level=['Antibody', 'Donor ID']):
        # print(label)
        df2 = df.loc[label]
        df2['Raw Data'] = df2['Raw Data'] / df2['Raw Data'].mean()
        df2['GAPDH'] = df2['GAPDH'] / df2['GAPDH'].mean()
        df2['Normed to average'] = df2['Raw Data'] / df2['GAPDH']

        # df2['Norm Data'] = df2['Raw Data'] / df2['GAPDH']
        # df2['Normed to average'] = df2['Norm Data'] / df2['Norm Data'].mean()
        df_dct[label] = df2

    data = pandas.concat(df_dct)
    data.index = data.index.rename(level=[0, 1], names=['Antibody', 'Donor ID'])
    saved_index = data.index
    data = data.reset_index()
    # print(data)
    azd = data[data['Donor ID'].isin([1, 2, 3, 4, 5])]
    mk = data[data['Donor ID'].isin([6, 7, 8, 9, 10])]
    cols = list(azd.columns)
    azd = azd.set_index(cols[:-4])
    mk = mk.set_index(cols[:-4])

    x = 'DMSO TGFB Everolimus AZD MK'.split(' ')
    azd.reset_index(x, inplace=True)
    azd = azd.drop(x, axis=1)
    mk.reset_index(x, inplace=True)
    mk = mk.drop(x, axis=1)

    azd = azd.drop('Time (h)', axis=1)
    mk = mk.drop('Time (h)', axis=1)

    return azd, mk


# fname = os.path.join(working_directory, 'df.xlsx')

def barplots(data_normed, save_dir=None):
    """
    Takes output of normalise() and plots graphs per antibody
    :param data_normed:
    :return:
    """
    if save_dir is not None:
        os.makedirs(save_dir) if not os.path.isdir(save_dir) else None

    antibodies = sorted(list(set(data_normed.index.get_level_values(0))))
    import matplotlib.colors
    colors = ["red", "gold", "limegreen"]
    cmap = matplotlib.colors.ListedColormap(colors)
    for a in antibodies:
        # a = 'Akt-pT308'
        df = data_normed.loc[a]
        df = df.reset_index()
        fig = plt.figure()

        seaborn.barplot(
            x='Condition ID',
            y='Normed to average',
            data=df,
            palette=['yellow'] * 2 + ['white'] * 1 + ['red'] * 4 + ['green'] * 4,
            linewidth=2,
            edgecolor='black',
            errcolor='black',
            errwidth=2,
            capsize=0.2

            # hue='AZD'
        )
        plt.title(a)
        plt.xticks(rotation=90)
        # plt.legend(loc=(1, 0.1))
        plt.ylabel('Normalised \nIntensity (AU)')
        plt.xlabel('')
        seaborn.despine(fig=fig, top=True, right=True)

        if save_dir is not None:
            fname = os.path.join(save_dir, a.replace('/', '_'))
            fig.savefig(fname, dpi=150, bbox_inches='tight')

    plt.show()


def t_test(data, antibody1, condition1, antibody2, condition2):
    data1 = data.xs((antibody1, condition1), level=(0, 2))['Normed to average'].dropna()
    data2 = data.xs((antibody2, condition2), level=(0, 2))['Normed to average'].dropna()
    print(antibody1, data1)
    print(antibody2, data2)
    return ttest_ind(data1, data2)


def plot_erk_repeats_by_condition(erk_azd_data, save_dir=None):
    """
    I've noticed that biological repeat 3 from erk antibody
    in the AZD dataset may be an anomoly. This function plots some graphs
    to show what I mean.
    :param erk_azd_data:
    :return:
    """
    erk_azd = azd.xs(['ERK-pT202'])
    erk_azd = erk_azd.reset_index()
    if save_dir is not None:
        os.makedirs(save_dir) if not os.path.isdir(save_dir) else None
    for label, df in erk_azd.groupby('Condition ID'):
        fig = plt.figure()
        seaborn.barplot(data=df, x='Condition ID', y='Normed to average', hue='Donor ID')
        seaborn.despine(fig, top=True, right=True)
        plt.xticks(rotation=90)
        plt.xlabel('')
        plt.title('AZD, ERK, {}'.format(label))
        fname = os.path.join(save_dir, "{}.png".format(label))
        plt.legend(loc=(1, 0.1))
        fig.savefig(fname, dpi=150, bbox_inches='tight')


if __name__ == '__main__':
    working_directory = r'D:\MesiSTRAT\CrossTalkModel\data'
    data_file = os.path.join(working_directory, 'all_data.xlsx')
    graph_dir = os.path.join(working_directory, 'Graphs')
    azd_data_file = os.path.join(working_directory, 'azd.xlsx')
    mk_data_file = os.path.join(working_directory, 'mk.xlsx')
    temp_file = os.path.join(working_directory, 'temp_df.xlsx')

    data_raw = parse_data(data_file)
    data_raw.to_excel(os.path.join(working_directory, 'data.xlsx'))

    azd, mk = normalise(data_raw)

    azd_average_dir = os.path.join(graph_dir, 'AZD')
    mk_average_dir = os.path.join(graph_dir, 'MK')

    ## wait until you have agreement that this repeat should be removed
    ## before including it in the parse data function.
    azd.loc['ERK-pT202', 3] = numpy.nan
    # print(azd.loc['ERK-pT202', 3] )
    # barplots(azd, azd_average_dir)
    # barplots(mk, mk_average_dir)
    # print(mk)
    # smad2_d = (mk.xs((), level=(0, 2)))

    smad2 = 'SMAD2-pS465-467'
    erk = 'ERK-pT202'
    # erk_plots_dir = os.path.join(graph_dir, 'AzdErkPlots')
    # plot_repeats_by_condition(azd, erk_plots_dir)

    t_test()


































