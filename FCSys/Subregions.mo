within FCSys;
package Subregions
  "Control volumes with multi-species transport, exchange, and storage"
  extends Modelica.Icons.Package;

  package Examples "Examples"
    extends Modelica.Icons.ExamplesPackage;
    // TODO: In the documentation of each model, insert the sample plots or link
    // to the sample results of the User's Guide.
    // TODO: In the documentation of each model, add discussion from the dissertation.
    model AirColumn
      "<html>Test a one-dimensional array of subregions with an initial pressure difference (C<sup>+</sup> and N<sub>2</sub> included by default)</html>"
      import FCSys.Utilities.round;
      extends Modelica.Icons.Example;

      parameter Integer n_y=3
        "Number of discrete subregions along the y axis, besides the 2 boundary subregions"
        annotation (Dialog(__Dymola_label="<html><i>n<i><sub>y</sub></html>"));
      parameter Q.Pressure Deltap_IC=0 "Initial pressure difference"
        annotation (Dialog(__Dymola_label=
              "<html>&Delta;<i>p</i><sub>IC</sub></html>"));

      output Q.Pressure Deltap=subregion2.gas.N2.p - subregion1.gas.N2.p
        "Measured pressure difference";
      output Q.Pressure Deltap_ex=-(n_y + 1)*10*U.m*environment.a[Axis.y]*
          Characteristics.N2.Gas.m*subregions[round(n_y/2)].gas.N2.rho
        "Expected pressure difference";

      inner Conditions.Environment environment(p=U.bar)
        annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
      FCSys.Subregions.Subregion subregion1(
        L={10,10,10}*U.m,
        inclFacesZ=false,
        inclTransZ=false,
        inclTransX=false,
        inclTransY=true,
        inclFacesX=false,
        inclFacesY=true,
        k_common=1e-7,
        gas(inclN2=true, N2(p_IC=environment.p - Deltap_IC/2, N(stateSelect=
                  StateSelect.always))),
        graphite('inclC+'=true, 'C+'(V_IC=U.mm^3, T(stateSelect=StateSelect.always))))
        annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));

      FCSys.Subregions.Subregion subregions[n_y](
        each L={10,10,10}*U.m,
        each inclTransZ=false,
        each inclFacesZ=false,
        each k_common=1e-7,
        gas(each inclN2=true, N2(
            p_IC={environment.p - Deltap_IC/2 - i*Deltap_IC/(n_y + 1) for i in
                1:n_y},
            each N(stateSelect=StateSelect.always),
            each phi(each stateSelect=StateSelect.always),
            each initTransY=InitTrans.velocity)),
        graphite(each 'inclC+'=true, each 'C+'(V_IC=U.mm^3,T(stateSelect=
                  StateSelect.always))),
        each inclTransX=false,
        each inclTransY=true,
        each inclFacesX=false,
        each inclFacesY=true) if n_y > 0
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      FCSys.Subregions.Subregion subregion2(
        L={10,10,10}*U.m,
        inclFacesZ=false,
        inclTransZ=false,
        inclTransX=false,
        inclTransY=true,
        inclFacesX=false,
        inclFacesY=true,
        each k_common=1e-7,
        graphite('inclC+'=true, 'C+'(V_IC=U.mm^3,T(stateSelect=StateSelect.always))),

        gas(inclN2=true, N2(
            p_IC=environment.p + Deltap_IC/2,
            N(stateSelect=StateSelect.always),
            phi(each stateSelect=StateSelect.always))))
        annotation (Placement(transformation(extent={{-10,20},{10,40}})));

      Conditions.ByConnector.FaceBus.Single.Efforts BC1(gas(inclN2=true, N2(
            redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.heatRate,
            materialSet(y=environment.p),
            thermalSet(y=0))), graphite('inclC+'=true, 'C+'(redeclare function
              thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.heatRate,
              thermalSet(y=0))))
        annotation (Placement(transformation(extent={{-10,46},{10,66}})));
    equation
      connect(subregion1.yPositive, subregions[1].yNegative) annotation (Line(
          points={{6.10623e-16,-20},{0,-18},{1.22125e-15,-16},{6.10623e-16,-16},
              {6.10623e-16,-10}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      for i in 1:n_y - 1 loop
        connect(subregions[1:n_y - 1].yPositive, subregions[2:n_y].yNegative)
          "Not shown in the diagram";
      end for;
      if n_y == 0 then
        connect(subregion1.yPositive, subregion2.yNegative)
          "Not shown in the diagram";
      end if;
      connect(subregions[n_y].yPositive, subregion2.yNegative) annotation (Line(
          points={{6.10623e-16,10},{0,14},{1.22125e-15,16},{6.10623e-16,16},{
              6.10623e-16,20}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(BC1.face, subregion2.yPositive) annotation (Line(
          points={{0,52},{0,40}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        experiment(StopTime=6, __Dymola_Algorithm="Dassl"),
        Documentation(info="<html><p>This is a model of a vertical column of 10&nbsp;&times;&nbsp;10&nbsp;&times;&nbsp;10&nbsp;m
    regions with N<sub>2</sub> gas.  The upper and lower boundary regions are held with zero velocity.  
    The initial pressure difference is zero, but a pressure difference
    develops due to gravity.  There are some oscillations due to the pressure/translational dynamics.
    After about 1.5&nbsp;s, the pressure difference settles to 
      <i>L</i><sub>y</sub> <i>a</i><sub>y</sub> <i>m</i> &rho;
      as expected.</p>
      
      <p>A temperature gradient is created due to the thermodynamics of the expanding and contracting 
      gases.  It takes much longer (about a day) for the temperatures to equalize since the gas has a
      relatively low thermal conductivity.</p>
      
      <p>Assumptions:
      <ol>
      <li>Graphite is included as a solid, stationary species with small relative volume and very slight 
      friction to dampen the oscillations.</li>
      <li>The central difference scheme is used (no upstream discretization).</ol>
      </p></html>"),
        Commands(file(ensureTranslated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.AirColumn.mos"
            "Subregions.Examples.AirColumn.mos"),
        __Dymola_experimentSetupOutput,
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics));
    end AirColumn;

    model Echo
      "Two regions of gas with initial pressure difference, no dampening"
      extends Subregions(inclH2=true, 'inclC+'=false);
      annotation (
        experiment(StopTime=0.0001),
        Commands(file(ensureTranslated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.Echo.mos"
            "Subregions.Examples.Echo.mos"),
        __Dymola_experimentSetupOutput);

    end Echo;

    model EchoCentral
      "Two regions of gas with initial pressure difference (no dampening), with central difference scheme"
      extends Subregions(
        'inclC+'=false,
        subregion1(gas(
            H2(upstreamX=false),
            H2O(upstreamX=false),
            N2(upstreamX=false),
            O2(upstreamX=false))),
        subregions(gas(
            each H2(upstreamX=false),
            each H2O(upstreamX=false),
            each N2(upstreamX=false),
            each O2(upstreamX=false))),
        subregion2(gas(
            H2(upstreamX=false),
            H2O(upstreamX=false),
            N2(upstreamX=false),
            O2(upstreamX=false))));
      annotation (
        experiment(StopTime=0.0001),
        Commands(file(ensureTranslated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.EchoCentral.mos"
            "Subregions.Examples.EchoCentral.mos"),
        __Dymola_experimentSetupOutput);
    end EchoCentral;

    model ElectricalConduction
      "<html>Test a one-dimensional array of subregions with C<sup>+</sup> and e<sup>-</sup></html>"

      output Q.Potential w=-subregion.graphite.'e-'.Deltag[1]
        "Electrical potential";
      output Q.Current zI=-subregion.graphite.'e-'.I_avg[1]
        "Electrical current";
      output Q.ResistanceElectrical R=w/zI "Measured electrical resistance";
      output Q.ResistanceElectrical R_ex=subregion.graphite.'e-'.r*subregion.L[
          Axis.x]/subregion.A[Axis.x] "Expected electrical resistance";
      output Q.Power P=subregion.graphite.'e-'.Edot_AT
        "Measured rate of heat generation";
      output Q.Power P_ex=zI^2*R "Expected rate of heat generation";
      output Q.TemperatureAbsolute T=subregion.graphite.'C+'.T
        "Measured temperature";
      output Q.TemperatureAbsolute T_ex=environment.T + subregion.graphite.'C+'.theta
          *U.cm*P/(4*U.mm^2) "Expected temperature";

      extends Examples.Subregion(
        'inclC+'=true,
        'incle-'=true,
        inclH2=false,
        subregion(L={U.cm,U.mm,U.mm}, graphite('C+'(initMaterial=InitThermo.pressure),
              'e-'(r=1e-2*U.ohm*U.m))));

      FCSys.Conditions.ByConnector.FaceBus.Single.Flows BC1(graphite(
          final 'incle-'='incle-',
          'inclC+'=true,
          'e-'(materialSet(y=-0.05*U.A)),
          'C+'(
            redeclare function thermalSpec =
                Conditions.ByConnector.Face.Single.Thermal.temperature,
            thermalSet(y=environment.T),
            redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.pressure,
            materialSet(y=U.atm)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-24,0})));

      FCSys.Conditions.ByConnector.FaceBus.Single.Flows BC2(graphite(
          'inclC+'=true,
          final 'incle-'='incle-',
          'C+'(redeclare function thermalSpec =
                Conditions.ByConnector.Face.Single.Thermal.temperature,
              thermalSet(y=environment.T)),
          'e-'(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.pressure)))
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={24,0})));

    equation
      connect(BC1.face, subregion.xNegative) annotation (Line(
          points={{-20,3.65701e-16},{-16,3.65701e-16},{-16,6.10623e-16},{-10,
              6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(subregion.xPositive, BC2.face) annotation (Line(
          points={{10,6.10623e-16},{16,6.10623e-16},{16,-2.54679e-16},{20,-2.54679e-16}},

          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        experiment(StopTime=100, Tolerance=1e-06),
        Commands(file(ensureTranslated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.ElectricalConduction.mos"
            "Subregions.Examples.ElectricalConduction.mos"),
        Documentation(info="<html><p>This is an example of Ohm's law.  The 1&nbsp;cm &times; 1&nbsp;mm &times; 1&nbsp;mm subregion contains
    carbon (C<sup>+</sup>) and electrons.  An electrical current of 50&nbsp;mA (5&nbsp;A/cm<sup>2</sup>) is delivered into
    the negative boundary and exits the positive boundary.  Due to the finite mobility of
    the electrons a force is required to support the current; this maps directly to
    electrical potential.  The example shows that the measured resistance is
    <i>R</i>&nbsp;=&nbsp;<i>L</i>/(<i>A</i>&nbsp;<i>&rho;</i>&nbsp;&mu;) as expected, where &rho; is electronic
    density and &mu; is electronic mobility.</p>

    <p>The measured rate of heat generation (<code>subregion.graphite.'e-'.Edot_DT</code>)
    is equal to <i>P</i> = (<i>zI</i>)<sup>2</sup> <i>R</i> as expected, where
    <i>zI</i> = 50&nbsp;mA is the electrical current.  This heat is conducted through the carbon
    to the boundaries, which are held at 25&nbsp;&deg;C.  The measured steady state temperature
    is <i>T</i>&nbsp;=&nbsp;<i>T</i><sub>0</sub>&nbsp;+&nbsp;&theta;&nbsp;<i>L</i>&nbsp;<i>P</i>/(4&nbsp;<i>A</i>) as expected, where
    <i>T</i><sub>0</sub>&nbsp;=&nbsp;25&nbsp;&deg;C is the boundary temperature and
    &theta; is the thermal resistance.  The factor of one fourth
    is due to the boundary conditions; the conduction length is half of the total length
    and the heat is rejected to both sides.  There is no thermal convection or 
    radiation&mdash;only conduction to the sides.</p>
    </html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics));
    end ElectricalConduction;

    model Evaporation "Test a subregion with evaporation and condensation"

      output Q.Pressure p_sat=
          Modelica.Media.Air.MoistAir.saturationPressureLiquid(subregion.gas.H2O.T
          /U.K)*U.Pa "Saturation pressure via Modelica.Media";

      extends Examples.Subregion(
        inclH2O=true,
        inclH2=false,
        subregion(gas(H2O(
              p_IC=U.kPa,
              consEnergy=Conservation.dynamic,
              N(stateSelect=StateSelect.always))), liquid(inclH2O=inclH2O, H2O(
              consEnergy=Conservation.dynamic,
              N(stateSelect=StateSelect.always),
              V_IC=subregion.V/1000))));

      annotation (
        Documentation(info="<html><p>Initially, the water vapor is below saturation and a small amount of liquid water is present (1/1000 of the total volume).
  Some of the liquid evaporates until saturation is reached. The boundaries are adiabatic; therefore, the temperature of the liquid and the gas 
  decreases due to the enthalpy of formation.</p></html>"),
        experiment(StopTime=120),
        Commands(file=
              "Resources/Scripts/Dymola/Subregions.Examples.Evaporation.mos"
            "Subregions.Examples.Evaporation.mos"),
        Diagram(graphics),
        __Dymola_experimentSetupOutput);

    end Evaporation;

    model SaturationPressure
      "Evaluate the saturation pressure curve by varying temperature"
      extends SaturationPressureIdeal(subregion(gas(H2O(redeclare package Data
                = FCSys.Characteristics.H2O.Gas))));

      annotation (
        Commands(file=
              "Resources/Scripts/Dymola/Subregions.Examples.SaturationPressure.mos"),

        experiment(StopTime=3600, Tolerance=1e-006),
        __Dymola_experimentSetupOutput);

    end SaturationPressure;

    model SaturationPressureIdeal
      "Evaluate the saturation pressure curve by varying temperature, assuming ideal gas"
      import saturationPressureSI =
        Modelica.Media.Air.MoistAir.saturationPressureLiquid;

      output Q.Pressure p_sat=saturationPressureSI(subregion.gas.H2O.T/U.K)*U.Pa
        "Saturation pressure via Modelica.Media";
      output Q.Number T_degC=U.to_degC(subregion.gas.H2O.T)
        "Temperature in degree Celsius";

      extends Examples.Subregion(
        inclH2O=true,
        inclH2=false,
        subregion(gas(H2O(N(stateSelect=StateSelect.always),p_IC=
                  saturationPressureSI(environment.T/U.K)*U.Pa)), liquid(H2O(
              N(stateSelect=StateSelect.always),
              initMaterial=InitThermo.volume,
              V_IC=0.25*U.cc), inclH2O=true)),
        environment(T=274.15*U.K));

      FCSys.Conditions.ByConnector.FaceBus.Single.Flows BC1(liquid(inclH2O=true,
            H2O(redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.temperature,
              redeclare Modelica.Blocks.Sources.Ramp thermalSet(
              height=99*U.K,
              duration=3600,
              offset=environment.T,
              y))), gas(inclH2O=inclH2O, H2O(redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.temperature,
              redeclare Modelica.Blocks.Sources.Ramp thermalSet(
              height=99*U.K,
              duration=3600,
              offset=environment.T,
              y)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-24,0})));

      FCSys.Conditions.ByConnector.FaceBus.Single.Flows BC2(gas(inclH2O=inclH2O,
            H2O(redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.temperature,
              redeclare Modelica.Blocks.Sources.Ramp thermalSet(
              height=99*U.K,
              duration=3600,
              offset=environment.T,
              y))), liquid(inclH2O=true, H2O(redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.temperature,
              redeclare Modelica.Blocks.Sources.Ramp thermalSet(
              height=99*U.K,
              duration=3600,
              offset=environment.T,
              y)))) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={24,0})));

    equation
      connect(BC1.face, subregion.xNegative) annotation (Line(
          points={{-20,3.65701e-16},{-16,-3.36456e-22},{-16,6.10623e-16},{-10,
              6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(subregion.xPositive, BC2.face) annotation (Line(
          points={{10,6.10623e-16},{16,6.10623e-16},{16,-2.54679e-16},{20,-2.54679e-16}},

          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        experiment(StopTime=3600, Tolerance=1e-006),
        Commands(file(ensureTranslated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.SaturationPressureIdeal.mos"
            "Subregions.Examples.SaturationPressureIdeal.mos"),
        __Dymola_experimentSetupOutput);
    end SaturationPressureIdeal;

    model Subregion
      "<html>Evaluate a single subregion, with H<sub>2</sub> by default</html>"

      extends Modelica.Icons.Example;

      parameter Boolean 'inclC+'=false
        "<html>Carbon plus (C<sup>+</sup>)</html>" annotation (choices(
            __Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean 'inclSO3-'=false
        "<html>Nafion sulfonate (C<sub>19</sub>HF<sub>37</sub>O<sub>5</sub>S<sup>-</sup>, abbreviated as SO<sub>3</sub><sup>-</sup>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean 'incle-'=false "<html>Electrons (e<sup>-</sup>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean 'inclH+'=false "<html>Protons (H<sup>+</sup>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean inclH2=true "<html>Hydrogen (H<sub>2</sub>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean inclH2O=false
        "<html>Water vapor (H<sub>2</sub>O)</html>" annotation (choices(
            __Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean inclN2=false "<html>Nitrogen (N<sub>2</sub>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean inclO2=false "<html>Oxygen (O<sub>2</sub>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));

      inner Conditions.Environment environment
        annotation (Placement(transformation(extent={{30,32},{50,52}})));
      FCSys.Subregions.Subregion subregion(
        L={1,1,1}*U.cm,
        inclTransY=false,
        inclTransZ=false,
        inclFacesY=false,
        inclFacesZ=false,
        inclFacesX=true,
        graphite(
          final 'inclC+'='inclC+',
          final 'incle-'='incle-',
          'C+'(V_IC=subregion.V/4)),
        gas(
          final inclH2=inclH2,
          final inclH2O=inclH2O,
          final inclN2=inclN2,
          final inclO2=inclO2,
          H2(
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none,
            N(stateSelect=StateSelect.always)),
          H2O(
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none),
          N2(
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none),
          O2(
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none)),
        liquid(H2O(
            V_IC=subregion.V/4,
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none)),
        ionomer(
          final 'inclSO3-'='inclSO3-',
          final 'inclH+'='inclH+',
          'SO3-'(V_IC=subregion.V/4),
          H2O(
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none)))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      annotation (
        Documentation(info="<html><p>This model is boring.  It just sets up a
  single subregion with H<sub>2</sub> by default.  There are no boundary conditions
  other than those implied by the open connectors (no diffusion current, no forces, 
  no thermal conduction).  Other examples in this package are extended from this one.</p>
  </html>"),
        experiment(StopTime=10),
        Commands(file(ensureTranslated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.Subregion.mos"
            "Subregions.Examples.Subregion.mos"));

    end Subregion;

    model Subregions
      "<html>Test a one-dimensional array of subregions with an initial pressure difference (C<sup>+</sup> and H<sub>2</sub> included by default)</html>"
      extends Modelica.Icons.Example;

      parameter Integer n_x=0
        "Number of discrete subregions along the x axis, besides the 2 side subregions"
        annotation (Dialog(__Dymola_label="<html><i>n<i><sub>x</sub></html>"));
      parameter Q.Pressure Deltap_IC=-100*U.Pa "Initial pressure difference"
        annotation (Dialog(__Dymola_label=
              "<html>&Delta;<i>p</i><sub>IC</sub></html>"));
      parameter Boolean 'inclC+'=true
        "<html>Carbon plus (C<sup>+</sup>)</html>" annotation (choices(
            __Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean 'inclSO3-'=false
        "<html>Nafion sulfonate (C<sub>19</sub>HF<sub>37</sub>O<sub>5</sub>S)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean 'incle-'=false "<html>Electrons (e<sup>-</sup>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean 'inclH+'=false "<html>Protons (H<sup>+</sup>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean inclH2=true "<html>Hydrogen (H<sub>2</sub>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean inclH2O=false
        "<html>Water vapor (H<sub>2</sub>O)</html>" annotation (choices(
            __Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean inclN2=false "<html>Nitrogen (N<sub>2</sub>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));
      parameter Boolean inclO2=false "<html>Oxygen (O<sub>2</sub>)</html>"
        annotation (choices(__Dymola_checkBox=true), Dialog(group="Species",
            __Dymola_descriptionLabel=true));

      inner Conditions.Environment environment
        annotation (Placement(transformation(extent={{30,20},{50,40}})));
      FCSys.Subregions.Subregion subregion1(
        L={1,1,1}*U.cm,
        inclFacesY=false,
        inclFacesZ=false,
        inclTransY=false,
        inclTransZ=false,
        gas(
          reduceTrans=true,
          reduceThermal=true,
          final inclH2=inclH2,
          final inclH2O=inclH2O,
          final inclN2=inclN2,
          final inclO2=inclO2,
          H2O(
            p_IC=environment.p - Deltap_IC/2,
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none),
          N2(
            p_IC=environment.p - Deltap_IC/2,
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none),
          O2(
            p_IC=environment.p - Deltap_IC/2,
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none),
          H2(
            p_IC=environment.p - Deltap_IC/2,
            N(stateSelect=StateSelect.always),
            T(stateSelect=StateSelect.always),
            phi(each stateSelect=StateSelect.always),
            initTransX=InitTrans.none,
            initTransY=InitTrans.none,
            initTransZ=InitTrans.none)),
        graphite(
          final 'inclC+'='inclC+',
          final 'incle-'='incle-',
          'C+'(V_IC=subregion1.V/1000,T(stateSelect=StateSelect.always))),
        ionomer(
          final 'inclSO3-'='inclSO3-',
          final 'inclH+'='inclH+',
          'SO3-'(V_IC=subregion1.V/1000)),
        liquid(H2O(V_IC=subregion1.V/4)))
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

      FCSys.Subregions.Subregion subregions[n_x](
        each L={1,1,1}*U.cm,
        each inclTransY=false,
        each inclTransZ=false,
        each inclFacesY=false,
        each inclFacesZ=false,
        graphite(
          each final 'inclC+'='inclC+',
          each final 'incle-'='incle-',
          'C+'(each V_IC=subregions[1].V/1000)),
        ionomer(
          each final 'inclSO3-'='inclSO3-',
          each final 'inclH+'='inclH+',
          'SO3-'(each V_IC=subregions[1].V/1000)),
        gas(
          each reduceThermal=true,
          each reduceTrans=true,
          each final inclH2=inclH2,
          each final inclH2O=inclH2O,
          each final inclN2=inclN2,
          each final inclO2=inclO2,
          H2(p_IC={environment.p - Deltap_IC/2 - i*Deltap_IC/(n_x + 1) for i
                 in 1:n_x}),
          H2O(p_IC={environment.p - Deltap_IC/2 - i*Deltap_IC/(n_x + 1) for i
                 in 1:n_x}),
          N2(p_IC={environment.p - Deltap_IC/2 - i*Deltap_IC/(n_x + 1) for i
                 in 1:n_x}),
          O2(p_IC={environment.p - Deltap_IC/2 - i*Deltap_IC/(n_x + 1) for i
                 in 1:n_x})),
        liquid(H2O(each V_IC=subregions[1].V/4))) if n_x > 0
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      FCSys.Subregions.Subregion subregion2(
        L={1,1,1}*U.cm,
        inclFacesY=false,
        inclFacesZ=false,
        inclTransY=false,
        inclTransZ=false,
        graphite(
          final 'inclC+'='inclC+',
          final 'incle-'='incle-',
          'C+'(V_IC=subregion2.V/1000,T(stateSelect=StateSelect.always))),
        ionomer(
          final 'inclSO3-'='inclSO3-',
          final 'inclH+'='inclH+',
          'SO3-'(V_IC=subregion2.V/1000)),
        gas(
          reduceTrans=true,
          final inclH2=inclH2,
          final inclH2O=inclH2O,
          final inclN2=inclN2,
          final inclO2=inclO2,
          H2O(p_IC=environment.p + Deltap_IC/2),
          N2(p_IC=environment.p + Deltap_IC/2),
          O2(p_IC=environment.p + Deltap_IC/2),
          H2(
            p_IC=environment.p + Deltap_IC/2,
            N(stateSelect=StateSelect.always),
            T(stateSelect=StateSelect.always))))
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));

      FCSys.Conditions.ByConnector.FaceBus.Single.Flows BC1(
        ionomer('inclSO3-'='inclSO3-', final 'inclH+'='inclH+'),
        graphite('inclC+'='inclC+', final 'incle-'='incle-'),
        gas(
          final inclH2=inclH2,
          final inclH2O=inclH2O,
          final inclN2=inclN2,
          final inclO2=inclO2)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-56,0})));

      FCSys.Conditions.ByConnector.FaceBus.Single.Flows BC2(
        ionomer('inclSO3-'='inclSO3-', final 'inclH+'='inclH+'),
        gas(
          final inclH2=inclH2,
          final inclH2O=inclH2O,
          final inclN2=inclN2,
          final inclO2=inclO2),
        graphite(
          'inclC+'='inclC+',
          final 'incle-'='incle-',
          'C+'(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.pressure,
              materialSet(y=U.atm)))) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={56,0})));

    equation
      connect(subregion1.xPositive, subregions[1].xNegative) annotation (Line(
          points={{-20,6.10623e-16},{-16,-3.36456e-22},{-16,6.10623e-16},{-10,
              6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      for i in 1:n_x - 1 loop
        connect(subregions[i].xPositive, subregions[i + 1].xNegative)
          "Not shown in the diagram";
      end for;
      if n_x == 0 then
        connect(subregion1.xPositive, subregion2.xNegative)
          "Not shown in the diagram";
      end if;
      connect(subregions[n_x].xPositive, subregion2.xNegative) annotation (Line(
          points={{10,6.10623e-16},{20,-3.36456e-22},{20,6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(BC1.face, subregion1.xNegative) annotation (Line(
          points={{-52,3.65701e-16},{-46,3.65701e-16},{-46,6.10623e-16},{-40,
              6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(subregion2.xPositive, BC2.face) annotation (Line(
          points={{40,6.10623e-16},{46,6.10623e-16},{46,-2.54679e-16},{52,-2.54679e-16}},

          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        experiment(
          StopTime=4,
          Tolerance=1e-006,
          __Dymola_Algorithm="Dassl"),
        Commands(file(ensureTranslated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.Subregions.mos"
            "Subregions.Examples.Subregions.mos"),
        __Dymola_experimentSetupOutput);
    end Subregions;

    model ThermalConduction "Test thermal conduction (through solid)"
      extends Examples.Subregions(
        n_x=6,
        'inclC+'=true,
        inclH2=false,
        subregion1(graphite('C+'(T_IC=environment.T + 30*U.K, initMaterial=
                  InitThermo.pressure))),
        subregions(graphite('C+'(each T(stateSelect=StateSelect.always),each
                initMaterial=InitThermo.pressure))),
        subregion2(graphite('C+'(s(stateSelect=StateSelect.never), initMaterial
                =InitThermo.pressure))),
        BC1(graphite('C+'(redeclare function materialSpec =
                  FCSys.Conditions.ByConnector.Face.Single.Material.pressure,
                materialSet(y=U.atm)))));

      annotation (
        Commands(file=
              "Resources/Scripts/Dymola/Subregions.Examples.ThermalConduction.mos"
            "Subregions.Examples.ThermalConduction.mos"),
        experiment(StopTime=500, Algorithm="Dassl"),
        __Dymola_experimentSetupOutput);

    end ThermalConduction;

    model ThermalConductionConvection
      "Test combined thermal conduction and convection"
      // **eliminate nonlinear eqs
      extends Examples.Subregions(
        n_x=6,
        'inclC+'=true,
        inclH2=false,
        inclN2=true,
        subregion1(gas(k={0.5,1,1}, N2(
              T_IC=environment.T + 30*U.K,
              p_IC=environment.p,
              N(stateSelect=StateSelect.always),
              T(stateSelect=StateSelect.always),
              phi(stateSelect=StateSelect.always,displayUnit="mm/s"))),
            graphite(k={0.5,1,1}, 'C+'(
              T_IC=environment.T + 30*U.K,
              V_IC=0.5*subregion1.V,
              T(stateSelect=StateSelect.always)))),
        subregions(each gas(k={0.5,1,1}, N2(
              p_IC=environment.p,
              N(stateSelect=StateSelect.always),
              T(stateSelect=StateSelect.always),
              phi(each stateSelect=StateSelect.always,displayUnit="mm/s"))),
            each graphite(k={0.5,1,1}, 'C+'(V_IC=0.5*subregions[1].V, T(
                  stateSelect=StateSelect.always)))),
        subregion2(gas(k={0.5,1,1}, N2(
              p_IC=environment.p,
              phi(displayUnit="mm/s"),
              N(stateSelect=StateSelect.always),
              T(stateSelect=StateSelect.always))), graphite(k={0.5,1,1}, 'C+'(
                V_IC=0.5*subregion2.V,T(stateSelect=StateSelect.always)))),
        BC1(graphite('C+'(redeclare function materialSpec =
                  FCSys.Conditions.ByConnector.Face.Single.Material.pressure,
                materialSet(y=U.atm)))));

      annotation (
        Commands(file=
              "Resources/Scripts/Dymola/Subregions.Examples.ThermalConductionConvection.mos"
            "Subregions.Examples.ThermalConductionConvection.mos"),
        experiment(
          StopTime=400,
          Tolerance=1e-006,
          __Dymola_Algorithm="Dassl"),
        __Dymola_experimentSetupOutput);

    end ThermalConductionConvection;

    model InternalFlow "Internal, laminar flow of liquid water"
      import FCSys.Utilities.Delta;

      final parameter Q.Area A=subregion.A[Axis.x] "Cross-sectional area"
        annotation (Dialog(__Dymola_label="<html><i>A</i></html>"));

      // Conditions
      parameter Q.VolumeRate Vdot=-0.1*U.L/U.s
        "Prescribed large signal volumetric flow rate"
        annotation (Dialog(__Dymola_label="<html><i>V&#775;</i></html>"));

      // Measurements
      output Q.Pressure Deltap=Delta(subregion.liquid.H2O.faces[1, :].p)
        "Measured pressure difference";
      output Q.Length D=2*A/(subregion.L[Axis.y] + subregion.L[Axis.z]);
      output Q.Number Re=subregion.liquid.H2O.phi[Axis.x]*D*subregion.liquid.H2O.zeta
          *subregion.liquid.H2O.Data.m*subregion.liquid.H2O.rho if environment.analysis
        "Reynolds number";
      output Q.Pressure Deltap_Poiseuille=-32*subregion.L[Axis.x]*subregion.liquid.H2O.phi[
          Axis.x]/(D^2*subregion.liquid.H2O.zeta)
        "Pressure difference according to Poiseuille's law";
      output Q.Power Qdot_gen=subregion.liquid.H2O.Edot_AT
        "Rate of heat generation";
      output Q.Power Qdot_gen_Poiseuille=-Deltap_Poiseuille*subregion.liquid.H2O.Vdot[
          1] "Rate of heat generation according to Poiseuille's law";

      extends Examples.Subregion(
        inclH2=false,
        subregion(
          L={U.m,U.cm,U.cm},
          inclFacesY=true,
          inclFacesZ=true,
          liquid(inclH2O=true, H2O(
              final V_IC=subregion.V,
              final beta=0,
              initMaterial=InitThermo.none,
              initTransX=InitTrans.none)),
          inclTransY=true,
          inclTransZ=true),
        environment(analysis=true));

      Conditions.ByConnector.FaceBus.Single.Flows BC1(liquid(inclH2O=true, H2O(
              redeclare Modelica.Blocks.Sources.Sine materialSet(
              amplitude=0.2*Vdot,
              offset=Vdot,
              freqHz=0.01), redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.volumeRate (
                  redeclare package Data = FCSys.Characteristics.H2O.Liquid))))
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-24,0})));

      Conditions.ByConnector.FaceBus.Single.Flows BC2(liquid(inclH2O=true, H2O(
              redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.pressure,
              materialSet(y=U.atm)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={24,0})));

      Conditions.ByConnector.FaceBus.Single.Flows BC3(liquid(inclH2O=true, H2O(
            redeclare function followingSpec =
                FCSys.Conditions.ByConnector.Face.Single.Translational.velocity,

            redeclare function precedingSpec =
                FCSys.Conditions.ByConnector.Face.Single.Translational.velocity,

            redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.temperature,
            thermalSet(y=environment.T)))) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=0,
            origin={0,-24})));

      Conditions.ByConnector.FaceBus.Single.Flows BC4(liquid(inclH2O=true, H2O(
            redeclare function followingSpec =
                FCSys.Conditions.ByConnector.Face.Single.Translational.velocity,

            redeclare function precedingSpec =
                FCSys.Conditions.ByConnector.Face.Single.Translational.velocity,

            redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.temperature,
            thermalSet(y=environment.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,24})));

      Conditions.ByConnector.FaceBus.Single.Flows BC5(liquid(inclH2O=true, H2O(
            redeclare function followingSpec =
                FCSys.Conditions.ByConnector.Face.Single.Translational.velocity,

            redeclare function precedingSpec =
                FCSys.Conditions.ByConnector.Face.Single.Translational.velocity,

            redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.temperature,
            thermalSet(y=environment.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=315,
            origin={24,24})));

      Conditions.ByConnector.FaceBus.Single.Flows BC6(liquid(inclH2O=true, H2O(
            redeclare function followingSpec =
                FCSys.Conditions.ByConnector.Face.Single.Translational.velocity,

            redeclare function precedingSpec =
                FCSys.Conditions.ByConnector.Face.Single.Translational.velocity,

            redeclare function thermalSpec =
                FCSys.Conditions.ByConnector.Face.Single.Thermal.temperature,
            thermalSet(y=environment.T)))) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=315,
            origin={-24,-24})));

    equation
      connect(BC1.face, subregion.xNegative) annotation (Line(
          points={{-20,-1.34539e-15},{-16,-1.34539e-15},{-16,6.10623e-16},{-10,
              6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(BC2.face, subregion.xPositive) annotation (Line(
          points={{20,1.23436e-15},{16,1.23436e-15},{16,6.10623e-16},{10,
              6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(subregion.yNegative, BC3.face) annotation (Line(
          points={{6.10623e-016,-10},{6.10623e-016,-20}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));
      connect(BC4.face, subregion.yPositive) annotation (Line(
          points={{6.10623e-16,20},{-3.36456e-22,16},{6.10623e-16,16},{
              6.10623e-16,10}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(subregion.zPositive, BC6.face) annotation (Line(
          points={{-5,-5},{-21.1716,-21.1716}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(subregion.zNegative, BC5.face) annotation (Line(
          points={{5,5},{21.1716,21.1716}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        Documentation(info="<html><p>Note that the temperature increases due to viscous dissipation.  
        However, the temperature rise is limited because the walls are held at constant temperature.</p></html>"),

        experiment(
          StopTime=800,
          Tolerance=1e-008,
          __Dymola_Algorithm="Dassl"),
        Commands(file=
              "Resources/Scripts/Dymola/Subregions.Examples.InternalFlow.mos"
            "Subregions.Examples.InternalFlow.mos"),
        __Dymola_experimentSetupOutput,
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics));
    end InternalFlow;

    model Reaction
      extends Modelica.Icons.Example;
      Reactions.HOR hOR(n_trans=3, inter(T(fixed=false)))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Conditions.ByConnector.Chemical.Potential H2(sT=1000*U.K, source(y=U.A))
        annotation (Placement(transformation(extent={{-10,-10},{10,-30}})));
      Conditions.ByConnector.Chemical.Current 'e-'(sT=2000*U.K, redeclare
          Modelica.Blocks.Sources.Ramp source(
          height=100*U.A,
          duration=100,
          startTime=10,
          offset=U.mA))
        annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
      Conditions.ByConnector.Chemical.Potential 'H+'(sT=3000*U.K)
        annotation (Placement(transformation(extent={{20,-10},{40,-30}})));

      Conditions.ByConnector.Amagat.Pressure pressure
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      inner Conditions.Environment environment
        annotation (Placement(transformation(extent={{40,40},{60,60}})));
      Conditions.ByConnector.Inter.Efforts inter
        annotation (Placement(transformation(extent={{20,10},{40,30}})));
    equation
      connect(hOR.'connH+', 'H+'.chemical) annotation (Line(
          points={{4,0},{4,-8},{30,-8},{30,-16}},
          color={221,23,47},
          smooth=Smooth.None));
      connect(H2.chemical, hOR.connH2) annotation (Line(
          points={{0,-16},{0,0}},
          color={221,23,47},
          smooth=Smooth.None));
      connect('e-'.chemical, hOR.'conne-') annotation (Line(
          points={{-30,-16},{-30,-8},{-4,-8},{-4,0}},
          color={221,23,47},
          smooth=Smooth.None));
      connect(hOR.amagat, pressure.amagat) annotation (Line(
          points={{-10,0},{-30,0},{-30,6}},
          color={47,107,251},
          smooth=Smooth.None));
      connect(inter.inter, hOR.inter) annotation (Line(
          points={{30,10},{30,0},{10,0}},
          color={38,196,52},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Commands(file=
              "Resources/Scripts/Dymola/Subregions.Examples.Reaction.mos"));
    end Reaction;

    model HOR "Test the hydrogen oxidation reaction in one subregion"

      /*
  output Q.Potential w=positiveBC.ionomer.'H+'.face.mPhidot[1]/(positiveBC.ionomer.
      'H+'.face.rho*subregion.A[Axis.x]) - negativeBC.graphite.'e-'.face.mPhidot[
      1]/(negativeBC.graphite.'e-'.face.rho*subregion.A[Axis.x]) 
    "Electrical potential";
  output Q.Current zI=subregion.graphite.'e-'.chemical.Ndot + subregion.graphite.
      'e-'.faces[1, 2].Ndot "Electrical current due to reaction";
  output Q.Number zJ_Apercm2=zI*U.cm^2/(subregion.A[Axis.x]*U.A) 
    "Electrical current density, in A/cm2";
  output Q.Power Qdot=subregion.graphite.'C+'.Edot_DE "Rate of heat generation";
  output Q.Power P=w*zI "Electrical power";
  output Q.NumberAbsolute eta=P/(P + Qdot) "Efficiency";
  // **Fix Qdot, P, eta
  // **Update plots
  */
      extends Examples.Subregion(
        'inclC+'=true,
        'inclSO3-'=true,
        'incle-'=true,
        'inclH+'=true,
        inclH2=true,
        inclH2O=true,
        subregion(
          L={0.287*U.mm,10*U.cm,10*U.cm},
          gas(H2(consTransX=Conservation.IC)),
          ionomer(inclH2O=true)),
        environment(analysis=false));
      extends Modelica.Icons.UnderConstruction;
      Conditions.ByConnector.FaceBus.Single.Efforts negativeBC(gas(
          inclH2=true,
          inclH2O=true,
          H2(materialSet(y=environment.p - environment.p_H2O)),
          H2O(materialSet(y=environment.p_H2O))), graphite(
          'incle-'=true,
          'inclC+'=true,
          'e-'(redeclare Modelica.Blocks.Sources.Ramp materialSet(
              height=-U.A,
              duration=100.1,
              startTime=0.1), redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.current)))
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-24,0})));

      Conditions.ByConnector.FaceBus.Single.Efforts positiveBC(ionomer('inclH+'
            =true, 'inclSO3-'=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={24,0})));

    equation
      connect(negativeBC.face, subregion.xNegative) annotation (Line(
          points={{-20,-1.34539e-15},{-16,-1.34539e-15},{-16,6.10623e-16},{-10,
              6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(subregion.xPositive, positiveBC.face) annotation (Line(
          points={{10,6.10623e-16},{14,6.10623e-16},{14,1.23436e-15},{20,
              1.23436e-15}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        experiment(StopTime=110, Tolerance=1e-06),
        Commands(file="Resources/Scripts/Dymola/Subregions.Examples.HOR.mos"
            "Subregions.Examples.HOR.mos"),
        __Dymola_experimentSetupOutput);
    end HOR;

    model Hydration
      "<html>Test absorption and desorption of H<sub>2</sub>O between the gas and ionomer</html>"

      extends Examples.Subregion(
        'inclSO3-'=true,
        inclH2O=true,
        inclH2=false,
        subregion(gas(H2O(p_IC=1.001*U.atm)), ionomer(inclH2O=inclH2O)));
      // In Dymola 7.4, p_IC=1.1*environment.p has no effect on the
      // initial pressure, but p_IC=1.1*U.atm does.
      extends Modelica.Icons.UnderConstruction;
      // TODO: Update the EOS for H2O in ionomer and recheck the result.
      annotation (experiment(StopTime=0.003, Tolerance=1e-06), Commands(file(
              ensureTranslated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.Hydration.mos"
            "Subregions.Examples.Hydration.mos"));

    end Hydration;

    model ORR "Test the oxygen reduction reaction in one subregion"
      output Q.Potential w=negativeBC.ionomer.'H+'.face.mPhidot[1]/(negativeBC.ionomer.
          'H+'.face.rho*subregion.A[Axis.x]) - positiveBC.graphite.'e-'.face.mPhidot[
          1]/(positiveBC.graphite.'e-'.face.rho*subregion.A[Axis.x])
        "Electrical potential";

      /* **
  output Q.Current zI=-subregion.graphite.'e-'.chemical.Ndot 
    "Electrical current due to reaction";
  output Q.Number zJ_Apercm2=zI*U.cm^2/(subregion.A[Axis.x]*U.A) 
    "Electrical current density, in A/cm2";
  output Q.Power Qdot=subregion.graphite.'C+'.Edot_DE "Rate of heat generation";
  output Q.Power P=w*zI "Electrical power";
  output Q.NumberAbsolute eta=P/(P + Qdot) "Efficiency";
*/
      // **Fix Qdot, P, eta

      extends Examples.Subregion(
        'inclC+'=true,
        'inclSO3-'=true,
        'incle-'=true,
        'inclH+'=true,
        inclH2=false,
        inclH2O=true,
        inclN2=true,
        inclO2=true,
        subregion(L={0.287*U.mm,10*U.cm,10*U.cm}, gas(
            reduceThermal=true,
            H2O(consTransX=Conservation.IC,p_IC=environment.p_H2O),
            N2(
              consTransX=Conservation.IC,
              p_IC=environment.p - environment.p_H2O - environment.p_O2,
              initEnergy=InitThermo.none),
            O2(
              consTransX=Conservation.IC,
              p_IC=environment.p_O2,
              initEnergy=InitThermo.none))));
      extends Modelica.Icons.UnderConstruction;
      Conditions.ByConnector.FaceBus.Single.Efforts negativeBC(ionomer('inclH+'
            =true, 'H+'(redeclare function normalSpec =
                Conditions.ByConnector.Face.Single.TranslationalNormal.force)))
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-24,0})));

      Conditions.ByConnector.FaceBus.Single.Efforts positiveBC(gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          H2O(materialSet(y=environment.p_H2O/environment.T)),
          H2(materialSet(y=(environment.p - environment.p_H2O - environment.p_O2)
                  /environment.T)),
          O2(materialSet(y=environment.p_O2/environment.T))), graphite('incle-'
            =true, 'e-'(redeclare function normalSpec =
                Conditions.ByConnector.Face.Single.TranslationalNormal.currentDensity,
              redeclare Modelica.Blocks.Sources.Ramp normalSet(
              height=-U.A/U.cm^2,
              duration=100.1,
              startTime=0.1)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={24,0})));

    equation
      connect(negativeBC.face, subregion.xNegative) annotation (Line(
          points={{-20,-1.34539e-15},{-16,-1.34539e-15},{-16,6.10623e-16},{-10,
              6.10623e-16}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      connect(subregion.xPositive, positiveBC.face) annotation (Line(
          points={{10,6.10623e-16},{14,6.10623e-16},{14,1.23436e-15},{20,
              1.23436e-15}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        experiment(StopTime=110, Tolerance=1e-06),
        Commands(file(ensureSimulated=true) =
            "Resources/Scripts/Dymola/Subregions.Examples.ORR.mos"
            "Subregions.Examples.ORR.mos"),
        __Dymola_experimentSetupOutput,
        Diagram(graphics));
    end ORR;

    model HOR3 "Test the hydrogen oxidation reaction in one subregion"

      /*
  output Q.Potential w=positiveBC.ionomer.'H+'.face.mPhidot[1]/(positiveBC.ionomer.
      'H+'.face.rho*subregion.A[Axis.x]) - negativeBC.graphite.'e-'.face.mPhidot[
      1]/(negativeBC.graphite.'e-'.face.rho*subregion.A[Axis.x]) 
    "Electrical potential";
  output Q.Current zI=subregion.graphite.'e-'.chemical.Ndot + subregion.graphite.
      'e-'.faces[1, 2].Ndot "Electrical current due to reaction";
  output Q.Number zJ_Apercm2=zI*U.cm^2/(subregion.A[Axis.x]*U.A) 
    "Electrical current density, in A/cm2";
  output Q.Power Qdot=subregion.graphite.'C+'.Edot_DE "Rate of heat generation";
  output Q.Power P=w*zI "Electrical power";
  output Q.NumberAbsolute eta=P/(P + Qdot) "Efficiency";
  // **Fix Qdot, P, eta
  // **Update plots
  */
      extends Examples.Subregion(
        'inclC+'=true,
        'inclSO3-'=true,
        'incle-'=true,
        'inclH+'=true,
        inclH2=true,
        subregion(
          L={0.287*U.mm,10*U.cm,10*U.cm},
          gas(H2(
              T(stateSelect=StateSelect.always),
              initMaterial=InitThermo.amount,
              N_IC=0.01*U.C,
              initTransX=InitTrans.none)),
          graphite('C+'(T(stateSelect=StateSelect.always))),
          ionomer(
            reduceThermal=true,
            inclH2O=false,
            'SO3-'(T(stateSelect=StateSelect.always)),
            'H+'(consTransX=Conservation.dynamic,phi(each stateSelect=
                    StateSelect.always)))),
        environment(analysis=false));

      extends Modelica.Icons.UnderConstruction;

      Conditions.ByConnector.FaceBus.Single.Efforts positiveBC(ionomer('inclH+'
            =true, 'inclSO3-'=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={24,0})));
      Conditions.ByConnector.FaceBus.Single.Efforts negativeBC(graphite(
            'inclC+'=true, 'incle-'=true), gas(inclH2=false)) annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-24,0})));
    equation
      connect(subregion.xPositive, positiveBC.face) annotation (Line(
          points={{10,0},{20,6.66134e-016}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));
      connect(negativeBC.face, subregion.xNegative) annotation (Line(
          points={{-20,-8.88178e-016},{-10,-8.88178e-016},{-10,0}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        experiment(StopTime=110, Tolerance=1e-06),
        Commands(file="Resources/Scripts/Dymola/Subregions.Examples.HOR.mos"
            "Subregions.Examples.HOR.mos"),
        __Dymola_experimentSetupOutput,
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics));
    end HOR3;

    model HOR4 "Test the hydrogen oxidation reaction in one subregion"

      /*
  output Q.Potential w=positiveBC.ionomer.'H+'.face.mPhidot[1]/(positiveBC.ionomer.
      'H+'.face.rho*subregion.A[Axis.x]) - negativeBC.graphite.'e-'.face.mPhidot[
      1]/(negativeBC.graphite.'e-'.face.rho*subregion.A[Axis.x]) 
    "Electrical potential";
  output Q.Current zI=subregion.graphite.'e-'.chemical.Ndot + subregion.graphite.
      'e-'.faces[1, 2].Ndot "Electrical current due to reaction";
  output Q.Number zJ_Apercm2=zI*U.cm^2/(subregion.A[Axis.x]*U.A) 
    "Electrical current density, in A/cm2";
  output Q.Power Qdot=subregion.graphite.'C+'.Edot_DE "Rate of heat generation";
  output Q.Power P=w*zI "Electrical power";
  output Q.NumberAbsolute eta=P/(P + Qdot) "Efficiency";
  // **Fix Qdot, P, eta
  // **Update plots
  */
      extends Examples.Subregion(
        'inclC+'=true,
        'inclSO3-'=true,
        'incle-'=true,
        'inclH+'=true,
        inclH2=true,
        subregion(
          L={0.287*U.mm,10*U.cm,10*U.cm},
          gas(H2(
              T(stateSelect=StateSelect.always),
              initMaterial=InitThermo.amount,
              N_IC=0.01*U.C,
              initTransX=InitTrans.none,
              consTransX=Conservation.dynamic)),
          graphite('C+'(T(stateSelect=StateSelect.always))),
          ionomer(
            reduceThermal=true,
            inclH2O=false,
            'SO3-'(T(stateSelect=StateSelect.always)),
            'H+'(consTransX=Conservation.dynamic))),
        environment(analysis=false));

      extends Modelica.Icons.UnderConstruction;

      Conditions.ByConnector.FaceBus.Single.Efforts positiveBC(
        ionomer('inclH+'=true, 'inclSO3-'=true),
        gas(inclH2=true, H2(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.current,
              materialSet(y=0))),
        graphite(
          'inclC+'=true,
          'incle-'=true,
          'C+'(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.current,
              materialSet(y=0)),
          'e-'(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.current,
              materialSet(y=0)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={24,0})));
      Conditions.ByConnector.FaceBus.Single.Efforts negativeBC(
        gas(inclH2=true, H2(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.current,
              materialSet(y=0))),
        graphite(
          'inclC+'=true,
          'incle-'=true,
          'e-'(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.current)),
        ionomer(
          'inclSO3-'=true,
          'inclH+'=true,
          'SO3-'(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.current,
              materialSet(y=0)),
          'H+'(redeclare function materialSpec =
                FCSys.Conditions.ByConnector.Face.Single.Material.current,
              materialSet(y=0)))) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-24,0})));
    equation
      connect(subregion.xPositive, positiveBC.face) annotation (Line(
          points={{10,0},{20,6.66134e-016}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));
      connect(negativeBC.face, subregion.xNegative) annotation (Line(
          points={{-20,-8.88178e-016},{-10,-8.88178e-016},{-10,0}},
          color={127,127,127},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        experiment(StopTime=110, Tolerance=1e-06),
        Commands(file="Resources/Scripts/Dymola/Subregions.Examples.HOR.mos"
            "Subregions.Examples.HOR.mos"),
        __Dymola_experimentSetupOutput,
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics));
    end HOR4;
  end Examples;

  model Subregion "Subregion with all phases"
    import Modelica.Constants.eps;
    extends Partial(final n_spec=gas.n_spec + graphite.n_spec + ionomer.n_spec
           + liquid.n_spec);

    parameter Q.NumberAbsolute k_gas_liq=eps
      "Additional coupling factor between gas and liquid" annotation (Dialog(
          group="Geometry",__Dymola_label=
            "<html><i>k</i><sub>gas liq</sub></html>"));
    parameter Q.NumberAbsolute k_graphite_liq=eps
      "Additional coupling factor between graphite and liquid" annotation (
        Dialog(group="Geometry", __Dymola_label=
            "<html><i>k</i><sub>graphite liq</sub></html>"));

    FCSys.Phases.Gas gas(
      n_inter=2,
      final n_faces=n_faces,
      k_inter={k_common,k_gas_liq}) "Gas" annotation (Dialog(group=
            "Phases (click to edit)"), Placement(transformation(extent={{-80,-4},
              {-60,16}})));

    FCSys.Phases.Graphite graphite(
      n_inter=2,
      final n_faces=n_faces,
      k_inter={k_common,k_graphite_liq}) "Graphite" annotation (Dialog(group=
            "Phases (click to edit)"), Placement(transformation(extent={{-40,-4},
              {-20,16}})));

    FCSys.Phases.Ionomer ionomer(
      n_inter=1,
      final n_faces=n_faces,
      k_inter={k_common}) "Ionomer" annotation (Dialog(group=
            "Phases (click to edit)"), Placement(transformation(extent={{0,-4},
              {20,16}})));

    FCSys.Phases.Liquid liquid(
      n_inter=3,
      final n_faces=n_faces,
      k_inter={k_common,k_gas_liq,k_graphite_liq},
      inclChemical=liquid.inclH2O and gas.inclH2O) "Liquid" annotation (Dialog(
          group="Phases (click to edit)"), Placement(transformation(extent={{40,
              -4},{60,16}})));

    inner Reactions.HOR HOR(n_trans=n_trans) if graphite.'incle-' and ionomer.
      'inclH+' and gas.inclH2 "Hydrogen oxidation reaction"
      annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
    // **temp false
    inner Reactions.ORR ORR(final n_trans=n_trans) if graphite.'incle-' and
      ionomer.'inclH+' and gas.inclO2 and gas.inclH2O
      "Oxygen reduction reaction"
      annotation (Placement(transformation(extent={{0,70},{20,90}})));

    Connectors.FaceBus xNegative if inclFacesX "Negative face along the x axis"
      annotation (Placement(transformation(extent={{-130,-22},{-110,-2}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
    Connectors.FaceBus yNegative if inclFacesY "Negative face along the y axis"
      annotation (Placement(transformation(extent={{-106,-46},{-86,-26}}),
          iconTransformation(extent={{-10,-110},{10,-90}})));
    Connectors.FaceBus zNegative if inclFacesZ "Negative face along the z axis"
      annotation (Placement(transformation(extent={{78,26},{98,46}}),
          iconTransformation(extent={{40,40},{60,60}})));
    Connectors.FaceBus xPositive if inclFacesX "Positive face along the x axis"
      annotation (Placement(transformation(extent={{90,14},{110,34}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    Connectors.FaceBus yPositive if inclFacesY "Positive face along the y axis"
      annotation (Placement(transformation(extent={{66,38},{86,58}}),
          iconTransformation(extent={{-10,90},{10,110}})));
    Connectors.FaceBus zPositive if inclFacesZ "Positive face along the z axis"
      annotation (Placement(transformation(extent={{-118,-34},{-98,-14}}),
          iconTransformation(extent={{-60,-60},{-40,-40}})));

  protected
    Conditions.ByConnector.Amagat.Volume2 volume(V=V) if n_spec > 0
      "Model to establish a fixed total volume"
      annotation (Placement(transformation(extent={{-118,50},{-98,70}})));
    Connectors.InertNode common
      "Connector for translational and thermal exchange among all species"
      annotation (Placement(transformation(extent={{76,-58},{96,-38}}),
          iconTransformation(extent={{100,18},{120,38}})));
    Connectors.InertNode gasLiq
      "Connector for translational and thermal exchange between gas and liquid"
      annotation (Placement(transformation(extent={{76,-70},{96,-50}}),
          iconTransformation(extent={{100,18},{120,38}})));
    Connectors.InertNode graphiteLiq
      "Connector for translational and thermal exchange between graphite and liquid"
      annotation (Placement(transformation(extent={{76,-82},{96,-62}}),
          iconTransformation(extent={{100,18},{120,38}})));

  equation
    // Boundaries and mixing
    // ---------------------
    // Gas
    connect(gas.amagat, volume.amagat) annotation (Line(
        points={{-75,11},{-75,60},{-108,60}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(gas.yNegative, yNegative.gas) annotation (Line(
        points={{-70,-2.4},{-70,-36},{-96,-36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.zPositive, zPositive.gas) annotation (Line(
        points={{-78,-2},{-78,-24},{-108,-24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.xNegative, xNegative.gas) annotation (Line(
        points={{-78,6},{-86,6},{-86,-12},{-120,-12}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.yPositive, yPositive.gas) annotation (Line(
        points={{-70,16},{-70,48},{76,48}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.zNegative, zNegative.gas) annotation (Line(
        points={{-65,11},{-62,14},{-62,36},{88,36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.xPositive, xPositive.gas) annotation (Line(
        points={{-62,6},{-54,6},{-54,24},{100,24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    // Graphite
    connect(graphite.amagat, volume.amagat) annotation (Line(
        points={{-35,11},{-35,60},{-108,60}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(graphite.yNegative, yNegative.graphite) annotation (Line(
        points={{-30,-2.4},{-30,-36},{-96,-36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.yPositive, yPositive.graphite) annotation (Line(
        points={{-30,16},{-30,48},{76,48}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.zNegative, zNegative.graphite) annotation (Line(
        points={{-25,11},{-22,14},{-22,36},{88,36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.zPositive, zPositive.graphite) annotation (Line(
        points={{-38,-2},{-38,-24},{-108,-24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.xNegative, xNegative.graphite) annotation (Line(
        points={{-38,6},{-46,6},{-46,-12},{-120,-12}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.xPositive, xPositive.graphite) annotation (Line(
        points={{-22,6},{-14,6},{-14,24},{100,24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    // Ionomer
    connect(ionomer.amagat, volume.amagat) annotation (Line(
        points={{5,11},{5,60},{-108,60}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(ionomer.yNegative, yNegative.ionomer) annotation (Line(
        points={{10,-2.4},{10,-36},{-96,-36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(ionomer.yPositive, yPositive.ionomer) annotation (Line(
        points={{10,16},{10,48},{76,48}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(ionomer.zNegative, zNegative.ionomer) annotation (Line(
        points={{15,11},{18,14},{18,36},{88,36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(ionomer.zPositive, zPositive.ionomer) annotation (Line(
        points={{2,-2},{2,-24},{-108,-24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(ionomer.xNegative, xNegative.ionomer) annotation (Line(
        points={{2,6},{-6,6},{-6,-12},{-120,-12}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(ionomer.xPositive, xPositive.ionomer) annotation (Line(
        points={{18,6},{26,6},{26,24},{100,24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    // Liquid
    connect(liquid.amagat, volume.amagat) annotation (Line(
        points={{45,11},{45,60},{-108,60}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(liquid.yNegative, yNegative.liquid) annotation (Line(
        points={{50,-2.4},{50,-36},{-96,-36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(liquid.yPositive, yPositive.liquid) annotation (Line(
        points={{50,16},{50,48},{76,48}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(liquid.zNegative, zNegative.liquid) annotation (Line(
        points={{55,11},{58,14},{58,36},{88,36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(liquid.zPositive, zPositive.liquid) annotation (Line(
        points={{42,-2},{42,-24},{-108,-24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(liquid.xNegative, xNegative.liquid) annotation (Line(
        points={{42,6},{34,6},{34,-12},{-120,-12}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(liquid.xPositive, xPositive.liquid) annotation (Line(
        points={{58,6},{66,6},{66,24},{100,24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));

    // Inert exchange
    // --------------
    // Common
    connect(gas.inter[1], common.exchange) annotation (Line(
        points={{-62,-1.5},{-62,-48},{86,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(graphite.inter[1], common.exchange) annotation (Line(
        points={{-22,-1.5},{-22,-48},{86,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(ionomer.inter[1], common.exchange) annotation (Line(
        points={{18,-2},{18,-48},{86,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(liquid.inter[1], common.exchange) annotation (Line(
        points={{58,-1.33333},{58,-48},{86,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    // Gas-liquid
    connect(gas.inter[2], gasLiq.exchange) annotation (Line(
        points={{-62,-2.5},{-62,-60},{86,-60}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(liquid.inter[2], gasLiq.exchange) annotation (Line(
        points={{58,-2},{58,-60},{86,-60}},
        color={38,196,52},
        smooth=Smooth.None));
    // Graphite-liquid
    connect(graphite.inter[2], graphiteLiq.exchange) annotation (Line(
        points={{-22,-2.5},{-22,-72},{86,-72}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(liquid.inter[3], graphiteLiq.exchange) annotation (Line(
        points={{58,-2.66667},{58,-72},{86,-72}},
        color={38,196,52},
        smooth=Smooth.None));

    // Reactions and phase change (not shown in diagram)
    // -------------------------------------------------
    connect(gas.connH2, HOR.connH2);
    connect(gas.connH2O, ORR.connH2O);
    connect(gas.connO2, ORR.connO2);
    connect(gas.connH2O, ionomer.connH2O);
    connect(gas.connH2O, liquid.connH2O);
    connect(graphite.'conne-', HOR.'conne-');
    connect(graphite.'conne-', ORR.'conne-');
    connect(ionomer.'connH+', HOR.'connH+');
    connect(ionomer.'connH+', ORR.'connH+');
    connect(HOR.amagat, volume.amagat) annotation (Line(
        points={{-40,80},{-40,60},{-108,60}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(ORR.amagat, volume.amagat) annotation (Line(
        points={{0,80},{0,60},{-108,60}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(ORR.inter, common.exchange) annotation (Line(
        points={{20,80},{20,72},{68,72},{68,-48},{86,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(HOR.inter, common.exchange) annotation (Line(
        points={{-20,80},{-20,72},{68,72},{68,-48},{86,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    annotation (Documentation(info="<html>
   <p>Please see the documentation of the
   <a href=\"modelica://FCSys.Subregions.BaseClasses.EmptySubregion\">EmptySubregion</a> model.</p></html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-120,-80},{
              100,100}}), graphics));
  end Subregion;

  model SubregionIonomerOnly "Subregion with only the ionomer phase"
    import Modelica.Constants.eps;
    extends Partial(final n_spec=ionomer.n_spec);

    FCSys.Phases.Ionomer ionomer(
      final inclChemical=false,
      n_inter=1,
      final n_faces=n_faces,
      k_inter={k_common}) "Ionomer" annotation (Dialog(group=
            "Phases (click to edit)"), Placement(transformation(extent={{-10,0},
              {10,20}})));

    Connectors.FaceBus xNegative if inclFacesX "Negative face along the x axis"
      annotation (Placement(transformation(extent={{-50,0},{-30,20}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
    Connectors.FaceBus yNegative if inclFacesY "Negative face along the y axis"
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}}),
          iconTransformation(extent={{-10,-110},{10,-90}})));
    Connectors.FaceBus zNegative if inclFacesZ "Negative face along the z axis"
      annotation (Placement(transformation(extent={{10,20},{30,40}}),
          iconTransformation(extent={{40,40},{60,60}})));
    Connectors.FaceBus xPositive if inclFacesX "Positive face along the x axis"
      annotation (Placement(transformation(extent={{30,0},{50,20}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    Connectors.FaceBus yPositive if inclFacesY "Positive face along the y axis"
      annotation (Placement(transformation(extent={{-10,40},{10,60}}),
          iconTransformation(extent={{-10,90},{10,110}})));
    Connectors.FaceBus zPositive if inclFacesZ "Positive face along the z axis"
      annotation (Placement(transformation(extent={{-30,-20},{-10,0}}),
          iconTransformation(extent={{-60,-60},{-40,-40}})));

  protected
    Conditions.ByConnector.Amagat.Volume2 volume(V=V) if n_spec > 0
      "Model to establish a fixed total volume"
      annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  equation
    // Boundaries and mixing
    // ---------------------
    // Ionomer
    connect(ionomer.amagat, volume.amagat) annotation (Line(
        points={{-5,15},{-20,30}},
        color={47,107,251},
        smooth=Smooth.None));

    connect(ionomer.yNegative, yNegative.ionomer) annotation (Line(
        points={{6.10623e-016,1.6},{6.10623e-016,-30},{5.55112e-016,-30}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));

    connect(ionomer.yPositive, yPositive.ionomer) annotation (Line(
        points={{6.10623e-016,20},{6.10623e-016,50},{5.55112e-016,50}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(ionomer.zNegative, zNegative.ionomer) annotation (Line(
        points={{5,15},{20,30}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(ionomer.zPositive, zPositive.ionomer) annotation (Line(
        points={{-8,2},{-20,-10}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));

    connect(ionomer.xNegative, xNegative.ionomer) annotation (Line(
        points={{-8,10},{-40,10}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(ionomer.xPositive, xPositive.ionomer) annotation (Line(
        points={{8,10},{40,10}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));

    annotation (Documentation(info="<html>
   <p>Please see the documentation of the
   <a href=\"modelica://FCSys.Subregions.BaseClasses.EmptySubregion\">EmptySubregion</a> model.</p></html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-60,-40},{
              60,60}}), graphics));
  end SubregionIonomerOnly;

  model SubregionNoIonomer "Subregion with all phases except ionomer"
    import Modelica.Constants.eps;
    extends Partial(final n_spec=gas.n_spec + graphite.n_spec + liquid.n_spec);

    parameter Q.NumberAbsolute k_gas_liq=eps
      "Additional coupling factor between gas and liquid" annotation (Dialog(
          group="Geometry",__Dymola_label=
            "<html><i>k</i><sub>gas liq</sub></html>"));
    parameter Q.NumberAbsolute k_graphite_liq=eps
      "Additional coupling factor between graphite and liquid" annotation (
        Dialog(group="Geometry", __Dymola_label=
            "<html><i>k</i><sub>graphite liq</sub></html>"));

    FCSys.Phases.Gas gas(
      n_inter=2,
      final n_faces=n_faces,
      final inclChemical=gas.inclH2O and liquid.inclH2O,
      k_inter={k_common,k_gas_liq}) "Gas" annotation (Dialog(group=
            "Phases (click to edit)"), Placement(transformation(extent={{-50,-4},
              {-30,16}})));

    FCSys.Phases.Graphite graphite(
      n_inter=2,
      final n_faces=n_faces,
      final inclChemical=gas.inclH2O and liquid.inclH2O,
      k_inter={k_common,k_graphite_liq}) "Graphite" annotation (Dialog(group=
            "Phases (click to edit)"), Placement(transformation(extent={{-10,-4},
              {10,16}})));

    FCSys.Phases.Liquid liquid(n_inter=3, k_inter={k_common,k_gas_liq,
          k_graphite_liq}) "Liquid" annotation (Dialog(group=
            "Phases (click to edit)"), Placement(transformation(extent={{30,-4},
              {50,16}})));

    Connectors.FaceBus xNegative if inclFacesX "Negative face along the x axis"
      annotation (Placement(transformation(extent={{-100,-22},{-80,-2}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
    Connectors.FaceBus yNegative if inclFacesY "Negative face along the y axis"
      annotation (Placement(transformation(extent={{-76,-46},{-56,-26}}),
          iconTransformation(extent={{-10,-110},{10,-90}})));
    Connectors.FaceBus zNegative if inclFacesZ "Negative face along the z axis"
      annotation (Placement(transformation(extent={{68,26},{88,46}}),
          iconTransformation(extent={{40,40},{60,60}})));
    Connectors.FaceBus xPositive if inclFacesX "Positive face along the x axis"
      annotation (Placement(transformation(extent={{80,14},{100,34}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    Connectors.FaceBus yPositive if inclFacesY "Positive face along the y axis"
      annotation (Placement(transformation(extent={{56,38},{76,58}}),
          iconTransformation(extent={{-10,90},{10,110}})));
    Connectors.FaceBus zPositive if inclFacesZ "Positive face along the z axis"
      annotation (Placement(transformation(extent={{-88,-34},{-68,-14}}),
          iconTransformation(extent={{-60,-60},{-40,-40}})));

  protected
    Conditions.ByConnector.Amagat.Volume2 volume(V=V) if n_spec > 0
      "Model to establish a fixed total volume"
      annotation (Placement(transformation(extent={{-88,50},{-68,70}})));
    Connectors.InertNode common
      "Connector for translational and thermal exchange among all species"
      annotation (Placement(transformation(extent={{66,-58},{86,-38}}),
          iconTransformation(extent={{100,18},{120,38}})));
    Connectors.InertNode gasLiq
      "Connector for translational and thermal exchange between gas and liquid"
      annotation (Placement(transformation(extent={{66,-70},{86,-50}}),
          iconTransformation(extent={{100,18},{120,38}})));
    Connectors.InertNode graphiteLiq
      "Connector for translational and thermal exchange between graphite and liquid"
      annotation (Placement(transformation(extent={{66,-82},{86,-62}}),
          iconTransformation(extent={{100,18},{120,38}})));

  equation
    // Boundaries and mixing
    // ---------------------
    // Gas
    connect(gas.amagat, volume.amagat) annotation (Line(
        points={{-45,11},{-45,60},{-78,60}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(gas.yNegative, yNegative.gas) annotation (Line(
        points={{-40,-2.4},{-40,-36},{-66,-36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.zPositive, zPositive.gas) annotation (Line(
        points={{-48,-2},{-48,-24},{-78,-24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.xNegative, xNegative.gas) annotation (Line(
        points={{-48,6},{-56,6},{-56,-12},{-90,-12}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.yPositive, yPositive.gas) annotation (Line(
        points={{-40,16},{-40,48},{66,48}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(gas.zNegative, zNegative.gas) annotation (Line(
        points={{-35,11},{-32,14},{-32,36},{78,36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));

    connect(gas.xPositive, xPositive.gas) annotation (Line(
        points={{-32,6},{-24,6},{-24,24},{90,24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    // Graphite
    connect(graphite.amagat, volume.amagat) annotation (Line(
        points={{-5,11},{-5,60},{-78,60}},
        color={47,107,251},
        smooth=Smooth.None));

    connect(graphite.yNegative, yNegative.graphite) annotation (Line(
        points={{0,-2.4},{0,-36},{-66,-36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.yPositive, yPositive.graphite) annotation (Line(
        points={{0,16},{0,48},{66,48}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.zNegative, zNegative.graphite) annotation (Line(
        points={{5,11},{8,14},{8,36},{78,36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.zPositive, zPositive.graphite) annotation (Line(
        points={{-8,-2},{-8,-24},{-78,-24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.xNegative, xNegative.graphite) annotation (Line(
        points={{-8,6},{-16,6},{-16,-12},{-90,-12}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(graphite.xPositive, xPositive.graphite) annotation (Line(
        points={{8,6},{16,6},{16,24},{90,24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    // Liquid
    connect(liquid.amagat, volume.amagat) annotation (Line(
        points={{35,11},{35,60},{-78,60}},
        color={47,107,251},
        smooth=Smooth.None));

    connect(liquid.yNegative, yNegative.liquid) annotation (Line(
        points={{40,-2.4},{40,-36},{-66,-36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(liquid.yPositive, yPositive.liquid) annotation (Line(
        points={{40,16},{40,48},{66,48}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(liquid.zNegative, zNegative.liquid) annotation (Line(
        points={{45,11},{48,14},{48,36},{78,36}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));
    connect(liquid.zPositive, zPositive.liquid) annotation (Line(
        points={{32,-2},{32,-24},{-78,-24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));

    connect(liquid.xNegative, xNegative.liquid) annotation (Line(
        points={{32,6},{24,6},{24,-12},{-90,-12}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));

    connect(liquid.xPositive, xPositive.liquid) annotation (Line(
        points={{48,6},{56,6},{56,24},{90,24}},
        color={127,127,127},
        pattern=LinePattern.None,
        thickness=0.5,
        smooth=Smooth.None));

    // Inert exchange
    // --------------
    // Common
    connect(gas.inter[1], common.exchange) annotation (Line(
        points={{-32,-1.5},{-32,-48},{76,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(graphite.inter[1], common.exchange) annotation (Line(
        points={{8,-1.5},{8,-48},{76,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(liquid.inter[1], common.exchange) annotation (Line(
        points={{48,-1.33333},{48,-48},{76,-48}},
        color={38,196,52},
        smooth=Smooth.None));
    // Gas-liquid
    connect(gas.inter[2], gasLiq.exchange) annotation (Line(
        points={{-32,-2.5},{-32,-60},{76,-60}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(liquid.inter[2], gasLiq.exchange) annotation (Line(
        points={{48,-2},{48,-60},{76,-60}},
        color={38,196,52},
        smooth=Smooth.None));
    // Graphite-liquid
    connect(graphite.inter[2], graphiteLiq.exchange) annotation (Line(
        points={{8,-2.5},{8,-72},{76,-72}},
        color={38,196,52},
        smooth=Smooth.None));
    connect(liquid.inter[3], graphiteLiq.exchange) annotation (Line(
        points={{48,-2.66667},{48,-72},{76,-72}},
        color={38,196,52},
        smooth=Smooth.None));

    // Phase change (not shown in diagram)
    // -----------------------------------
    connect(gas.connH2O, liquid.connH2O);

    annotation (Documentation(info="<html>
   <p>Please see the documentation of the
   <a href=\"modelica://FCSys.Subregions.BaseClasses.EmptySubregion\">EmptySubregion</a> model.</p></html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-80},{
              100,80}}), graphics));
  end SubregionNoIonomer;

  partial model Partial
    "Base model for multi-dimensional, multi-species storage, transport, and exchange"
    import FCSys.Utilities.cartWrap;
    import Modelica.Math.BooleanVectors.countTrue;
    import Modelica.Math.BooleanVectors.enumerate;
    import Modelica.Math.BooleanVectors.index;
    // extends FCSys.Icons.Names.Top3;

    // Geometric parameters
    inner parameter Q.Length L[Axis](each min=Modelica.Constants.small) = {U.cm,
      U.cm,U.cm} "Lengths" annotation (Dialog(group="Geometry", __Dymola_label=
            "<html><b><i>L</i></b></html>"));
    final inner parameter Q.Area A[Axis]={L[cartWrap(axis + 1)]*L[cartWrap(axis
         + 2)] for axis in Axis} "Cross-sectional areas";
    final inner parameter Q.Volume V=product(L) "Volume";
    parameter Q.NumberAbsolute k_common=1
      "Coupling factor for exchange among all phases" annotation (Dialog(group=
            "Geometry", __Dymola_label="<html><i>k</i><sub>common</sub></html>"));

    // Assumptions
    // -----------
    // Included components of translational momentum
    parameter Boolean inclTransX=true "X" annotation (choices(__Dymola_checkBox
          =true), Dialog(
        tab="Assumptions",
        group="Axes with translational momentum included",
        compact=true));
    parameter Boolean inclTransY=true "Y" annotation (choices(__Dymola_checkBox
          =true), Dialog(
        tab="Assumptions",
        group="Axes with translational momentum included",
        compact=true));
    parameter Boolean inclTransZ=true "Z" annotation (choices(__Dymola_checkBox
          =true), Dialog(
        tab="Assumptions",
        group="Axes with translational momentum included",
        compact=true));
    //
    // Included faces
    parameter Boolean inclFacesX=true "X" annotation (
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(
        tab="Assumptions",
        group="Axes with faces included",
        compact=true));
    parameter Boolean inclFacesY=true "Y" annotation (
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(
        tab="Assumptions",
        group="Axes with faces included",
        compact=true));
    parameter Boolean inclFacesZ=true "Z" annotation (
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(
        tab="Assumptions",
        group="Axes with faces included",
        compact=true));

  protected
    parameter Integer n_spec(start=0) "Number of species"
      annotation (HideResult=true);
    final inner parameter Boolean inclTrans[Axis]={inclTransX,inclTransY,
        inclTransZ}
      "true, if each component of translational momentum is included";
    final inner parameter Boolean inclFaces[Axis]={inclFacesX,inclFacesY,
        inclFacesZ} "true, if each pairs of faces is included";
    final inner parameter Boolean inclRot[Axis]={inclFacesY and inclFacesZ,
        inclFacesZ and inclFacesX,inclFacesX and inclFacesY}
      "true, if each axis of rotation has all its tangential faces included";
    final inner parameter Integer n_trans=countTrue(inclTrans)
      "Number of components of translational momentum";
    final inner parameter Integer n_faces=countTrue(inclFaces)
      "Number of pairs of faces";
    final inner parameter Integer cartTrans[n_trans]=index(inclTrans)
      "Cartesian-axis indices of the components of translational momentum";
    final inner parameter Integer cartFaces[n_faces]=index(inclFaces)
      "Cartesian-axis indices of the pairs of faces";
    final inner parameter Integer cartRot[:]=index(inclRot)
      "Cartesian-axis indices of the components of rotational momentum";
    final inner parameter Integer transCart[Axis]=enumerate(inclTrans)
      "Translational-momentum-component indices of the Cartesian axes";
    final inner parameter Integer facesCart[Axis]=enumerate(inclFaces)
      "Face-pair indices of the Cartesian axes";

    annotation (
      defaultComponentPrefixes="replaceable",
      defaultComponentName="subregion",
      Documentation(info="<html>
  <p>At least one component of translational momentum must be included.
  All of the components are included by default.</p>

    <p>At least one pair of faces must be included.
  All of the faces are included by default.</p>

  <p>This model should be extended to include the appropriate phases and reactions.</p>
  </html>"),
      Icon(graphics={
          Line(
            points={{-100,0},{-40,0}},
            color={127,127,127},
            thickness=0.5,
            visible=inclFacesX,
            smooth=Smooth.None),
          Line(
            points={{0,-40},{0,-100}},
            color={127,127,127},
            thickness=0.5,
            visible=inclFacesY,
            smooth=Smooth.None),
          Line(
            points={{40,40},{50,50}},
            color={127,127,127},
            thickness=0.5,
            visible=inclFacesZ,
            smooth=Smooth.None),
          Polygon(
            points={{-40,16},{-16,40},{40,40},{40,-16},{16,-40},{-40,-40},{-40,
                16}},
            lineColor={127,127,127},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-40,-40},{-16,-16}},
            color={127,127,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash),
          Line(
            points={{-16,40},{-16,-16},{40,-16}},
            color={127,127,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash),
          Line(
            points={{-40,0},{28,0}},
            color={210,210,210},
            visible=inclFacesX,
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{0,28},{0,-40}},
            color={210,210,210},
            visible=inclFacesY,
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{28,0},{100,0}},
            color={127,127,127},
            thickness=0.5,
            visible=inclFacesX,
            smooth=Smooth.None),
          Line(
            points={{0,100},{0,28}},
            color={127,127,127},
            thickness=0.5,
            visible=inclFacesY,
            smooth=Smooth.None),
          Line(
            points={{-12,-12},{40,40}},
            color={210,210,210},
            visible=inclFacesZ,
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{-40,16},{16,16},{16,-40}},
            color={127,127,127},
            smooth=Smooth.None),
          Line(
            points={{-50,-50},{-12,-12}},
            color={127,127,127},
            thickness=0.5,
            visible=inclFacesZ,
            smooth=Smooth.None),
          Polygon(
            points={{-40,16},{-16,40},{40,40},{40,-16},{16,-40},{-40,-40},{-40,
                16}},
            lineColor={127,127,127},
            smooth=Smooth.None),
          Line(
            points={{40,40},{16,16}},
            color={127,127,127},
            smooth=Smooth.None),
          Text(
            extent={{-100,56},{100,96}},
            textString="%name",
            lineColor={0,0,0})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics));

  end Partial;
  annotation (Documentation(info="
<html>
  <p><b>Licensed by the Georgia Tech Research Corporation under the Modelica License 2</b><br>
Copyright 2007&ndash;2013, <a href=\"http://www.gtrc.gatech.edu/\">Georgia Tech Research Corporation</a>.</p>

<p><i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>;
it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the
disclaimer of warranty) see <a href=\"modelica://FCSys.UsersGuide.License\">
FCSys.UsersGuide.License</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">
http://www.modelica.org/licenses/ModelicaLicense2</a>.</i></p>
</html>"));
end Subregions;
