﻿within FCSys;
package Units "Constants and units of physical measure"
  extends Modelica.Icons.Package;
  function setup "Establish conversions to display quantities in units"
    import Modelica.Utilities.Streams.print;
    extends Modelica.Icons.Function;

  algorithm
    print("Establishing display units...");

    // -------------------------------------------------------------------------
    // Default display units
    // -------------------------------------------------------------------------
    // If units other than those in the displayUnit attribute of the quantities
    // in FCSys.Quantities should be used by default, then specify them here.
    // Be sure that the desired unit is included in a defineUnitConversion
    // command below.
    // Generated from FCSys/Resources/quantities.xls, 2014-2-28
    defineDefaultDisplayUnit("1/N", "1/mol") "Reciprocal of amount";
    defineDefaultDisplayUnit("A", "degree") "Angle";
    defineDefaultDisplayUnit("A.N.T/(L2.M)", "1/Wb")
      "Reciprocal of magnetic flux";
    defineDefaultDisplayUnit("A/L", "rad/m") "Wavenumber";
    defineDefaultDisplayUnit("A/T", "Hz") "Frequency";
    defineDefaultDisplayUnit("A2", "sr") "Solid angle";
    defineDefaultDisplayUnit("L", "cm") "Length";
    defineDefaultDisplayUnit("L.M/(N.T)", "N/A") "Continuity";
    defineDefaultDisplayUnit("L.M/(N.T2)", "V/m") "Specific force";
    defineDefaultDisplayUnit("L.M/N2", "H/m") "Permeability";
    defineDefaultDisplayUnit("L.M/T2", "N") "Force";
    defineDefaultDisplayUnit("L.N/T", "A.m") "VelocityAmount";
    defineDefaultDisplayUnit("L.T/M", "1/(Pa.s)") "Fluidity";
    defineDefaultDisplayUnit("L.T/N", "cm/A") "Resistivity";
    defineDefaultDisplayUnit("L.T2/M", "1/kPa") "Reciprocal of pressure";
    defineDefaultDisplayUnit("L/(T.s)", "cm/s2")
      "for derivative of velocity in Dymola";
    defineDefaultDisplayUnit("L/N", "m/mol") "Specific length";
    defineDefaultDisplayUnit("L/T", "cm/s") "Velocity";
    defineDefaultDisplayUnit("L/T2", "m/s2") "Acceleration";
    defineDefaultDisplayUnit("L2", "cm2") "Area";
    defineDefaultDisplayUnit("L2.M/(A.N.T)", "Wb") "Magnetic flux";
    defineDefaultDisplayUnit("L2.M/(A.T)", "J.s/rad") "Rotational momentum";
    defineDefaultDisplayUnit("L2.M/(A2.T3)", "cd") "Radiant power";
    defineDefaultDisplayUnit("L2.M/(N.T)", "cm2/s") "Diffusivity";
    defineDefaultDisplayUnit("L2.M/(N.T2.s)", "V/s")
      "for derivative of potential in Dymola";
    defineDefaultDisplayUnit("L2.M/(N.T2)", "V") "Potential";
    defineDefaultDisplayUnit("L2.M/(N.T3)", "V/s") "Rate of potential";
    defineDefaultDisplayUnit("L2.M/(N2.T)", "ohm") "Electrical resistance";
    defineDefaultDisplayUnit("L2.M/N2", "uH") "Inductance";
    defineDefaultDisplayUnit("L2.M/T2", "J") "Energy";
    defineDefaultDisplayUnit("L2.M/T3", "W") "Power";
    defineDefaultDisplayUnit("L2/N", "cm2/C") "Specific area";
    defineDefaultDisplayUnit("L2/T2", "J/g") "Squared velocity";
    defineDefaultDisplayUnit("L3", "cc") "Volume";
    defineDefaultDisplayUnit("L3.M/(A.N.T2)", "V.m/rad")
      "Potential per wavenumber";
    defineDefaultDisplayUnit("L3.M/(N2.T2)", "m/H")
      "Reciprocal of permittivity";
    defineDefaultDisplayUnit("L3/(N.s)", "cc/(C.s)")
      "for derivative of specific volume in Dymola";
    defineDefaultDisplayUnit("L3/(N.T)", "cc/(C.s)")
      "Rate of specific volume";
    defineDefaultDisplayUnit("L3/N", "cc/C") "Specific volume";
    defineDefaultDisplayUnit("L3/T", "L/min") "Rate of volume";
    defineDefaultDisplayUnit("L4.M/T3", "W.m2") "Power times area";
    defineDefaultDisplayUnit("M", "g") "Mass";
    defineDefaultDisplayUnit("M.T5/L8", "W/(m2.K4)")
      "Areic power per 4th power of potential";
    defineDefaultDisplayUnit("M/(A.N.T)", "T") "Areic magnetic flux";
    defineDefaultDisplayUnit("M/(L.N.T)", "Pa/A") "Fluid resistance";
    defineDefaultDisplayUnit("M/(L.T2.s)", "Pa/s")
      "for derivative of pressure in Dymola";
    defineDefaultDisplayUnit("M/(L.T2)", "kPa") "Pressure";
    defineDefaultDisplayUnit("M/(L.T3)", "Pa/s") "Rate of pressure";
    defineDefaultDisplayUnit("M/(T2.L.s)", "Pa/s")
      "for derivative of pressure in Dymola";
    defineDefaultDisplayUnit("M/L3", "g/cc") "Volumic mass";
    defineDefaultDisplayUnit("M/N", "g/mol") "Specific mass";
    defineDefaultDisplayUnit("M/s", "g/s") "for derivative of mass in Dymola";
    defineDefaultDisplayUnit("M/T2", "N/m") "Surface tension";
    defineDefaultDisplayUnit("M/T3", "W/m2") "Areic power";
    defineDefaultDisplayUnit("N", "C") "Amount";
    defineDefaultDisplayUnit("N.T/M", "cm2/(V.s)") "Mobility";
    defineDefaultDisplayUnit("N/(L2.T)", "A/cm2") "Areic current";
    defineDefaultDisplayUnit("N/(T.s)", "A/s")
      "for derivative of current in Dymola";
    defineDefaultDisplayUnit("N/L3", "C/cc") "Density";
    defineDefaultDisplayUnit("N/s", "A") "for derivative of amount in Dymola";
    defineDefaultDisplayUnit("N/T", "A") "Current";
    defineDefaultDisplayUnit("N/T2", "A/s") "Rate of current";
    defineDefaultDisplayUnit("N2.T/(L2.M)", "S") "Electrical conductance";
    defineDefaultDisplayUnit("N2.T/(L3.M)", "S/m") "Electrical conductivity";
    defineDefaultDisplayUnit("N2.T2/(L2.M)", "uF") "Capacitance";
    defineDefaultDisplayUnit("N2.T2/(L3.M)", "F/m") "Permittivity";
    defineDefaultDisplayUnit("T", "s") "Time";

    // -------------------------------------------------------------------------
    // Conversions to display quantities in units
    // -------------------------------------------------------------------------
    defineUnitConversion(
        "1",
        "%",
        1/'%') "Number";
    defineUnitConversion(
        "1",
        "J/(mol.K)",
        mol*K/J) "Absolute number";
    defineUnitConversion(
        "1/N",
        "1/C",
        C) "Reciprocal of amount";
    defineUnitConversion(
        "1/N",
        "1/mol",
        mol) "Reciprocal of amount";
    defineUnitConversion(
        "A",
        "degree",
        1/degree) "Angle";
    defineUnitConversion(
        "A",
        "rad",
        1/rad) "Angle";
    defineUnitConversion(
        "A.N.T/(L2.M)",
        "1/Wb",
        Wb) "Reciprocal of magnetic flux";
    defineUnitConversion(
        "A/L",
        "cyc/m",
        m/cyc) "Wavenumber";
    defineUnitConversion(
        "A/L",
        "rad/m",
        m/rad) "Wavenumber";
    defineUnitConversion(
        "A/T",
        "Hz",
        1/Hz) "Frequency";
    defineUnitConversion(
        "A/T",
        "rad/s",
        s/rad) "Frequency";
    defineUnitConversion(
        "A2",
        "sr",
        1/sr) "Solid angle";
    defineUnitConversion(
        "L",
        "cm",
        1/cm) "Length";
    defineUnitConversion(
        "L",
        "m",
        1/m) "Length";
    defineUnitConversion(
        "L",
        "mm",
        1/mm) "Length";
    defineUnitConversion(
        "L.M/(N.T)",
        "N/A",
        A/N) "Continuity";
    defineUnitConversion(
        "L.M/(N.T2)",
        "V/m",
        m/V) "Specific force";
    defineUnitConversion(
        "L.M/N2",
        "H/m",
        m/H) "Permeability";
    defineUnitConversion(
        "L.M/T2",
        "N",
        1/N) "Force";
    defineUnitConversion(
        "L.N/T",
        "A.m",
        1/(A*m)) "VelocityAmount";
    defineUnitConversion(
        "L.N/T",
        "mol.m/s",
        s/(mol*m)) "VelocityAmount";
    defineUnitConversion(
        "L.T/M",
        "1/(Pa.s)",
        Pa*s) "Fluidity";
    defineUnitConversion(
        "L.T/M",
        "cm.s/g",
        g/(cm*s)) "Fluidity";
    defineUnitConversion(
        "L.T/N",
        "cm/A",
        A/cm) "Resistivity";
    defineUnitConversion(
        "L.T/N",
        "m/A",
        A/m) "Resistivity";
    defineUnitConversion(
        "L.T/N",
        "m.K/W",
        W/(m*K)) "Resistivity";
    defineUnitConversion(
        "L.T2/M",
        "1/kPa",
        kilo*Pa) "Reciprocal of pressure";
    defineUnitConversion(
        "L.T2/M",
        "1/Pa",
        Pa) "Reciprocal of pressure";
    defineUnitConversion(
        "L/(T.s)",
        "cm/s2",
        s/cm) "for derivative of velocity in Dymola";
    defineUnitConversion(
        "L/(T.s)",
        "m/s2",
        s/m) "for derivative of velocity in Dymola";
    defineUnitConversion(
        "L/N",
        "m/C",
        C/m) "Specific length";
    defineUnitConversion(
        "L/N",
        "m/mol",
        mol/m) "Specific length";
    defineUnitConversion(
        "L/T",
        "cm/s",
        s/cm) "Velocity";
    defineUnitConversion(
        "L/T",
        "m/s",
        s/m) "Velocity";
    defineUnitConversion(
        "L/T",
        "mm/s",
        s/mm) "Velocity";
    defineUnitConversion(
        "L/T",
        "um/s",
        s/um) "Velocity";
    defineUnitConversion(
        "L/T2",
        "cm/s2",
        s^2/cm) "Acceleration";
    defineUnitConversion(
        "L/T2",
        "m/s2",
        s^2/m) "Acceleration";
    defineUnitConversion(
        "L2",
        "cm2",
        1/cm^2) "Area";
    defineUnitConversion(
        "L2",
        "m2",
        1/m^2) "Area";
    defineUnitConversion(
        "L2.M/(A.N.T)",
        "Wb",
        1/Wb) "Magnetic flux";
    defineUnitConversion(
        "L2.M/(A.T)",
        "J.s/rad",
        rad/(J*s)) "Rotational momentum";
    defineUnitConversion(
        "L2.M/(A2.T3)",
        "cd",
        1/cd) "Radiant power";
    defineUnitConversion(
        "L2.M/(A2.T3)",
        "W/sr",
        sr/W) "Radiant power";
    defineUnitConversion(
        "L2.M/(N.T)",
        "cm2/s",
        s/cm^2) "Diffusivity";
    defineUnitConversion(
        "L2.M/(N.T)",
        "m2/s",
        s/m^2) "Diffusivity";
    defineUnitConversion(
        "L2.M/(N.T)",
        "mm2/s",
        s/mm^2) "Diffusivity";
    defineUnitConversion(
        "L2.M/(N.T2.s)",
        "K/s",
        1/K) "for derivative of potential in Dymola";
    defineUnitConversion(
        "L2.M/(N.T2.s)",
        "V/s",
        1/V) "for derivative of potential in Dymola";
    defineUnitConversion(
        "L2.M/(N.T2)",
        "J/mol",
        mol/J) "Potential";
    defineUnitConversion(
        "L2.M/(N.T2)",
        "K",
        1/K) "Absolute potential";
    defineUnitConversion(
        "L2.M/(N.T2)",
        "kJ/mol",
        mol/kJ) "Potential";
    defineUnitConversion(
        "L2.M/(N.T2)",
        "V",
        1/V) "Potential";
    defineUnitConversion(
        "L2.M/(N.T3)",
        "K/s",
        s/K) "Rate of potential";
    defineUnitConversion(
        "L2.M/(N.T3)",
        "V/s",
        s/V) "Rate of potential";
    defineUnitConversion(
        "L2.M/(N2.T)",
        "ohm",
        1/ohm) "Electrical resistance";
    defineUnitConversion(
        "L2.M/N2",
        "H",
        1/H) "Inductance";
    defineUnitConversion(
        "L2.M/N2",
        "uH",
        1/(micro*H)) "Inductance";
    defineUnitConversion(
        "L2.M/T2",
        "J",
        1/J) "Energy";
    defineUnitConversion(
        "L2.M/T3",
        "lm",
        1/lm) "Power";
    defineUnitConversion(
        "L2.M/T3",
        "W",
        1/W) "Power";
    defineUnitConversion(
        "L2/N",
        "cm2/C",
        C/cm^2) "Specific area";
    defineUnitConversion(
        "L2/N",
        "cm2/mol",
        mol/cm^2) "Specific area";
    defineUnitConversion(
        "L2/N",
        "m2/C",
        C/m^2) "Specific area";
    defineUnitConversion(
        "L2/N",
        "m2/mol",
        mol/m^2) "Specific area";
    defineUnitConversion(
        "L2/T2",
        "J/g",
        g/J) "Squared velocity";
    defineUnitConversion(
        "L3",
        "cc",
        1/cc) "Volume";
    defineUnitConversion(
        "L3",
        "L",
        1/L) "Volume";
    defineUnitConversion(
        "L3",
        "m3",
        1/m^3) "Volume";
    defineUnitConversion(
        "L3.M/(A.N.T2)",
        "K.m/rad",
        rad/(K*m)) "Potential per wavenumber";
    defineUnitConversion(
        "L3.M/(A.N.T2)",
        "V.m/rad",
        rad/(V*m)) "Potential per wavenumber";
    defineUnitConversion(
        "L3.M/(N2.T2)",
        "m/H",
        H/m) "Reciprocal of permittivity";
    defineUnitConversion(
        "L3/(N.s)",
        "cc/(C.s)",
        C*s/cc) "for derivative of specific volume in Dymola";
    defineUnitConversion(
        "L3/(N.s)",
        "m3/(C.s)",
        C*s/m^3) "for derivative of specific volume in Dymola";
    defineUnitConversion(
        "L3/(N.s)",
        "m3/(mol.s)",
        mol*s/m^3) "for derivative of specific volume in Dymola";
    defineUnitConversion(
        "L3/(N.T)",
        "cc/(C.s)",
        C*s/cc) "Rate of specific volume";
    defineUnitConversion(
        "L3/(N.T)",
        "m3/(C.s)",
        C*s/m^3) "Rate of specific volume";
    defineUnitConversion(
        "L3/(N.T)",
        "m3/(mol.s)",
        mol*s/m^3) "Rate of specific volume";
    defineUnitConversion(
        "L3/N",
        "cc/C",
        C/cc) "Specific volume";
    defineUnitConversion(
        "L3/N",
        "m3/C",
        C/m^3) "Specific volume";
    defineUnitConversion(
        "L3/N",
        "m3/mol",
        mol/m^3) "Specific volume";
    defineUnitConversion(
        "L3/s",
        "cc/s",
        1/(centi*m)^3) "for derivative of volume in Dymola";
    defineUnitConversion(
        "L3/s",
        "L/min",
        min/(L*s)) "for derivative of volume in Dymola";
    defineUnitConversion(
        "L3/s",
        "m3/s",
        1/m^3) "for derivative of volume in Dymola";
    defineUnitConversion(
        "L3/T",
        "cc/s",
        s/cc) "Rate of volume";
    defineUnitConversion(
        "L3/T",
        "L/min",
        min/L) "Rate of volume";
    defineUnitConversion(
        "L3/T",
        "m3/s",
        s/m^3) "Rate of volume";
    defineUnitConversion(
        "L4.M/T3",
        "W.m2",
        1/(W*m^2)) "Power times area";
    defineUnitConversion(
        "M",
        "g",
        1/g) "Mass";
    defineUnitConversion(
        "M",
        "kg",
        1/kg) "Mass";
    defineUnitConversion(
        "M.T5/L8",
        "W/(m2.K4)",
        m^2*K^4/W) "Areic power per 4th power of potential";
    defineUnitConversion(
        "M/(A.N.T)",
        "T",
        1/T) "Areic magnetic flux";
    defineUnitConversion(
        "M/(L.N.T)",
        "Pa/A",
        A/Pa) "Fluid resistance";
    defineUnitConversion(
        "M/(L.T2.s)",
        "Pa/s",
        1/Pa) "for derivative of pressure in Dymola";
    defineUnitConversion(
        "M/(L.T2)",
        "atm",
        1/atm) "Pressure";
    defineUnitConversion(
        "M/(L.T2)",
        "bar",
        1/bar) "Pressure";
    defineUnitConversion(
        "M/(L.T2)",
        "kPa",
        1/(kilo*Pa)) "Pressure";
    defineUnitConversion(
        "M/(L.T2)",
        "Pa",
        1/Pa) "Pressure";
    defineUnitConversion(
        "M/(L.T3)",
        "Pa/s",
        s/Pa) "Rate of pressure";
    defineUnitConversion(
        "M/(T2.L.s)",
        "Pa/s",
        1/Pa) "for derivative of pressure in Dymola";
    defineUnitConversion(
        "M/L3",
        "g/cc",
        cc/g) "Volumic mass";
    defineUnitConversion(
        "M/L3",
        "kg/m3",
        m^3/kg) "Volumic mass";
    defineUnitConversion(
        "M/N",
        "g/mol",
        mol/g) "Specific mass";
    defineUnitConversion(
        "M/N",
        "kg/mol",
        mol/kg) "Specific mass";
    defineUnitConversion(
        "M/N",
        "ug/C",
        C/(micro*g)) "Specific mass";
    defineUnitConversion(
        "M/s",
        "g/s",
        s/g) "for derivative of mass in Dymola";
    defineUnitConversion(
        "M/s",
        "kg/s",
        s/kg) "for derivative of mass in Dymola";
    defineUnitConversion(
        "M/T2",
        "N/m",
        m/N) "Surface tension";
    defineUnitConversion(
        "M/T3",
        "lm/m2",
        m^2/lm) "Areic power";
    defineUnitConversion(
        "M/T3",
        "W/m2",
        m^2/W) "Areic power";
    defineUnitConversion(
        "N",
        "C",
        1/C) "Amount";
    defineUnitConversion(
        "N",
        "J/K",
        K/J) "Amount";
    defineUnitConversion(
        "N",
        "mol",
        1/mol) "Amount";
    defineUnitConversion(
        "N",
        "q",
        1/q) "Amount";
    defineUnitConversion(
        "N.T/M",
        "C.s/g",
        g/(C*s)) "Mobility";
    defineUnitConversion(
        "N.T/M",
        "cm2/(V.s)",
        V*s/cm^2) "Mobility";
    defineUnitConversion(
        "N/(L2.T)",
        "A/cm2",
        cm^2/A) "Areic current";
    defineUnitConversion(
        "N/(L2.T)",
        "A/cm2",
        cm^2/A) "Absolute areic current";
    defineUnitConversion(
        "N/(L2.T)",
        "A/m2",
        m^2/A) "Areic current";
    defineUnitConversion(
        "N/(L2.T)",
        "A/m2",
        m^2/A) "Absolute areic current";
    defineUnitConversion(
        "N/(L2.T)",
        "kat/cm2",
        cm^2/kat) "Areic current";
    defineUnitConversion(
        "N/(L2.T)",
        "kat/cm2",
        cm^2/kat) "Absolute areic current";
    defineUnitConversion(
        "N/(L2.T)",
        "kat/m2",
        m^2/kat) "Areic current";
    defineUnitConversion(
        "N/(L2.T)",
        "kat/m2",
        m^2/kat) "Absolute areic current";
    defineUnitConversion(
        "N/(T.s)",
        "A/s",
        1/A) "for derivative of current in Dymola";
    defineUnitConversion(
        "N/(T.s)",
        "kat/s",
        1/kat) "for derivative of current in Dymola";
    defineUnitConversion(
        "N/L3",
        "C/cc",
        cc/C) "Density";
    defineUnitConversion(
        "N/L3",
        "C/m3",
        m^3/C) "Density";
    defineUnitConversion(
        "N/L3",
        "J/(m3.K)",
        m^3*K/J) "Density";
    defineUnitConversion(
        "N/L3",
        "M",
        1/M) "Density";
    defineUnitConversion(
        "N/s",
        "A",
        1/C) "for derivative of amount in Dymola";
    defineUnitConversion(
        "N/s",
        "kat",
        1/mol) "for derivative of amount in Dymola";
    defineUnitConversion(
        "N/s",
        "W/K",
        K/J) "for derivative of amount in Dymola";
    defineUnitConversion(
        "N/T",
        "A",
        1/A) "Current";
    defineUnitConversion(
        "N/T",
        "kat",
        1/kat) "Current";
    defineUnitConversion(
        "N/T",
        "W/K",
        K/W) "Current";
    defineUnitConversion(
        "N/T2",
        "A/s",
        s/A) "Rate of current";
    defineUnitConversion(
        "N/T2",
        "kat/s",
        s/kat) "Rate of current";
    defineUnitConversion(
        "N2.T/(L2.M)",
        "S",
        1/S) "Electrical conductance";
    defineUnitConversion(
        "N2.T/(L3.M)",
        "S/m",
        m/S) "Electrical conductivity";
    defineUnitConversion(
        "N2.T2/(L2.M)",
        "F",
        1/F) "Capacitance";
    defineUnitConversion(
        "N2.T2/(L2.M)",
        "uF",
        1/(micro*F)) "Capacitance";
    defineUnitConversion(
        "N2.T2/(L3.M)",
        "F/m",
        m/F) "Permittivity";
    defineUnitConversion(
        "T",
        "day",
        1/day) "Time";
    defineUnitConversion(
        "T",
        "hr",
        1/hr) "Time";
    defineUnitConversion(
        "T",
        "us",
        1/(micro*s)) "Time";
    defineUnitConversion(
        "T",
        "ms",
        1/(milli*s)) "Time";
    defineUnitConversion(
        "T",
        "min",
        1/min) "Time";
    defineUnitConversion(
        "T",
        "s",
        1/s) "Time";
    // -------- end from FCSys/Resources/quantities.xls

    // -------------------------------------------------------------------------
    // Conversions with offsets
    // -------------------------------------------------------------------------

    defineUnitConversion(
        "L2.M/(N.T2)",
        "degC",
        1/K,
        -273.15) "Temperature in degC";
    defineUnitConversion(
        "L2.M/(N.T2)",
        "degF",
        9/(5*K),
        32 - (9/5)*273.15) "Temperature in degF";
    defineUnitConversion(
        "M/(L.T2)",
        "kPag",
        1/kPa,
        -atm/kPa) "Pressure in kPag";

    print("Done.");
    annotation (Documentation(info="<html><p>This function has no inputs or outputs.  It is essentially a script.
The <code>defineDefaultDisplayUnit</code> and <code>defineUnitConversion</code> functions
used here are not defined in the Modelica language (as of version 3.3) but are
recognized by Dymola.</p>

<p>For more information, please see the documentation for the
<a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"));
  end setup;

  package Examples "Examples"
    extends Modelica.Icons.ExamplesPackage;

    model Evaluate "Evaluate the values assigned to constants and units"
      extends Modelica.Icons.Example;

      // -------------------------------------------------------------------------
      // Mathematical constants

      final constant Q.Number pi=U.pi "pi";

      // -------------------------------------------------------------------------
      // SI prefixes [BIPM2006, Table 5]

      final constant Q.Number yotta=U.yotta "yotta (Y)";
      final constant Q.Number zetta=U.zetta "zetta (Z)";
      final constant Q.Number exa=U.exa "exa (E)";
      final constant Q.Number peta=U.peta "peta (P)";
      final constant Q.Number tera=U.tera "tera (T)";
      final constant Q.Number giga=U.giga "giga (G)";
      final constant Q.Number mega=U.mega "mega (M)";
      final constant Q.Number kilo=U.kilo "kilo (k)";
      final constant Q.Number hecto=U.hecto "hecto (h)";
      final constant Q.Number deca=U.deca "deca (da)";
      final constant Q.Number deci=U.deci "deci (d)";
      final constant Q.Number centi=U.centi "centi (c)";
      final constant Q.Number milli=U.milli "milli (m)";
      final constant Q.Number micro=U.micro "micro (u)";
      final constant Q.Number nano=U.nano "nano (n)";
      final constant Q.Number pico=U.pico "pico (p)";
      final constant Q.Number femto=U.femto "femto (f)";
      final constant Q.Number atto=U.atto "atto (a)";
      final constant Q.Number zepto=U.zepto "zepto (z)";
      final constant Q.Number yocto=U.yocto "yocto (y)";

      // -------------------------------------------------------------------------
      // Independent base physical constants and units

      final constant Q.Angle cyc=U.cyc "cycle";
      final constant Q.Wavenumber R_inf=U.R_inf "Rydberg constant";
      final constant Q.Velocity c=U.c "speed of light in vacuum";
      final constant Q.ConductanceElectrical G_0=U.G_0 "conductance quantum";
      final constant Q.MagneticFlux Phi_0=U.Phi_0 "magnetic flux quantum";
      final constant Q.Number k_F=U.k_F "Faraday constant";
      final constant Q.Number R=U.R "gas constant";

      // -------------------------------------------------------------------------
      // SI units that depend on transcendental and arbitrated empirical numbers

      final constant Q.Angle rad=U.rad "radian";
      final constant Q.Length m=U.m "meter";
      final constant Q.Time s=U.s "second";
      final constant Q.MagneticFlux Wb=U.Wb "weber";
      final constant Q.ConductanceElectrical S=U.S "siemen";
      final constant Q.Amount mol=U.mol "mole";
      final constant Q.Potential K=U.K "kelvin";

      // -------------------------------------------------------------------------
      // SI base units [BIPM2006, Table 1] and intermediate units

      final constant Q.Frequency Hz=U.Hz "hertz";
      final constant Q.Potential V=U.V "volt";
      final constant Q.Current A=U.A "ampere";
      final constant Q.Amount C=U.C "coulomb";
      final constant Q.Energy J=U.J "joule";
      final constant Q.Velocity2 Gy=U.Gy "gray";
      final constant Q.Mass kg=U.kg "kilogram ";
      final constant Q.Power W=U.W "watt";
      final constant Q.Power lm=U.lm "lumen";
      final constant Q.Angle2 sr=U.sr "steradian";
      final constant Q.PowerRadiant cd=U.cd "candela";

      // -------------------------------------------------------------------------
      // SI derived units with special names and symbols [BIPM2006, Table 3]

      final constant Q.Force N=U.N "newton";
      final constant Q.Pressure Pa=U.Pa "pascal";
      final constant Q.MagneticFluxAreic T=U.T "tesla";
      final constant Q.PowerAreic lx=U.lx "lux";
      final constant Q.Capacitance F=U.F "farad";
      final constant Q.ResistanceElectrical ohm=U.ohm "ohm (Omega)";
      final constant Q.Inductance H=U.H "henry";
      final constant Q.Current kat=U.kat "katal";
      final constant Q.Mass g=U.g "gram";

      // -------------------------------------------------------------------------
      // Non-SI units accepted for use with SI units [BIPM2006, Table 6]

      final constant Q.Time min=U.min "minute";
      final constant Q.Time hr=U.hr "hour";
      final constant Q.Time day=U.day "day";
      final constant Q.Angle degree=U.degree "degree";
      final constant Q.Volume L=U.L "liter (L or l)";

      // -------------------------------------------------------------------------
      // Derived physical constants and units

      // Electrical -- involving conductance
      final constant Q.Number alpha=U.alpha "fine-structure constant";
      final constant Q.ResistanceElectrical Z_0=U.Z_0
        "characteristic impedance of vacuum";
      final constant Q.Permeability mu_0=U.mu_0 "magnetic constant";
      final constant Q.Permittivity epsilon_0=U.epsilon_0 "electric constant";

      // Electromagnetism -- involving conductance and magnetic flux
      final constant Q.Amount q=U.q "elementary charge";
      final constant Q.Energy eV=U.eV "electron volt";
      final constant Q.MomentumRotational h=U.h "Planck constant";
      final constant Q.Energy E_h=U.E_h "Hartree energy";

      // Chemistry
      final constant Q.AmountReciprocal N_A=U.N_A "Avogadro constant";

      // Thermal physics
      final constant Q.Amount k_B=U.k_B "Boltzmann constant";
      final constant Q.PowerAreicPerPotential4 sigma=U.sigma
        "Stefan-Boltzmann constant";
      final constant Q.PowerArea c_1=U.c_1 "first radiation constant";
      final constant Q.PotentialPerWavenumber c_2=U.c_2
        "second radiation constant";
      final constant Q.PotentialPerWavenumber c_3_f=U.c_3_f
        "Wien frequency displacement law constant";
      final constant Q.MagneticFluxReciprocal c_3_lambda=U.c_3_lambda
        "Wien wavelength displacement law constant";

      // -------------------------------------------------------------------------
      // Other selected non-SI units from [BIPM2006, Table 8]

      final constant Q.Pressure bar=U.bar "bar";
      final constant Q.Length angstrom=U.angstrom "angstrom";

      // -------------------------------------------------------------------------
      // Additional units that are useful for fuel cells

      final constant Q.Angle2 sp=U.sp "spat";
      final constant Q.Pressure atm=U.atm "atmosphere";
      final constant Q.Pressure kPa=U.kPa "kilopascal";
      final constant Q.Energy kJ=U.kJ "kilojoule";
      final constant Q.Time ms=U.ms "millisecond";
      final constant Q.Current mA=U.mA "milliampere";
      final constant Q.Length cm=U.cm "centimeter";
      final constant Q.Length mm=U.mm "millimeter";
      final constant Q.Length um=U.um "micrometer";
      final constant Q.Length nm=U.nm "nanometer";
      final constant Q.Volume cc=U.cc "cubic centimeter";
      final constant Q.Number '%'=U.'%' "percent";
      final constant Q.Density M=U.M "molar";
      annotation (Documentation(info="<html><p>This model may be used to calculate the values of the
  constants and units.</p>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units.",
            executeCall=checkModel("FCSys.Units")));

    end Evaluate;

  end Examples;

  package Bases "Sets of base constants and units"
    extends Modelica.Icons.Package;

    record Gaussian
      "<html>Base constants and units for Gaussian units (<i>k</i><sub>A</sub> = <i>k</i><sub>e</sub> = 1)</html>"
      extends Base(final c=1,final G_0=299792458*2e-7/25812.8074434);
      annotation (Documentation(info="<html><p>Gaussian systems of units impose that:</p>
  <ol>
  <li>the magnetic force constant is one (<i>k</i><sub>A</sub> = 1) (&rArr; <i>R</i><sub>K</sub>/<i>c</i> = 2&pi;/&alpha;) and</li>
  <li>the electric force constant is one (<i>k</i><sub>e</sub> = 1) (&rArr; <i>R</i><sub>K</sub> <i>c</i> = 2&pi;/&alpha;).</li>
  </ol>
  <p>This implies that <i>c</i> = 1 and <i>R</i><sub>K</sub> = 2&pi;/&alpha;.</p>

<p>The Gaussian conditions are not sufficient
to fully establish the values of the base constants and units of the
<a href=\"modelica://FCSys.Units\">Units</a> package.  Gaussian units
encompass other systems of units.</p>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"));

    end Gaussian;

    record Hartree "Base constants and units for Hartree atomic units"

      extends Base(
        final R_inf=1e-7*299792458/(2*cyc^2*25812.8074434),
        final c=25812.8074434/(2*pi*299792458*1e-7*cyc),
        final G_0=1/(cyc*pi),
        final Phi_0=pi);

      annotation (Documentation(info="<html>
<p>Stoney units impose that:
  <ol> 
  <li>the elementary charge is one (<i>q</i> = 1),</li>
  <li>Planck's constant is two pi (<i>h</i> = 2&pi;),</li>
  <li>the electric force constant is one (<i>k</i><sub>e</sub> = 1), and</li>
  <li>the mass of an electron is one (4&pi;&nbsp;&nbsp;<i>k</i><sub>A</sub>&nbsp;<i>R</i><sub>&infin;</sub>&nbsp;<i>q</i><sup>2</sup> = &alpha;<sup>3</sup>).
  </ol></p>
  
<p>Please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end Hartree;

    record LH
      "<html>Base constants and units for Lorentz-Heaviside units (&mu;<sub>0</sub> = &epsilon;<sub>0</sub> = 1)</html>"
      extends Base(final c=1,final G_0=4*pi*2e-7*299792458/25812.8074434);
      annotation (Documentation(info="<html><p>Lorentz-Heaviside systems of units impose that:</p>
  <ol>
  <li>the magnetic constant is one (&mu;<sub>0</sub> = 1) (&rArr; <i>R</i><sub>K</sub>/<i>c</i> = 1/(2&alpha;)) and</li>
  <li>the electric constant is one (&epsilon;<sub>0</sub> = 1) (&rArr; <i>R</i><sub>K</sub>&nbsp;<i>c</i> = 1/(2&alpha;)).</li>
  </ol>
  <p>This implies that <i>c</i> = 1 and <i>R</i><sub>K</sub> = 1/(2&alpha;).</p>

<p>The Lorentz-Heaviside conditions are not sufficient
to fully establish the values of the base constants and units of the
<a href=\"modelica://FCSys.Units\">Units</a> package.  Lorentz-Heaviside units
encompass other systems of units.</p>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"));

    end LH;

    record Stoney "Base constants and units for Stoney units"

      extends Gaussian(final Phi_0=25812.8074434/(cyc*2e-7*299792458));
      annotation (Documentation(info="<html><p>Stoney units are 
  <a href=\"modelica://FCSys.Units.Bases.Gaussian\">Gaussian</a> units 
  (<i>k</i><sub>A</sub> = <i>k</i><sub>e</sub> = 1) which also impose that:
  <ol> 
  <li>the elementary charge is one (<i>q</i> = 1) and</li>
  <li>the gravitational constant is one (although not included in the <a href=\"modelica://FCSys.Units\">Units</a> package).
  </ol></p>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end Stoney;

    record SIAK
      "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of A and K</html>"

      extends Base(
        final cyc=c/299792458*(4*pi^2*R_inf/(10973731.568539*683))^(1/3),
        final R_inf=10973731.568539,
        final c=299792458,
        final G_0=2/(96485.3365^2*25812.8074434),
        final Phi_0=m/(483597.870e9*sqrt(S*s)));
      annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>A &asymp; 1.03643e-5</li>
  <li>K &asymp; 8.31446</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end SIAK;

    record SIAm
      "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of A and m</html>"

      extends Base(
        final cyc=c/299792458*(4*pi^2*R_inf/(10973731.568539*683))^(1/3),
        final R_inf=sqrt(8.3144621)*10973731.568539,
        final c=299792458/sqrt(8.3144621),
        final G_0=2*8.3144621/(96485.3365^2*25812.8074434),
        final Phi_0=m/(483597.870e9*sqrt(S*s)));
      annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>A &asymp; 1.03643e-5</li>
  <li>m &asymp; 0.346803</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end SIAm;

    record SIAs
      "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of A and s</html>"
      extends Base(
        final cyc=c/299792458*(4*pi^2*R_inf/(10973731.568539*683))^(1/3),
        final R_inf=10973731.568539,
        final c=299792458/sqrt(8.3144621),
        final G_0=2*sqrt(8.3144621)/(96485.3365^2*25812.8074434),
        final Phi_0=m/(483597.870e9*sqrt(S*s)));
      annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>A &asymp; 3.59436e-6</li>
  <li>s &asymp; 2.88348</li>
  </ul>

  <p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end SIAs;

    record SIKmol
      "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of K and mol</html>"
      extends Base(
        final cyc=c/299792458*(4*pi^2*R_inf/(10973731.568539*683))^(1/3),
        final R_inf=10973731.568539,
        final c=299792458,
        final G_0=2/25812.8074434,
        final Phi_0=m/(483597.870e9*sqrt(S*s)));
      annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>K &asymp; 8.61733e-5</li>
  <li>mol &asymp; 96485.3</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end SIKmol;

    record SIKs
      "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of K and s</html>"
      extends Base(
        final cyc=c/299792458*(4*pi^2*R_inf/(10973731.568539*683))^(1/3),
        final R_inf=10973731.568539,
        final c=96485.3365*299792458,
        final G_0=2/(96485.3365^3*25812.8074434),
        final Phi_0=m/(483597.870e9*sqrt(S*s)));
      annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>K &asymp; 7.74028e10</li>
  <li>s &asymp; 1.03643e-5</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end SIKs;

    record SImmol
      "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of m and mol</html>"
      extends Base(
        final cyc=c/299792458*(4*pi^2*R_inf/(10973731.568539*683))^(1/3),
        final R_inf=sqrt(8.3144621/96485.3365)*10973731.568539,
        final c=sqrt(96485.3365/8.3144621)*299792458,
        final G_0=2*8.3144621/(96485.3365*25812.8074434),
        final Phi_0=m/(483597.870e9*sqrt(S*s)));
      annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>m &asymp; 107.724</li>
  <li>mol &asymp; 96485.3</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end SImmol;

    record SIms
      "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of m and s</html>"
      extends Base(
        final cyc=c/299792458*(4*pi^2*R_inf/(10973731.568539*683))^(1/3),
        final R_inf=96485.3365*sqrt(8.3144621)*10973731.568539,
        final c=299792458/sqrt(8.3144621),
        final G_0=2*8.3144621/(96485.3365*25812.8074434),
        final Phi_0=m/(483597.870e9*sqrt(S*s)));
      annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>m &asymp; 3.59436e-6</li>
  <li>s &asymp; 1.03643e-5</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end SIms;

    record SImols
      "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of mol and s</html>"
      extends Base(
        final cyc=c/299792458*(4*pi^2*R_inf/(10973731.568539*683))^(1/3),
        final R_inf=10973731.568539,
        final c=(96485.3365/8.3144621)^(1/3)*299792458,
        final G_0=2*8.3144621/(96485.3365*25812.8074434),
        final Phi_0=m/(483597.870e9*sqrt(S*s)));

      annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>mol &asymp; 4261.73</li>
  <li>s &asymp; 0.0441697</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end SImols;

    record Base "Base constants and units"
      extends Modelica.Icons.Record;

      constant Q.Angle cyc=1 "cycle";
      // Unit of rotation or planar angle
      // This is also known as a revolution or turn.
      constant Q.Wavenumber R_inf=1
        "<html>Rydberg constant (R<sub>&infin;</sub>)</html>";
      // The SI unit length (meter) is inversely proportional to this value,
      // which should be increased for larger characteristic lengths.
      constant Q.Velocity c=1 "<html>speed of light in vacuum (c)</html>";
      // The SI unit time (second) is inversely proportional to this value (and
      // R_inf), which should be increased for larger characteristic times.
      constant Q.ConductanceElectrical G_0=1
        "<html>conductance quantum (<i>G</i><sub>0</sub>)</html>";
      // The SI unit of electrical conductance (siemen) is proportional to this
      // value, which should be decreased for larger characteristic conductances.
      // Also, the SI unit of charge (coulomb) is proportional to this value.
      constant Q.MagneticFlux Phi_0=1
        "<html>magnetic flux quantum (&Phi;<sub>0</sub>)</html>";
      // The SI unit of magnetic flux (weber) is proportional to this value, which
      // should be decreased for larger magnetic flux numbers.  Also, the SI unit
      // of charge (coulomb) is proportional to this value.
      final constant Q.Number k_F=1
        "<html>Faraday constant (k<sub>F</sub>)</html>";
      // The unit of substance (mole) is inversely proportional to this value.
      // The Faraday constant isn't adjustable because the equations of FCSys
      // require that it's one, which means that charge is considered to be an
      // amount.
      final constant Q.Number R=1 "gas constant";
      // The unit of temperature (kelvin) is inversely proportional to this value.
      // The gas constant isn't adjustable because the equations of FCSys require
      // that it's one, which means that temperature is considered to be a
      // potential.
      annotation (Documentation(info="<html><p>Please see the notes in the Modelica code and the documentation of the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
          Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end Base;
    annotation (Documentation(info="<html>
  <p>Some systems of units
  are not compatible with <a href=\"modelica://FCSys\">FCSys</a>.
  Although the structure of the <a href=\"modelica://FCSys.Units\">Units</a> package 
  is general, the models in <a href=\"modelica://FCSys\">FCSys</a>
  require that the Faraday and gas constants are
  normalized to one.  It follows that <i>k</i><sub>B</sub> = <i>q</i>.  
  This is not
  the case for the Planck, Rydberg, and Natural systems of units
  [<a href=\"http://en.wikipedia.org/wiki/Natural_units\">http://en.wikipedia.org/wiki/Natural_units</a>].</p>

  <p>The quasi-SI
  sets in this package are named by listing (in alphabetical order) the two units (out of A, cd, K, kg, m, mol, and s) that are
  <i>not</i> normalized for the sake of normalizing the Faraday and gas constants. 
  There are eight possible systems of this type (<a href=\"modelica://FCSys.Units.Bases.SIAK\">SIAK</a>,
  <a href=\"modelica://FCSys.Units.Bases.SIAm\">SIAm</a>,
  <a href=\"modelica://FCSys.Units.Bases.SIAs\">SIAs</a>,
  <a href=\"modelica://FCSys.Units.Bases.SIKmol\">SIKmol</a>,
  <a href=\"modelica://FCSys.Units.Bases.SIKs\">SIKs</a>,
  <a href=\"modelica://FCSys.Units.Bases.SImmol\">SImmol</a>,
  <a href=\"modelica://FCSys.Units.Bases.SIms\">SIms</a>, and
  <a href=\"modelica://FCSys.Units.Bases.SImols\">SImols</a>).</p>

  <p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"),
        Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."));

  end Bases;

  function from_degC
    "Convert from temperature in degree Celsius to temperature as a quantity"
    extends Modelica.SIunits.Icons.Conversion;

    input Real T_degC "Temperature in degree Celsius";
    output Q.TemperatureAbsolute T "Thermodynamic temperature";

  algorithm
    T := (T_degC + 273.15)*K;
    annotation (Inline=true, inverse(T_degC=FCSys.Units.to_degC(T)));
  end from_degC;

  function to_degC
    "Convert from temperature as a quantity to temperature in degree Celsius"
    extends Modelica.SIunits.Icons.Conversion;

    input Q.TemperatureAbsolute T "Thermodynamic temperature";
    output Real T_degC "Temperature in degree Celsius";

  algorithm
    T_degC := T/K - 273.15;
    annotation (Inline=true, inverse(T=FCSys.Units.from_degC(T_degC)));
  end to_degC;

  function from_kPag
    "Convert from gauge pressure in kilopascals to absolute pressure as a quantity"
    extends Modelica.SIunits.Icons.Conversion;

    input Real p_kPag "Gauge pressure in kilopascals";
    output Q.PressureAbsolute p "Absolute pressure";

  algorithm
    p := p_kPag*kPa + atm;
    annotation (Inline=true, inverse(p_kPag=FCSys.Units.to_kPag(p)));
  end from_kPag;

  function to_kPag
    "Convert from absolute pressure as a quantity to gauge pressure in kilopascals"
    extends Modelica.SIunits.Icons.Conversion;

    input Q.PressureAbsolute p "Absolute pressure";
    output Real p_kPag "Gauge pressure in kilopascals";

  algorithm
    p_kPag := (p - atm)/kPa;
    annotation (Inline=true, inverse(p=FCSys.Units.from_kPag(p_kPag)));
  end to_kPag;

  // -------------------------------------------------------------------------
  // Mathematical constants
  // -------------------------------------------------------------------------

  final constant Q.Number pi=2*acos(0) "<html>pi (<i>&pi;</i>)</html>";

  // -------------------------------------------------------------------------
  // SI prefixes [BIPM2006, Table 5]
  // -------------------------------------------------------------------------

  final constant Q.Number yotta=1e24 "yotta (Y)";
  final constant Q.Number zetta=1e21 "zetta (Z)";
  final constant Q.Number exa=1e18 "exa (E)";
  final constant Q.Number peta=1e15 "peta (P)";
  final constant Q.Number tera=1e12 "tera (T)";
  final constant Q.Number giga=1e9 "giga (G)";
  final constant Q.Number mega=1e6 "mega (M)";
  final constant Q.Number kilo=1e3 "kilo (k)";
  final constant Q.Number hecto=1e2 "hecto (h)";
  final constant Q.Number deca=1e1 "deca (da)";
  final constant Q.Number deci=1e-1 "deci (d)";
  final constant Q.Number centi=1e-2 "centi (c)";
  final constant Q.Number milli=1e-3 "milli (m)";
  final constant Q.Number micro=1e-6 "micro (u)";
  final constant Q.Number nano=1e-9 "nano (n)";
  final constant Q.Number pico=1e-12 "pico (p)";
  final constant Q.Number femto=1e-15 "femto (f)";
  final constant Q.Number atto=1e-18 "atto (a)";
  final constant Q.Number zepto=1e-21 "zepto (z)";
  final constant Q.Number yocto=1e-24 "yocto (y)";

  // -------------------------------------------------------------------------
  // Independent base constants and units
  // -------------------------------------------------------------------------

  replaceable constant Bases.LH base constrainedby Bases.Base
    "Scalable base constants and units";
  // 2013/11/16:  The following systems result in a smooth temperature trend
  // in FCSys.Regions.Examples.AnGDL with a tolerance of 0.0001 in Dymola
  // 2014:
  //   Gaussian, LH, Stoney, SIAK, SIKmol, SIKs, SImmol, SIms, SImols
  // 2013/12/2:  LH is the only unit system that has steady, zero velocity
  // when FCSys.Subregions.Examples.Subregions is initialized with uniform
  // pressure.
  final constant Q.Angle cyc=base.cyc "cycle";
  final constant Q.Wavenumber R_inf=base.R_inf
    "<html>Rydberg constant (<i>R</i><sub>&infin;</sub>)</html>";
  final constant Q.Velocity c=base.c
    "<html>speed of light in vacuum (<i>c</i>)</html>";
  final constant Q.ConductanceElectrical G_0=base.G_0
    "<html>conductance quantum (<i>G</i><sub>0</sub>)</html>";
  final constant Q.MagneticFlux Phi_0=base.Phi_0
    "<html>magnetic flux quantum (&Phi;<sub>0</sub>)</html>";
  final constant Q.Number k_F=base.k_F
    "<html>Faraday constant (<i>k</i><sub>F</sub>)</html>";
  final constant Q.Number R=base.R "gas constant";

  // -------------------------------------------------------------------------
  // SI units that depend on transcendental and arbitrated empirical numbers
  // -------------------------------------------------------------------------
  final constant Q.Angle rad=cyc/(2*pi) "radian";
  // SI unit of plane angle
  // Note:  [BIPM2006] defines rad = 1, but this trigonometric relation is
  // used instead, where the cycle (cyc) is an independent base unit.
  constant Q.Length m=10973731.568539*cyc/R_inf "meter";
  // SI unit of length
  // This is the "Rydberg constant" relation [NIST2010] with the unit cycle
  // explicitly included in the wavenumber.  The Rydberg constant can be
  // determined by measuring the spectra of hydrogen, deuterium, and
  // antiprotonic helium [http://en.wikipedia.org/wiki/Rydberg_constant].
  constant Q.Time s=299792458*m/c "second";
  // SI unit of time or duration
  // This is the "speed of light in vacuum" relation [NIST2010].  One way that
  // the speed of light can be determined is by measuring the time for
  // electromagnetic waves to travel to and from spacecraft
  // [https://en.wikipedia.org/wiki/Speed_of_light#Astronomical_measurements].
  constant Q.MagneticFlux Wb=483597.870e9*Phi_0 "weber";
  // SI unit of magnetic flux
  // This is the based on the "Josephson constant" relation [NIST2010], given
  // that the Josephson constant is the reciprocal of the magnetic flux
  // quantum.  The Josephson constant can be determined by measuring
  // supercurrent across a Josephson junction
  // [http://en.wikipedia.org/wiki/Josephson_effect].
  constant Q.ConductanceElectrical S=25812.8074434*G_0/2 "siemen";
  // SI unit of electrical conductance
  // This is based on the "von Klitzing constant" relation [NIST2010], given
  // that the von Klitzing constant is twice the reciprocal of the conductance
  // quantum and the siemen is the reciprocal of the ohm.  The von Klitzing
  // constant can be determined by measuring the quantum hall effect
  // [http://en.wikipedia.org/wiki/Quantum_Hall_effect].
  constant Q.Amount mol=96485.3365*Wb*cyc*S/k_F "mole";
  // SI unit of chemical amount
  // This is the "Faraday constant" relation [NIST2010].  The factor of
  // Wb*cyc*S is the coulomb, which is defined below.  The Faraday constant
  // can be determined by electrochemical experiments relating the charge and
  // the chemical amount involved in a reaction.
  constant Q.Potential K=8.3144621*(Wb*cyc)^2*S/(s*mol*R) "kelvin";
  // SI unit of thermodynamic temperature
  // This is the "molar gas constant" relation [NIST2010].  The factor of
  // (Wb*cyc)^2*S/s is the joule, which is defined below.  The gas consant can
  // be determined by measuring acoustic resonation (see
  // http://nvlpubs.nist.gov/nistpubs/sp958-lide/339-343.pdf).  The gas
  // constant is directly related to the Boltzmann constant through other
  // constants above (see the definition of k_B below).  The Boltzmann
  // constant can be determined (among other ways) by measuring thermal
  // electronic noise
  // [http://en.wikipedia.org/wiki/Johnson-Nyquist_noise].

  // -------------------------------------------------------------------------
  // SI base units [BIPM2006, Table 1] and intermediate units
  // -------------------------------------------------------------------------
  // Note:  Only A, kg, and cd remain (cd, m, s, K, and mol defined above).

  final constant Q.Frequency Hz=cyc/s "hertz";
  // SI unit of frequency
  // Note:  [BIPM2006] defines Hz = 1/s, but that conflicts with the common
  // definition of the hertz as "one cycle per second"
  // [https://en.wikipedia.org/wiki/Hertz].  Since BIPM defines rad = 1 and
  // trigonometry requires cyc = 2*pi*rad (see above), BIPM implies that
  // Hz = cyc/(2*pi*s) -- an inconsistency.
  final constant Q.Potential V=Wb*Hz "volt";
  // SI unit of EMF
  // Note:  [BIPM2006] defines Wb = V*s, but Wb = V/Hz is used here (which is
  // different, see above) to be explicit in angle.
  final constant Q.Current A=V*S "ampere";
  // SI unit of rate of charge
  final constant Q.Amount C=A*s "coulomb";
  // SI unit of charge
  final constant Q.Energy J=V*C "joule";
  // SI unit of energy
  final constant Q.Velocity2 Gy=(m/s)^2 "gray";
  // SI unit of specific energy (imparted by radiation into material)
  final constant Q.Mass kg=J/Gy "kilogram";
  // SI unit of mass
  final constant Q.Power W=J/s "watt";
  // SI unit of power
  final constant Q.Power lm=W/683 "lumen";
  // SI unit of luminous flux
  // Note:  This results in the candela (cd, below) being a dependent unit,
  // but [BIPM2006] defines cd independently (see doc).
  final constant Q.Angle2 sr=rad^2 "steradian";
  // SI unit of solid angle
  // Note: [BIPM2006] defines sr = 1, which is consistent with the common
  // definition of the steradian as the square of the radian (rad)
  // [https://en.wikipedia.org/wiki/Steradian] only because [BIPM2006] defines
  // rad = 1.  Here, the common definition is applied directly.
  final constant Q.PowerRadiant cd=lm/sr "candela";
  // SI unit of luminous intensity

  // -------------------------------------------------------------------------
  // SI derived units with special names and symbols [BIPM2006, Table 3]
  // -------------------------------------------------------------------------
  // Note:  rad, sr, Hz, Wb, S, V, C, J, lm, and Gy have already been defined.
  // Degree celsius is only defined in setup(), to_degC(), and from_degC()
  // since it includes an offset.  Becquerel (Bq) and sievert (Sv) are
  // excluded since they have the same value as hertz (Hz) and gray (Gy),
  // respectively.

  final constant Q.Force N=J/m "newton";
  // SI unit of force
  final constant Q.Pressure Pa=N/m^2 "pascal";
  // SI unit of pressure
  final constant Q.MagneticFluxAreic T=Wb/m^2 "tesla";
  // SI unit of magnetic flux density
  final constant Q.PowerAreic lx=lm/m^2 "lux";
  // SI unit of illuminance
  final constant Q.Capacitance F=s*S "farad";
  // SI unit of capacitance
  final constant Q.ResistanceElectrical ohm=1/S "<html>ohm (&Omega;)</html>";
  // SI unit of electrical resistance
  final constant Q.Inductance H=s/S "henry";
  // SI unit of inductance
  // Note:  The definition in [BIPM2006], H = Wb/A, is not valid here because
  // angle is included explicitly in magnetic flux (i.e., Wb = V/Hz = V*s/cyc,
  // not Wb = V*s).
  final constant Q.Current kat=mol/s "katal";
  // SI unit of catalytic activity
  final constant Q.Mass g=kg/kilo "gram";
  // CGS unit of mass
  // The base SI unit of mass includes a prefix.  See section 3.2 of
  // [BIPM2006].

  // -------------------------------------------------------------------------
  // Non-SI units accepted for use with SI units [BIPM2006, Table 6]
  // -------------------------------------------------------------------------

  final constant Q.Time min=60*s "minute";
  final constant Q.Time hr=60*min "hour";
  final constant Q.Time day=24*hr "day";
  final constant Q.Angle degree=cyc/360 "<html>degree (&deg;)</html>";
  final constant Q.Volume L=(deci*m)^3 "liter (L or l)";

  // -------------------------------------------------------------------------
  // Derived physical constants and units
  // -------------------------------------------------------------------------
  // Note:  These are established by definition, but may include
  // transcendental mathematical factors.

  // Electrical -- involving conductance
  final constant Q.Number alpha=1e-7*pi*c*s*G_0/(m*S)
    "<html>fine-structure constant (&alpha;)</html>";
  // The fine-structure constant is simply the product of 1e-7, pi, the speed
  // of light in meters per second, and the conductance quantum in siemens.
  // Each of these four factors is dimensionless, so the fine-structure
  // constant is dimensionless too.
  final constant Q.ResistanceElectrical Z_0=4*alpha/G_0
    "<html>characteristic impedance of vacuum (<i>Z</i><sub>0</sub>)</html>";
  final constant Q.Permeability mu_0=Z_0/(c*cyc)
    "<html>magnetic constant (&mu;<sub>0</sub>)</html>";
  // This is also known as the vacuum permeability, the permeability of free
  // space, or the magnetic constant.
  final constant Q.Permittivity epsilon_0=1/(Z_0*c)
    "<html>electric constant (&epsilon;<sub>0</sub>)</html>";
  // This is also known as the vacuum permittivity or the permittivity of free
  // space.

  // Electromagnetism -- involving conductance and magnetic flux
  final constant Q.Amount q=G_0*Phi_0*cyc "elementary charge";
  // Note:  The factor of cyc is included to be explicit in angle.
  final constant Q.Energy eV=q*V "electron volt";
  final constant Q.MomentumRotational h=2*q*Phi_0 "Planck constant";
  final constant Q.Energy E_h=2*R_inf*h*c
    "<html>Hartree energy (<i>E</i><sub>h</sub>)</html>";

  // Chemistry
  final constant Q.AmountReciprocal N_A=k_F/q
    "<html>Avogadro constant (<i>N</i><sub>A</sub>)</html>";

  // Thermal physics
  final constant Q.Amount k_B=R/N_A
    "<html>Boltzmann constant (<i>k</i><sub>B</sub>)</html>";
  final constant Q.PowerAreicPerPotential4 sigma=2*pi^5*k_B^4/(15*(h*cyc)^3*c
      ^2) "<html>Stefan-Boltzmann constant (&sigma;)</html>";
  // See http://en.wikipedia.org/wiki/Stefan-Boltzmann_constant.  This
  // equation can be derived from Planck's law for spectral radiance:
  //   B = 2*(h*f)^3/(h*cyc*c)^2/(exp(h*f/(k_B*T)) - 1).
  // where the factor of cyc has been included to be explicit in angle.  The
  // previous equation can be written as:
  //   B*(h*cyc*c)^2/(2*((k_B*T))^3) = (h*f/(k_B*T))^3/(exp(h*f/(k_B*T)) - 1).
  // The RHS is multiplied by pi due to integration over the half sphere and
  // the LHS is multiplied by h/(k_B*T) due to substitution prior to
  // integration [http://en.wikipedia.org/wiki/Stefan-Boltzmann_law].  Now,
  // the equation is:
  //   B*(h*cyc)^3*c^2/(2*(k_B*T)^4) = pi*(h*f/T)^3/(exp(h*f/(k_B*T)) - 1).
  // The integral of the RHS as a function of (h*f/(k_B*T)) over the entire
  // frequency domain (0 to infinity) is pi^4/15.  Finally, this results in:
  //   B_tot/T^4 = 2*pi^5*k_B^4/(15*(h*cyc)^3*c^2),
  // where the RHS is the Stefan-Boltzmann constant.
  final constant Q.PowerArea c_1=2*pi*h*cyc*c^2
    "<html>first radiation constant (<i>c</i><sub>1</sub>)</html>";
  // Note:  The factor of cyc is included to be explicit in angle.
  final constant Q.PotentialPerWavenumber c_2=h*c/k_B
    "<html>second radiation constant (<i>c</i><sub>2</sub>)</html>";
  final constant Q.PotentialPerWavenumber c_3_lambda=c_2/4.965114231744276
    "<html>Wien wavelength displacement law constant (<i>c</i><sub>3 &lambda;</sub>)</html>";
  // See the notes for c_3_nu below.  The derivation is similar, but the
  // number is the solution to exp(x)*(5 - x) = 5.  Note that the frequency
  // displacement constant isn't directly related to the wavelength
  // displacement constant "[b]ecause the spectrum resulting from Planck's law
  // of black body radiation takes a different shape in the frequency domain
  // from that of the wavelength domain."
  // [http://en.wikipedia.org/wiki/Wien's_displacement_law, accessed
  // 1/19/10].
  final constant Q.MagneticFluxReciprocal c_3_f=2.821439372122079*k_B/h
    "<html>Wien frequency displacement law constant (<i>c</i><sub>3 <i>f</i></sub>)</html>";
  // The Wien displacement constant can be derived by setting the derivative
  // of Planck's law to zero and solving for h*f/(k_B*T) in order to find the
  // frequency at maximum radiant intensity.  That procedure results in
  // solving the following equation: exp(x)*(3 - x) = 3, where x is h*f/k_B.
  // The number above (2.821...) is Mathematica's solution
  // (FCSys/Resources/Documentation/Units/math-constants.cdf).

  // -------------------------------------------------------------------------
  // Other selected non-SI units from [BIPM2006, Table 8]
  // -------------------------------------------------------------------------
  // Note:  Logarithmic ratios have been excluded because they can't be
  // represented in Dymola's unit conversion GUI.

  final constant Q.Pressure bar=1e5*Pa "bar";
  final constant Q.Length angstrom=0.1*nano*m
    "<html>angstrom (&#8491;)</html>";

  // -------------------------------------------------------------------------
  // Additional units that are useful for this library
  // -------------------------------------------------------------------------

  final constant Q.Angle2 sp=4*pi*sr "spat";
  // Solid angle of one sphere
  final constant Q.Pressure atm=101325*Pa "atmosphere";
  // Value from "standard atmosphere" [NIST2010]
  final constant Q.Pressure kPa=kilo*Pa "kilopascal";
  final constant Q.Energy kJ=kilo*J "kilojoule";
  final constant Q.Time ms=milli*s "millisecond";
  final constant Q.Current mA=milli*A "milliampere";
  final constant Q.Length cm=centi*m "centimeter";
  final constant Q.Length mm=milli*m "millimeter";
  final constant Q.Length um=micro*m "micrometer";
  final constant Q.Length nm=nano*m "nanometer";
  final constant Q.Volume cc=cm^3 "cubic centimeter";
  final constant Q.Number '%'=centi "percent (%)";
  final constant Q.Density M=mol/L "molar";
  annotation (
    Documentation(info="<html>  
<p>The information below has been updated and adapted from 
[<a href=\"modelica://FCSys.UsersGuide.Publications.Davies2012b\">Davies2012b</a>].  
That paper also offers suggestions as to how the approach might be 
better integrated in the <a href=\"http://www.modelica.org\">Modelica 
language</a>.  For more information, please also see the documentation 
of the <a href=\"modelica://FCSys.Quantities\">Quantities</a> package.</p>

<p><b>Introduction and Overview:</b></p>

<p>Mathematical models of physical systems use variables to represent 
physical quantities. As stated by the Bureau International des Poids et 
Mesures (BIPM) [<a href=\"modelica://FCSys.UsersGuide.References.BIPM2006\">BIPM2006</a>, 
p.&nbsp;103]:</p> <blockquote> \"The value of a quantity 
is generally expressed as the product of a number and a unit.  The unit 
is simply a particular example of the quantity concerned which is used as 
a reference, and the number is the ratio of the value of the quantity to 
the unit.\" </blockquote> <p>In general, a unit may be the product of 
other units, whether they are base units or units derived from the base 
units in the same manner.</p>

<p>In <a href=\"http://www.modelica.org\">Modelica</a>, a physical 
quantity is represented by a variable which is an instance of the 
<code>Real</code> type.  Its <code>value</code> attribute is a number 
associated with the value of the quantity (not the value of the quantity 
itself, as will be shown).  Usually the <code>value</code> attribute is 
not referenced explicitly because it is automatically returned when the 
variable itself is referenced. The <code>unit</code> attribute is a string that 
describes the unit by which the value of the quantity has been divided to 
arrive at the number.  The <code>displayUnit</code> attribute (also a 
string) describes the unit by which the value of the quantity should be 
divided to arrive at the number as it is entered by or presented to the 
user.  The <code>Real</code> type contains other attributes as well, 
including the <code>quantity</code> string.</p>

<p>The <a href=\"modelica://Modelica.SIunits\">SIunits</a> package of the 
<a href=\"modelica://Modelica\">Modelica Standard Library</a> contains 
types that extend from the <code>Real</code> type.  The type definitions 
modify the <code>unit</code>, <code>displayUnit</code>, and 
<code>quantity</code> attributes (among others) to represent various 
physical quantities.  The <code>unit</code> and <code>displayUnit</code> 
attributes are based on the International System of Units (Syst&egrave;me 
international d'unit&eacute;s, SI). The <code>quantity</code> string is 
the name of the physical quantity.  For example, the 
<a href=\"modelica://Modelica.SIunits.Velocity\">Velocity</a>  type has a 
<code>unit</code> of \"m/s\" and a <code>quantity</code> of \"Velocity\".  
If an instance of <a href=\"modelica://Modelica.SIunits.Velocity\">Velocity</a> 
has a <code>value</code> of one (<i>v</i> = 1), then it is 
meant that \"the value of velocity is one meter per second.\"  Again, the 
<code>value</code> attribute represents the number, or the value of the 
quantity divided by the unit, not the value of the quantity itself.</p>

<p>This conflict is solved in <a href=\"modelica://FCSys\">FCSys</a> 
by establishing units as mathematical entities and writing 
<i>v</i> = 1&nbsp;m/s (in code, <code>v = 1*U.m/U.s</code> or simply 
<code>v = U.m/U.s</code>, where <code>U</code> is an abbreviation for this 
package). Here, the variable <i>v</i> directly represents the quantity. 
Its <code>value</code> attribute is truly the value of the quantity in the 
context of the statement by BIPM (above). One advantage is that unit 
conversion is handled naturally.  The essence of unit conversion is the 
phrase \"value of a quantity in a unit\" typically means \"value of a 
quantity divided by a unit.\"  Continuing with the previous example, 
<i>v</i> is divided by m/s in order to display <i>v</i> in meters per 
second (as a number).  If another unit of length like the foot is 
established by the appropriate relation (ft &asymp; 0.3048&nbsp;m) and 
<i>v</i> is divided by ft/s, the result is velocity in feet per second 
(&sim;3.2894).  Some units such as &deg;C, Pag, and dB involve offsets or 
nonlinear transformations between the value of the quantity and the 
number; these are described by functions besides simple division.</p>

<p><b>Method:</b></p>

<p>In <a href=\"modelica://FCSys\">FCSys</a>, each unit is a constant 
quantity. The values of the units, like other quantities, is the product 
of a number and a unit. Therefore, units may be derived from other units 
(e.g., cyc = 2&pi;&nbsp;rad). This recursive definition leaves several 
units (in SI, 7) that are locally independent and must be established 
universally.  These base units are established by the \"particular example 
of the quantity concerned which is used as a reference\" quoted previously 
[<a href=\"modelica://FCSys.UsersGuide.References.BIPM2006\">BIPM2006</a>].  
The choice of the base units is somewhat arbitrary [<a 
href=\"modelica://FCSys.UsersGuide.References.Fritzson2004\">Fritzson2004</a>, 
p.&nbsp;375], but regardless, there are a number of 
units that must be defined by example.</p> 

<p>If only SI will be used, then it is easiest to set each of the base 
units of SI equal to one&mdash;the meter (m), kilogram (kg), second (s), 
ampere (A), kelvin (K), mole (mol), and candela (cd).  This is implicitly 
the case in the <a href=\"modelica://Modelica.SIunits\">SIunits</a> 
package, but again, it hardly captures the idea that the value of a 
quantity is the product of a number and a unit.</p>

<p>Instead, in <a href=\"modelica://FCSys\">FCSys</a>, the base units are 
established by universal physical constants (except the unit cycle, which 
is physically arbitrary). The \"particular example of the quantity\" 
[<a href=\"modelica://FCSys.UsersGuide.References.BIPM2006\">BIPM2006</a>] is 
an experiment that yields precise and universally repeatable results in 
determining a constant rather than a prototype (e.g., the International 
Prototype of the Kilogram) which is carefully controlled and distributed 
via replicas. This method of defining the base units from measured 
physical quantities (rather than vice versa) is natural and reflects the 
way that standards organizations (e.g., <a href=\"http://www.nist.gov/\">NIST</a>) 
define units. A system of units is considered to be natural if 
all of its base units are established by universal physical constants. 
Often, those universal constants are defined to be equal to one, but the 
values can be chosen to scale the numerical values of variables during 
simulation.</p>

<p>There are physical systems where typical quantities are many orders of 
magnitude larger or smaller than the related product of powers of base SI 
units (e.g., the domains of astrophysics and atomic physics).  In modeling 
and simulating those systems, it may be advantageous to choose 
appropriately small or large values (respectively) for the corresponding 
base units so that the product of the number (large or small in magnitude) 
and the unit (small or large, respectively) is well-scaled.  Products of 
this type are often involved in initial conditions or parameter 
expressions, which are not time-varying.  Therefore, the number and the 
unit can be multiplied before the dynamic simulation.  During the 
simulation, only the value is important.  After the simulation, the 
trajectory of the value may be divided by the unit for display.  This 
scaling is usually unnecessary due to the wide range and appropriate 
distribution of the real numbers that are representable in floating 
point.  The Modelica language specification recommends that floating point 
numbers be represented in at least IEEE double precision, which covers 
magnitudes from &sim;2.225&times;10<sup>-308</sup> to 
&sim;1.798&times;10<sup>308</sup> [<a href=\"modelica://FCSys.UsersGuide.References.Modelica2010\">Modelica2010</a>,
 p.&nbsp;13]. However, in some cases it may be preferable to scale the 
units and use lower precision for the sake of computational performance.  
There are fields of research where, even today, simulations are sometimes 
performed in single precision [<a href=\"modelica://FCSys.UsersGuide.References.Brown2011\">Brown2011</a>, 
<a href=\"modelica://FCSys.UsersGuide.References.Hess2008\">Hess2008</a>] and 
where scaling is a concern [<a href=\"modelica://FCSys.UsersGuide.References.Rapaport2004\">Rapaport2004</a>, 
p.&nbsp;29].</p> 

<p>The method is neutral with regards to not only the values of the base 
units, but also the choice of the base units and even the number of base 
units.  This is an advantage because many systems of units besides SI are 
used in science and engineering. As mentioned previously, the choice of 
base units is somewhat arbitrary, and different systems of units are based 
on different choices.  Some systems of units have fewer base units (lower 
rank) than SI, since additional constraints are added that exchange base 
units for derived units.  For example, the Planck, Stoney, Hartree, and 
Rydberg systems of units define the Boltzmann constant to be equal to one 
(<i>k</i><sub>B</sub> = 1) 
[<a href=\"http://en.wikipedia.org/wiki/Natural_units\">http://en.wikipedia.org/wiki/Natural_units</a>]. 
The unit K is eliminated 
[<a href=\"modelica://FCSys.UsersGuide.References.Greiner1995\">Greiner1995</a>, 
p.&nbsp;386] or, more precisely, considered a derived 
unit instead of a base unit.  In SI, the kelvin would be derived from the 
units kilogram, meter, and second (K &asymp; 
1.381&times;10<sup>-23</sup>&nbsp;kg&nbsp;m<sup>2</sup>/s<sup>2</sup>).</p> 

<p>There are seven independent units and constants in the 
<a href=\"modelica://FCSys.Units\">Units</a> package (cyc, 
<i>R</i><sub>&infin;</sub>, <i>c</i>, <i>G</i><sub>0</sub>, &Phi;<sub>0</sub>,  
<i>k</i><sub>F</sub>, and <i>R</i>; see 
<a href=\"modelica://FCSys.Units.Bases\">Units.Bases</a>), which are related 
to the seven SI base units (m, kg, s, A, K, mol, and cd). The primary 
relations are between 
<i>R</i><sub>&infin;</sub> and m,
<i>c</i> and s,
<i>G</i><sub>0</sub> and A, 
&Phi;<sub>0</sub> and V,
<i>k</i><sub>F</sub> and mol, and
<i>R</i> and K.
The cycle (cyc) is defined independently, but the candela (cd) is considered a 
derived unit (1/683&nbsp;W/sr).</p>
  
<p>Although the Faraday constant (<i>k</i><sub>F</sub> or 
96485.3399&nbsp;C/mol) and the gas constant (<i>R</i> or 
8.314472&nbsp;J/(mol&nbsp;K)) are among the independent constants, 
they are normalized to one in order to simplify the model equations 
and allow electrons and chemical species to be to represented by the 
same base <a href=\"modelica://FCSys.Species.Species\">Species</a> 
model. The normalization of the Faraday constant implies that 
the coulomb (C) is an amount (not necessarily of charge) which is 
proportional to the mole (mol). The additional normalization of 
the gas constant (R or 8.314472&nbsp;J/(mol&nbsp;K)) implies that 
the kelvin (K) is a potential which is proportional to the volt (V or 
J/C).</p>
  
  
<p><b>Implementation:</b></p>

<p>The units and constants are defined as variables in this 
<a href=\"modelica://FCSys.Units\">Units</a> package.  Each is a 
<code>constant</code> of the appropriate type from the 
<a href=\"modelica://FCSys.Quantities\">Quantities</a> package. The first 
section of this package establishes mathematical constants.  The next section 
establishes the independent constants and units, which grouped in a 
<code>replaceable</code> subpackage.  The third section  establishes the 
constants and units which may be derived from the base units and constants 
using  transcendental and accepted empirical relations.  The rest of the 
code establishes the SI prefixes  and the remaining derived units and 
constants.  The SI prefixes are included in their  unabbreviated form in 
order to avoid naming conflicts.  All of the primary units of SI  are 
included (Tables 1 and 3 of  [<a href=\"modelica://FCSys.UsersGuide.References.BIPM2006\">BIPM2006</a>]) except 
for &deg;C, since  it involves an offset.  Other units such as the 
atmosphere (atm) are included for convenience.  Some units that include 
prefixes are defined as well (e.g., kg, mm, and kPa).  However,  most 
prefixes must be given as explicit factors (e.g., 
<code>U.kilo*U.m</code>).</p>
 
<p>Besides the units and constants, this package also contains functions 
(e.g., <a href=\"modelica://FCSys.Units.to_degC\">to_degC</a>) that   
convert quantities from the unit system defined in <a href=\"modelica://FCSys\">FCSys</a> 
to quantities   expressed in units.  These functions are included for units 
that involve offsets<!-- or other functions besides simple scaling-->.   For 
conversions that require just a scaling factor, it is simpler to use the 
units directly.  For example, to convert from potential in volts use <code>v = 
v_V*U.V</code>,   where <code>v</code> is potential and <code>v_V</code> 
is potential expressed in volts.</p>
 
<p>This package (<a href=\"modelica://FCSys.Units\">Units</a>) is 
abbreviated as <code>U</code> for convenience throughout   the rest of 
<a href=\"modelica://FCSys.FCSys\">FCSys</a>.  For example, an initial 
pressure might be defined as   <i>p</i><sub>IC</sub> = 
<code>U.atm</code>.</p>

<p>An instance of the <a href=\"modelica://FCSys.Conditions.Environment\">Environment</a> 
model is usually included at the top level of a model.  
It records the base units and constants so that it is possible to 
re-derive all of the other units and constants.  This is important in 
order to properly interpret simulation results if the base units and 
constants are later re-adjusted.</p>

<p>The <a href=\"modelica://FCSys.Units.setup\">Units.setup</a> function 
establishes unit conversions using the values of the units, constants, and 
prefixes.  These unit conversions may include offsets. The function also 
sets the default display units.  It is automatically called when 
<a href=\"modelica://FCSys\">FCSys</a> is loaded from the 
<a href=\"modelica://FCSys/../load.mos\">load.mos</a> script.  It can also be called 
manually from the \"Re-initialize the units\" command available in the 
Modelica development environment from the <a href=\"modelica://FCSys.Units\">Units</a> 
package or any subpackage.  A spreadsheet 
(<a href=\"modelica://FCSys/Resources/quantities.xls\">Resources/quantities.xls</a>) 
is available to help maintain the quantities, default units, and the setup 
function.</p>

<p>The values of the units, constants, and prefixes can be evaluated by 
translating the <a href=\"modelica://FCSys.Units.Examples.Evaluate\">Units.Examples.Evaluate</a> 
model.  This defines the values in the workspace of the Modelica development 
environment. For convenience, the <a href=\"modelica://FCSys/../load.mos\">load.mos</a> 
script automatically does this and saves the result as \"units.mos\" in the working 
directory.</p>
 
<p>Where the <code>der</code> operator is used in models, it is explicitly 
divided by the unit second (e.g., <code>der(x)/U.s</code>).  This is 
necessary because the global variable <code>time</code> is in seconds 
(i.e., <code>time</code> is a number, not a quantity).</p>

<p>Although it is not necessary due to the acausal nature of 
<a href=\"http://www.modelica.org\">Modelica</a>, the declarations in this 
package are sorted so that they can be easily ported to imperative or 
causal languages (e.g.,   <a href=\"http://www.python.org\">Python</a> 
and C).  In fact, this has been done in the included 
<a href=\"modelica://FCSys/Resources/Source/Python/doc/index.html\">FCRes</a> 
module for plotting and analysis.</p>


<p><b>Some Notes on Angle:</b></p>

<p>As mentioned in the <a href=\"modelica://FCSys.Quantities\">Quantities</a> 
package, angle is a dimension.  This is different from 
SI, where angle is considered dimensionless (rad = 1) 
[<a href=\"modelica://FCSys.UsersGuide.References.BIPM2006\">BIPM2006</a>].<sup><a href=\"#fn1\" id=\"ref1\">1</a></sup>
Units of angle such as cycle (cyc), 
radian (rad), and degree must be explicitly included in the expression of 
quantities.  The radian is defined as the cycle divided by two pi (rad = 
cyc/2&pi;), which is not necessarily one because the cycle is an 
independent base unit (as mentioned above).  Solid angle has the dimensionality of 
squared angle; the streradian (sr) is defined as the squared radian 
(rad<sup>2</sup>), not one. Wavenumber has a dimensionality of angle per 
length (e.g., can be expressed in cyc/cm) and frequency has a dimensionality of angle per 
time.  The hertz (Hz) is defined as cyc/s (not 1/s).  The weber (Wb) is 
defined as V/Hz (not V&nbsp;s) and the henry (H) is defined as V&nbsp;s/A
(not Wb/A).  Planck's constant (<i>h</i>) can be expressed in J/Hz or 
J&nbsp;s/rad (not J&nbsp;s).  The magnetic constant and Amp&egrave;re's force 
constant can be expressed in Wb/(A&nbsp;m), not H/m (see below).</p>

<p>The explicit inclusion of angle has four advantanges.  The first is that it 
avoids a conflict in the definition of SI units.  BIPM defines the hertz 
as the reciprocal second (Hz = s<sup>-1</sup>), but states that \"[t]he SI 
unit of frequency is given as the hertz, implying the unit cycles per 
second\" [<a href=\"modelica://FCSys.UsersGuide.References.BIPM2006\">BIPM2006</a>]. 
Due to trigonometry (cyc = 2&pi;&nbsp;rad), BIPM's 
definition of the radian as one (rad = 1) implies that the cycle is two pi 
(cyc = 2&pi;) and the hertz is not cycles per second but rather cycles per 
second divided by two pi (Hz = cyc/(2&pi;&nbsp;s)).</p>

<p>The second advantage is that the explicit inclusion of angle avoids the 
need to use different variables depending on the chosen unit of angle.  If 
a variable represents a quantity (e.g., angle) directly, then its value 
does not depend on the chosen unit (e.g., of angle).  A single variable 
can be used regardless of which unit the angle is ultimately expressed in. 
For example, frequency is sometimes represented by a variable in hertz 
(e.g., &nu;) and other times by a variable in radians per second (e.g., 
&omega;).  If angle is explcit, one variable will suffice (<i>f</i> = 
&nu;&nbsp;cyc/s = &omega;&nbsp;rad/s).  Likewise, there is no need for the 
reduced Planck constant (i.e., <i>h</i> &asymp; 
6.6260e-34&nbsp;J/Hz &asymp; 1.0545e-34&nbsp;J&nbsp;s/rad).</p>

<p>The third advantage appears when the size of a circle (variable <i>S</i>) is 
described in terms of length per angle&mdash;radius per radian (<i>r</i>/rad) 
or, equivalently, circumference per cycle.  This simplifies the 
representation of some common equations.  The circumference of one circle is 
<i>S</i>&nbsp;cyc, which is preferred over 2&pi;<i>r</i>.  The surface area of 
one sphere is <i>S</i><sup>2</sup>&nbsp;sp, where sp = 4&pi;&nbsp;sr is the 
spat, a unit of solid angle.<sup><a href=\"#fn2\" id=\"ref2\">2</a></sup>

<!--Coulomb's force law can be expressed using the electric constant (&epsilon;<sub>0</sub>) without 
a explicit factor of 1/4&pi;:  
<blockquote>
 <i>F</i> = (1/&epsilon;<sub>0</sub>)&nbsp;<i>q</i><sub>1</sub><i>q</i><sub>2</sub>/(<i>S</i><sup>2</sup>&nbsp;sp)
</blockquote>
where <i>S</i><sup>2</sup>&nbsp;sp is the surface area of the sphere centered between and touching the charges 
(<i>q</i><sub>1</sub> and <i>q</i><sub>2</sub>).
Since <i>S</i> = <i>r</i>/rad, sp = 4&pi;&nbsp;sr, and sr = rad<sup>2</sup>,
this is
<blockquote>
 <i>F</i> = <i>k</i><sub>e</sub>&nbsp;<i>q</i><sub>1</sub><i>q</i><sub>2</sub>/<i>r</i><sup>2</sup>
 </blockquote>
where <i>k</i><sub>e</sub> is the electric constant, which is 
1/(4*&pi;&epsilon;<sub>0</sub>) as expected.
Thus, there is no real 
need to maintain the electric force constant as a separate variable from 
the electric constant.-->

Amp&egrave;re's force law can be expressed using the magnetic constant (&mu;<sub>0</sub>) without 
an explicit factor of 1/2&pi;:  
<blockquote>
 <i>F</i> = &mu;<sub>0</sub>&nbsp;<i>I</i><sub>1</sub><i>I</i><sub>2</sub>&nbsp;<i>L</i>/<i>S</i>
</blockquote>
where <i>I</i><sub>1</sub> and <i>I</i><sub>2</sub> are the currents, 
<i>L</i> is the length of each wire, and <i>F</i> is the force.  
Since <i>S</i> = <i>r</i>/rad, rad = cyc/2&pi;, and 
&mu;<sub>0</sub> = 4&pi;&times;10<sup>−7</sup>&nbsp;Wb/(A&nbsp;m), where 
Wb = V/Hz = V&nbsp;s/cyc, this is
<blockquote>
 <i>F</i> = 2<i>k</i><sub>A</sub>&nbsp;<i>I</i><sub>1</sub><i>I</i><sub>2</sub>&nbsp;<i>L</i>/<i>r</i>
</blockquote>
where <i>k</i><sub>A</sub> is the magnetic force constant 
(10<sup>−7</sup>&nbsp;N/A<sup>2</sup>) as expected.  Thus, there is no real 
need to maintain the magnetic force constant as a separate variable from 
the magnetic constant.  

The inductance of a solenoid can be expressed as 
&mu;<i>N</i><i>A</i>/<i>L</i>&prime;, where &mu; is the permeability 
(product of relative permeability and &mu;<sub>0</sub>, with the same
dimensionality as &mu;<sub>0</sub>) and <i>A</i> is the projected cross-sectional 
area of the solenoid.  The variable <i>N</i> represents the
number of turns, which is dimensionless.<sup><a href=\"#fn3\" id=\"ref3\">3</a></sup>
<i>L</i>&prime; is the pitch&mdash;the length of the solenoid divided by the
wrapped angle.  Its dimensionality is length per angle.  Therefore, the angle 
in the denominators of &mu; and <i>L</i>&prime; cancel; angle does not
appear in the dimensionality of inductance.
</p>


<p>Finally, the potential confusion with energy and torque in SI 
[<a href=\"modelica://FCSys.UsersGuide.References.BIPM2006\">BIPM2006</a>] can
be eliminated using explicit angles and the concept of the size of a circle.  If torque is 
expressed as the product of force and the size of the circular path (not 
radius), then it has the dimensionality of energy per angle, which is clearly
distinct from energy.  The angle cancels in the expression of rotational
power as the product of torque and rotational velocity (angle per time).</p>


<hr>

<p id=\"fn1\"><small>1. The common argument that angle is 
dimensionless (\"angle is a ratio of lengths\") is flawed.    It is not 
correct to say that \"angle is the ratio of arclength to radius.\"    
Rather, angle in radians is the ratio of arclength to radius   
(&theta;/rad = <i>L</i>/<i>r</i>).  It is not necessary that angle 
(&theta;)   is dimensionless, only that angle and radian (rad) have the 
same dimension.   In <a href=\"modelica://FCSys\">FCSys</a>, that 
dimension is called angle.   The common (and correct) understanding is 
that the radian (rad) is a unit of angle,   just as the meter (m) is a 
unit of length.  The dimensionality of the radian  is angle, just as 
the dimensionality of the meter is length.<a href=\"#ref1\" title=\"Jump 
back to footnote 1 in the text.\">&#8629;</a></small></p>

<p id=\"fn2\"><small>2. The spat (sp) is the solid angle of one sphere, just 
as the cycle (cyc) is the angle of one circle.  For mnemonic purposes, sp can be 
considered as the abbreviation for sphere as well as spat.<a href=\"#ref2\" title=\"Jump 
back to footnote 2 in the text.\">&#8629;</a></small></p>

<p id=\"fn3\"><small>3. The number of turns (<i>N</i>) is the wrapped angle 
(&Theta;) expressed in cycles (i.e., turns): <i>N</i> = &Theta;/cyc.  Thus, it
is a dimensionless ratio.<a href=\"#ref3\" title=\"Jump 
back to footnote 3 in the text.\">&#8629;</a></small></p>

<p><b>Licensed by the Hawaii Natural Energy Institute under the Modelica 
License 2</b><br> Copyright &copy; 2007&ndash;2014, <a href=\"
http://www.hnei.hawaii.edu/\">Hawaii Natural Energy Institute</a> and <a 
href=\"http://www.gtrc.gatech.edu/\">Georgia Tech Research 
Corporation</a>.</p>
 
<p><i>This Modelica package is <u>free</u> software and the use is 
completely at <u>your own risk</u>; it can be redistributed and/or 
modified under the terms of the Modelica License 2. For license conditions 
(including the disclaimer of warranty) see <a href=\"
modelica://FCSys.UsersGuide.License\"> FCSys.UsersGuide.License</a> or 
visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> 
http://www.modelica.org/licenses/ModelicaLicense2</a>.</i></p>
</html>"),
    Commands(executeCall=FCSys.Units.setup() "Re-initialize the units."),
    Icon(graphics={
        Line(
          points={{-66,78},{-66,-40}},
          color={64,64,64},
          smooth=Smooth.None),
        Ellipse(
          extent={{12,36},{68,-38}},
          lineColor={64,64,64},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-74,78},{-66,-40}},
          lineColor={64,64,64},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-66,-4},{-66,6},{-16,56},{-16,46},{-66,-4}},
          lineColor={64,64,64},
          smooth=Smooth.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,16},{-40,22},{-2,-40},{-10,-40},{-46,16}},
          lineColor={64,64,64},
          smooth=Smooth.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,26},{58,-28}},
          lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{68,2},{68,-46},{64,-60},{58,-68},{48,-72},{18,-72},{18,-64},
              {46,-64},{54,-60},{58,-54},{60,-46},{60,-26},{64,-20},{68,-6},{
              68,2}},
          lineColor={64,64,64},
          smooth=Smooth.Bezier,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}));

end Units;
