#!/usr/bin/python
"""Plot polarization curves with varying temperature.
"""

import matplotlib.pyplot as plt

from modelicares import save, label_quantity
from fcres import SimRes, annotate_conditions, multiplot

# Specify the baseline conditions.
conditions = dict(T = (60, 'degC'),
                  p = (48.3, 'kPag'),
                  n_O2 = (21, '%'),
                  anInletRH = (80, '%'),
                  caInletRH = (50, '%'),
                  anStoich = (1.5, '1'),
                  caStoich = (2.0, '1'))

                  
# Settings
files = ['../'*6 + 'baseline.mat',
         '../'*6 + '40C.mat',
         '../'*6 + '80C.mat']
variable = 'environment.T' # Varied parameter
unit = 'degC' # Display unit for the varied parameter
baseline = 1 # Index of the baseline simulation (after sorting)

# Load and sort the results.
sims = map(SimRes, files)
vals = [sim.get_IV(variable, sim.to_unit(unit)) for sim in sims]
vals, sims = zip(*sorted(zip(vals, sims)))

# Plot
labels = [label_quantity(round(val), unit) for val in vals]
labels[baseline] += " (baseline)"
multiplot(sims, xname='J', ynames1=['w'], label='polarization-temperature',
          title = 'Cell Polarization: Varying Inlet and Flow Plate Temperature\n'
                  + annotate_conditions(conditions, temp=False),
          legends1=[''], suffixes=[label for label in labels], 
          use_paren=False, leg1_kwargs=dict(loc='upper right'))
plt.legend()
plt.xlim(xmax=2.25)
plt.ylim(ymax=1.2)
save()
