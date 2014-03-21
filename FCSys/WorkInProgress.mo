within FCSys;
package WorkInProgress "Incomplete classes under development"
  extends Modelica.Icons.Package;

  // Maximum line width before a new word is wrapped in the code listing in
  // the LaTeX document (76 characters, including leading spaces and // )
  // -------------------------------------------------------------------------

  model CellMSL
    "<html>Single-cell PEMFC with interfaces from the <a href=\"modelica://Modelica\">Modelica Standard Library</a></html>"
    extends FCSys.Icons.Cell;

    Assemblies.Cells.Examples.Cell cell(anFP(redeclare
          FCSys.Subregions.Subregion subregions(
          each final inclX=true,
          each inclY=true,
          each graphite('incle-'=true, 'e-'(perfectMaterialDiff={{{{true,false}}}})),

          each gas(inclH2=true, inclH2O=true))))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    inner FCSys.Conditions.Environment environment(analysis=false)
      annotation (Placement(transformation(extent={{40,60},{60,80}})));
    Conditions.Adapters.Phases.Graphite caModelicaAdapt(A=cell.L_y[1]*cell.L_z[
          1]) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Conditions.Adapters.Phases.Graphite anModelicaAdapt(A=cell.L_y[1]*cell.L_z[
          1])
      annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
    FCSys.WorkInProgress.TanConduct tanConduct
      annotation (Placement(transformation(extent={{10,40},{-10,60}})));
    Modelica.Blocks.Sources.Ramp loadSweep(duration=1000)
      "This is the arctangent of conductance."
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

  equation
    connect(anModelicaAdapt.normal, cell.anFPX[1, 1]) annotation (Line(
        points={{-20,6.10623e-16},{-16,6.10623e-16},{-16,5.55112e-16},{-10,
            5.55112e-16}},
        color={0,0,0},
        thickness=0.5,
        smooth=Smooth.None));

    connect(caModelicaAdapt.normal, cell.caFPX[1, 1]) annotation (Line(
        points={{20,6.10623e-16},{16,6.10623e-16},{16,5.55112e-16},{10,
            5.55112e-16}},
        color={0,0,0},
        thickness=0.5,
        smooth=Smooth.None));

    connect(loadSweep.y, tanConduct.atanGstar) annotation (Line(
        points={{-19,70},{-6.66134e-16,70},{-6.66134e-16,61}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(tanConduct.p, caModelicaAdapt.pin) annotation (Line(
        points={{10,50},{60,50},{60,4},{40,4}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(tanConduct.n, anModelicaAdapt.pin) annotation (Line(
        points={{-10,50},{-60,50},{-60,4},{-40,4}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (defaultComponentName="cell",experiment(StopTime=1000));
  end CellMSL;

  function plot "Create plots using FCRes"
    extends Modelica.Icons.Function;

  algorithm
    Modelica.Utilities.System.command("loadres");

  end plot;

  model ElectroOsmoticDrag
    "<html>Example to calibrate the coupling between H<sup>+</sup> and H<sub>2</sub>O in the PEM</html>"

    extends Regions.Examples.CLtoCL(anCL(redeclare model Subregion =
            Subregions.Subregion (ionomer(redeclare FCSys.Species.H2O.Gas.Fixed
                H2O(
                redeclare package Data = FCSys.Characteristics.'H+'.Ionomer,
                p_IC=65536*U.kPa,
                consMaterial=ConsThermo.IC)))), caCL(redeclare model Subregion
          = Subregions.Subregion (ionomer(redeclare FCSys.Species.H2O.Gas.Fixed
                H2O(
                redeclare package Data = FCSys.Characteristics.'H+'.Ionomer,
                p_IC=65536*U.kPa,
                consMaterial=ConsThermo.IC)))));

  end ElectroOsmoticDrag;

  model RegionsExamplesCLtoCLVoltage
    "Test one catalyst layer to the other, with prescribed voltage"

    extends Modelica.Icons.Example;
    output Q.Potential w=anCL.subregions[1, 1, 1].graphite.'e-'.g_boundaries[1,
        Side.n] - caCL.subregions[1, 1, 1].graphite.'e-'.g_boundaries[1, Side.p]
      if environment.analysis "Electrical potential";
    output Q.Current zI=-sum(anCL.subregions[1, :, :].graphite.'e-'.boundaries[
        1, Side.n].Ndot) if environment.analysis "Electrical current";
    output Q.Number J_Apercm2=zI*U.cm^2/(anCL.A[Axis.x]*U.A)
      "Electrical current density, in A/cm2";

    parameter Q.Length L_y[:]={8}*U.cm "Lengths in the y direction";
    parameter Q.Length L_z[:]={6.25}*U.cm "Lengths in the z direction";
    Regions.AnCLs.AnCL anCL(
      final L_y=L_y,
      final L_z=L_z,
      subregions(graphite(each inclDL=true, transfer(each fromI=false))))
      annotation (Placement(transformation(extent={{-30,30},{-10,50}})));

    Regions.PEMs.PEM PEM(
      final L_y=L_y,
      final L_z=L_z,
      subregions(ionomer('H+'(each consTransX=ConsTrans.dynamic))))
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
    Regions.CaCLs.CaCL caCL(
      final L_y=L_y,
      final L_z=L_z,
      subregions(graphite(each inclDL=true, transfer(each fromI=false)), each
          ORR('e-'(reaction(Ndot(stateSelect=StateSelect.always))))))
      annotation (Placement(transformation(extent={{10,30},{30,50}})));

    // Conditions
    Conditions.ByConnector.BoundaryBus.Single.Sink anBC[anCL.n_y, anCL.n_z](
        each gas(
        inclH2=true,
        inclH2O=true,
        H2(
          materialSet(y=environment.p_dry),
          redeclare function thermalSpec =
              Conditions.ByConnector.Boundary.Single.Thermal.temperature,
          thermalSet(y=environment.T)),
        H2O(
          redeclare function materialSpec =
              Conditions.ByConnector.Boundary.Single.Material.pressure,
          materialSet(y=environment.p_H2O),
          redeclare function thermalSpec =
              Conditions.ByConnector.Boundary.Single.Thermal.heatRate,
          thermalSet(y=0))), each graphite(
        'inclC+'=true,
        'incle-'=true,
        redeclare Conditions.ByConnector.ThermalDiffusive.Single.Temperature
          'C+'(set(y=environment.T)),
        'e-'(
          redeclare function thermalSpec =
              Conditions.ByConnector.Boundary.Single.Thermal.temperature,
          thermalSet(y=environment.T),
          redeclare function materialMeas =
              Conditions.ByConnector.Boundary.Single.Material.potential (
                redeclare package Data = FCSys.Characteristics.'e-'.Graphite))))
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-44,40})));

    Conditions.ByConnector.BoundaryBus.Single.Source caBC[caCL.n_y, caCL.n_z](
        each gas(
        inclH2O=true,
        inclO2=true,
        H2O(
          redeclare function materialSpec =
              Conditions.ByConnector.Boundary.Single.Material.pressure,
          materialSet(y=environment.p_H2O),
          redeclare function thermalSpec =
              Conditions.ByConnector.Boundary.Single.Thermal.heatRate,
          thermalSet(y=0)),
        O2(
          redeclare function materialSpec =
              Conditions.ByConnector.Boundary.Single.Material.pressure,
          materialSet(y=environment.p_O2),
          thermalSet(y=environment.T))), graphite(
        each 'inclC+'=true,
        each 'incle-'=true,
        each 'C+'(set(y=environment.T)),
        'e-'(
          redeclare each function materialSpec =
              Conditions.ByConnector.Boundary.Single.Material.potential (
                redeclare package Data = FCSys.Characteristics.'e-'.Graphite),
          materialSet(y=anBC.graphite.'e-'.materialOut.y + fill(
                  -voltageSet.y,
                  caCL.n_y,
                  caCL.n_z)),
          each thermalSet(y=environment.T)))) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={44,40})));

    Modelica.Blocks.Sources.Ramp voltageSet(
      duration=300,
      offset=1.19997*U.V,
      height=-0.8*U.V)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    inner Conditions.Environment environment(
      analysis=true,
      T=333.15*U.K,
      p=U.from_kPag(48.3),
      RH=0.7) "Environmental conditions"
      annotation (Placement(transformation(extent={{-10,70},{10,90}})));

  equation
    connect(anCL.xPositive, PEM.xNegative) annotation (Line(
        points={{-10,40},{-10,40}},
        color={240,0,0},
        thickness=0.5,
        smooth=Smooth.None));
    connect(PEM.xPositive, caCL.xNegative) annotation (Line(
        points={{10,40},{10,40}},
        color={0,0,240},
        thickness=0.5,
        smooth=Smooth.None));
    connect(anBC.boundary, anCL.xNegative) annotation (Line(
        points={{-40,40},{-30,40}},
        color={240,0,0},
        thickness=0.5,
        smooth=Smooth.None));
    connect(caCL.xPositive, caBC.boundary) annotation (Line(
        points={{30,40},{40,40}},
        color={0,0,240},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Commands(file=
            "Resources/Scripts/Dymola/Regions.Examples.CLtoCLVoltage.mos"
          "Regions.Examples.CLtoCLVoltage.mos"),
      experiment(
        StopTime=600,
        Tolerance=1e-007,
        __Dymola_Algorithm="Dassl"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics));
  end RegionsExamplesCLtoCLVoltage;

  model SubregionsExamplesCapillaryAction
    "Transport of liquid due to capillary action"
    extends Subregions.Examples.Subregions(
      Deltap_IC=0,
      subregion1(gas(H2(consEnergy=ConsThermo.dynamic))),
      subregion2(gas(H2(consEnergy=ConsThermo.dynamic))),
      environment(analysis=false));

    annotation (Commands(file=
            "Resources/Scripts/Dymola/Subregions.Examples.CapillaryAction.mos"
          "Subregions.Examples.CapillaryAction.mos"));

  end SubregionsExamplesCapillaryAction;

  package Units "Constants and units of physical measure"
    extends Modelica.Icons.Package;

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
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units.",
              executeCall=checkModel("FCSys.Units")));

      end Evaluate;
    end Examples;

    // -------------------------------------------------------------------------
    // Mathematical constants
    // -------------------------------------------------------------------------

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
        import FCSys;

        extends Base(
          final R_inf=1e-7*299792458/(2*cyc^2*25812.8074434),
          final c=25812.8074434/(2*FCSys.Units.pi*299792458*1e-7*cyc),
          final G_0=1/(cyc*FCSys.Units.pi),
          final Phi_0=FCSys.Units.pi);

        annotation (Documentation(info="<html>
<p>Stoney units impose that:
  <ol> 
  <li>the elementary charge is one (<i>q</i> = 1),</li>
  <li>Planck's constant is two pi (<i>h</i> = 2&pi;),</li>
  <li>the electric force constant is one (<i>k</i><sub>e</sub> = 1), and</li>
  <li>the mass of an electron is one (4&pi;&nbsp;&nbsp;<i>k</i><sub>A</sub>&nbsp;<i>R</i><sub>&infin;</sub>&nbsp;<i>q</i><sup>2</sup> = &alpha;<sup>3</sup>).
  </ol></p>
  
<p>Please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end Hartree;

      record LH
        "<html>Base constants and units for Lorentz-Heaviside units (&mu;<sub>0</sub> = &epsilon;<sub>0</sub> = 1)</html>"
        import FCSys;
        extends Base(final c=1,final G_0=4*FCSys.Units.pi*2e-7*299792458/
              25812.8074434);
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
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end Stoney;

      record SIAK
        "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of A and K</html>"
        import FCSys;

        extends Base(
          final cyc=c/299792458*(4*FCSys.Units.pi^2*R_inf/(10973731.568539*683))
              ^(1/3),
          final R_inf=10973731.568539,
          final c=299792458,
          final G_0=2/(96485.3365^2*25812.8074434),
          final Phi_0=FCSys.Units.m/(483597.870e9*sqrt(FCSys.Units.S*FCSys.Units.s)));
        annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>A &asymp; 1.03643e-5</li>
  <li>K &asymp; 8.31446</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end SIAK;

      record SIAm
        "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of A and m</html>"
        import FCSys;

        extends Base(
          final cyc=c/299792458*(4*FCSys.Units.pi^2*R_inf/(10973731.568539*683))
              ^(1/3),
          final R_inf=sqrt(8.3144621)*10973731.568539,
          final c=299792458/sqrt(8.3144621),
          final G_0=2*8.3144621/(96485.3365^2*25812.8074434),
          final Phi_0=FCSys.Units.m/(483597.870e9*sqrt(FCSys.Units.S*FCSys.Units.s)));
        annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>A &asymp; 1.03643e-5</li>
  <li>m &asymp; 0.346803</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end SIAm;

      record SIAs
        "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of A and s</html>"
        import FCSys;
        extends Base(
          final cyc=c/299792458*(4*FCSys.Units.pi^2*R_inf/(10973731.568539*683))
              ^(1/3),
          final R_inf=10973731.568539,
          final c=299792458/sqrt(8.3144621),
          final G_0=2*sqrt(8.3144621)/(96485.3365^2*25812.8074434),
          final Phi_0=FCSys.Units.m/(483597.870e9*sqrt(FCSys.Units.S*FCSys.Units.s)));
        annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>A &asymp; 3.59436e-6</li>
  <li>s &asymp; 2.88348</li>
  </ul>

  <p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end SIAs;

      record SIKmol
        "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of K and mol</html>"
        import FCSys;
        extends Base(
          final cyc=c/299792458*(4*FCSys.Units.pi^2*R_inf/(10973731.568539*683))
              ^(1/3),
          final R_inf=10973731.568539,
          final c=299792458,
          final G_0=2/25812.8074434,
          final Phi_0=FCSys.Units.m/(483597.870e9*sqrt(FCSys.Units.S*FCSys.Units.s)));
        annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>K &asymp; 8.61733e-5</li>
  <li>mol &asymp; 96485.3</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end SIKmol;

      record SIKs
        "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of K and s</html>"
        import FCSys;
        extends Base(
          final cyc=c/299792458*(4*FCSys.Units.pi^2*R_inf/(10973731.568539*683))
              ^(1/3),
          final R_inf=10973731.568539,
          final c=96485.3365*299792458,
          final G_0=2/(96485.3365^3*25812.8074434),
          final Phi_0=FCSys.Units.m/(483597.870e9*sqrt(FCSys.Units.S*FCSys.Units.s)));
        annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>K &asymp; 7.74028e10</li>
  <li>s &asymp; 1.03643e-5</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end SIKs;

      record SImmol
        "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of m and mol</html>"
        import FCSys;
        extends Base(
          final cyc=c/299792458*(4*FCSys.Units.pi^2*R_inf/(10973731.568539*683))
              ^(1/3),
          final R_inf=sqrt(8.3144621/96485.3365)*10973731.568539,
          final c=sqrt(96485.3365/8.3144621)*299792458,
          final G_0=2*8.3144621/(96485.3365*25812.8074434),
          final Phi_0=FCSys.Units.m/(483597.870e9*sqrt(FCSys.Units.S*FCSys.Units.s)));
        annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>m &asymp; 107.724</li>
  <li>mol &asymp; 96485.3</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end SImmol;

      record SIms
        "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of m and s</html>"
        import FCSys;
        extends Base(
          final cyc=c/299792458*(4*FCSys.Units.pi^2*R_inf/(10973731.568539*683))
              ^(1/3),
          final R_inf=96485.3365*sqrt(8.3144621)*10973731.568539,
          final c=299792458/sqrt(8.3144621),
          final G_0=2*8.3144621/(96485.3365*25812.8074434),
          final Phi_0=FCSys.Units.m/(483597.870e9*sqrt(FCSys.Units.S*FCSys.Units.s)));
        annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>m &asymp; 3.59436e-6</li>
  <li>s &asymp; 1.03643e-5</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end SIms;

      record SImols
        "<html>Base constants and units for SI with <i>k</i><sub>F</sub> and <i>R</i> normalized instead of mol and s</html>"
        import FCSys;
        extends Base(
          final cyc=c/299792458*(4*FCSys.Units.pi^2*R_inf/(10973731.568539*683))
              ^(1/3),
          final R_inf=10973731.568539,
          final c=(96485.3365/8.3144621)^(1/3)*299792458,
          final G_0=2*8.3144621/(96485.3365*25812.8074434),
          final Phi_0=FCSys.Units.m/(483597.870e9*sqrt(FCSys.Units.S*FCSys.Units.s)));

        annotation (Documentation(info="<html><p>The values of the un-normalized SI base units are (see
  <a href=\"modelica://FCSys/Resources/Documentation/Units/Bases/unit-systems.cdf\">Resources/unit-systems.cdf</a>):</p>
  <ul>
  <li>mol &asymp; 4261.73</li>
  <li>s &asymp; 0.0441697</li>
  </ul>

<p>For more information, please see the documentation for the
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

      end SImols;

      record Base "Base constants and units"
        extends Modelica.Icons.Record;

        constant Q.Angle cyc=1 "cycle";
        // Unit of rotation or planar angle
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
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
              executeCall=FCSys.Units.setup() "Re-initialize the units."));

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
  <a href=\"modelica://FCSys.Units\">Units</a> package.</p></html>"), Commands(
            executeCall=FCSys.Units.setup() "Re-initialize the units."));

    end Bases;
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
    // **check all dimensions, update doc
    final constant Q.Angle rad=cyc/(2*pi) "radian";
    constant Q.Length m=10973731.568539*cyc/R_inf "meter";
    constant Q.Time s=299792458*m/c "second";
    constant Q.ConductanceElectrical S=25812.8074434*m*G_0/(4*pi*2e-7*c*s)
      "siemen";
    // **This modified siemen (S = 1/Z_0 = G_0/(4*alpha)) is the basis of all
    // the units below.
    // E.g., the new ohm is ~376 times the traditional ohm.  The new ohm is the
    // impedance of free space.
    constant Q.MagneticFlux Wb=483597.870e9*Phi_0 "weber";
    constant Q.Amount mol=96485.3365*Wb*cyc*S/k_F "mole";
    constant Q.Potential K=8.3144621*(Wb*cyc)^2*S/(s*mol*R) "kelvin";
    // **note that now there are no arbitrary numbers below here--even for fine
    // structure constant--because the base unit of resistance and the
    // impedence of free space are the same.

    // -------------------------------------------------------------------------
    // SI base units [BIPM2006, Table 1] and intermediate units
    // -------------------------------------------------------------------------

    final constant Q.Frequency Hz=cyc/s "hertz";
    final constant Q.Potential V=Wb*Hz "volt";
    final constant Q.Current A=V*S "ampere";
    final constant Q.Amount C=A*s "coulomb";
    final constant Q.Energy J=V*C "joule";
    final constant Q.Velocity2 Gy=(m/s)^2 "gray";
    final constant Q.Mass kg=J/Gy "kilogram";
    final constant Q.Power W=J/s "watt";
    final constant Q.Power lm=W/683 "lumen";
    final constant Q.Angle2 sr=rad^2 "steradian";
    final constant Q.PowerRadiant cd=lm/sr "candela";

    // -------------------------------------------------------------------------
    // SI derived units with special names and symbols [BIPM2006, Table 3]
    // -------------------------------------------------------------------------

    final constant Q.Force N=J/m "newton";
    final constant Q.Pressure Pa=N/m^2 "pascal";
    final constant Q.MagneticFluxAreic T=Wb/m^2 "tesla";
    final constant Q.PowerAreic lx=lm/m^2 "lux";
    final constant Q.Capacitance F=s*S "farad";
    final constant Q.ResistanceElectrical ohm=1/S "<html>ohm (&Omega;)</html>";
    final constant Q.Inductance H=s/S "henry";
    final constant Q.Frequency Bq=Hz "becquerel";
    final constant Q.Velocity2 Sv=Gy "sievert";
    final constant Q.Current kat=mol/s "katal";
    final constant Q.Mass g=kg/kilo "gram";

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

    // Electromagnetism -- current
    // **Z_0 eliminated (same as ohm)
    final constant Q.Permeability mu_0=ohm/(c*cyc)
      "<html>magnetic constant (&mu;<sub>0</sub>)</html>";
    // **modified
    final constant Q.Permittivity epsilon_0=1/(ohm*c)
      "<html>electric constant (&epsilon;<sub>0</sub>)</html>";
    // **modified
    final constant Q.Number alpha=ohm*G_0/4
      "<html>fine-structure constant (&alpha;)</html>";
    // **modified
    // **Note that 2*alpha ia just an arbitrated number, like 299792458, only
    // it involves a special symbol (alpha).
    // 2*alpha = G_0/S
    // 299792458 = c*s/m

    // Electromagnetism -- magnetic flux
    final constant Q.Amount q=G_0*Phi_0*cyc "elementary charge";
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
    final constant Q.PowerArea c_1=2*pi*h*cyc*c^2
      "<html>first radiation constant (<i>c</i><sub>1</sub>)</html>";
    final constant Q.PotentialPerWavenumber c_2=h*c/k_B
      "<html>second radiation constant (<i>c</i><sub>2</sub>)</html>";
    final constant Q.PotentialPerWavenumber c_3_lambda=c_2/4.965114231744276
      "<html>Wien wavelength displacement law constant (<i>c</i><sub>3 &lambda;</sub>)</html>";
    final constant Q.MagneticFluxReciprocal c_3_f=2.821439372122079*k_B/h
      "<html>Wien frequency displacement law constant (<i>c</i><sub>3 <i>f</i></sub>)</html>";

    // -------------------------------------------------------------------------
    // Other selected non-SI units from [BIPM2006, Table 8]
    // -------------------------------------------------------------------------

    final constant Q.Pressure bar=1e5*Pa "bar";
    final constant Q.Length angstrom=0.1*nano*m
      "<html>angstrom (&#8491;)</html>";

    // -------------------------------------------------------------------------
    // Additional units that are useful for this library
    // -------------------------------------------------------------------------

    final constant Q.Angle2 sp=4*pi*sr "spat";
    final constant Q.Pressure atm=101325*Pa "atmosphere";
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
    annotation (Icon(graphics={Line(
              points={{-66,78},{-66,-40}},
              color={64,64,64},
              smooth=Smooth.None),Ellipse(
              extent={{12,36},{68,-38}},
              lineColor={64,64,64},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-74,78},{-66,-40}},
              lineColor={64,64,64},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-66,-4},{-66,6},{-16,56},{-16,46},{-66,-4}},
              lineColor={64,64,64},
              smooth=Smooth.None,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-46,16},{-40,22},{-2,-40},{-10,-40},{-46,16}},
              lineColor={64,64,64},
              smooth=Smooth.None,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{22,26},{58,-28}},
              lineColor={64,64,64},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Polygon(
              points={{68,2},{68,-46},{64,-60},{58,-68},{48,-72},{18,-72},{18,-64},
              {46,-64},{54,-60},{58,-54},{60,-46},{60,-26},{64,-20},{68,-6},{68,
              2}},
              lineColor={64,64,64},
              smooth=Smooth.Bezier,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid)}));

  end Units;
  annotation (Commands(
      file="../../units.mos"
        "Establish the constants and units in the workspace (first translate a model besides Units.Evaluate).",

      file="test/check.mos" "Check all of FCSys using Dymola's check function.",

      file="../../../LaTeX/Dissertation/Results/Cell/Simulation/sim.mos"), Icon(
        graphics={Polygon(
          points={{-80,-72},{0,68},{80,-72},{-80,-72}},
          lineColor={255,0,0},
          lineThickness=0.5)}));

end WorkInProgress;
