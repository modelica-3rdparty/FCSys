#!/usr/bin/python
"""Plot results of the cell model under sinuosoidal load.
"""

import matplotlib.pyplot as plt

from modelicares import save
from fcres import SimRes

# Load the results.
sim = SimRes('../'*6 + 'cycle.mat')

# Polarization
sim.plot(label='cycle-polarization', xname='J', ynames1=['w'],
         title="Cell Potential under Sinuosoidal Load\n", legends1=None)
plt.annotate("Start", xy=(0.08, 1.2), xycoords="data",
             xytext=(0.1, 1.3), 
             va="top", ha="center",
             bbox=dict(boxstyle="round", fc="w"),
             arrowprops=dict(arrowstyle="->"))
plt.ylim(0.7, 1.5)
plt.grid()
save()
plt.close()

# Pore saturation
sim.plot(label='cycle-saturation', 
         title='Liquid Pore Saturation throughout the Cell\nBaseline Conditions, Sinuosoidal Load',
         ynames1=["cell.anFP.subregions[1, 1, 1].volume.x",
                  "cell.anGDL.subregions[1, 1, 1].volume.x",
                  "cell.anCL.subregions[1, 1, 1].volume.x",
                  "cell.caCL.subregions[1, 1, 1].volume.x",
                  "cell.caGDL.subregions[1, 1, 1].volume.x",
                  "cell.caFP.subregions[1, 1, 1].volume.x"], yunit1='%',
         leg1_kwargs=dict(loc='upper center', ncol=3),
         legends1=["anFP",
                   "anGDL",
                   "anCL",
                   "caCL",
                   "caGDL",
                   "caFP"])
plt.xlim(xmax=9)
plt.ylim(ymax=0.7)
save()