#!/bin/bash
# Check for quantities and references that aren't used in the Modelica code.
#
# Manually temove the unused quantities from FCSys/Resources/quantities.xls and
# update Quantities.mo and FCSys/Resources/Scripts/units.mos.  Remove the unused
# references from package.mo (FCSys.UsersGuide.References).

# Kevin Davies, 7/18/12

# Quantities
# Resistivity is used in Quantities.mo under "Aliases that imply special display units".
# Diffusivity is used in FCSysTest
# The following quantities are used as a result of der() in Dymola:
#   ConcentrationRate, CurrentRate, MassRate, PotentialRate, PressureRate 
for s in  Amount AmountReciprocal Angle Angle2 Area AreaSpecific Capacitance ConductanceElectrical ConductivityElectrical Continuity Current CurrentAreic CurrentAreicAbsolute CurrentRate Density Diffusivity Energy Fluidity Force ForceSpecific Frequency Inductance Length LengthSpecific MagneticFlux MagneticFluxAreic MagneticFluxReciprocal Mass MassRate MassSpecific MassVolumic Mobility MomentumRotational Number NumberAbsolute Permeability Permittivity PermittivityReciprocal Potential PotentialAbsolute PotentialPerWavenumber PotentialRate Power PowerArea PowerAreic PowerAreicPerPotential4 PowerRadiant Pressure PressureAbsolute PressureRate PressureReciprocal Quantity ResistanceElectrical ResistanceFluid Resistivity SurfaceTension Time TimeAbsolute Velocity Velocity2 VelocityAmount Volume VolumeRate 
do
    hits=`grep --color "Q.$s " --files-with-matches --max-count=1 --exclude WorkInProgress.mo --exclude Quantities.mo *.mo`
    if [ -z "$hits" ]; then
        echo Quantity \"$s\" was not found.
    fi
done

# References
# Note that Larminie2003 appears in FCSysTest.
for s in Aronsson2009 Avogadro Bejan2006 Bernardi1992 BIPM2006 Broman2008 Brown2011 DuPont2004N DuPont2004NRE DuPont2005 Dymond2002 Entegris2012 Fritzson2004 Greiner1995 Gurau1998 Hess2008 Incropera2002 Kandlikar2009 Larminie2003 Lin2006 Mark1999 Mattsson1993 Mattsson2008 McBride1996 McBride2002 Mills1997 Modelica2010 Moran2004 NIST2010 Nitta2008 Parikh2012 Present1958 Rao1997 Rapaport2004 Reichert2010 Salzman2004 Schetz1996 SGL2004 SGL2007 Shah2009 Sivertsen2005 Slattery1958 Springer1991 Spry2009 Suzuki2010 Svehla1995 Takenaka1990 Tissandier1998 Toray2010 Wang2001 Weber2004 Woo1995 Yuan2009 
do
    hits=`find \( -iname "*.mo" -o -iname "*.cdf" \) | xargs grep --files-with-matches --max-count=1 --exclude package.mo --exclude WorkInProgress.mo $s`
    if [ -z "$hits" ]; then
        echo Reference \"$s\" was not found.
    fi
done
