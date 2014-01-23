#!/usr/bin/env python
"""Load and analyze results from FCSys_.

This module provides direct access to the most important functions and classes
from its submodules.  These are:

- Basic supporting classes and functions: :meth:`base.add_arrows`,
  :meth:`base.add_hlines`, :meth:`base.add_vlines`, :meth:`base.animate`,
  :class:`base.ArrowLine`, :meth:`base.closeall`, :meth:`base.figure`,
  :meth:`base.load_csv`, :meth:`base.save`, :meth:`base.saveall`, :meth:`base.setup_subplots`

- To manage simulation experiments:  :class:`exps.Experiment`,
  :meth:`exps.gen_experiments`, :class:`exps.ParamDict`,
  :meth:`exps.read_params`, :meth:`exps.run_models`, :meth:`exps.write_params`,
  :meth:`exps.write_script`

- To handle multiple files at once: :meth:`multi.multiload`,
  :meth:`multi.multiplot`

- For simulation results: :class:`fcsimres.FCSimRes`, :class:`simres.SimRes`,
  :meth:`fcsimres.gen_subtitle_conditions`

- To label numbers and quantities: :meth:`texunit.label_number`,
  :meth:`texunit.label_quantity`, :meth:`texunit.unit2tex`

.. _Modelica: http://www.modelica.org/
.. _FCSys: http://kdavies4.github.com/FCSys/
"""
__author__ = "Kevin Davies"
__email__ = "kdavies4@gmail.com"
__copyright__ = "Copyright 2010-2013, Georgia Tech Research Corporation"


import sys


# Check the Python version.
major, minor1, minor2, s, tmp = sys.version_info
if not (major == 2 and minor1 == 7):
    raise ImportError('Currently, fcres requires Python 2.7.')
# TODO:  Add support for Python 3.x once wx supports it.


# All functions and classes
#__all__ = ['simres', 'fcsimres', 'modelicares']


# Essential functions and classes
#
# These will be available directly from fcres; others must be loaded from their
# submodules.
#
# From modelicares:
from modelicares.base import (add_arrows, add_hlines, add_vlines, animate,
    ArrowLine, closeall, figure, load_csv, save, saveall, setup_subplots)
from modelicares.exps import (Experiment, gen_experiments, ParamDict,
    read_params, run_models, write_params, write_script)
import modelicares.exps.doe as doe
from modelicares.multi import multiload, multiplot, multibode, multinyquist
from modelicares.texunit import label_number, label_quantity, unit2tex
#
# Local:
from simres import SimRes
from fcsimres import FCSimRes, annotate_conditions
