within FCSys;
package Chemistry "Chemical reactions and related models"
  extends Icons.ChemistryPackage;

  package Examples "Examples"
    extends Modelica.Icons.ExamplesPackage;
    //  **update

    model Overpotential "Demonstrate the Butler-Volmer overpotential"
      extends Modelica.Icons.Example;
      extends Modelica.Icons.UnderConstruction;

      output Q.Potential w=-transfer.Deltag "Overpotential";
      output Q.Current I_A=-transfer.I/U.A if environment.analysis
        "Reaction current in amperes";

      Chemistry.Electrochemistry.ElectronTransfer transfer(
        redeclare constant Integer n_trans=1,
        fromI=false,
        I0_300K=U.mA)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
      Conditions.ByConnector.Chemical.Potential potential(
        inclTransY=false,
        inclTransZ=false,
        chemical(redeclare constant Integer n_trans=1)) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={36,0})));
      Conditions.ByConnector.Chemical.Current current(
        inclTransY=false,
        inclTransZ=false,
        chemical(redeclare constant Integer n_trans=1),
        redeclare Modelica.Blocks.Sources.Sine set(
          freqHz=1,
          amplitude=100*U.A,
          phase=1.5707963267949)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-36,0})));
      Chemistry.Electrochemistry.DoubleLayer doubleLayer(
        setVelocity=false,
        inclVolume=false,
        redeclare constant Integer n_trans=1,
        w(fixed=true))
        annotation (Placement(transformation(extent={{-10,20},{10,40}})));
      Conditions.ByConnector.Inter.Efforts substrate(
        inclTransX=true,
        inclTransY=false,
        inclTransZ=false,
        internalTransX=true,
        internalTransY=true,
        internalTransZ=true)
        annotation (Placement(transformation(extent={{50,10},{70,-10}})));

      inner Conditions.Environment environment
        annotation (Placement(transformation(extent={{40,40},{60,60}})));

    equation
      connect(current.chemical, transfer.negative) annotation (Line(
          points={{-32,0},{-6,0}},
          color={255,195,38},
          smooth=Smooth.None));
      connect(potential.chemical, transfer.positive) annotation (Line(
          points={{32,0},{6,0}},
          color={255,195,38},
          smooth=Smooth.None));
      connect(doubleLayer.negative, transfer.negative) annotation (Line(
          points={{-6,30},{-20,30},{-20,0},{-6,0}},
          color={255,195,38},
          smooth=Smooth.None));
      connect(doubleLayer.positive, transfer.positive) annotation (Line(
          points={{6,30},{20,30},{20,0},{6,0}},
          color={255,195,38},
          smooth=Smooth.None));
      connect(substrate.inter, doubleLayer.inert) annotation (Line(
          points={{60,10},{60,20},{0,20},{0,26}},
          color={221,23,47},
          smooth=Smooth.None));
      connect(substrate.inter, transfer.inert) annotation (Line(
          points={{60,10},{60,20},{0,20},{0,4}},
          color={221,23,47},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        experiment(StopTime=2, __Dymola_NumberOfIntervals=5000),
        Commands(file=
              "Resources/Scripts/Dymola/Chemistry.Examples.Overpotential.mos"
            "Chemistry.Examples.Overpotential.mos"));
    end Overpotential;

    model Stoichiometry
      "<html>Test the stoichiometry of the <a href=\"modelica://FCSys.Chemistry.HOR\">HOR</a></html>"
      extends Modelica.Icons.Example;
      extends Modelica.Icons.UnderConstruction;

      HOR hOR(n_trans=3)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Conditions.ByConnector.Chemical.Potential H2(sT=1000*U.K, set(y=U.A))
        annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
      Conditions.ByConnector.Chemical.Current 'e-'(sT=2000*U.K, redeclare
          Modelica.Blocks.Sources.Ramp set(
          height=100*U.A,
          duration=100,
          startTime=10,
          offset=U.mA))
        annotation (Placement(transformation(extent={{-10,-10},{10,-30}})));
      Conditions.ByConnector.Chemical.Potential 'H+'(sT=3000*U.K)
        annotation (Placement(transformation(extent={{20,-10},{40,-30}})));

      inner Conditions.Environment environment
        annotation (Placement(transformation(extent={{20,20},{40,40}})));

    equation
      connect(hOR.'chemH+', 'H+'.chemical) annotation (Line(
          points={{4,0},{4,-8},{30,-8},{30,-16}},
          color={255,195,38},
          smooth=Smooth.None));
      connect(H2.chemical, hOR.chemH2) annotation (Line(
          points={{-30,-16},{-30,-8},{-4,-8},{-4,0}},
          color={255,195,38},
          smooth=Smooth.None));
      connect('e-'.chemical, hOR.'cheme-') annotation (Line(
          points={{0,-16},{0,0}},
          color={255,195,38},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        Commands(file=
              "Resources/Scripts/Dymola/Chemistry.Examples.Stoichiometry.mos"
            "Reactions.Examples.Stoichiometry.mos"),
        experiment(StopTime=200));
    end Stoichiometry;

  end Examples;

  package Electrochemistry "Models associated with electrochemical reactions"
    extends Modelica.Icons.Package;

    model DoubleLayer "Electrolytic double layer"
      extends FCSys.Icons.Names.Top2;

      parameter Integer n_trans(min=1,max=3)
        "Number of components of translational momentum" annotation (Evaluate=
            true,Dialog(__Dymola_label="<html><i>n</i><sub>trans</sub></html>"));
      parameter Q.Area A=10*U.m^2 "Surface area"
        annotation (Dialog(__Dymola_label="<html><i>A</i></html>"));
      parameter Q.Length L=1e-10*U.m "Length of the gap"
        annotation (Dialog(__Dymola_label="<html><i>L</i></html>"));
      parameter Q.Permittivity epsilon=U.epsilon_0
        "Permittivity of the dielectric"
        annotation (Dialog(__Dymola_label="<html>&epsilon;</html>"));

      final parameter Q.Capacitance C=epsilon*A/L "Capacitance";
      replaceable package Data = Characteristics.'e-'.Graphite constrainedby
        Characteristics.BaseClasses.Characteristic "Material properties"
        annotation (
        Evaluate=true,
        choicesAllMatching=true,
        __Dymola_choicesFromPackage=true);

      parameter Boolean setVelocity=true
        "<html>Include the <code>inert</code> connector to set the exit velocity</html>"
        annotation (
        Evaluate=true,
        Dialog(tab="Assumptions", compact=true),
        choices(__Dymola_checkBox=true));
      parameter Boolean inclVolume=true
        "<html>Include the <code>amagat</code> connector to occupy volume</html>"
        annotation (
        Evaluate=true,
        Dialog(tab="Assumptions", compact=true),
        choices(__Dymola_checkBox=true));

      // Aliases
      Q.Potential w(
        stateSelect=StateSelect.always,
        start=0,
        fixed=true) "Electrical potential";
      Q.Current I "Material current";

      output Q.Amount Z(stateSelect=StateSelect.never) = C*w if environment.analysis
        "Amount of charge shifted in the positive direction";

      Connectors.Chemical negative(final n_trans=n_trans)
        "Chemical connector on the 1st side" annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}}), iconTransformation(
              extent={{-70,-10},{-50,10}})));
      Connectors.Chemical positive(final n_trans=n_trans)
        "Chemical connector on the 2nd side" annotation (Placement(
            transformation(extent={{10,-10},{30,10}}), iconTransformation(
              extent={{50,-10},{70,10}})));
      Connectors.Inert inert(
        final n_trans=n_trans,
        final phi=phi_inert,
        final mPhidot=mPhidot_inert,
        final Qdot=Qdot_inert) if setVelocity
        "Translational and thermal interface with the substrate" annotation (
          Placement(transformation(extent={{-10,-30},{10,-10}}),
            iconTransformation(extent={{-10,-50},{10,-30}})));

      Connectors.Amagat amagat(final V=-A*L) if inclVolume
        "Connector for additivity of volume"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    protected
      Q.Velocity phi_inert[n_trans]
        "Velocity at the inert connector (or zero if removed)";
      Q.Force mPhidot_inert[n_trans] "Force into the inert connector";
      Q.Power Qdot_inert "Rate of thermal conduction into the inert connector";

      outer Conditions.Environment environment "Environmental conditions";

    equation
      // Equations if inert connector is removed
      if not setVelocity then
        phi_inert = zeros(n_trans);
        mPhidot_inert = zeros(n_trans);
      end if;

      // Aliases
      Data.z*w = positive.g - negative.g;
      I = positive.Ndot;

      // Streams
      if setVelocity then
        negative.phi = phi_inert;
        positive.phi = phi_inert;
      else
        negative.phi = inStream(positive.phi);
        positive.phi = inStream(negative.phi);
      end if;
      negative.sT = inStream(positive.sT);
      positive.sT = inStream(negative.sT);

      // Conservation
      0 = negative.Ndot + positive.Ndot "Material (no storage)";
      zeros(n_trans) = Data.m*(actualStream(negative.phi) - actualStream(
        positive.phi))*I + mPhidot_inert "Translational momentum (no storage)";
      der(C*w)/U.s = Data.z*I
        "Electrical energy (reversible; simplified using material conservation and divided by potential)";
      0 = Qdot_inert + (actualStream(negative.phi)*actualStream(negative.phi)
         - actualStream(positive.phi)*actualStream(positive.phi))*I*Data.m/2 +
        phi_inert*mPhidot_inert "Mechanical and thermal energy (no storage)";

      annotation (
        Documentation(info="<html><p>The capacitance (<i>C</i>) is calculated from the surface area (<i>A</i>), 
    length of the gap (<i>L</i>), and the permittivity (&epsilon;) assuming that the
  charges are uniformly distributed over (infinite) parallel planes.</p>

  <p>If <code>setVelocity</code> is <code>true</code>, then the material exits with the
  velocity of the <code>inert</code> connector.  Typically, that connector should be connected to the stationary solid,
  in which case heat will be generated if material arrives with a nonzero velocity.  That heat is rejected to the same connector.
  If <code>setVelocity</code> is <code>false</code>, then the <code>inert</code> connector is removed.</p>

  </html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{-20,30},{-20,-30}},
                  color={255,195,38},
                  smooth=Smooth.None),Line(
                  points={{20,30},{20,-30}},
                  color={255,195,38},
                  smooth=Smooth.None),Line(
                  points={{-50,0},{-20,0}},
                  color={255,195,38},
                  smooth=Smooth.None),Line(
                  points={{20,0},{50,0}},
                  color={255,195,38},
                  smooth=Smooth.None)}));
    end DoubleLayer;

    model ElectronTransfer "Electron transfer"
      import Modelica.Math.asinh;
      extends FCSys.Icons.Names.Top1;

      parameter Integer n_trans(min=1,max=3)
        "Number of components of translational momentum" annotation (Evaluate=
            true,Dialog(__Dymola_label="<html><i>n</i><sub>trans</sub></html>"));
      parameter Integer n=1 "Apparent electron transfer number" annotation (
          Dialog(group="Electrochemical parameters", __Dymola_label=
              "<html><i>n</i></html>"));
      parameter Q.Potential E_A=0 "Activation energy" annotation (Dialog(group=
              "Electrochemical parameters", __Dymola_label=
              "<html><i>E</i><sub>A</sub></html>"));
      parameter Q.NumberAbsolute alpha(max=1) = 0.5
        "Charge transfer coefficient" annotation (Dialog(group=
              "Electrochemical parameters", __Dymola_label=
              "<html>&alpha;</html>"));
      Q.Current I0_300K=U.A "Exchange current @ 300 K" annotation (Dialog(
            __Dymola_label="<html><i>I</i><sup>o</sup><sub>300 K</sub></html>",
            group="Electrochemical parameters"));
      parameter Boolean fromI=true
        "<html>Invert the Butler-Volmer equation, if &alpha;=&frac12;</html>"
        annotation (Dialog(tab="Advanced", compact=true), choices(
            __Dymola_checkBox=true));

      Connectors.Chemical negative(final n_trans=n_trans)
        "Chemical connector on the 1st side" annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}}), iconTransformation(
              extent={{-70,-10},{-50,10}})));
      Connectors.Chemical positive(final n_trans=n_trans)
        "Chemical connector on the 2nd side" annotation (Placement(
            transformation(extent={{10,-10},{30,10}}), iconTransformation(
              extent={{50,-10},{70,10}})));

      // Aliases
      Q.TemperatureAbsolute T(start=300*U.K) "Reaction rate";
      Q.Current I(start=0) "Reaction rate";
      Q.Potential Deltag(start=0) "Potential difference";
      Q.Current I0 "Exchange current";

      Connectors.Inert inert(final n_trans=n_trans)
        "Translational and thermal interface with the substrate" annotation (
          Placement(transformation(extent={{-10,-30},{10,-10}}),
            iconTransformation(extent={{-10,-50},{10,-30}})));

    equation
      // Aliases
      I = positive.Ndot;
      Deltag = positive.g - negative.g;
      T = inert.T;
      I0 = n*I0_300K*exp(E_A*(1/(300*U.K) - 1/T)) "Arrhenius equation";
      // **note that I0_300K is for single electron transfer
      // **note that exchange current density is adjusted from the reference at
      // 300 K (I0_300K) using the Arrhenius equation

      // Streams
      negative.phi = inStream(positive.phi);
      positive.phi = inStream(negative.phi);
      // **negative.phi = zeros(n_trans);
      // **positive.phi = zeros(n_trans);
      negative.sT = inStream(positive.sT);
      positive.sT = inStream(negative.sT);

      // Reaction rate
      if abs(alpha - 0.5) < Modelica.Constants.eps and fromI then
        n*Deltag = 2*T*asinh(0.5*I/I0);
      else
        I = I0*(exp(n*(1 - alpha)*Deltag/T) - exp(-n*alpha*Deltag/T));
      end if;

      // Conservation (without storage)
      0 = negative.Ndot + positive.Ndot "Material";
      zeros(n_trans) = inert.mPhidot "Translational momentum";
      0 = Deltag*I + inert.Qdot "Energy";
      // Note:  Energy and momentum cancel among the stream terms.

      annotation (
        defaultComponentName="transfer",
        Documentation(info="<html><p><code>fromI</code> may help to eliminate nonlinear systems of equations if the

    <a href=\"modelica://FCSys.Chemistry.Electrochemistry.DoubleLayer\">double layer capacitance</a> is not included.</p>
    
    <p>
    Note that the apparent electron number may be different than the total number of electrons in the reaction, and
    it may even depend on reaction rate [<a href=\"modelica://FCSys.UsersGuide.References.Yuan2009\">Yuan2009</a>, p.&nbsp;20]</html>"),

        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{0,-20},{0,-50}},
                  color={221,23,47},
                  smooth=Smooth.None),Line(
                  points={{-50,0},{50,0}},
                  color={255,195,38},
                  smooth=Smooth.None),Rectangle(
                  extent={{-30,20},{32,-20}},
                  lineColor={255,195,38},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-20,4},{20,4},{8,12}},
                  color={255,195,38},
                  smooth=Smooth.None),Line(
                  points={{-20,-5},{20,-5},{8,3}},
                  color={255,195,38},
                  smooth=Smooth.None,
                  origin={0,-11},
                  rotation=180)}));
    end ElectronTransfer;

  end Electrochemistry;

  model HOR "Hydrogen oxidation reaction"
    extends FCSys.Icons.Names.Top2;

    constant Integer n_trans(min=0, max=3)
      "Number of components of translational momentum" annotation (Dialog(
          __Dymola_label="<html><i>n</i><sub>trans</sub></html>"));
    // Note:  This must be a constant rather than a parameter due to errors in
    // Dymola 2014.
    Conditions.Adapters.ChemicalReaction 'e-'(
      final n_trans=n_trans,
      m=Characteristics.'e-'.Gas.m,
      n=-2) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-10,-10})));
    Conditions.Adapters.ChemicalReaction 'H+'(
      final n_trans=n_trans,
      m=Characteristics.'H+'.Gas.m,
      n=-2) annotation (Placement(transformation(extent={{0,-20},{-20,-40}})));
    Conditions.Adapters.ChemicalReaction H2(
      final n_trans=n_trans,
      m=Characteristics.H2.Gas.m,
      n=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,-20})));

    Connectors.Chemical 'cheme-'(redeclare final constant Integer n_trans=
          n_trans) "Connector for e-" annotation (Placement(transformation(
            extent={{20,-20},{40,0}}), iconTransformation(extent={{-10,-10},{10,
              10}})));
    Connectors.Chemical 'chemH+'(redeclare final constant Integer n_trans=
          n_trans) "Connector for H+" annotation (Placement(transformation(
            extent={{20,-40},{40,-20}}), iconTransformation(extent={{30,-10},{
              50,10}})));
    Connectors.Chemical chemH2(redeclare final constant Integer n_trans=n_trans)
      "Connector for H2" annotation (Placement(transformation(extent={{-60,-30},
              {-40,-10}}), iconTransformation(extent={{-50,-10},{-30,10}})));
    // Note:  These redeclarations are necessary due to errors in Dymola 2014.
    // **Try again

    parameter Boolean inclDL=false "Include the double-layer capacitance"
      annotation (
      HideResult=true,
      Dialog(tab="Assumptions", compact=true),
      choices(__Dymola_checkBox=true));

    Electrochemistry.ElectronTransfer transfer(
      redeclare final constant Integer n_trans=n_trans,
      n=2,
      E_A=15*U.kJ/U.mol) "Electron transfer" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={10,-10})));
    Electrochemistry.DoubleLayer doubleLayer(redeclare final constant Integer
        n_trans=n_trans) if inclDL "Electrolytic double layer" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={10,26})));
    // Note:  n_trans must be constant in Dymola 2014 to prevent errors such as
    // "Failed to expand the variable subregion.ORR.transfer.negative.phi".  The
    // setting of n_trans=1 must be manually changed at instantiation if
    // additional transport axes are enabled.
    Connectors.Amagat amagat if inclDL "Connector for additivity of volume"
      annotation (Placement(transformation(extent={{20,20},{40,40}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    Connectors.Inter inert(final n_trans=n_trans)
      "Translational and thermal interface with the substrate" annotation (
        Placement(transformation(extent={{20,0},{40,20}}), iconTransformation(
            extent={{-108,-10},{-88,10}})));
  equation
    connect(chemH2, H2.chemical) annotation (Line(
        points={{-50,-20},{-34,-20}},
        color={255,195,38},
        smooth=Smooth.None));
    connect('H+'.chemical, 'chemH+') annotation (Line(
        points={{-6,-30},{30,-30}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(H2.reaction, 'e-'.reaction) annotation (Line(
        points={{-26,-20},{-20,-20},{-20,-10},{-14,-10}},
        color={255,195,38},
        smooth=Smooth.None));
    connect('H+'.reaction, H2.reaction) annotation (Line(
        points={{-14,-30},{-20,-30},{-20,-20},{-26,-20}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(doubleLayer.positive, 'cheme-') annotation (Line(
        points={{16,26},{20,26},{20,-10},{30,-10}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(transfer.positive, 'cheme-') annotation (Line(
        points={{16,-10},{30,-10}},
        color={255,195,38},
        smooth=Smooth.None));
    connect('e-'.chemical, transfer.negative) annotation (Line(
        points={{-6,-10},{4,-10}},
        color={255,195,38},
        smooth=Smooth.None));
    connect('e-'.chemical, doubleLayer.negative) annotation (Line(
        points={{-6,-10},{0,-10},{0,26},{4,26}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(doubleLayer.inert, transfer.inert) annotation (Line(
        points={{10,22},{10,-6}},
        color={221,23,47},
        smooth=Smooth.None));
    connect(amagat, doubleLayer.amagat) annotation (Line(
        points={{30,30},{10,30},{10,26}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(inert, transfer.inert) annotation (Line(
        points={{30,10},{10,10},{10,-6}},
        color={221,23,47},
        smooth=Smooth.None));
    annotation (
      defaultComponentName="HOR",
      Documentation(info="<html>
    
    <table border=1><tr><td><font size=100 color=\"gray\">H<sub>2</sub> &#8652; 2e<sup>-</sup> + 2H<sup>+</sup></font></td></tr></table>
    
    <p>The activation energy of 15&nbsp;kJ/mol is the middle of the range (10&ndash;20&nbsp;kJ/mol) given by
    [<a href=\"modelica://FCSys.UsersGuide.References.Neyerlin2007\">Neyerlin2007</a>, p.&nbsp;B635].    
    </p>
    </html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
              extent={{-100,40},{100,-50}},
              pattern=LinePattern.Dash,
              lineColor={127,127,127},
              radius=15,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Bitmap(extent={{-100,-20},{100,-40}},
            fileName=
            "modelica://FCSys/Resources/Documentation/Reactions/HOR.png")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-40},{40,
              40}}), graphics));
  end HOR;

  model ORR "Oxygen reduction reaction"
    extends FCSys.Icons.Names.Top2;

    constant Integer n_trans(min=0, max=3)
      "Number of components of translational momentum" annotation (Dialog(
          __Dymola_label="<html><i>n</i><sub>trans</sub></html>"));
    // Note:  This must be a constant rather than a parameter due to errors in
    // Dymola 2014.
    parameter Boolean inclDL=false "Include the double-layer capacitance"
      annotation (
      HideResult=true,
      Dialog(tab="Assumptions", compact=true),
      choices(__Dymola_checkBox=true));

    Conditions.Adapters.ChemicalReaction 'e-'(
      final n_trans=n_trans,
      m=Characteristics.'e-'.Gas.m,
      reaction(Ndot(stateSelect=StateSelect.prefer)),
      n=4) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-10,-10})));
    Conditions.Adapters.ChemicalReaction 'H+'(
      final n_trans=n_trans,
      m=Characteristics.'H+'.Gas.m,
      n=4) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Conditions.Adapters.ChemicalReaction O2(
      final n_trans=n_trans,
      m=Characteristics.O2.Gas.m,
      n=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-10,-50})));
    Conditions.Adapters.ChemicalReaction H2O(
      final n_trans=n_trans,
      m=Characteristics.H2O.Gas.m,
      n=-2) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={10,-30})));

    Connectors.Chemical 'cheme-'(redeclare final constant Integer n_trans=
          n_trans) "Connector for e-" annotation (Placement(transformation(
            extent={{-60,-20},{-40,0}}), iconTransformation(extent={{-70,-10},{
              -50,10}})));
    Connectors.Chemical 'chemH+'(redeclare final constant Integer n_trans=
          n_trans) "Connector for H+" annotation (Placement(transformation(
            extent={{-60,-40},{-40,-20}}), iconTransformation(extent={{-30,-10},
              {-10,10}})));
    Connectors.Chemical chemO2(redeclare final constant Integer n_trans=n_trans)
      "Connector for O2" annotation (Placement(transformation(extent={{-60,-60},
              {-40,-40}}), iconTransformation(extent={{10,-10},{30,10}})));
    Connectors.Chemical chemH2O(redeclare final constant Integer n_trans=
          n_trans) "Connector for H2O" annotation (Placement(transformation(
            extent={{20,-40},{40,-20}}), iconTransformation(extent={{50,-10},{
              70,10}})));
    // Note:  These redeclarations are necessary due to errors in Dymola 2014.
    // **Try again
    Electrochemistry.ElectronTransfer transfer(
      redeclare final constant Integer n_trans=n_trans,
      n=4,
      E_A=67*U.kJ/U.mol) "Electron transfer" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={-30,-10})));
    Electrochemistry.DoubleLayer doubleLayer(redeclare final constant Integer
        n_trans=n_trans) if inclDL "Electrolytic double layer" annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,26})));
    Connectors.Amagat amagat if inclDL "Connector for additivity of volume"
      annotation (Placement(transformation(extent={{-60,20},{-40,40}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    Connectors.Inter inert(final n_trans=n_trans)
      "Translational and thermal interface with the substrate" annotation (
        Placement(transformation(extent={{-60,0},{-40,20}}), iconTransformation(
            extent={{-108,-10},{-88,10}})));
  equation
    connect('H+'.chemical, 'chemH+') annotation (Line(
        points={{-14,-30},{-50,-30}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(O2.chemical, chemO2) annotation (Line(
        points={{-14,-50},{-50,-50}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(H2O.chemical, chemH2O) annotation (Line(
        points={{14,-30},{30,-30}},
        color={255,195,38},
        smooth=Smooth.None));
    connect('e-'.reaction, H2O.reaction) annotation (Line(
        points={{-6,-10},{0,-10},{0,-30},{6,-30}},
        color={255,195,38},
        smooth=Smooth.None));
    connect('H+'.reaction, H2O.reaction) annotation (Line(
        points={{-6,-30},{6,-30}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(O2.reaction, H2O.reaction) annotation (Line(
        points={{-6,-50},{0,-50},{0,-30},{6,-30}},
        color={255,195,38},
        smooth=Smooth.None));
    connect('e-'.chemical, transfer.negative) annotation (Line(
        points={{-14,-10},{-24,-10}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(doubleLayer.positive, 'cheme-') annotation (Line(
        points={{-36,26},{-40,26},{-40,-10},{-50,-10}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(transfer.positive, 'cheme-') annotation (Line(
        points={{-36,-10},{-50,-10}},
        color={255,195,38},
        smooth=Smooth.None));
    connect('e-'.chemical, doubleLayer.negative) annotation (Line(
        points={{-14,-10},{-20,-10},{-20,26},{-24,26}},
        color={255,195,38},
        smooth=Smooth.None));
    connect(amagat, doubleLayer.amagat) annotation (Line(
        points={{-50,30},{-30,30},{-30,26}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(doubleLayer.inert, transfer.inert) annotation (Line(
        points={{-30,22},{-30,-6}},
        color={221,23,47},
        smooth=Smooth.None));
    connect(inert, transfer.inert) annotation (Line(
        points={{-50,10},{-30,10},{-30,-6}},
        color={221,23,47},
        smooth=Smooth.None));
    annotation (
      defaultComponentName="ORR",
      Documentation(info="<html><table border=1><tr><td><font size=100 color=\"gray\">4e<sup>-</sup> + 4H<sup>+</sup> + O<sub>2</sub> &#8652; 2H<sub>2</sub>O</font></td></tr></table> 
        
    <p>The activation energy is 67&nbsp;kJ/mol [<a href=\"modelica://FCSys.UsersGuide.References.Neyerlin2007\">Neyerlin2006</a>, p.&nbsp;A1955].
    </p>
    </html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
              extent={{-100,40},{100,-50}},
              pattern=LinePattern.Dash,
              lineColor={127,127,127},
              radius=15,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Bitmap(extent={{-100,-20},{100,-40}},
            fileName=
            "modelica://FCSys/Resources/Documentation/Reactions/ORR.png")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},{40,
              40}}), graphics));
  end ORR;

public
  model Capillary "Young-Laplace model for capillary pressure"

    extends FCSys.Icons.Names.Top2;

    // Geometry
    parameter Q.Length R=U.um "Effective radius" annotation (Dialog(group=
            "Geometry", __Dymola_label="<html><i>R</i></html>"));

    // Material properties
    parameter Q.SurfaceTension gamma=0.0663*U.N/U.m "Surface tension"
      annotation (Dialog(group="Material properties", __Dymola_label=
            "<html>&gamma;</html>"));
    parameter Q.Angle theta=140*U.degree "Contact angle" annotation (Dialog(
          group="Material properties", __Dymola_label="<html>&theta;</html>"));

    // Auxiliary variables (for analysis only)
    Q.Pressure Deltap=wetting.p - nonwetting.p if environment.analysis
      "Pressure difference due to surface tension";

    Connectors.Amagat wetting "Interface to the wetting phase" annotation (
        Placement(transformation(extent={{-30,-10},{-10,10}}),
          iconTransformation(extent={{-50,-10},{-30,10}})));
    Connectors.Amagat nonwetting "Interface to the nonwetting phase"
      annotation (Placement(transformation(extent={{10,-10},{30,10}}),
          iconTransformation(extent={{30,-10},{50,10}})));

  protected
    outer Conditions.Environment environment "Environmental conditions";

  equation
    // Pressure relation
    nonwetting.p = wetting.p + 2*gamma*cos(theta)/R "Young-Laplace equation";

    // Conservation (without storage)
    0 = wetting.V + nonwetting.V "Volume";

    annotation (
      Documentation(info="<html>
    <p>The characteristic radius (<i>R</i>) is the harmonic mean of the (2) principle radii of the liquid volume.</p>

    <p>The default surface tension (&gamma; = 0.0663 N/m) is for saturated water at 60 &deg;C, interpolated from
    [<a href=\"modelica://FCSys.UsersGuide.References.Incropera2002\">Incropera2002</a>, p.&nbsp;924].  Note that the surface tension in
    [<a href=\"modelica://FCSys.UsersGuide.References.Wang2001\">Wang2001</a>] is incorrect (likely unit conversion error).</p>

    <p>The default contact angle (&theta; = 140&deg;) is typical of the GDL measurements listed at
    <a href=\"http://www.chem.mtu.edu/cnlm/research/Movement_of_Water-in_Fuel_Cell_Electrodes.htm\">http://www.chem.mtu.edu/cnlm/research/Movement_of_Water-in_Fuel_Cell_Electrodes.htm</a>
    (accessed Nov. 22, 2103).</p>
    
    </html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
              extent={{-40,40},{40,-40}},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),Rectangle(
              extent={{42,40},{20,-40}},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{0,40},{40,-40}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),Line(
              points={{-40,40},{40,40}},
              color={0,0,0},
              smooth=Smooth.None),Line(
              points={{-40,-40},{40,-40}},
              color={0,0,0},
              smooth=Smooth.None)}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics));
  end Capillary;

  model CapillaryVolume "Volume with capillary pressure applied to the liquid"
    extends FCSys.Icons.Names.Top3;

    // Material properties
    parameter Q.Volume V "Volume" annotation (Dialog(group="Geometry",
          __Dymola_label="<html><i>V</i></html>"));

    // Material properties
    parameter Boolean inclGas=true "Gas" annotation (
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(group="Included phases", compact=true));
    parameter Boolean inclLiquid=true "Liquid" annotation (
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(group="Included phases", compact=true));
    parameter Boolean inclSolid=true "Solid" annotation (
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(group="Included phases", compact=true));

    // Capillary pressure
    parameter Boolean inclCapillary=false "Include capillary pressure"
      annotation (
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(
        group="Capillary pressure",
        __Dymola_descriptionLabel=true,
        __Dymola_label="Include",
        compact=true,
        __Dymola_joinNext=true,
        enable=inclLiquid));
    Capillary capillary if inclLiquid and inclCapillary "Capillary model"
      annotation (Dialog(__Dymola_descriptionLabel=true, enable=inclLiquid and
            inclCapillary), Placement(transformation(extent={{-40,0},{-20,20}})));

    // Alias variables (for common terms)
    Q.Volume V_pore "Pore volume";

    // Auxiliary variables (for analysis)
    output Q.NumberAbsolute x(final stateSelect=StateSelect.never) = liquid.V/(
      gas.V + liquid.V) if inclLiquid and inclGas and environment.analysis
      "Liquid saturation";

    Connectors.Dalton gas if inclGas "Interface to the gas phase" annotation (
        Placement(transformation(extent={{20,0},{40,20}}),iconTransformation(
            extent={{10,10},{30,30}})));
    Connectors.Amagat liquid if inclLiquid "Interface to the liquid phase"
      annotation (Placement(transformation(extent={{-60,0},{-40,20}}),
          iconTransformation(extent={{-20,-20},{0,0}})));
    Connectors.Amagat solid "Interface to the solid phase" annotation (
        Placement(transformation(extent={{-4,-20},{16,0}}), iconTransformation(
            extent={{50,-30},{70,-10}})));

    Conditions.ByConnector.Amagat.VolumeFixed volume(final V=V) if inclGas or
      inclLiquid "Fixed volume"
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));

  protected
    Conditions.Adapters.AmagatDalton amagatDalton if inclGas or (inclSolid and
      not inclLiquid)
      "Adapter between additivity of volume and additivity of gas pressure"
      annotation (Placement(transformation(extent={{0,0},{20,20}})));

    outer Conditions.Environment environment "Environmental conditions";

  equation
    // Aliases
    V = V_pore + solid.V;

    if not inclCapillary then
      connect(liquid, volume.amagat)
        "Directly connect liquid to the volume (not shown in diagram)";
    end if;

    connect(capillary.wetting, liquid) annotation (Line(
        points={{-34,10},{-50,10}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(solid, amagatDalton.amagat) annotation (Line(
        points={{6,-10},{6,10}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(volume.amagat, amagatDalton.amagat) annotation (Line(
        points={{-10,10},{6,10}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(gas, amagatDalton.dalton) annotation (Line(
        points={{30,10},{14,10}},
        color={47,107,251},
        smooth=Smooth.None));
    connect(capillary.nonwetting, volume.amagat) annotation (Line(
        points={{-26,10},{-10,10}},
        color={47,107,251},
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Polygon(
              points={{-60,-60},{-60,20},{-20,60},{60,60},{60,-20},{20,-60},{-60,
              -60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash,
              fillColor={225,225,225},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-62,10},{48,54},{30,-36},{-38,-46},{-62,10}},
              lineColor={191,191,191},
              smooth=Smooth.Bezier,
              visible=inclGas,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-40,8},{20,-30}},
              lineColor={85,170,255},
              visible=inclLiquid,
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),Ellipse(extent={{-40,8},{20,-30}},
            lineColor={225,225,225}),Line(
              points={{-60,20},{20,20},{20,-60}},
              color={0,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None),Line(
              points={{60,60},{20,20}},
              color={0,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None)}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-60,-20},{40,20}}), graphics));
  end CapillaryVolume;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics));
end Chemistry;
