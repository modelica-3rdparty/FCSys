within FCSys;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  class GettingStarted "Getting started"
    extends Modelica.Icons.Information;
    annotation (preferredView="info", Documentation(info="<html>
    <table border=1 cellspacing=0 cellpadding=4>
      <tr bgcolor=#afc1c4>
        <td style=\"border: 1px solid #000000;\">
        <font color=#ffffff><b>Note</b></font>
        </td>
      </tr>
      <tr bgcolor=#f7f7f7>
        <td>
        FCSys should be compatible with any
        modeling environment that supports Modelica Standard Library 3.2.1.  The following tools have been tested:
        <ul>
          <li>Dymola: Supported by version 2014.
          Dymola's annotations for parameter dialogs and replaceable choices are used.</li>
          <li>MapleSim: Not supported as of version 4.5</li>
          <li>MWorks: Not supported as of version 2.6.10</li>
          <li>OpenModelica: Not supported as of version 1.8.1</li>
          <li>SystemModeler: Not supported as of version 3.0</li>
          <!--<li>JModelica: 9/17/12: Not able to get version 1.8 running on Windows or Linux </li>-->
        </ul>
        </td>
      </tr>
    </table>

    <p>These are the suggested steps to begin using FCSys:</p>
    <ol>
        <li>Read the overview in the <a href=\"modelica://FCSys\">top-level documentation</a>.</li>
        
        <li>Browse the subpackages of FCSys.  In general, the subpackages are
        ordered with high-level models at the top and basic classes at the bottom.</li>
        
        <li>Call <a href=\"modelica://FCSys.Units.setup\">FCSys.Units.setup</a>() to
        establish the display units.  This is automatic if FCSys
        is loaded via the <a href=\"modelica://FCSys/../load.mos\">load.mos</a> script.</li>
        
        <li>Simulate the <a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\">FCSys.Assemblies.Cells.Examples.TestStand</a>
        model.
        There are scripts in <a href=\"modelica://FCSys/Resources/Scripts/Dymola/README.md\">Resources/Scripts/Dymola/</a> to
        create useful plots of that model and others.
        The scripts should be accessible from the \"Command\" menu of the Modelica development environment.
        For more detailed analysis,
        a Python module called FCRes is available in
        <a href=\"modelica://FCSys/Resources/Source/Python/README.md\">Resources/Source/Python/</a>
        (HTML and PDF documentation <a href=\"modelica://FCSys/Resources/Source/Python/doc/index.html\">here</a> and
        <a href=\"modelica://FCSys/Resources/Source/Python/doc/FCRes.pdf\">here</a>).</li>
        
        <li>Read the documentation of the classes. In particular, these may be of interest:
        <ul>
            <li><a href=\"modelica://FCSys.Units\">FCSys.Units</a> package:
            Information about the system of units, which is different
            than <a href=\"modelica://Modelica.SIunits\">Modelica.SIunits</a></li>
            
            <li><a href=\"modelica://FCSys.Connectors\">FCSys.Connectors</a> package:
            Overview of the connectors</li>
            
            <li><a href=\"modelica://FCSys.Species.Species\">FCSys.Species.Species</a> model:
            Details about the storage and transfer of material, momentum, and
            energy</li>
            
            <li><a href=\"modelica://FCSys.Regions.AnFPs.AnFP\">FCSys.Regions.AnFPs.AnFP</a> model:
            Information about the geometric orientation of the cell</li>
        </ul>
        In general, overviews are given in the documentation of containing packages and
        detailed information is given at the appropriate level of inheritance.  If a class does not
        have sufficient documentation, please look at its base class(es) and the package(s) that
        contain it.  Assumptions are only listed at the lowest level of inheritance at which they apply.  Therefore, the
        list of assumptions in a model should be considered in conjunction with the assumptions in all
        the models it inherits from.</li>
        
        <li>Create and simulate examples of other applications and scenarios.  Many of the
        submodels (regions, subregions, species) are replaceable.
        Their parameters are often not propagated to the cell level, but may
        be edited via the parameter dialog by accessing the submodel.  Note that
        many models have auxiliary output variables for analysis and diagnostics.
        These may be included by setting <code>analysis=true</code> in the outer environment model (instance
        of <a href=\"modelica://FCSys.Conditions.Environment\">Environment</a>).</li>
        
        <li>Develop your own classes.  It should be possible to model other fluidic or electrochemical
        devices (solid oxide fuel cells, lithium ion batteries, flow batteries/regenerative fuel cells, etc.) by
        extending the existing classes and
        following the existing framework.  It will be necessary to add species models
        (Li<sup>+</sup>, O<sup>2-</sup>, etc.).</li>
        
        <li>Please share your additions or modifications to the source code so that the library
        can be improved and others may benefit.  The best way is to create a fork from the
        development page at <a href=\"https://github.com/kdavies4/FCSys\">https://github.com/kdavies4/FCSys</a>.
        Please also use the <a href=\"modelica://FCSys.UsersGuide.Contact\">contact information</a>.</li>
    </ol>
    </html>"));

  end GettingStarted;

  class SampleResults "Sample results"
    extends Modelica.Icons.Information;

    annotation (preferredView="info", Documentation(info="<html>
  
  <p>The figures below show the results from several cell-level examples of
    <a href=\"modelica://FCSys\">FCSys</a>.   The models were simulated using Dymola 2014.  The plots were
    generated using <a href=\"http://kdavies4.github.io/ModelicaRes/\">ModelicaRes</a>.  For more information, please
    follow the links to the associated models.  For discussion and more results, please see
    [<a href=\"modelica://FCSys.UsersGuide.References\">Davies, 2014</a>].  
    </p>

    <p align=center id=\"Fig1\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/PolarizationTemperature.png\"></a>
    <br>Figure&nbsp;1: Polarization curves of the cell with various inlet and flow plate temperatures
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\">FCSys.Assemblies.Cells.Examples.TestStand</a>).</p>
    
    <p align=center id=\"Fig2\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/PolarizationPressure.png\"></a>
    <br>Figure&nbsp;2: Polarization curves of the cell with various outlet pressures
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\">FCSys.Assemblies.Cells.Examples.TestStand</a>).</p>
    
    <p align=center id=\"Fig3\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/Losses.png\"></a>
    <br>Figure&nbsp;3: Potential losses during the baseline polarization test
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\">FCSys.Assemblies.Cells.Examples.TestStand</a>).</p>

    <p align=center id=\"Fig4\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/Temperature.png\"></a>
    <br>Figure&nbsp;4: Temperature throughout the cell during the baseline polarization test
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\">FCSys.Assemblies.Cells.Examples.TestStand</a>).</p>
    
    <p align=center id=\"Fig5\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/PressureO2.png\"></a>
    <br>Figure&nbsp;5: Oxygen pressure during the baseline polarization test
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\">FCSys.Assemblies.Cells.Examples.TestStand</a>).</p>

    <p align=center id=\"Fig6\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/Energy.png\"></a>
    <br>Figure&nbsp;6: Energy balance of a 50&nbsp;cm<sup>2</sup> cell at 1.5&nbsp;A/cm<sup>2</sup> during the baseline polarization test
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStand\">FCSys.Assemblies.Cells.Examples.TestStand</a>).</p>

    <p align=center id=\"Fig7\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStandFixedFlowSegmented\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/SegmentPolarization.png\"></a>
    <br>Figure&nbsp;7: Polarization of cell segments with fixed reactant flow rates
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStandFixedFlowSegmented\">FCSys.Assemblies.Cells.Examples.TestStandFixedFlowSegmented</a>).</p>

    <p align=center id=\"Fig8\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStandCycle\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/CyclePolarization.png\"></a>
    <br>Figure&nbsp;8: Polarization under sinusoidal, reversing load
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStandCycle\">FCSys.Assemblies.Cells.Examples.TestStandCycle</a>).</p>

    <p align=center id=\"Fig9\"><a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStandCycle\"><img src=\"modelica://FCSys/Resources/Documentation/UsersGuide/SampleResults/CycleSaturation.png\"></a>
    <br>Figure&nbsp;9: Liquid pore saturation under sinusoidal, reversing load
    (<a href=\"modelica://FCSys.Assemblies.Cells.Examples.TestStandCycle\">FCSys.Assemblies.Cells.Examples.TestStandCycle</a>).</p>

    </html>"));

  end SampleResults;

  package Glossary "Glossary"
    extends Modelica.Icons.Information;

    class 'configuration'
      "<html>(<i>noun</i>) a species in a particular phase within a subregion</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'configuration';

    class 'continuity'
      "<html>(<i>noun</i>) resistivity to axial compression or material storage during transport [M&nbsp;N<sup>-1</sup>&nbsp;T<sup>-1</sup>]</html>"

      annotation (
        preferredView="info",
        DocumentationClass=false,
        Documentation(info=
              "<html><p>See <a href=\"modelica://FCSys.Characteristics.BaseClasses.Characteristic.zeta\">&zeta;</a>().</p></html>"));
    end 'continuity';

    class 'density'
      "<html>(<i>noun</i>) amount of material per volume [N&nbsp;L<sup>-3</sup>]</html>"

      annotation (
        preferredView="info",
        DocumentationClass=false,
        Documentation(info="<html><p>Synonyms: concentration, molar concentration, number density</p>
    
    <p>Note that mass per volume is volumic mass (see <a href=\"modelica://FCSys.UsersGuide.Glossary.'massic'\">massic</a>).</p></html>"));
    end 'density';

    class 'equivalent current'
      "<html>(<i>noun</i>) rate of supply of a reactant required to support the given electrical current assuming complete <a href=\"modelica://FCSys.UsersGuide.Glossary.'utilization'\">utilization</a> [N&nbsp;T<sup>-1</sup>]</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'equivalent current';

    class 'exchange'
      "<html>(<i>noun</i>) transfer of a conserved quantity among configurations within a region</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'exchange';

    class 'fluidity'
      "<html>(<i>noun</i>) reciprocal of dynamic viscosity [L&nbsp;T&nbsp;M<sup>-1</sup>]</html>"

      annotation (
        preferredView="info",
        DocumentationClass=false,
        Documentation(info=
              "<html><p>See <a href=\"modelica://FCSys.Characteristics.BaseClasses.Characteristic.eta\">&eta;</a>().</p></html>"));
    end 'fluidity';

    class 'Gibbs potential'
      "<html>(<i>noun</i>) specific Gibbs energy [L<sup>2</sup>&nbsp;M&nbsp;N<sup>-1</sup>&nbsp;T<sup>-2</sup>]</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'Gibbs potential';

    class 'lineic'
      "<html>adjective that indicates the quotient of the following quantity and its associated length [&times;&nbsp;L<sup>-1</sup>]</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'lineic';

    class 'massic'
      "<html>adjective that indicates the quotient of the following quantity and its associated mass [&times;&nbsp;M<sup>-1</sup>]</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'massic';

    class 'material' "<html>1. (<i>noun</i>) quantity that represents particles, atoms, or molecules (i.e., matter)<br>
2. (<i>adj</i>) of particles, atoms, or molecules</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'material';

    class 'particle number'
      "<html>(<i>noun</i>) number of particles [N]</html>"

      annotation (
        preferredView="info",
        DocumentationClass=false,
        Documentation(info="<html><p>Note that particle number is equivalent to amount of material due to the system of units
      (see the <a href=\"modelica://FCSys.Units\">Units</a> package).</p></html>"));
    end 'particle number';

    class 'specific'
      "<html>adjective that indicates the quotient of the following quantity and its associated particle number [&times;&nbsp;N<sup>-1</sup>]</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'specific';

    class 'thermal independity'
      "<html>(<i>noun</i>) extent to which an exchange of thermal energy between species causes or requires a temperature difference [T]</html>"

      annotation (
        preferredView="info",
        DocumentationClass=false,
        Documentation(info=
              "<html><p>See <a href=\"modelica://FCSys.Characteristics.BaseClasses.Characteristic.nu\">&nu;</a>().</p></html>"));
    end 'thermal independity';

    class 'translational Nusselt number'
      "<html>(<i>noun</i>) correction to Newton's law of viscous shear for the shape of the flow profile [1]</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'translational Nusselt number';

    class 'transport'
      "<html>(<i>noun</i>) transfer of a conserved quantity between adjacent subregions</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'transport';

    class 'utilization'
      "<html>(<i>noun</i>) fraction of the reactant supply that is consumed [1]</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end 'utilization';

    class 'volumic'
      "<html>adjective that indicates the quotient of the following quantity and its associated volume [&times;&nbsp;L<sup>-3</sup>]</html>"

      annotation (
        preferredView="info",
        DocumentationClass=false,
        Documentation(info=
              "<html><p>Example: volumic mass [M L<sup>-3</sup>]</p></html>"));
    end 'volumic';

    annotation (preferredView="info",Documentation(info="<html><p>Some of the terms below are
  unique to FCSys (e.g., 
  <a href=\"modelica://FCSys.UsersGuide.Glossary.'thermal independity'\">thermal independity</a> and
  <a href=\"modelica://FCSys.UsersGuide.Glossary.'translational Nusselt number'\">translational Nusselt number</a>) or are have 
  nontraditional definitions (e.g., 
  <a href=\"modelica://FCSys.UsersGuide.Glossary.'configuration'\">configuration</a>, 
  <a href=\"modelica://FCSys.UsersGuide.Glossary.'continuity'\">continuity</a>, 
  <a href=\"modelica://FCSys.UsersGuide.Glossary.'density'\">density</a>, 
  <a href=\"modelica://FCSys.UsersGuide.Glossary.'material'\">material</a>, and
  <a href=\"modelica://FCSys.UsersGuide.Glossary.'specific'\">specific</a>).
  </p></html>"));

  end Glossary;

  package References "References"

    extends Modelica.Icons.References;

    class Aronsson2009
      "<html>P. Aronsson and D. Broman, \"<a href=\"http://www.ep.liu.se/ecp_article/index.en.aspx?issue=043;article=105\">Extendable Physical Unit Checking with Understandable Error Reporting</a>,\"  in <i>Modelica Conference</i> (Como, Italy), Modelica Assoc., Sep. 2009</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Aronsson2009;

    class Avogadro
      "<html>Avogadro: An Open-Source Molecular Builder and Visualization Tool, ver. 1.03. <a href=\"http://avogadro.openmolecules.net\">http://avogadro.openmolecules.net</a></html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Avogadro;

    class Bejan2006
      "<html>A. Bejan, <i>Advanced Engineering Thermodynamics</i>, John Wiley &amp; Sons, 3rd ed., 2006</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Bejan2006;

    class Bernardi1992
      "<html>D. M. Bernardi and M. W. Verbrugge, \"<a href=\"http://dx.doi.org/10.1149/1.2221251\">A Mathematical Model of the Solid-Polymer-Electrolyte Fuel Cell</a>,\" <i>J. Electrochem. Soc.</i>, vol. 139, no. 9, pp. 2477&ndash;2491, Sep. 1992</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Bernardi1992;

    class BIPM2006
      "<html>International Bureau of Weights and Measures (BIPM), \"<a href=\"http://www.bipm.org/utils/common/pdf/si_brochure_8_en.pdf\">The International System of Units (SI)</a>,\" 8th ed., 2006</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end BIPM2006;

    class Broman2008
      "<html>D. Broman and P. Aronsson and P. Fritzson, \"<a href=\"http://dx.doi.org/10.1149/1.2221251\">Design Considerations for Dimensional Inference and Unit Consistency Checking in Modelica</a>,\"  in <i>Modelica Conference</i> (Bielefeld, Germany), Modelica Assoc., Mar. 2008</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Broman2008;

    class Brown2011
      "<html>W. M. Brown, P. Wang, S. J. Plimpton, and A. N. Tharrington, \"<a href=\"http://dx.doi.org/10.1016/j.cpc.2010.12.021\">Implementing Molecular Dynamics on Hybrid High Performance Computers&mdash;Short Range Forces</a>,\" <i>Comput. Phys. Commun.</i>, vol. 182, no. 4, pp. 898&ndash;911, 2011</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Brown2011;

    class DuPont2004N
      "<html>DuPont, \"Nafion&reg; PFSA Membranes N-112, NE-1135, N-115, N-117, NE-1110</a>,\" <a href = http://www.fuelcells.dupont.com>http://www.fuelcells.dupont.com</a>, Feb. 2004</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end DuPont2004N;

    class DuPont2004NRE
      "<html>DuPont, \"Nafion&reg; PFSA Membranes NRE-211 and NRE-212</a>,\" <a href = http://www.fuelcells.dupont.com>http://www.fuelcells.dupont.com</a>, Feb. 2004</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end DuPont2004NRE;

    class DuPont2005
      "<html>DuPont, \"Nafion&reg; PFSA Membranes NE-1135, N-115, N-117, NE-1110</a>,\" <a href = http://www.fuelcells.dupont.com>http://www.fuelcells.dupont.com</a>, Feb. 2005</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end DuPont2005;

    class Dymond2002
      "<html>J. H. Dymond, K. N. Marsh, R. C. Wilhoit, and K. C. Wong, <i>Virial Coefficients of Pure Gases</i>, Springer-Verlag, 2002</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Dymond2002;

    class Entegris2012
      "<html>Entegris, \"Industrial Graphite,\" <a href=\"http://www.entegris.com/Resources/assets/6204-7085-0312.pdf\">http://www.entegris.com/Resources/assets/6204-7085-0312.pdf</a>, Apr. 2012</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Entegris2012;

    class Fritzson2004
      "<html>P. Fritzson, <i>Principles of Object-Oriented Modeling and Simulation with Modelica 2.1</i>, IEEE Press (Piscataway, NJ), 2004</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Fritzson2004;

    class Greiner1995
      "<html>W. Greiner, L. Neisem and H. St&ouml;cker, \"<a href=\"http://books.google.com/books?id=12DKsFtFTgYC\">A Mathematical Model of the Solid-Polymer-Electrolyte Fuel Cell</a>,\" <i>J. Electrochem. Soc.</i>, vol. 139, no. 9, pp. 2477&ndash;2491, Sep. 1992</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Greiner1995;

    class Gurau1998
      "<html>V. Gurau, H. Liu, and S. Kaka, \"<a href=\"http://dx.doi.org/10.1002/aic.690441109\">Two-Dimensional Model for Proton Exchange Membrane Fuel Cells</a>,\" <i>AIChE J.</i>, vol. 44, no. 11, pp. 2410&ndash;2422, Nov. 1998</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Gurau1998;

    class Hess2008
      "<html>B. Hess, C. Kutzner, D. van der Spoel, and E. Lindahl, \"GROMACS 4: Algorithms for Highly Efficient, Load-Balanced, and Scalable Molecular Simulation,\" <i>J. Chem. Theory Comput.</i>, vol. 4, no. 3, pp. 435&ndash;447, 2008</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Hess2008;

    class Incropera2002
      "<html>F. P. Incropera and D. P. DeWitt, <i>Fundamentals of Heat and Mass Transport</i>, 5th ed., John Wiley &amp; Sons, 2002</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Incropera2002;

    class Kandlikar2009
      "<html>S. G. Kandlikar and Z. Lu, \"<a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2008.05.009\">Thermal Management Issues in a PEMFC Stack&mdash;A Brief Review of Current Status</a>,\" <i>Appl. Therm. Eng.</i>, vol. 29, no. 7, pp. 1276&ndash;1280, 2009</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Kandlikar2009;

    class Larminie2003
      "<html>J. Larminie and A. Dicks, <i>Fuel Cell Systems Explained</i>, John Wiley &amp; Sons, 2003</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Larminie2003;

    class Lin2006
      "<html>J. Lin, J. K. Lee, M. Kellner, R. Wycisk, and P. N. Pintauroa, \"<a href=\"http://dx.doi.org/10.1149/1.2196687\">Nafion-Flourinated Ethylene-Propylene Resin Membrane Blends for Direct Methanol Fuel Cells</a>,\" <i>J. Electrochem. Soc.</i>, vol. 153, no. 7, pp. A1325&ndash;A1331, 2006</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Lin2006;

    class Mark1999
      "<html>J. E. Mark, <i>Polymer Data Handbook</i>, Oxford University Press, 1999</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Mark1999;

    class Mattsson1993
      "<html>S. E. Mattsson and G. Soderlind, \"Index Reduction in Differential-Algebraic Equations Using Dummy Derivatives,\" <i>SIAM J. Sci. Comput.</i>, vol. 14, no. 3, pp. 677&ndash;692, May 1993</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Mattsson1993;

    class Mattsson2008
      "<html>S. E. Mattsson and H. Elmqvist, \"Unit Checking and Quantity Conservation,\" in <i>Modelica Conf.</i> (Bielefeld, Germany), Modelica Assoc., Mar. 2008</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Mattsson2008;

    class McBride1996
      "<html>B. J. McBride and S. Gordon, \"<a href=\"http://www.grc.nasa.gov/WWW/CEAWeb/RP-1311P2.htm\">Computer Program for Calculating Complex Chemical Equilibrium Compositions and Applications II. Users Manual and Program Description</a>,\" NASA Reference Publication 1311, Jun. 1996</html>"

      annotation (
        preferredView="info",
        DocumentationClass=false,
        Documentation(info=
              "<html><p>Recent data is available at <a href=\"http://www.grc.nasa.gov/WWW/CEAWeb/ceaHome.htm\">http://www.grc.nasa.gov/WWW/CEAWeb/ceaHome.htm</a>.</p></html>"));
    end McBride1996;

    class McBride2002
      "<html>B. J. McBride, M. J. Zehe, and S. Gordon, \"<a href=\"http://gltrs.grc.nasa.gov/cgi-bin/GLTRS/browse.pl?2002/TP-2002-211556.html\">NASA Glenn Coefficients for Calculating Thermodynamic Properties of Individual Species</a>,\" NASA report TP-2002-211556, Sep. 2002</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end McBride2002;

    class Modelica2010
      "<html>Modelica Association, <i><a href=\"https://www.modelica.org/documents/ModelicaSpec32.pdf\">Modelica: A Unified Object-Oriented Language for Physical Systems Modeling: Language Specification</i></a>, Ver. 3.2, Mar. 2010</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Modelica2010;

    class Moran2004
      "<html>M. J. Moran and H. N. Shapiro, <i>Fundamentals of Engineering Thermodynamics</i>, 5th ed., John Wiley &amp; Sons, 2004</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Moran2004;

    class NIST2010
      "<html>National Institute of Standards and Technology (NIST), \"Fundamental Physical Constants: Complete Listing,\" <a href=\"http://physics.nist.gov/cuu/Constants/Table/allascii.txt\">http://physics.nist.gov/cuu/Constants/Table/allascii.txt</a>, 2010</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end NIST2010;

    class Nitta2008
      "<html>I. Nitta, O. Himanen, and M. Mikkola, \"<a href=\"http://dx.doi.org/10.1002/fuce.200700054\">Thermal Conductivity and Contact Resistance of Compressed Gas Diffusion Layer of PEM Fuel Cell</a>,\" <i>Fuel Cells</i>, vol. 8, pp. 111&ndash;119, 2008</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Nitta2008;

    class Parikh2012
      "<html>N. Parikh, J. S. Allen, R. S. Yassar, \"<a href=\"http://onlinelibrary.wiley.com/doi/10.1002/fuce.201100014/abstract\">Microstructure of Gas Diffusion Layers for PEM Fuel Cells</a>,\" <i>Fuel Cells</i>, vol. 12, no. 3, pp. 1615&ndash;6854, 2012</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Parikh2012;

    class Present1958
      "<html>R. D. Present, <i>Kinetic Theory of Gases</i>, McGraw Hill, 1958</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Present1958;

    class Rao1997
      "<html>Y. V. C. Rao, <i>Chemical Engineering Thermodynamics</i>, Hyderabad, India:  Universities Press, 1997</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Rao1997;

    class Rapaport2004
      "<html>D. C. Rapaport, <i>The Art of Molecular Dynamics Simulation</i>, Cambridge University Press, 2nd ed., 2004</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Rapaport2004;

    class Reichert2010
      "<html>P. Reichert and N. Schuwirth, \"<a href=\"http://dx.doi.org/10.1016/j.envsoft.2010.03.002\">A Generic Framework for Deriving Process Stoichiometry in Environmental Models</a>,\" <i>Environmental Modelling &amp; Software</i>, vol. 25, pp. 1241&ndash;1251, 2010</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Reichert2010;

    class Salzman2004
      "<html>W. R. Salzman, \"The Virial Expansion,\" <a href=\"http://www.chem.arizona.edu/~salzmanr/480a/480ants/VIRIAL/virial.html\">http://www.chem.arizona.edu/~salzmanr/480a/480ants/VIRIAL/virial.html</a>, Course notes for Physical Chemistry (Chemistry 480A), University of Arizona, Jul. 2004</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Salzman2004;

    class Schetz1996
      "<html>J. A. Schetz and A. E. Fuhs (ed.), <i>Handbook of Fluid Dynamics and Fluid Machinery</i>, John Wiley &amp; Sons, vol. 1: Fundamentals of Fluid Dynamics, 1996</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Schetz1996;

    class SGL2004
      "<html>SGL Carbon Group, \"Sigracet&reg; 24 &amp; 25 Series Gas Diffusion Layer,\" <a href=\"http://www.sglcarbon.com\">http://www.sglcarbon.com</a>, Sep. 2004</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end SGL2004;

    class SGL2007
      "<html>SGL Carbon Group, \"Sigracet&reg; 10 Series Gas Diffusion Layer,\" <a href=\"http://www.sglcarbon.com\">http://www.sglcarbon.com</a>, Apr. 2007</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end SGL2007;

    class Shah2009
      "<html>A. A. Shah, T. R. Ralph, and F. C. Walsh, \"Modeling and Simulation of the Degradation of Perfluorinated Ion-Exchange Membranes in PEM Fuel Cells,\" <i>J. Electrochem. Soc.</i>, vol. 156, no. 4, pp. B465&ndash;B484, 2009</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Shah2009;

    class Sivertsen2005
      "<html>B. R. Sivertsen and N. Djilali, \"CFD-based Modelling of Proton Exchange Membrane Fuel Cells,\" <i>J. Power Sources</i>, vol. 141, pp. 65&ndash;78, 2005</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Sivertsen2005;

    class Slattery1958
      "<html>J. C. Slattery and R. B. Bird, \"Calculation of the Diffusion Coefficient of Dilute Gases and of the Self-diffusion Coefficient of Dense Gases,\" <i>American Institute of Chemical Engineers Journal</i>, vol. 4, no. 2, pp. 137&ndash;142, 1958</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Slattery1958;

    class Springer1991
      "<html>T. E. Springer, T. A. Zawodzinski, and S. Gottesfeld, \"<a href=\"http://dx.doi.org/10.1149/1.2085971\">Polymer Electrolyte Fuel Cell Model</a>,\" <i>J. Electrochem. Soc.</i>, vol. 138, pp. 2334&ndash;2342, Aug. 1991</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Springer1991;

    class Spry2009
      "<html>D. B. Spry and M. D. Fayer, \"<a href=\"http://www.stanford.edu/group/fayer/articles/384-392/385.pdf\">Proton Transfer and Proton Concentrations in Protonated Nafion Fuel Cell Membranes</a>,\" <i>J. Phys. Chem. B</i>, vol. 113, no. 30, pp. 10210&ndash;10221, 2009</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Spry2009;

    class Svehla1995
      "<html>R. A. Svehla, \"<a href=\"http://www.grc.nasa.gov/WWW/CEAWeb/TM-4647.htm\">Transport Coefficients for the NASA Lewis Chemical Equilibrium Program</a>,\" NASA Technical Memorandum 4647, Apr. 1995</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Svehla1995;

    class Takenaka1990
      "<html>M. Takenaka and R. Masui, \"<a href=\"http://iopscience.iop.org/0026-1394/27/4/001\">Measurement of the Thermal Expansion of Pure Water in the Temperature Range 0&nbsp;&deg;C&ndash;85&deg;C</a>,\" <i>Metrologia</i>, vol. 27, pp. 165&ndash;171, 1990</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Takenaka1990;

    class Tissandier1998
      "<html>M. D. Tissandier, K. A. Cowen, W. Y. Feng, E. Gundlach, M. H. Cohen, A. D. Earhart, J. V. Coe, and T. R. Tuttle, Jr., \"<a href=\"http://www.uh.edu/~chembi/single_ion_hydration.PDF\">The Proton's Absolute Aqueous Enthalpy and Gibbs Free Energy of Solvation from Cluster-Ion Solvation Data</a>,\" <i>J. Phys. Chem. A</i>, vol. 102, pp. 7787&ndash;7794, 1998</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Tissandier1998;

    class Toray2010
      "<html>Toray Industries, Inc., \"Carbon Paper,\" <a href = http://www.torayca.com/index2.html>http://www.torayca.com/index2.html</a>, accessed 2010</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Toray2010;

    class Wang2001
      "<html>Z. H. Wang, C.-Y. Wang, and K. S. Chen, \"Two-phase Flow and Transport in the Air Cathode of Proton Exchange Membrane Fuel Cells</a>,\" <i>J. Power Sources</i>, vol. 94, pp. 40&ndash;50, 2001</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Wang2001;

    class Weber2004
      "<html>A. Z. Weber and J. Newman, \"<a href=\"http://dx.doi.org/10.1021/cr020729l\">Modeling Transport in Polymer-Electrolyte Fuel Cells</a>,\" <i>Chem. Rev.</i>, vol. 104, pp. 4679&ndash;4726, 2004</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Weber2004;

    class Woo1995
      "<html>K. W. Woo and S. I. Yeo, \"Dalton's Law vs. Amagat's Law for the Mixture of Real Gases,\" <i>SNU J. Educ. Res.</i>, vol. 5, pp. 127&ndash;134, 1995</html>"

      annotation (preferredView="info", DocumentationClass=false);
    end Woo1995;

    annotation (preferredView="info", Documentation(info="<html>
    <p>This library (<a href=\"modelica://FCSys\">FCSys</a>) is described in</p>
    <ol>
    <li>K. L. Davies, <i><a href=\"http://kdavies4.github.io/Dissertation/Davies - Declarative Modeling of Coupled Advective and Diffusive Processes as Applied to FCs.pdf\">Declarative Modeling of Coupled Advective and Diffusive Processes as Applied to Fuel Cells</a></i>, Ph.D. dissertation, Georgia Institute of Technology, Jan. 2014.</li>
    </ol>

    <p>These papers describe work leading up to it (most recent first):</p>
    <ol>
    <li>K. L. Davies, C. L. Haynes, and C. J. Paredis, \"<a href=\"http://www.ep.liu.se/ecp_article/index.en.aspx?issue=076;article=010\">Library for First-Principle Models of Proton Exchange Membrane Fuel Cells in Modelica</a>,\" in <i>Modelica Conference</i> (Munich, Germany), Modelica Assoc., Sep. 2012.</li>
    <li>K. L. Davies, \"<a href=\"http://www.ep.liu.se/ecp_article/index.en.aspx?issue=076;article=082\">Natural Unit Representation in Modelica</a>,\" in <i>Modelica Conference</i> (Munich, Germany), Modelica Assoc., Sep. 2012 (<a href=\"modelica://FCSys/Resources/Documentation/UsersGuide/References/Natural Unit Representation in Modelica (poster).pdf\">poster</a>).</li>
    <li>K. L. Davies, C. L. Haynes, and C. J. Paredis, \"<a href=\"http://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0106/0106.pdf\">Modeling Reaction and Diffusion Processes of Fuel Cells within Modelica</a>,\" in <i>Modelica Conference</i> (Como, Italy), Modelica Assoc., Sep. 2009.</li>
    <li>K. L. Davies, R. M. Moore, and G. Bender, \"<a href=\"http://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0107/0107.pdf\">Model Library of Polymer Electrolyte Membrane Fuel Cells for System Hardware and Control Design</a>,\" in <i>Modelica Conference</i> (Como, Italy), Modelica Assoc., Sep. 2009.</li>
    <li>K. L. Davies and R. M. Moore, \"<a href=\"http://link.aip.org/link/abstract/ECSTF8/v11/i1/p797/s1\">Object-Oriented Fuel Cell Model Library</a>,\" <i>Electrochem. Soc. T.</i>, vol. 11, no. 1, pp. 797&ndash;808, 2007.</li>
    </ol>

    <p>The external references, which are cited throughout <a href=\"modelica://FCSys\">FCSys</a>, are listed as entries in this package.</p>
    </html>"));
  end References;

  class Contact "Contact"
    extends Modelica.Icons.Contact;
    annotation (preferredView="info", Documentation(info="<html>
    <p>Updates to this library (<a href=\"modelica://FCSys\">FCSys</a>) may be available online at the
    <a href=\"http://kdavies4.github.io/FCSys/\">main project site</a> or the
    <a href=\"https://modelica.org/libraries\">Modelica libraries page</a>.
    The development page is
    <a href=\"https://github.com/kdavies4/FCSys\">https://github.com/kdavies4/FCSys</a>.
    Please report any problems using the <a href=\"https://github.com/kdavies4/FCSys/issues\">issues</a>
    link on that page.</p>

    <dl><dt><b>Author:</b><br></dt>
    <dd>Kevin Davies</dd>
    <dd><a href=\"http://www.hnei.hawaii.edu\">Hawaii Natural Energy Institute</a></dd>
    <dd><a href=\"http://www.hawaii.edu\">University of Hawaii</a></dd>
    <dd>1680 East-West Rd., POST 109</dd>
    <dd>Honolulu, HI  96822</dd>
    <dd>USA</dd>
    <dd>email: <a href=\"mailto:kdavies4@gmail.com\">kdavies4@gmail.com</a></dd></dl>

    <p><b>Acknowledgments:</b></p><ul>
    
    <li>Technical discussions and insight from 
    Mike Angelo, 
    Guido Bender, 
    Chris Ford, 
    Tom Fuller, 
    Comas Haynes, 
    Sebastian Herzig, 
    Sheldon Jeter, 
    Ben Lee, 
    Robert Moore, 
    George Nelson, 
    Chris Paredis,
    Mike Tiller, 
    Hubertus Tummescheit, and 
    Mebs Virji</li>
    
    <li>Source-code contributions and bug fixes from Kevin Bandy, Martin Sj&ouml;lund, and Joerg Weiss-Ungeth&uuml;m</li>

    <li>Review and feedback from
    Mohammad Ali, Severine Busquet, Francois Steinmetz, and Dietmar Winkler
    </li>
    
    <li>Financial support from:
    <ul>
    <li>Presidential Fellowship from the <a href=\"http://www.me.gatech.edu\">George W. Woodruff
    School of Mechanical Engineering</a> and the <a href=\"http://www.gatech.edu\">Georgia Institute
    of Technology</a></li>
    <li>Robert G. Shackelford Fellowship from the <a href=\"http://www.gtri.gatech.edu\">Georgia
    Tech Research Institute</a></li>
    <li>Grant #N00014-04-0682 from the <a href=\"http://www.onr.navy.mil\">Office of Naval Research</a></li>
    </ul>
    </ul>
</html>"));

  end Contact;

  class License "License"
    extends Modelica.Icons.Information;
    annotation (preferredView="info", Documentation(info="<html>
<p>All files in this directory (FCSys) and all subdirectories are licensed by
<a href=\"http://www.gtrc.gatech.edu/\">Georgia Tech Research Corporation</a> under the

<a href=\"#ModelicaLicense2\">Modelica License 2</a>

with the additional condition:</p><ul>
  <li>This software is controlled under the jurisdiction of the United States
      Department of Commerce and subject to Export Administration Regulations.
      By downloading or using the Software, you are agreeing to comply with
      U. S. export controls.  Diversion contrary to law is prohibited.  The
      software cannot be exported or reexported to sanctioned countries that
      are controlled for Anti-Terrorism (15 CFR Part 738 Supplement 1) or to
      denied parties, <a
      href=\"http://www.bis.doc.gov/index.php/policy-guidance/lists-of-parties-of-concern\">
      http://www.bis.doc.gov/index.php/policy-guidance/lists-of-parties-of-concern</a>.
      EAR99 items cannot be exported or reexported to Iraq for a military
      purpose or to a military end-user (15 CFR Part 746.3).  Export and
      reexport include any release of technology to a foreign national within
      the United States.  Technology is released for export when it is
      available to foreign nationals for visual inspection, when technology is
      exchanged orally or when technology is made available by practice or
      application under the guidance of persons with knowledge of the
      technology.</li></ul>
      
<p><b>Copyright &copy; 2008&ndash;2013, Georgia Tech Research Corporation</b></p>

<hr>

<h4><font color=\"green\" size=4><a name=\"ModelicaLicense2\">The Modelica License 2</a></font></h4>

<p><b>Preamble.</b> The goal of this license is that Modelica related
model libraries, software, images, documents, data files etc. can be
used freely in the original or a modified form, in open source and in
commercial environments (as long as the license conditions below are
fulfilled, in particular sections 2c) and 2d). The Original Work is
provided free of charge and the use is completely at your own risk.
Developers of free Modelica packages are encouraged to utilize this
license for their work.</p>

<p>The Modelica License applies to any Original Work that contains the
following licensing notice adjacent to the copyright notice(s) for
this Original Work:</p>

<p><b>Licensed by the Georgia Tech Research Corporation under the Modelica License 2</b></p>

<p><b>1. Definitions.</b></p>
<ol type=\"a\">
        <li>&ldquo;License&rdquo; is this Modelica License.</li>

        <li>&ldquo;Original Work&rdquo; is any work of authorship, including
        software, images, documents, data files, that contains the above
        licensing notice or that is packed together with a licensing notice
        referencing it.</li>

        <li>&ldquo;Licensor&rdquo; is the provider of the Original Work who has
        placed this licensing notice adjacent to the copyright notice(s) for
        the Original Work. The Original Work is either directly provided by
        the owner of the Original Work, or by a licensee of the owner.</li>

        <li>&ldquo;Derivative Work&rdquo; is any modification of the Original
        Work which represents, as a whole, an original work of authorship.
        For the matter of clarity and as examples:

        <ol type=\"A\">
                <li>Derivative Work shall not include work that remains separable from
                the Original Work, as well as merely extracting a part of the
                Original Work without modifying it.</li>

                <li>Derivative Work shall not include (a) fixing of errors and/or (b)
                adding vendor-specific Modelica annotations and/or (c) using a
                subset of the classes of a Modelica package, and/or (d) using a
                different representation, e.g., a binary representation.</li>

                <li>Derivative Work shall include classes that are copied from the
                Original Work where declarations, equations or the documentation
                are modified.</li>

                <li>Derivative Work shall include executables to simulate the models
                that are generated by a Modelica translator based on the Original
                Work (of a Modelica package).</li>
        </ol>

        <li>&ldquo;Modified Work&rdquo; is any modification of the Original Work
        with the following exceptions: (a) fixing of errors and/or (b)
        adding vendor-specific Modelica annotations and/or (c) using a
        subset of the classes of a Modelica package, and/or (d) using a
        different representation, e.g., a binary representation.</li>

        <li>&quot;Source Code&quot; means the preferred form of the Original
        Work for making modifications to it and all available documentation
        describing how to modify the Original Work.</li>

        <li>&ldquo;You&rdquo; means an individual or a legal entity exercising
        rights under, and complying with all of the terms of, this License.</li>

        <li>&ldquo;Modelica package&rdquo; means any Modelica library that is
        defined with the &ldquo;<code><b>package</b>&nbsp;&lt;Name&gt;&nbsp;&hellip;&nbsp;<b>end</b>&nbsp;&lt;Name&gt;;</code>&rdquo; Modelica language element.</li>

</ol>

<p><b>2. Grant of Copyright License.</b> Licensor grants You a
worldwide, royalty-free, non-exclusive, sublicensable license, for
the duration of the copyright, to do the following:</p>

<ol type=\"a\">
        <li><p>To reproduce the Original Work in copies, either alone or as part of
        a collection.</p></li>
        <li><p>To create Derivative Works according to Section 1d) of this License.</p></li>
        <li><p>To distribute or communicate to the public copies of the <u>Original
        Work</u> or a <u>Derivative Work</u> under <u>this License</u>. No
        fee, neither as a copyright-license fee, nor as a selling fee for
        the copy as such may be charged under this License. Furthermore, a
        verbatim copy of this License must be included in any copy of the
        Original Work or a Derivative Work under this License.<br>
        For the matter of clarity, it is permitted A) to distribute or
        communicate such copies as part of a (possible commercial)
        collection where other parts are provided under different licenses
        and a license fee is charged for the other parts only and B) to
        charge for mere printing and shipping costs.</p></li>
        <li><p>To distribute or communicate to the public copies of a <u>Derivative
        Work</u>, alternatively to Section 2c), under <u>any other license</u>
        of your choice, especially also under a license for
        commercial/proprietary software, as long as You comply with Sections
        3, 4 and 8 below.<br>      For the matter of clarity, no
        restrictions regarding fees, either as to a copyright-license fee or
        as to a selling fee for the copy as such apply.</p></li>
        <li><p>To perform the Original Work publicly.</p></li>
        <li><p>To display the Original Work publicly.</p></li>
</ol>

<p><b>3. Acceptance.</b> Any use of the Original Work or a
Derivative Work, or any action according to either Section 2a) to 2f)
above constitutes Your acceptance of this License.</p>

<p><b>4. Designation of Derivative Works and of Modified Works.
</b>The identifying designation of Derivative Work and of Modified
Work must be different to the corresponding identifying designation
of the Original Work. This means especially that the (root-level)
name of a Modelica package under this license must be changed if the
package is modified (besides fixing of errors, adding vendor-specific
Modelica annotations, using a subset of the classes of a Modelica
package, or using another representation, e.g. a binary
representation).</p>

<p><b>5. Grant of Patent License.</b>
Licensor grants You a worldwide, royalty-free, non-exclusive, sublicensable license,
under patent claims owned by the Licensor or licensed to the Licensor by
the owners of the Original Work that are embodied in the Original Work
as furnished by the Licensor, for the duration of the patents,
to make, use, sell, offer for sale, have made, and import the Original Work
and Derivative Works under the conditions as given in Section 2.
For the matter of clarity, the license regarding Derivative Works covers
patent claims to the extent as they are embodied in the Original Work only.</p>

<p><b>6. Provision of Source Code.</b> Licensor agrees to provide
You with a copy of the Source Code of the Original Work but reserves
the right to decide freely on the manner of how the Original Work is
provided.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For the matter of clarity, Licensor might provide only a binary
representation of the Original Work. In that case, You may (a) either
reproduce the Source Code from the binary representation if this is
possible (e.g., by performing a copy of an encrypted Modelica
package, if encryption allows the copy operation) or (b) request the
Source Code from the Licensor who will provide it to You.</p>

<p><b>7. Exclusions from License Grant.</b> Neither the names of
Licensor, nor the names of any contributors to the Original Work, nor
any of their trademarks or service marks, may be used to endorse or
promote products derived from this Original Work without express
prior permission of the Licensor. Except as otherwise expressly
stated in this License and in particular in Sections 2 and 5, nothing
in this License grants any license to Licensor&rsquo;s trademarks,
copyrights, patents, trade secrets or any other intellectual
property, and no patent license is granted to make, use, sell, offer
for sale, have made, or import embodiments of any patent claims.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No license is granted to the trademarks of
Licensor even if such trademarks are included in the Original Work,
except as expressly stated in this License. Nothing in this License
shall be interpreted to prohibit Licensor from licensing under terms
different from this License any Original Work that Licensor otherwise
would have a right to license.</p>

<p><b>8. Attribution Rights.</b> You must retain in the Source
Code of the Original Work and of any Derivative Works that You
create, all author, copyright, patent, or trademark notices, as well
as any descriptive text identified therein as an &quot;Attribution
Notice&quot;. The same applies to the licensing notice of this
License in the Original Work. For the matter of clarity, &ldquo;author
notice&rdquo; means the notice that identifies the original
author(s).<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You must cause the Source Code for any Derivative
Works that You create to carry a prominent Attribution Notice
reasonably calculated to inform recipients that You have modified the
Original Work.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In case the Original Work or Derivative Work is not provided in
Source Code, the Attribution Notices shall be appropriately
displayed, e.g., in the documentation of the Derivative Work.</p>

<p><b>9. Disclaimer
of Warranty.<br><u>The Original Work is provided under this
License on an &quot;as is&quot; basis and without warranty, either
express or implied, including, without limitation, the warranties of
non-infringement, merchantability or fitness for a particular
purpose. The entire risk as to the quality of the Original Work is
with You.</u></b> This disclaimer of warranty constitutes an
essential part of this License. No license to the Original Work is
granted by this License except under this disclaimer.</p>

<p><b>10. Limitation of Liability.</b> Under no circumstances and
under no legal theory, whether in tort (including negligence),
contract, or otherwise, shall the Licensor, the owner or a licensee
of the Original Work be liable to anyone for any direct, indirect,
general, special, incidental, or consequential damages of any
character arising as a result of this License or the use of the
Original Work including, without limitation, damages for loss of
goodwill, work stoppage, computer failure or malfunction, or any and
all other commercial damages or losses. This limitation of liability
shall not apply to the extent applicable law prohibits such
limitation.</p>

<p><b>11. Termination.</b> This License conditions your rights to
undertake the activities listed in Section 2 and 5, including your
right to create Derivative Works based upon the Original Work, and
doing so without observing these terms and conditions is prohibited
by copyright law and international treaty. Nothing in this License is
intended to affect copyright exceptions and limitations. This License
shall terminate immediately and You may no longer exercise any of the
rights granted to You by this License upon your failure to observe
the conditions of this license.</p>

<p><b>12. Termination for Patent Action.</b> This License shall
terminate automatically and You may no longer exercise any of the
rights granted to You by this License as of the date You commence an
action, including a cross-claim or counterclaim, against Licensor,
any owners of the Original Work or any licensee alleging that the
Original Work infringes a patent. This termination provision shall
not apply for an action alleging patent infringement through
combinations of the Original Work under combination with other
software or hardware.</p>

<p><b>13. Jurisdiction.</b> Any action or suit relating to this
License may be brought only in the courts of a jurisdiction wherein
the Licensor resides and under the laws of that jurisdiction
excluding its conflict-of-law provisions. The application of the
United Nations Convention on Contracts for the International Sale of
Goods is expressly excluded. Any use of the Original Work outside the
scope of this License or after its termination shall be subject to
the requirements and penalties of copyright or patent law in the
appropriate jurisdiction. This section shall survive the termination
of this License.</p>

<p><b>14. Attorneys&rsquo; Fees.</b> In any action to enforce the
terms of this License or seeking damages relating thereto, the
prevailing party shall be entitled to recover its costs and expenses,
including, without limitation, reasonable attorneys' fees and costs
incurred in connection with such action, including any appeal of such
action. This section shall survive the termination of this License.</p>

<p><b>15. Miscellaneous.</b></p>
<ol type=\"a\">
        <li>If any
        provision of this License is held to be unenforceable, such
        provision shall be reformed only to the extent necessary to make it
        enforceable.</li>

        <li>No verbal
        ancillary agreements have been made. Changes and additions to this
        License must appear in writing to be valid. This also applies to
        changing the clause pertaining to written form.</li>

        <li>You may use the
        Original Work in all ways not otherwise restricted or conditioned by
        this License or by law, and Licensor promises not to interfere with
        or be responsible for such uses by You.</li>
</ol>
</html>"));

  end License;
  annotation (preferredView="info", DocumentationClass=true);

end UsersGuide;
