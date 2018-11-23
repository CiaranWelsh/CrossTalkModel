<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="24" versionDevel="197" copasiSourcesModified="0">
  <ListOfFunctions>
    <Function key="Function_6" name="Constant flux (irreversible)" type="PreDefined" reversible="false">
      <Expression>
        v
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_49" name="v" order="0" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_13" name="Mass action (irreversible)" type="MassAction" reversible="false">
      <MiriamAnnotation>
        <rdf:RDF xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
          <rdf:Description rdf:about="#Function_13">
            <CopasiMT:is rdf:resource="urn:miriam:obo.sbo:SBO:0000163"/>
          </rdf:Description>
        </rdf:RDF>
      </MiriamAnnotation>
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
          <b>Mass action rate law for irreversible reactions</b>
          <p>
Reaction scheme where the products are created from the reactants and the change of a product quantity is proportional to the product of reactant activities. The reaction scheme does not include any reverse process that creates the reactants from the products. The change of a product quantity is proportional to the quantity of one reactant.
</p>
        </body>
      </Comment>
      <Expression>
        k1*PRODUCT&lt;substrate_i&gt;
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_80" name="k1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_81" name="substrate" order="1" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_47" name="MA3_1" type="UserDefined" reversible="false">
      <Expression>
        tgfb_ka*tgfb_R1*tgfb_R2*tgfb_ligand
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_290" name="tgfb_R1" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_291" name="tgfb_R2" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_292" name="tgfb_ka" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_293" name="tgfb_ligand" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="NonCompetitiveInhibition_1" type="UserDefined" reversible="false">
      <Expression>
        mapk_J0_V1*mapk_MKKK/((1+(mapk_MAPK_PP/mapk_J0_Ki)^mapk_J0_n)*(mapk_J0_K1+mapk_MKKK))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_322" name="mapk_J0_K1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_323" name="mapk_J0_Ki" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_324" name="mapk_J0_V1" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_325" name="mapk_J0_n" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_326" name="mapk_MAPK_PP" order="4" role="modifier"/>
        <ParameterDescription key="FunctionParameter_327" name="mapk_MKKK" order="5" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="MM_1" type="UserDefined" reversible="false">
      <Expression>
        mapk_J1_V2*mapk_MKKK_P/(mapk_J1_KK2+mapk_MKKK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_316" name="mapk_J1_KK2" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_319" name="mapk_J1_V2" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_321" name="mapk_MKKK_P" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="MMWithKcat_1" type="UserDefined" reversible="false">
      <Expression>
        mapk_J2_k3*mapk_MKKK_P*mapk_MKK/(mapk_J2_KK3+mapk_MKK)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_338" name="mapk_J2_KK3" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_339" name="mapk_J2_k3" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_340" name="mapk_MKK" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_341" name="mapk_MKKK_P" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="MMWithKcat_2" type="UserDefined" reversible="false">
      <Expression>
        mapk_J3_k4*mapk_MKK_P*mapk_MKKK_P/(mapk_J3_KK4+mapk_MKKK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_346" name="mapk_J3_KK4" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_347" name="mapk_J3_k4" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_348" name="mapk_MKKK_P" order="2" role="modifier"/>
        <ParameterDescription key="FunctionParameter_349" name="mapk_MKK_P" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="MM_2" type="UserDefined" reversible="false">
      <Expression>
        mapk_J4_V5*mapk_MKK_PP/(mapk_J4_KK5+mapk_MKK_PP)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_337" name="mapk_J4_KK5" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_354" name="mapk_J4_V5" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_355" name="mapk_MKK_PP" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="MM_3" type="UserDefined" reversible="false">
      <Expression>
        mapk_J5_V6*mapk_MKK_P/(mapk_J5_KK6+mapk_MKK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_359" name="mapk_J5_KK6" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_360" name="mapk_J5_V6" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_361" name="mapk_MKK_P" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="MMWithKcat_3" type="UserDefined" reversible="false">
      <Expression>
        mapk_J6_k7*mapk_MKK_PP*mapk_MAPK/(mapk_J6_KK7+mapk_MAPK)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_366" name="mapk_J6_KK7" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_367" name="mapk_J6_k7" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_368" name="mapk_MAPK" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_369" name="mapk_MKK_PP" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="MMWithKcat_4" type="UserDefined" reversible="false">
      <Expression>
        mapk_J7_k8*mapk_MKK_PP*mapk_MAPK_P/(mapk_J7_KK8+mapk_MAPK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_374" name="mapk_J7_KK8" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_375" name="mapk_J7_k8" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_376" name="mapk_MAPK_P" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_377" name="mapk_MKK_PP" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="MM_4" type="UserDefined" reversible="false">
      <Expression>
        mapk_J8_V9*mapk_MAPK_PP/(mapk_J8_KK9+mapk_MAPK_PP)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_365" name="mapk_J8_KK9" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_382" name="mapk_J8_V9" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_383" name="mapk_MAPK_PP" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="MM_5" type="UserDefined" reversible="false">
      <Expression>
        mapk_J9_V10*mapk_MAPK_P/(mapk_J9_KK10+mapk_MAPK_P)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_387" name="mapk_J9_KK10" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_388" name="mapk_J9_V10" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_389" name="mapk_MAPK_P" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_1" name="TGFbPlusMAPK" simulationType="time" timeUnit="h" volumeUnit="l" areaUnit="m&#178;" lengthUnit="m" quantityUnit="nmol" type="deterministic" avogadroConstant="6.0221417899999999e+23">
    <ListOfCompartments>
      <Compartment key="Compartment_0" name="Plasma membrane" simulationType="fixed" dimensionality="3" addNoise="false">
      </Compartment>
      <Compartment key="Compartment_1" name="mapk_Cell" simulationType="fixed" dimensionality="3" addNoise="false">
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_0" name="Receptor 1" simulationType="reactions" compartment="Compartment_0" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_1" name="Receptor 2" simulationType="reactions" compartment="Compartment_0" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_2" name="ligand receptor complex-plasma membrane" simulationType="reactions" compartment="Compartment_0" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_3" name="ligand receptor complex-endosome" simulationType="reactions" compartment="Compartment_0" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_4" name="Receptor 1-endosome" simulationType="reactions" compartment="Compartment_0" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_5" name="Receptor 2 endosome" simulationType="reactions" compartment="Compartment_0" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_6" name="Mos" simulationType="reactions" compartment="Compartment_1" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_7" name="Mos-P" simulationType="reactions" compartment="Compartment_1" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_8" name="Mek1" simulationType="reactions" compartment="Compartment_1" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_9" name="Mek1-P" simulationType="reactions" compartment="Compartment_1" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_10" name="Mek1-PP" simulationType="reactions" compartment="Compartment_1" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_11" name="Erk2" simulationType="reactions" compartment="Compartment_1" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_12" name="Erk2-P" simulationType="reactions" compartment="Compartment_1" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_13" name="Erk2-PP" simulationType="reactions" compartment="Compartment_1" addNoise="false">
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_0" name="tgfb_ka" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_1" name="tgfb_kcd" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_2" name="tgfb_klid" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_3" name="tgfb_ki" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_4" name="tgfb_pRI" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_5" name="tgfb_kr" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_6" name="tgfb_pRII" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_7" name="tgfb_TGFb" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_8" name="tgfb_alpha" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_9" name="mapk_J0_K1" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_10" name="mapk_J0_Ki" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_11" name="mapk_J0_V1" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_12" name="mapk_J0_n" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_13" name="mapk_J1_KK2" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_14" name="mapk_J1_V2" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_15" name="mapk_J2_KK3" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_16" name="mapk_J2_k3" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_17" name="mapk_J3_KK4" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_18" name="mapk_J3_k4" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_19" name="mapk_J4_KK5" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_20" name="mapk_J4_V5" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_21" name="mapk_J5_KK6" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_22" name="mapk_J5_V6" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_23" name="mapk_J6_KK7" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_24" name="mapk_J6_k7" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_25" name="mapk_J7_KK8" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_26" name="mapk_J7_k8" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_27" name="mapk_J8_KK9" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_28" name="mapk_J8_V9" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_29" name="mapk_J9_KK10" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_30" name="mapk_J9_V10" simulationType="fixed" addNoise="false">
      </ModelValue>
      <ModelValue key="ModelValue_31" name="tgfb_ligand" simulationType="fixed" addNoise="false">
      </ModelValue>
    </ListOfModelValues>
    <ListOfReactions>
      <Reaction key="Reaction_0" name="Ligand receptor complex formation" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5009" name="tgfb_ka" value="1"/>
          <Constant key="Parameter_5008" name="tgfb_ligand" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_47" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_290">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_291">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_292">
              <SourceParameter reference="ModelValue_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="Ligand receptor complex constitutive degradation" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_5007" name="k1" value="0.0277778"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_2" name="Ligand independent complex degradation" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_5006" name="k1" value="0.25"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_3" name="Ligand receptor complex internalization" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5005" name="k1" value="0.333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_4" name="R1 synthesis" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5004" name="v" value="8"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_5" name="R1 constitutive degradation" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_5003" name="k1" value="0.0277778"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_6" name="R1 internalization" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5002" name="k1" value="0.333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="R1 recycling" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5001" name="k1" value="0.0333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="Ligand Receptor complex recycling" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_0" stoichiometry="1"/>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5000" name="k1" value="0.0333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="R2 synthesis" reversible="false" fast="false" addNoise="false">
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4999" name="v" value="4"/>
        </ListOfConstants>
        <KineticLaw function="Function_6" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_49">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="R2 constitutive degradation" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_4998" name="k1" value="0.0277778"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="R2 internalization" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4997" name="k1" value="0.333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="R2 recycling" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4996" name="k1" value="0.0333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="MAPKKK activation" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4995" name="mapk_J0_K1" value="10"/>
          <Constant key="Parameter_4994" name="mapk_J0_Ki" value="9"/>
          <Constant key="Parameter_4993" name="mapk_J0_V1" value="2.5"/>
          <Constant key="Parameter_4992" name="mapk_J0_n" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_48" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_322">
              <SourceParameter reference="ModelValue_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_323">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_324">
              <SourceParameter reference="ModelValue_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_325">
              <SourceParameter reference="ModelValue_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_326">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_327">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="MAPKKK inactivation" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4991" name="mapk_J1_KK2" value="8"/>
          <Constant key="Parameter_4990" name="mapk_J1_V2" value="0.25"/>
        </ListOfConstants>
        <KineticLaw function="Function_49" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_316">
              <SourceParameter reference="ModelValue_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_319">
              <SourceParameter reference="ModelValue_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_321">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="phosphorylation of MAPKK" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4989" name="mapk_J2_KK3" value="15"/>
          <Constant key="Parameter_4988" name="mapk_J2_k3" value="0.025"/>
        </ListOfConstants>
        <KineticLaw function="Function_50" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_338">
              <SourceParameter reference="ModelValue_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_339">
              <SourceParameter reference="ModelValue_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_340">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_341">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="phosphorylation of MAPKK-P" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4987" name="mapk_J3_KK4" value="15"/>
          <Constant key="Parameter_4986" name="mapk_J3_k4" value="0.025"/>
        </ListOfConstants>
        <KineticLaw function="Function_51" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_346">
              <SourceParameter reference="ModelValue_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_347">
              <SourceParameter reference="ModelValue_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_348">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_349">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_17" name="dephosphorylation of MAPKK-PP" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4985" name="mapk_J4_KK5" value="15"/>
          <Constant key="Parameter_4984" name="mapk_J4_V5" value="0.75"/>
        </ListOfConstants>
        <KineticLaw function="Function_52" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_337">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_354">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_355">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_18" name="dephosphorylation of MAPKK-P" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4983" name="mapk_J5_KK6" value="15"/>
          <Constant key="Parameter_4982" name="mapk_J5_V6" value="0.75"/>
        </ListOfConstants>
        <KineticLaw function="Function_53" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_359">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_360">
              <SourceParameter reference="ModelValue_22"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_361">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_19" name="phosphorylation of MAPK" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4981" name="mapk_J6_KK7" value="15"/>
          <Constant key="Parameter_4980" name="mapk_J6_k7" value="0.025"/>
        </ListOfConstants>
        <KineticLaw function="Function_54" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_366">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_367">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_368">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_369">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_20" name="phosphorylation of MAPK-P" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4979" name="mapk_J7_KK8" value="15"/>
          <Constant key="Parameter_4978" name="mapk_J7_k8" value="0.025"/>
        </ListOfConstants>
        <KineticLaw function="Function_55" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_374">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_375">
              <SourceParameter reference="ModelValue_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_376">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_377">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_21" name="dephosphorylation of MAPK-PP" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4977" name="mapk_J8_KK9" value="15"/>
          <Constant key="Parameter_4976" name="mapk_J8_V9" value="0.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_56" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_365">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_382">
              <SourceParameter reference="ModelValue_28"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_383">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="dephosphorylation of MAPK-P" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4975" name="mapk_J9_KK10" value="15"/>
          <Constant key="Parameter_4974" name="mapk_J9_V10" value="0.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_57" unitType="Default" scalingCompartment="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_387">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_388">
              <SourceParameter reference="ModelValue_30"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_389">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfModelParameterSets activeSet="ModelParameterSet_1">
      <ModelParameterSet key="ModelParameterSet_1" name="Initial State">
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane]" value="1" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane],Vector=Metabolites[Receptor 1]" value="1.6325243514257299e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane],Vector=Metabolites[Receptor 2]" value="76533593366573008" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane],Vector=Metabolites[ligand receptor complex-plasma membrane]" value="1018506774517330" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane],Vector=Metabolites[ligand receptor complex-endosome]" value="10185067745173300" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane],Vector=Metabolites[Receptor 1-endosome]" value="1.63252435142573e+18" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[Plasma membrane],Vector=Metabolites[Receptor 2 endosome]" value="7.6533593366572992e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell],Vector=Metabolites[Mos]" value="54199276110000000" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell],Vector=Metabolites[Mos-P]" value="6022141790000000" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell],Vector=Metabolites[Mek1]" value="1.6861997012e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell],Vector=Metabolites[Mek1-P]" value="6022141790000000" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell],Vector=Metabolites[Mek1-PP]" value="6022141790000000" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell],Vector=Metabolites[Erk2]" value="1.6861997012e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell],Vector=Metabolites[Erk2-P]" value="6022141790000000" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Compartments[mapk_Cell],Vector=Metabolites[Erk2-PP]" value="6022141790000000" type="Species" simulationType="reactions"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_ka]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_kcd]" value="0.0277777778" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_klid]" value="0.25" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_ki]" value="0.33333333333330001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_pRI]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_kr]" value="0.033333333333333298" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_pRII]" value="4" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_TGFb]" value="0.01" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_alpha]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J0_K1]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J0_Ki]" value="9" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J0_V1]" value="2.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J0_n]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J1_KK2]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J1_V2]" value="0.25" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J2_KK3]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J2_k3]" value="0.025000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J3_KK4]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J3_k4]" value="0.025000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J4_KK5]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J4_V5]" value="0.75" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J5_KK6]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J5_V6]" value="0.75" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J6_KK7]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J6_k7]" value="0.025000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J7_KK8]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J7_k8]" value="0.025000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J8_KK9]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J8_V9]" value="0.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J9_KK10]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J9_V10]" value="0.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_ligand]" value="1" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand receptor complex formation]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand receptor complex formation],ParameterGroup=Parameters,Parameter=tgfb_ka" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_ka],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand receptor complex formation],ParameterGroup=Parameters,Parameter=tgfb_ligand" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_ligand],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand receptor complex constitutive degradation]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand receptor complex constitutive degradation],ParameterGroup=Parameters,Parameter=k1" value="0.0277777778" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_kcd],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand independent complex degradation]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand independent complex degradation],ParameterGroup=Parameters,Parameter=k1" value="0.25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_klid],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand receptor complex internalization]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand receptor complex internalization],ParameterGroup=Parameters,Parameter=k1" value="0.33333333333330001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R1 synthesis]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R1 synthesis],ParameterGroup=Parameters,Parameter=v" value="8" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_pRI],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R1 constitutive degradation]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R1 constitutive degradation],ParameterGroup=Parameters,Parameter=k1" value="0.0277777778" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_kcd],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R1 internalization]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R1 internalization],ParameterGroup=Parameters,Parameter=k1" value="0.33333333333330001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R1 recycling]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R1 recycling],ParameterGroup=Parameters,Parameter=k1" value="0.033333333333333298" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_kr],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand Receptor complex recycling]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[Ligand Receptor complex recycling],ParameterGroup=Parameters,Parameter=k1" value="0.033333333333333298" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_kr],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R2 synthesis]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R2 synthesis],ParameterGroup=Parameters,Parameter=v" value="4" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_pRII],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R2 constitutive degradation]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R2 constitutive degradation],ParameterGroup=Parameters,Parameter=k1" value="0.0277777778" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_kcd],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R2 internalization]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R2 internalization],ParameterGroup=Parameters,Parameter=k1" value="0.33333333333330001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R2 recycling]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[R2 recycling],ParameterGroup=Parameters,Parameter=k1" value="0.033333333333333298" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[tgfb_kr],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[MAPKKK activation]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[MAPKKK activation],ParameterGroup=Parameters,Parameter=mapk_J0_K1" value="10" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J0_K1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[MAPKKK activation],ParameterGroup=Parameters,Parameter=mapk_J0_Ki" value="9" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J0_Ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[MAPKKK activation],ParameterGroup=Parameters,Parameter=mapk_J0_V1" value="2.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J0_V1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[MAPKKK activation],ParameterGroup=Parameters,Parameter=mapk_J0_n" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J0_n],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[MAPKKK inactivation]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[MAPKKK inactivation],ParameterGroup=Parameters,Parameter=mapk_J1_KK2" value="8" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J1_KK2],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[MAPKKK inactivation],ParameterGroup=Parameters,Parameter=mapk_J1_V2" value="0.25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J1_V2],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPKK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPKK],ParameterGroup=Parameters,Parameter=mapk_J2_KK3" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J2_KK3],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPKK],ParameterGroup=Parameters,Parameter=mapk_J2_k3" value="0.025000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J2_k3],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPKK-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPKK-P],ParameterGroup=Parameters,Parameter=mapk_J3_KK4" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J3_KK4],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPKK-P],ParameterGroup=Parameters,Parameter=mapk_J3_k4" value="0.025000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J3_k4],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPKK-PP]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPKK-PP],ParameterGroup=Parameters,Parameter=mapk_J4_KK5" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J4_KK5],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPKK-PP],ParameterGroup=Parameters,Parameter=mapk_J4_V5" value="0.75" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J4_V5],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPKK-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPKK-P],ParameterGroup=Parameters,Parameter=mapk_J5_KK6" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J5_KK6],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPKK-P],ParameterGroup=Parameters,Parameter=mapk_J5_V6" value="0.75" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J5_V6],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPK]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPK],ParameterGroup=Parameters,Parameter=mapk_J6_KK7" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J6_KK7],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPK],ParameterGroup=Parameters,Parameter=mapk_J6_k7" value="0.025000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J6_k7],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPK-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPK-P],ParameterGroup=Parameters,Parameter=mapk_J7_KK8" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J7_KK8],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[phosphorylation of MAPK-P],ParameterGroup=Parameters,Parameter=mapk_J7_k8" value="0.025000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J7_k8],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPK-PP]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPK-PP],ParameterGroup=Parameters,Parameter=mapk_J8_KK9" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J8_KK9],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPK-PP],ParameterGroup=Parameters,Parameter=mapk_J8_V9" value="0.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J8_V9],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPK-P]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPK-P],ParameterGroup=Parameters,Parameter=mapk_J9_KK10" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J9_KK10],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbPlusMAPK,Vector=Reactions[dephosphorylation of MAPK-P],ParameterGroup=Parameters,Parameter=mapk_J9_V10" value="0.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbPlusMAPK,Vector=Values[mapk_J9_V10],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_1"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_12"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
      <StateTemplateVariable objectReference="Compartment_1"/>
      <StateTemplateVariable objectReference="ModelValue_0"/>
      <StateTemplateVariable objectReference="ModelValue_1"/>
      <StateTemplateVariable objectReference="ModelValue_2"/>
      <StateTemplateVariable objectReference="ModelValue_3"/>
      <StateTemplateVariable objectReference="ModelValue_4"/>
      <StateTemplateVariable objectReference="ModelValue_5"/>
      <StateTemplateVariable objectReference="ModelValue_6"/>
      <StateTemplateVariable objectReference="ModelValue_7"/>
      <StateTemplateVariable objectReference="ModelValue_8"/>
      <StateTemplateVariable objectReference="ModelValue_9"/>
      <StateTemplateVariable objectReference="ModelValue_10"/>
      <StateTemplateVariable objectReference="ModelValue_11"/>
      <StateTemplateVariable objectReference="ModelValue_12"/>
      <StateTemplateVariable objectReference="ModelValue_13"/>
      <StateTemplateVariable objectReference="ModelValue_14"/>
      <StateTemplateVariable objectReference="ModelValue_15"/>
      <StateTemplateVariable objectReference="ModelValue_16"/>
      <StateTemplateVariable objectReference="ModelValue_17"/>
      <StateTemplateVariable objectReference="ModelValue_18"/>
      <StateTemplateVariable objectReference="ModelValue_19"/>
      <StateTemplateVariable objectReference="ModelValue_20"/>
      <StateTemplateVariable objectReference="ModelValue_21"/>
      <StateTemplateVariable objectReference="ModelValue_22"/>
      <StateTemplateVariable objectReference="ModelValue_23"/>
      <StateTemplateVariable objectReference="ModelValue_24"/>
      <StateTemplateVariable objectReference="ModelValue_25"/>
      <StateTemplateVariable objectReference="ModelValue_26"/>
      <StateTemplateVariable objectReference="ModelValue_27"/>
      <StateTemplateVariable objectReference="ModelValue_28"/>
      <StateTemplateVariable objectReference="ModelValue_29"/>
      <StateTemplateVariable objectReference="ModelValue_30"/>
      <StateTemplateVariable objectReference="ModelValue_31"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 1.6325243514257299e+17 76533593366573008 6022141790000000 6022141790000000 1018506774517330 54199276110000000 10185067745173300 1.63252435142573e+18 7.6533593366572992e+17 6022141790000000 1.6861997012e+17 6022141790000000 1.6861997012e+17 6022141790000000 1 1 1 0.0277777778 0.25 0.33333333333330001 8 0.033333333333333298 4 0.01 1 10 9 2.5 1 8 0.25 15 0.025000000000000001 15 0.025000000000000001 15 0.75 15 0.75 15 0.025000000000000001 15 0.025000000000000001 15 0.5 15 0.5 1 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_14" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_9" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="JacobianRequested" type="bool" value="1"/>
        <Parameter name="StabilityAnalysisRequested" type="bool" value="1"/>
      </Problem>
      <Method name="Enhanced Newton" type="EnhancedNewton">
        <Parameter name="Resolution" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Derivation Factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Use Newton" type="bool" value="1"/>
        <Parameter name="Use Integration" type="bool" value="1"/>
        <Parameter name="Use Back Integration" type="bool" value="0"/>
        <Parameter name="Accept Negative Concentrations" type="bool" value="0"/>
        <Parameter name="Iteration Limit" type="unsignedInteger" value="50"/>
        <Parameter name="Maximum duration for forward integration" type="unsignedFloat" value="1000000000"/>
        <Parameter name="Maximum duration for backward integration" type="unsignedFloat" value="1000000"/>
      </Method>
    </Task>
    <Task key="Task_15" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_16" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="1"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_17" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_10" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_18" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_11" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Subtask" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <ParameterText name="ObjectiveExpression" type="expression">
        </ParameterText>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
      </Problem>
      <Method name="Random Search" type="RandomSearch">
        <Parameter name="Log Verbosity" type="unsignedInteger" value="0"/>
        <Parameter name="Number of Iterations" type="unsignedInteger" value="100000"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_19" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_12" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
        <Parameter name="Steady-State" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <Parameter name="Time-Course" type="cn" value="CN=Root,Vector=TaskList[Time-Course]"/>
        <Parameter name="Create Parameter Sets" type="bool" value="0"/>
        <ParameterGroup name="Experiment Set">
        </ParameterGroup>
        <ParameterGroup name="Validation Set">
          <Parameter name="Weight" type="unsignedFloat" value="1"/>
          <Parameter name="Threshold" type="unsignedInteger" value="5"/>
        </ParameterGroup>
      </Problem>
      <Method name="Evolutionary Programming" type="EvolutionaryProgram">
        <Parameter name="Log Verbosity" type="unsignedInteger" value="0"/>
        <Parameter name="Number of Generations" type="unsignedInteger" value="200"/>
        <Parameter name="Population Size" type="unsignedInteger" value="20"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
        <Parameter name="Stop after # Stalled Generations" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_20" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_13" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_14"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Use Reder" type="bool" value="1"/>
        <Parameter name="Use Smallbone" type="bool" value="1"/>
      </Method>
    </Task>
    <Task key="Task_21" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_14" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="ExponentNumber" type="unsignedInteger" value="3"/>
        <Parameter name="DivergenceRequested" type="bool" value="1"/>
        <Parameter name="TransientTime" type="float" value="0"/>
      </Problem>
      <Method name="Wolf Method" type="WolfMethod">
        <Parameter name="Orthonormalization Interval" type="unsignedFloat" value="1"/>
        <Parameter name="Overall time" type="unsignedFloat" value="1000"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_22" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_15" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
      </Problem>
      <Method name="ILDM (LSODA,Deuflhard)" type="TimeScaleSeparation(ILDM,Deuflhard)">
        <Parameter name="Deuflhard Tolerance" type="unsignedFloat" value="0.0001"/>
      </Method>
    </Task>
    <Task key="Task_23" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_16" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="SubtaskType" type="unsignedInteger" value="1"/>
        <ParameterGroup name="TargetFunctions">
          <Parameter name="SingleObject" type="cn" value=""/>
          <Parameter name="ObjectListType" type="unsignedInteger" value="7"/>
        </ParameterGroup>
        <ParameterGroup name="ListOfVariables">
          <ParameterGroup name="Variables">
            <Parameter name="SingleObject" type="cn" value=""/>
            <Parameter name="ObjectListType" type="unsignedInteger" value="41"/>
          </ParameterGroup>
          <ParameterGroup name="Variables">
            <Parameter name="SingleObject" type="cn" value=""/>
            <Parameter name="ObjectListType" type="unsignedInteger" value="0"/>
          </ParameterGroup>
        </ParameterGroup>
      </Problem>
      <Method name="Sensitivities Method" type="SensitivitiesMethod">
        <Parameter name="Delta factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Delta minimum" type="unsignedFloat" value="9.9999999999999998e-13"/>
      </Method>
    </Task>
    <Task key="Task_24" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_25" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
        <Parameter name="LimitCrossings" type="bool" value="0"/>
        <Parameter name="NumCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitOutTime" type="bool" value="0"/>
        <Parameter name="LimitOutCrossings" type="bool" value="0"/>
        <Parameter name="PositiveDirection" type="bool" value="1"/>
        <Parameter name="NumOutCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitUntilConvergence" type="bool" value="0"/>
        <Parameter name="ConvergenceTolerance" type="float" value="9.9999999999999995e-07"/>
        <Parameter name="Threshold" type="float" value="0"/>
        <Parameter name="DelayOutputUntilConvergence" type="bool" value="0"/>
        <Parameter name="OutputConvergenceTolerance" type="float" value="9.9999999999999995e-07"/>
        <ParameterText name="TriggerExpression" type="expression">
        </ParameterText>
        <Parameter name="SingleVariable" type="cn" value=""/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_26" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_17" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value=""/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_9" name="Steady-State" taskType="steadyState" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_10" name="Elementary Flux Modes" taskType="fluxMode" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_11" name="Optimization" taskType="optimization" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Object=Description"/>
        <Object cn="String=\[Function Evaluations\]"/>
        <Object cn="Separator=&#9;"/>
        <Object cn="String=\[Best Value\]"/>
        <Object cn="Separator=&#9;"/>
        <Object cn="String=\[Best Parameters\]"/>
      </Header>
      <Body>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Function Evaluations"/>
        <Object cn="Separator=&#9;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Value"/>
        <Object cn="Separator=&#9;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Parameters"/>
      </Body>
      <Footer>
        <Object cn="String=&#10;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_12" name="Parameter Estimation" taskType="parameterFitting" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Object=Description"/>
        <Object cn="String=\[Function Evaluations\]"/>
        <Object cn="Separator=&#9;"/>
        <Object cn="String=\[Best Value\]"/>
        <Object cn="Separator=&#9;"/>
        <Object cn="String=\[Best Parameters\]"/>
      </Header>
      <Body>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Function Evaluations"/>
        <Object cn="Separator=&#9;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Value"/>
        <Object cn="Separator=&#9;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Parameters"/>
      </Body>
      <Footer>
        <Object cn="String=&#10;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_13" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#10;"/>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_14" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#10;"/>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_15" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#10;"/>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_16" name="Sensitivities" taskType="sensitivities" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#10;"/>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_17" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#9;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Linear Noise Approximation],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#10;"/>
        <Object cn="CN=Root,Vector=TaskList[Linear Noise Approximation],Object=Result"/>
      </Footer>
    </Report>
  </ListOfReports>
  <SBMLReference file="KholoPlusVilar.sbml">
    <SBMLMap SBMLid="mapk_Cell" COPASIkey="Compartment_1"/>
    <SBMLMap SBMLid="mapk_J0" COPASIkey="Reaction_13"/>
    <SBMLMap SBMLid="mapk_J0_K1" COPASIkey="ModelValue_9"/>
    <SBMLMap SBMLid="mapk_J0_Ki" COPASIkey="ModelValue_10"/>
    <SBMLMap SBMLid="mapk_J0_V1" COPASIkey="ModelValue_11"/>
    <SBMLMap SBMLid="mapk_J0_n" COPASIkey="ModelValue_12"/>
    <SBMLMap SBMLid="mapk_J1" COPASIkey="Reaction_14"/>
    <SBMLMap SBMLid="mapk_J1_KK2" COPASIkey="ModelValue_13"/>
    <SBMLMap SBMLid="mapk_J1_V2" COPASIkey="ModelValue_14"/>
    <SBMLMap SBMLid="mapk_J2" COPASIkey="Reaction_15"/>
    <SBMLMap SBMLid="mapk_J2_KK3" COPASIkey="ModelValue_15"/>
    <SBMLMap SBMLid="mapk_J2_k3" COPASIkey="ModelValue_16"/>
    <SBMLMap SBMLid="mapk_J3" COPASIkey="Reaction_16"/>
    <SBMLMap SBMLid="mapk_J3_KK4" COPASIkey="ModelValue_17"/>
    <SBMLMap SBMLid="mapk_J3_k4" COPASIkey="ModelValue_18"/>
    <SBMLMap SBMLid="mapk_J4" COPASIkey="Reaction_17"/>
    <SBMLMap SBMLid="mapk_J4_KK5" COPASIkey="ModelValue_19"/>
    <SBMLMap SBMLid="mapk_J4_V5" COPASIkey="ModelValue_20"/>
    <SBMLMap SBMLid="mapk_J5" COPASIkey="Reaction_18"/>
    <SBMLMap SBMLid="mapk_J5_KK6" COPASIkey="ModelValue_21"/>
    <SBMLMap SBMLid="mapk_J5_V6" COPASIkey="ModelValue_22"/>
    <SBMLMap SBMLid="mapk_J6" COPASIkey="Reaction_19"/>
    <SBMLMap SBMLid="mapk_J6_KK7" COPASIkey="ModelValue_23"/>
    <SBMLMap SBMLid="mapk_J6_k7" COPASIkey="ModelValue_24"/>
    <SBMLMap SBMLid="mapk_J7" COPASIkey="Reaction_20"/>
    <SBMLMap SBMLid="mapk_J7_KK8" COPASIkey="ModelValue_25"/>
    <SBMLMap SBMLid="mapk_J7_k8" COPASIkey="ModelValue_26"/>
    <SBMLMap SBMLid="mapk_J8" COPASIkey="Reaction_21"/>
    <SBMLMap SBMLid="mapk_J8_KK9" COPASIkey="ModelValue_27"/>
    <SBMLMap SBMLid="mapk_J8_V9" COPASIkey="ModelValue_28"/>
    <SBMLMap SBMLid="mapk_J9" COPASIkey="Reaction_22"/>
    <SBMLMap SBMLid="mapk_J9_KK10" COPASIkey="ModelValue_29"/>
    <SBMLMap SBMLid="mapk_J9_V10" COPASIkey="ModelValue_30"/>
    <SBMLMap SBMLid="mapk_MAPK" COPASIkey="Metabolite_11"/>
    <SBMLMap SBMLid="mapk_MAPK_P" COPASIkey="Metabolite_12"/>
    <SBMLMap SBMLid="mapk_MAPK_PP" COPASIkey="Metabolite_13"/>
    <SBMLMap SBMLid="mapk_MKK" COPASIkey="Metabolite_8"/>
    <SBMLMap SBMLid="mapk_MKKK" COPASIkey="Metabolite_6"/>
    <SBMLMap SBMLid="mapk_MKKK_P" COPASIkey="Metabolite_7"/>
    <SBMLMap SBMLid="mapk_MKK_P" COPASIkey="Metabolite_9"/>
    <SBMLMap SBMLid="mapk_MKK_PP" COPASIkey="Metabolite_10"/>
    <SBMLMap SBMLid="tgfb_Cell" COPASIkey="Compartment_0"/>
    <SBMLMap SBMLid="tgfb_LRC" COPASIkey="Metabolite_2"/>
    <SBMLMap SBMLid="tgfb_LRC_EE" COPASIkey="Metabolite_3"/>
    <SBMLMap SBMLid="tgfb_R1" COPASIkey="Metabolite_0"/>
    <SBMLMap SBMLid="tgfb_R1_EE" COPASIkey="Metabolite_4"/>
    <SBMLMap SBMLid="tgfb_R2" COPASIkey="Metabolite_1"/>
    <SBMLMap SBMLid="tgfb_R2_EE" COPASIkey="Metabolite_5"/>
    <SBMLMap SBMLid="tgfb_TGFb" COPASIkey="ModelValue_7"/>
    <SBMLMap SBMLid="tgfb_alpha" COPASIkey="ModelValue_8"/>
    <SBMLMap SBMLid="tgfb_ka" COPASIkey="ModelValue_0"/>
    <SBMLMap SBMLid="tgfb_kcd" COPASIkey="ModelValue_1"/>
    <SBMLMap SBMLid="tgfb_ki" COPASIkey="ModelValue_3"/>
    <SBMLMap SBMLid="tgfb_klid" COPASIkey="ModelValue_2"/>
    <SBMLMap SBMLid="tgfb_kr" COPASIkey="ModelValue_5"/>
    <SBMLMap SBMLid="tgfb_ligand" COPASIkey="ModelValue_31"/>
    <SBMLMap SBMLid="tgfb_pRI" COPASIkey="ModelValue_4"/>
    <SBMLMap SBMLid="tgfb_pRII" COPASIkey="ModelValue_6"/>
    <SBMLMap SBMLid="tgfb_v1" COPASIkey="Reaction_0"/>
    <SBMLMap SBMLid="tgfb_v10" COPASIkey="Reaction_9"/>
    <SBMLMap SBMLid="tgfb_v11" COPASIkey="Reaction_10"/>
    <SBMLMap SBMLid="tgfb_v12" COPASIkey="Reaction_11"/>
    <SBMLMap SBMLid="tgfb_v13" COPASIkey="Reaction_12"/>
    <SBMLMap SBMLid="tgfb_v2" COPASIkey="Reaction_1"/>
    <SBMLMap SBMLid="tgfb_v3" COPASIkey="Reaction_2"/>
    <SBMLMap SBMLid="tgfb_v4" COPASIkey="Reaction_3"/>
    <SBMLMap SBMLid="tgfb_v5" COPASIkey="Reaction_4"/>
    <SBMLMap SBMLid="tgfb_v6" COPASIkey="Reaction_5"/>
    <SBMLMap SBMLid="tgfb_v7" COPASIkey="Reaction_6"/>
    <SBMLMap SBMLid="tgfb_v8" COPASIkey="Reaction_7"/>
    <SBMLMap SBMLid="tgfb_v9" COPASIkey="Reaction_8"/>
  </SBMLReference>
  <ListOfUnitDefinitions>
    <UnitDefinition key="Unit_0" name="meter" symbol="m">
      <Expression>
        m
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_2" name="second" symbol="s">
      <Expression>
        s
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_6" name="Avogadro" symbol="Avogadro">
      <Expression>
        Avogadro
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_8" name="item" symbol="#">
      <Expression>
        #
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_17" name="liter" symbol="l">
      <Expression>
        0.001*m^3
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_20" name="mole" symbol="mol">
      <Expression>
        Avogadro*#
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_33" name="hour" symbol="h">
      <Expression>
        3600*s
      </Expression>
    </UnitDefinition>
  </ListOfUnitDefinitions>
</COPASI>
