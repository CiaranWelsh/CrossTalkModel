import os, glob, pandas, numpy
import seaborn
import matplotlib.pyplot as plt
seaborn.set_context(context='talk')
seaborn.set_style('white')


def parse_data(data_file):

    data = pandas.read_excel(data_file, sheet='data')

    data = data.drop(['Original Description', 'New Description', 'Time (min)', 'Donor'], axis=1)
    data['Time (h)'] = data['Time (h)']*-1
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

def PlotErkAt1_25(data_raw):

    df = data_raw.sort_values('Raw Data').copy()
    erk = df.xs('ERK-pT202', level=1)
    erk = erk.xs(1.25, level='Time (h)')
    erk = erk.xs('T_A_1.25', level='Condition ID')
    # erk = numpy.log10(erk)
    erk = erk.reset_index()
    print(erk)

    fig = plt.subplot(211)
    ax1 = plt.subplot(2, 1, 1)
    seaborn.barplot(data=erk, x='Donor ID', y='Raw Data')
    seaborn.despine(ax=ax1, top=True, right=True)
    plt.title('ERK')
    ax2 = plt.subplot(2, 1, 2)
    seaborn.barplot(data=erk, x='Donor ID', y='GAPDH')
    plt.title('GAPDH')
    seaborn.despine(ax=ax2, top=True, right=True)
    #
    plt.suptitle("ERK-pT202 in AZD Minus Everolimus \nfor 1.25h")
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
            palette=['yellow']*2+['white']*1+['red']*4+['green']*4,
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

    #
    # fname = os.path.join(working_directory, 'akt_df.xlsx')
    # df = df.set_index(['Donor ID', 'Condition ID'])
    # df.to_excel(fname)


if __name__ == '__main__':
    working_directory = r'D:\MesiSTRAT\CrossTalkModel\data'
    data_file = os.path.join(working_directory, 'all_data.xlsx')
    graph_dir = os.path.join(working_directory, 'Graphs')
    azd_data_file = os.path.join(working_directory, 'azd.xlsx')
    mk_data_file = os.path.join(working_directory, 'mk.xlsx')

    data_raw = parse_data(data_file)
    data_raw.to_excel(os.path.join(working_directory, 'data.xlsx'))

    azd, mk = normalise(data_raw)
    print(azd)
    # azd.to_excel(azd_data_file)
    # mk.to_excel(mk_data_file)
    # azd = pandas.read_excel(azd_data_file)
    # mk = pandas.read_excel(mk_data_file)


    azd_average_dir = os.path.join(graph_dir, 'AZD')
    mk_average_dir = os.path.join(graph_dir, 'MK')
    # barplots(azd, azd_average_dir)
    # barplots(mk, mk_average_dir)

    print(azd)




    # # print(data_raw)
    #
    #
    #
    #     # print(df)
    # plt.show()

    # print(df.to_excel(fname))
        # print(df2['Norm Data'].median())
        # df2 = df2.reset_index()
        # plt.figure()
        # seaborn.barplot(x='Condition ID', y='Norm Data', data=df2)
    # plt.show()
    #


    # data_norm = pandas.DataFrame(data_raw['Raw Data'] / data_raw['GAPDH'])
    # data_norm.columns = ['Data Norm']
    # print(data_norm)
    # print(data_norm.pivot_table(values='Data Norm', index=['Antibody', 'Donor ID'], columns=['Condition ID']))
    # data_norm = data_norm.unstack(level='Condition ID')
    # smad2 = data_norm.loc['SMAD2-pS465-467']
    # print(smad2)

    # data_norm = data_norm.reset_index()
    # smad2 = data_norm[data_norm['Antibody'] == 'SMAD2-pS465-467']

    # smad2 = smad2.unstack(level='Condition ID')
    # print(smad2)

    # fig = plt.figure()
    # seaborn.barplot(data=smad2, x='Condition ID', y='Data Norm', units='Donor ID')
    # plt.xticks(rotation=90)
    # plt.show()

    '''
    Plot distributions for each gel
    '''

    # plot_raw_gapdh(data_raw)

    # plot_raw_data(data_raw)
    # print(data_raw)
    # print(data_raw.loc['Condition ID' == 'T_A_1.25'])
    # df = data_raw.xs('T_A_1.25', level=2)
    # df = df.sort_values('Raw Data')



    # PlotErkAt1_25(data_raw)
    # print(df)


























