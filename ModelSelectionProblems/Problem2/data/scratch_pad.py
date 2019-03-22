import matplotlib.pyplot as plt
from matplotlib import gridspec

time = [0, 1, 2, 3, 4]
y1 = list(range(10, 15))
y2 = list(range(15, 20))

plt.figure()
fig = gridspec.GridSpec(2, 1, height_ratios=[1, 1])

x1 = plt.subplot(fig[0])
plt.plot(time, y1)

x1 = plt.subplot(fig[1])
plt.plot(time, y2)

plt.show()









