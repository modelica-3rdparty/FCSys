within FCSysTest;
package Subregions
  extends Modelica.Icons.ExamplesPackage;

  model Subregion "Test a single subregion"
    import FCSys.Species.Enumerations.Init;

    extends FCSys.Subregions.Examples.Subregion(
      inclH2=true,
      inclH2O=true,
      inclN2=true,
      inclO2=true,
      subregion(gas(
          H2O(initEnergy=Init.none),
          N2(initEnergy=Init.none),
          O2(initEnergy=Init.none))),
      environment(RH=0.5));
    // TODO:  Create a separate model to test reactions.
    // Currently, there are no assertions.  This model just checks that the
    // simulation runs.

  end Subregion;

  model Test2Subregions
    "Test two subregions with an initial temperature difference"
    import FCSys.Species.Enumerations.Init;
    extends FCSys.Subregions.Examples.Subregions(
      n_x=0,
      Deltap_IC=0,
      'inclC+'=true,
      'incle-'=true,
      'inclSO3-'=true,
      inclH2=true,
      inclH2O=true,
      inclN2=true,
      inclO2=true,
      subregion1(
        gas(
          H2O(initEnergy=Init.none),
          N2(initEnergy=Init.none),
          O2(initEnergy=Init.none),
          H2(T_IC=293.15*U.K)),
        graphite('C+'(T_IC=293.15*U.K)),
        ionomer('SO3-'(T_IC=293.15*U.K))),
      subregion2(gas(
          H2O(initEnergy=Init.none),
          N2(initEnergy=Init.none),
          O2(initEnergy=Init.none))),
      environment(final analysis=true));
    // Note:  H+ is excluded to prevent reactions.

    output Q.Amount S(stateSelect=StateSelect.never) = subregion1.graphite.'C+'.S
       + subregion2.graphite.'C+'.S + subregion1.ionomer.'SO3-'.S + subregion2.ionomer.
      'SO3-'.S + subregion1.graphite.'e-'.S + subregion2.graphite.'e-'.S +
      subregion1.gas.H2.S + subregion2.gas.H2.S + subregion1.gas.H2O.S +
      subregion2.gas.H2O.S + subregion1.gas.N2.S + subregion2.gas.N2.S +
      subregion1.gas.O2.S + subregion2.gas.O2.S "Total entropy";
    Q.Amount S_IC "Initial total entropy";

    FCSys.Conditions.ByConnector.BoundaryBus.Single.Sink BC1(graphite('incle-'=
            true)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-44,0})));

  initial equation
    S_IC = S;

  equation
    der(S_IC) = 0;
    when terminal() then
      assert(S >= S_IC, "Entropy cannot decrease.");
    end when;
    //assert(der(S) >= 0, "Entropy cannot decrease.");
    // Note:  This fails due to simulation noise.

    connect(BC1.boundary, subregion1.xNegative) annotation (Line(
        points={{-40,0},{-30,0}},
        color={127,127,127},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      experiment(StopTime=300),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
      __Dymola_experimentSetupOutput);
  end Test2Subregions;

end Subregions;
