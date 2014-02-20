#!/usr/bin/python
"""Create sample plots from the baseline polarization test.
"""

import matplotlib.pyplot as plt

from matplotlib.offsetbox import AnchoredOffsetbox, TextArea, VPacker
from matplotlib.sankey import Sankey
from modelicares import figure, save
from fcres import SimRes
from matplotlib import rcParams

# Load the data.
sim = SimRes('../'*6 + 'baseline.mat')

# Create some unit conversion functions.
A = sim.to_unit('A')
Apercm2 = sim.to_unit('A/cm2')
W = sim.to_unit('W')
V = sim.to_unit('V')

# Determine the maximum current density
Jmax = max(sim.get_values('J', f=Apercm2))

# Temperature
sim.plot(label='temperature', xname='J',
         title="Temperature throughout the Cell\nBaseline Conditions",
         ynames1=["cell.anFP.subregions[1, 1, 1].gas.H2O.T",
                  "cell.anFP.subregions[1, 1, 1].liquid.H2O.T",
                  "cell.anFP.subregions[1, 1, 1].graphite.'C+'.T",
                  "cell.anGDL.subregions[1, 1, 1].graphite.'C+'.T",
                  "cell.anCL.subregions[1, 1, 1].graphite.'C+'.T",
                  "cell.PEM.subregions[1, 1, 1].ionomer.'SO3-'.T",
                  "cell.caCL.subregions[1, 1, 1].graphite.'C+'.T",
                  "cell.caGDL.subregions[1, 1, 1].graphite.'C+'.T",
                  "cell.caFP.subregions[1, 1, 1].gas.H2O.T",
                  "cell.caFP.subregions[1, 1, 1].liquid.H2O.T",
                  "cell.caFP.subregions[1, 1, 1].graphite.'C+'.T"],
         legends1=["anFP gas", "anFP liquid", "anFP graphite", 
                   "anGDL", 
                   "anCL",
                   "PEM",
                   "caCL",
                   "caGDL",
                   "caFP gas", "caFP liquid", "caFP graphite"],
         leg1_kwargs=dict(ncol=2, loc='upper left'), yunit1='degC')
plt.xlim(xmax=Jmax)
plt.ylim(59.5, 66)
save()
plt.close()

# O2 pressure
sim.plot(label='pressure-O2', xname='J',
         title='$O_2$ Pressure from the Inlet to the ORR\nBaseline Conditions',
         ynames1=["cell.caFP.subregions[1, 1, 1].gas.O2.boundaries[2, 1].p",
                  "cell.caFP.subregions[1, 1, 1].gas.O2.p",
                  "cell.caGDL.subregions[1, 1, 1].gas.O2.boundaries[1, 1].p",
                  "cell.caGDL.subregions[1, 1, 1].gas.O2.p",
                  "cell.caCL.subregions[1, 1, 1].gas.O2.boundaries[1, 1].p",
                  "cell.caCL.subregions[1, 1, 1].gas.O2.p"],  
         leg1_kwargs=dict(loc='upper left'),
         legends1=["Inlet", 
                   "caFP",
                   "caFP-caGDL interface",
                   "caGDL",
                   "caGDL-caCL interface",
                   "caCL/ORR"])
plt.xlim(xmax=Jmax)
plt.ylim(ymax=60)
save()
plt.close()

# Losses
sim.plot(label='losses', xname='J', ylabel1="Potential difference",
         title="Potential Losses\nBaseline Conditions",
         ynames1=["Deltaw_an", "Deltaw_ca", "'Deltaw_e-'", "'Deltaw_H+'",          
                  "Deltaw_H2", "Deltaw_O2", "Deltaw_H2O"],
         legends1=["Anode overpotential",
                   "Cathode overpotential",
                   "Electronic conduction",
                   "Protonic conduction",
                   "$H_2$ transport (inlet to HOR)",
                   "$O_2$ transport (inlet to ORR)",
                   "$H_2O$ transport (ORR to outlet)"], 
         leg1_kwargs=dict(loc='upper center', ncol=2))
plt.xlim(xmax=Jmax)
plt.ylim(-0.02, 0.7)
save()
plt.close()

# Energy Sankey
#
# Settings
get = sim.get_values_at_times
def get_values(time):
    values = []
    negV = lambda x: -V(x)
    values.append(get("w", f=negV, times=time)*get("zI", f=A, times=time))
    values.append(get("cell.caFP.xPositive[1, 1].graphite.'C+'.Qdot", f=W, times=time))
    values.append(get("cell.anFP.subregions[1, 1, 1].gas.H2O.Hprimedot[2, 1]", f=W, times=time) 
                + get("cell.anFP.subregions[1, 1, 1].gas.H2O.Hprimedot[2, 2]", f=W, times=time))
    values.append(get("cell.anFP.xNegative[1, 1].graphite.'C+'.Qdot", f=W, times=[time]))
    values.append(get("cell.caFP.subregions[1, 1, 1].gas.H2O.Hprimedot[2, 1]", f=W, times=time) 
                + get("cell.caFP.subregions[1, 1, 1].gas.H2O.Hprimedot[2, 2]", f=W, times=time))
    values.append(get("cell.caFP.subregions[1, 1, 1].gas.N2.Hprimedot[2, 1]", f=W, times=time) 
                + get("cell.caFP.subregions[1, 1, 1].gas.N2.Hprimedot[2, 2]", f=W, times=time))
    values.append(get("cell.caFP.subregions[1, 1, 1].liquid.H2O.Hprimedot[2, 1]", f=W, times=time) 
                + get("cell.caFP.subregions[1, 1, 1].liquid.H2O.Hprimedot[2, 2]", f=W, times=time))
    values.append(get("cell.anFP.subregions[1, 1, 1].liquid.H2O.Hprimedot[2, 1]", f=W, times=time) 
                + get("cell.anFP.subregions[1, 1, 1].liquid.H2O.Hprimedot[2, 2]", f=W, times=time))
    values.append(get("cell.anFP.subregions[1, 1, 1].gas.H2.Hprimedot[2, 1]", f=W, times=time) 
                + get("cell.anFP.subregions[1, 1, 1].gas.H2.Hprimedot[2, 2]", f=W, times=time))
    values.append(get("cell.caFP.subregions[1, 1, 1].gas.O2.Hprimedot[2, 1]", f=W, times=time) 
                + get("cell.caFP.subregions[1, 1, 1].gas.O2.Hprimedot[2, 2]", f=W, times=time))
    return values
labels=["", 
        "ca", 
        "$H_2O_g$ an", 
        "an", 
        "$H_2O_g$ ca", 
        "$N_2$ ca", 
        "$H_2O_l$ ca", 
        "$H_2O_l$ an", 
        "$H_2$ an", 
        "$O_2$ ca"]
colors = ['g', 'r', 'b', 'r', 'b', 'b', 'b', 'b', 'b', 'b']
orientations = [0, -1, 1, 1, -1, -1, -1, 1, 1, -1]
left = rcParams['figure.subplot.left']
right = rcParams['figure.subplot.right']
bottom = rcParams['figure.subplot.bottom']
rcParams['figure.subplot.left'] = 0.02
rcParams['figure.subplot.right'] = 0.98
rcParams['figure.subplot.bottom'] = 0.02
time = 18180
#
# Set up.
fig = figure('energy')
ax = fig.add_subplot(1, 1, 1, xticks=[], yticks=[],
                     title="Energy Balance\nBaseline Conditions @ %g $A/cm^2$"
                     % sim.get_values_at_times('J_Apercm2', times=time))
#
# Create the Sankey diagram.
[sankey] = Sankey(ax=ax, patchlabel="PEMFC",
                  scale=0.002, trunklength=0.5, format='%.1f', unit='W', 
                  flows=get_values(time),
                  labels=labels,
                  orientations=orientations).finish()
for t, color in zip(sankey.texts, colors):
    t.set_color(color)
#
# Add the key.
texts = [('Key:', 'k'), 
         ('Thermal cond.', 'r'),
         ('Fluid', 'b'),
         ('Electrical', 'g')]
box = VPacker(children=[TextArea(t, textprops=dict(color=c)) for t, c in texts],
              align="left",
              pad=0, sep=6)
anchored_box = AnchoredOffsetbox(loc=2, child=box, pad=0.8, frameon=True,
                                 bbox_to_anchor=(0.006, 0.99),
                                 bbox_transform=ax.transAxes)
ax.add_artist(anchored_box)
#
# Annotate.
x = list(plt.xlim())
x = [x[0] - 0.2, x[1] - 0.2]
plt.xlim(x)
x = [x[0] + 0.1, x[0] + 0.5]
plt.plot(x, [0, 0], 'k:')
plt.text(sum(x)/2, 0.03, "Anode", ha="center", va="bottom")
plt.text(sum(x)/2, -0.03, "Cathode", ha="center", va="top")
#
# Finish.
save()

