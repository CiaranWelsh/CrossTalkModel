import os, glob, pandas


fname = r'/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles'


files = glob.glob(os.path.join(fname, '*.csv'))

for i in files:
    df = pandas.read_csv(i)
    df.to_csv(i, sep='\t', index=False)
    print("{} converted to tab separated".format(i))

































