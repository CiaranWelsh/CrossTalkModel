import os, glob, pandas


fname = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles'


files = glob.glob(os.path.join(fname, '*.csv'))


df_l = {}
for i in files:
    df = pandas.read_csv(i)
    df = df.rename(columns={'pSmad2': 'pSmad2IsIgnored'})
    df.to_csv(i, index=False)
    # print(df)
#     df_l[os.path.split(i)[1]] = df.iloc[6]
#
# df = pandas.concat(df_l, axis=1)
# print(df.transpose())
# stats = df.transpose().describe()[['pSmad2', 'pAkt', 'ppErk', 'pS6K']]
# print(stats)
# max = stats.loc['max']
#
# print(max)
























