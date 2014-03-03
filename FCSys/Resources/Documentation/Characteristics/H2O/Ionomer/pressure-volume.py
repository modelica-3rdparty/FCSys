#!/usr/bin/python
"""Determine a pressure-volume relationship of absorbed H2O that results in the
[Springer1991] hydration as a function of activity.
"""

import numpy as np

from scipy import integrate
from pint import UnitRegistry

U = UnitRegistry()


## Define functions

# Membrane hydration as a function of water vapor activity [Springer1991]
lambda_ = lambda a: 0.043 + 17.81*a - 39.85*a**2 + 36*a**3

# Specific volume of H2O in the membrane as a function of membrane hydration
v = lambda lambda_: (1044.214 - 1.007)/(2*lambda_)*U.cm**3/U.mole

# Gibbs potential of H2O vapor as a function of activity
g = lambda a: (0.02612*np.log(a*0.042469) - 3.10057)*U.V

# Partial derivative of pressure at constant temperature as a function of 
# specific volume and the derivative of Gibbs potential
delp_T = lambda v, dg: dg/v

phi = 1*U.cm/U.s
print phi
print(phi.dimensionality)
print phi*U.min
print phi**2

exit()

#
#p = lambda : delp_T(v=, dg=)


integrate.quad(delp_T, x1, x2)


# Calculate the values.
a = np.linspace(0, 1, 101)
lambda_ = map(lambda_, a)
v = map(v, lambda_)



