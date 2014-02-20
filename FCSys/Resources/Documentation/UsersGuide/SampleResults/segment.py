#!/usr/bin/python
"""Plot polarization curves from the segmented cell model.
"""

import matplotlib.pyplot as plt

from itertools import cycle
from modelicares import save, label_number, figure
from fcres import SimRes, annotate_conditions

# Specify the baseline conditions.
conditions = dict(T = (60, 'degC'),
                  p = (48.3, 'kPag'),
                  n_O2 = (21, '%'),
                  anInletRH = (80, '%'),
                  caInletRH = (50, '%'),
                  anStoich = (1.5, '1'),
                  caStoich = (2.0, '1'))

# Settings
colors = ['b', 'g', 'r', 'c', 'm', 'y', 'k']
dashes = [(None, None), (3, 3), (1, 1), (3, 2, 1, 2)]

# Load the results.
sim = SimRes('../'*6 + 'segment.mat')

# Establish some units.
V = sim.to_unit('V')
A = sim.to_unit('A')
cm2 = sim.to_unit('cm2')
Apercm2 = sim.to_unit('A/cm2')

# Plot
figure('segment-polarization')
n_y = sim.get_IV('cell.n_y')
plt.title('Segment Current Densities @ Fixed Flow\n'
          + annotate_conditions(conditions))
w = sim.get_values('w', f=V)
plt.plot(w, sim.get_values('J', f=Apercm2), 'k', label='Net', lw=2)
c = cycle(colors)
d = cycle(dashes)
area = sim.get_IV('cell.anFP.subregions[1, 1, 1].A[1]', f=cm2)
for i in range(n_y):
    J = sim.get_values("cell.anFP.xPositive[%i, 1].graphite.'e-'.Ndot" % (i+1), 
                       f=A)/area
    plt.plot(w, J, label='Segment ' + str(i+1), 
             color=c.next(), dashes=d.next())
plt.legend()
plt.xlabel(label_number('Potential', 'V'))
plt.ylabel(label_number('Current density', 'A/cm2'))
plt.xlim(min(w), 1.2)
plt.ylim(ymax=2.3)
save()
