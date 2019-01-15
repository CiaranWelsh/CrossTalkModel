<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="24" versionDevel="197" copasiSourcesModified="0">
  <ListOfFunctions>
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
    <Function key="Function_39" name="NonCompetitiveInhibition" type="UserDefined" reversible="unspecified">
      <Expression>
        Vmax*S/((km+S)*(1+(I/ki)^n))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_264" name="km" order="0" role="variable"/>
        <ParameterDescription key="FunctionParameter_263" name="ki" order="1" role="variable"/>
        <ParameterDescription key="FunctionParameter_262" name="Vmax" order="2" role="variable"/>
        <ParameterDescription key="FunctionParameter_261" name="n" order="3" role="variable"/>
        <ParameterDescription key="FunctionParameter_250" name="I" order="4" role="variable"/>
        <ParameterDescription key="FunctionParameter_265" name="S" order="5" role="variable"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="Function for TGF_R1" type="UserDefined" reversible="false">
      <Expression>
        _kTGFbOn*TGFbR*TGFb
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_299" name="TGFb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_300" name="TGFbR" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_301" name="_kTGFbOn" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="MMWithKcat_1" type="UserDefined" reversible="false">
      <Expression>
        _kSmad2Phos_kcat*TGFbR_EE*Smad2/(kSmad2Phos_km+Smad2)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_316" name="Smad2" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_317" name="TGFbR_EE" order="1" role="modifier"/>
        <ParameterDescription key="FunctionParameter_318" name="_kSmad2Phos_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_319" name="kSmad2Phos_km" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="MM_1" type="UserDefined" reversible="false">
      <Expression>
        kSmad2Dephos_Vmax*pSmad2/(kSmad2Dephos_km+pSmad2)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_314" name="kSmad2Dephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_324" name="kSmad2Dephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_325" name="pSmad2" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="Function for MAPK_R0" type="UserDefined" reversible="false">
      <Expression>
        GrowthFactors*NonCompetitiveInhibition(kRafPhos_km,kRafPhos_ki,kRafPhos_Vmax,kRafPhos_n,ppErk,Raf)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_333" name="GrowthFactors" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_334" name="Raf" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_335" name="kRafPhos_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_336" name="kRafPhos_ki" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_337" name="kRafPhos_km" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_338" name="kRafPhos_n" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_339" name="ppErk" order="6" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="MM_2" type="UserDefined" reversible="false">
      <Expression>
        kRafDephosVmax*pRaf/(kRafDephos_km+pRaf)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_315" name="kRafDephosVmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_329" name="kRafDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_332" name="pRaf" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="CompetitiveInhibitionWithKcat_1" type="UserDefined" reversible="false">
      <Expression>
        kMekPhos_kcat*pRaf*Mek/(kMekPhos_km1+Mek+kMekPhos_km1*AZD/_kMekPhos_ki)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_352" name="AZD" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_353" name="Mek" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_354" name="_kMekPhos_ki" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_355" name="kMekPhos_kcat" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_356" name="kMekPhos_km1" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_357" name="pRaf" order="5" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="CompetitiveInhibitionWithKcat_2" type="UserDefined" reversible="false">
      <Expression>
        kMekPhos_kcat*pRaf*pMek/(kMekPhos_km1+pMek+kMekPhos_km1*AZD/_kMekPhos_ki)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_364" name="AZD" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_365" name="_kMekPhos_ki" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_366" name="kMekPhos_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_367" name="kMekPhos_km1" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_368" name="pMek" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_369" name="pRaf" order="5" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="MM_3" type="UserDefined" reversible="false">
      <Expression>
        kMekDephos_Vmax*ppMek/(kMekDephos_km+ppMek)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_313" name="kMekDephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_350" name="kMekDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_331" name="ppMek" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="MM_4" type="UserDefined" reversible="false">
      <Expression>
        kMekDephos_Vmax*pMek/(kMekDephos_km+pMek)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_379" name="kMekDephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_380" name="kMekDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_381" name="pMek" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="MMWithKcat_2" type="UserDefined" reversible="false">
      <Expression>
        kErkPhos_kcat*ppMek*Erk/(kErkPhos_km1+Erk)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_386" name="Erk" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_387" name="kErkPhos_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_388" name="kErkPhos_km1" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_389" name="ppMek" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_58" name="MMWithKcat_3" type="UserDefined" reversible="false">
      <Expression>
        kErkPhos_kcat*ppMek*pErk/(kErkPhos_km1+pErk)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_394" name="kErkPhos_kcat" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_395" name="kErkPhos_km1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_396" name="pErk" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_397" name="ppMek" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_59" name="MM_5" type="UserDefined" reversible="false">
      <Expression>
        kErkDephos_Vmax*ppErk/(kErkDephos_km+ppErk)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_349" name="kErkDephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_402" name="kErkDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_403" name="ppErk" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_60" name="MM_6" type="UserDefined" reversible="false">
      <Expression>
        kErkDephos_Vmax*pErk/(kErkDephos_km+pErk)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_407" name="kErkDephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_408" name="kErkDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_409" name="pErk" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_61" name="Function for PI3K_R1" type="UserDefined" reversible="false">
      <Expression>
        _kPI3KPhosByGF*PI3K*GrowthFactors
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_413" name="GrowthFactors" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_414" name="PI3K" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_415" name="_kPI3KPhosByGF" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_62" name="Function for PI3K_R2" type="UserDefined" reversible="false">
      <Expression>
        _kPI3KDephosByS6K*pPI3K*pS6K
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_419" name="_kPI3KDephosByS6K" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_420" name="pPI3K" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_421" name="pS6K" order="2" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_63" name="CompetitiveInhibitionWithKcat_3" type="UserDefined" reversible="false">
      <Expression>
        _kAktPhos_kcat*pPI3K*Akt/(kAktPhos_km+Akt+kAktPhos_km*MK2206/_kAktPhos_ki)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_428" name="Akt" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_429" name="MK2206" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_430" name="_kAktPhos_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_431" name="_kAktPhos_ki" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_432" name="kAktPhos_km" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_433" name="pPI3K" order="5" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_64" name="MM_7" type="UserDefined" reversible="false">
      <Expression>
        kAktDephos_Vmax*pAkt/(kAktDephos_km+pAkt)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_351" name="kAktDephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_426" name="kAktDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_330" name="pAkt" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_65" name="CompetitiveInhibitionWithKcat_4" type="UserDefined" reversible="false">
      <Expression>
        _kmTORC1Phos_kcat*pAkt*mTORC1/(kmTORC1Phos_km+mTORC1+kmTORC1Phos_km*Everolimus/_kmTORC1Phos_ki)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_446" name="Everolimus" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_447" name="_kmTORC1Phos_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_448" name="_kmTORC1Phos_ki" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_449" name="kmTORC1Phos_km" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_450" name="mTORC1" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_451" name="pAkt" order="5" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_66" name="CompetitiveInhibition_1" type="UserDefined" reversible="false">
      <Expression>
        _kmTORCPhosBasal_Vmax*mTORC1/(_kmTORCPhosBasal_km+mTORC1+_kmTORCPhosBasal_km*Everolimus/_kmTORC1Phos_ki)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_444" name="Everolimus" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_458" name="_kmTORC1Phos_ki" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_459" name="_kmTORCPhosBasal_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_460" name="_kmTORCPhosBasal_km" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_461" name="mTORC1" order="4" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_67" name="MM_8" type="UserDefined" reversible="false">
      <Expression>
        _kmTORC1Dephos_Vmax*pmTORC1/(kmTORC1Dephos_km+pmTORC1)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_425" name="_kmTORC1Dephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_445" name="kmTORC1Dephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_467" name="pmTORC1" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_68" name="MMWithKcat_4" type="UserDefined" reversible="false">
      <Expression>
        _kS6KPhosBymTORC1_kcat*pmTORC1*S6K/(kS6KPhosBymTORC1_km+S6K)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_472" name="S6K" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_473" name="_kS6KPhosBymTORC1_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_474" name="kS6KPhosBymTORC1_km" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_475" name="pmTORC1" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_69" name="MM_9" type="UserDefined" reversible="false">
      <Expression>
        kS6KDephos_Vmax*pS6K/(kS6KDephos_km+pS6K)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_385" name="kS6KDephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_480" name="kS6KDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_481" name="pS6K" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_70" name="MMWithKcat_5" type="UserDefined" reversible="false">
      <Expression>
        _kRafPhosByTGFbR_kcat*TGFbR_Cav*Raf/(kRafPhosByTGFbR_km+Raf)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_486" name="Raf" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_487" name="TGFbR_Cav" order="1" role="modifier"/>
        <ParameterDescription key="FunctionParameter_488" name="_kRafPhosByTGFbR_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_489" name="kRafPhosByTGFbR_km" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_71" name="MMWithKcat_6" type="UserDefined" reversible="false">
      <Expression>
        _kRafPhosByPI3K_kcat*pPI3K*Raf/(kRafPhosByPI3K_km+Raf)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_494" name="Raf" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_495" name="_kRafPhosByPI3K_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_496" name="kRafPhosByPI3K_km" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_497" name="pPI3K" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_72" name="MMWithKcat_7" type="UserDefined" reversible="false">
      <Expression>
        _kPI3KPhosByTGFbR_kcat*TGFbR_Cav*PI3K/(kPI3KPhosByTGFbR_km+PI3K)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_502" name="PI3K" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_503" name="TGFbR_Cav" order="1" role="modifier"/>
        <ParameterDescription key="FunctionParameter_504" name="_kPI3KPhosByTGFbR_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_505" name="kPI3KPhosByTGFbR_km" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_73" name="Function for CrossTalkR4" type="UserDefined" reversible="false">
      <Expression>
        _kPI3KDephosByErk*pPI3K*ppErk
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_485" name="_kPI3KDephosByErk" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_510" name="pPI3K" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_511" name="ppErk" order="2" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_74" name="MMWithKcat_8" type="UserDefined" reversible="false">
      <Expression>
        kSmad2PhosByAkt_kcat*pAkt*Smad2/(kSmad2PhosByAkt_km+Smad2)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_516" name="Smad2" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_517" name="kSmad2PhosByAkt_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_518" name="kSmad2PhosByAkt_km" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_519" name="pAkt" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_75" name="MMWithKcat_9" type="UserDefined" reversible="false">
      <Expression>
        kSmad2DephosByErk_kcat*Erk*pSmad2/(kSmad2DephosByErk_km+pSmad2)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_524" name="Erk" order="0" role="modifier"/>
        <ParameterDescription key="FunctionParameter_525" name="kSmad2DephosByErk_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_526" name="kSmad2DephosByErk_km" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_527" name="pSmad2" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_1" name="CrossTalkModel" simulationType="time" timeUnit="h" volumeUnit="l" areaUnit="m&#178;" lengthUnit="m" quantityUnit="nmol" type="deterministic" avogadroConstant="6.0221417899999999e+23">
    <ListOfCompartments>
      <Compartment key="Compartment_0" name="Cell" simulationType="fixed" dimensionality="3" addNoise="false">
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_0" name="TGFbR" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="4.627394424183029e+16">
      </Metabolite>
      <Metabolite key="Metabolite_1" name="TGFbR_a" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="582171684778969.5">
      </Metabolite>
      <Metabolite key="Metabolite_2" name="TGFbR_EE" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="7557984064814293.0">
      </Metabolite>
      <Metabolite key="Metabolite_3" name="TGFbR_Cav" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5821716847789695.0">
      </Metabolite>
      <Metabolite key="Metabolite_4" name="Smad2" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="2.99167357629441e+16">
      </Metabolite>
      <Metabolite key="Metabolite_5" name="pSmad2" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="301446136082777.0">
      </Metabolite>
      <Metabolite key="Metabolite_6" name="Mek" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="1.5228567762895856e+17">
      </Metabolite>
      <Metabolite key="Metabolite_7" name="pMek" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="3.3762689754202348e+16">
      </Metabolite>
      <Metabolite key="Metabolite_8" name="Erk" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="1.1040507301812789e+17">
      </Metabolite>
      <Metabolite key="Metabolite_9" name="pErk" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="7.09903494779345e+16">
      </Metabolite>
      <Metabolite key="Metabolite_10" name="PI3K" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="6.019751165508762e+16">
      </Metabolite>
      <Metabolite key="Metabolite_11" name="pPI3K" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="23906244912320.023">
      </Metabolite>
      <Metabolite key="Metabolite_12" name="Akt" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.9868063199575336e+16">
      </Metabolite>
      <Metabolite key="Metabolite_13" name="pAkt" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="353354698618055.75">
      </Metabolite>
      <Metabolite key="Metabolite_14" name="mTORC1" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.436335312462394e+16">
      </Metabolite>
      <Metabolite key="Metabolite_15" name="pmTORC1" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5858064775376091.0">
      </Metabolite>
      <Metabolite key="Metabolite_16" name="S6K" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.450459027995909e+16">
      </Metabolite>
      <Metabolite key="Metabolite_17" name="pS6K" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5716827620643109.0">
      </Metabolite>
      <Metabolite key="Metabolite_18" name="Raf" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.2954255562812696e+16">
      </Metabolite>
      <Metabolite key="Metabolite_19" name="pRaf" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="7267162338328442.0">
      </Metabolite>
      <Metabolite key="Metabolite_20" name="ppMek" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="1.7481983859999028e+16">
      </Metabolite>
      <Metabolite key="Metabolite_21" name="ppErk" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="2.594715898704886e+16">
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_0" name="Smad2Tot" simulationType="assignment" addNoise="false" initial_value="50.178463">
        <Expression>
          &lt;CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration&gt;+&lt;CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Smad2],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_1" name="_kTGFbOn" simulationType="fixed" addNoise="false" initial_value="0.1">
      </ModelValue>
      <ModelValue key="ModelValue_2" name="TGFb" simulationType="fixed" addNoise="false" initial_value="0.005">
      </ModelValue>
      <ModelValue key="ModelValue_3" name="kTGFbOff" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_4" name="kTGFbRIntern" simulationType="fixed" addNoise="false" initial_value="0.33">
      </ModelValue>
      <ModelValue key="ModelValue_5" name="kTGFbRRecyc" simulationType="fixed" addNoise="false" initial_value="0.033">
      </ModelValue>
      <ModelValue key="ModelValue_6" name="kSmad2Phos_km" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_7" name="_kSmad2Phos_kcat" simulationType="fixed" addNoise="false" initial_value="0.1">
      </ModelValue>
      <ModelValue key="ModelValue_8" name="kSmad2Dephos_km" simulationType="fixed" addNoise="false" initial_value="60.0">
      </ModelValue>
      <ModelValue key="ModelValue_9" name="kSmad2Dephos_Vmax" simulationType="fixed" addNoise="false" initial_value="65.0">
      </ModelValue>
      <ModelValue key="ModelValue_10" name="GrowthFactors" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_11" name="kRafPhos_km" simulationType="fixed" addNoise="false" initial_value="10.0">
      </ModelValue>
      <ModelValue key="ModelValue_12" name="kRafPhos_ki" simulationType="fixed" addNoise="false" initial_value="3.5">
      </ModelValue>
      <ModelValue key="ModelValue_13" name="kRafPhos_Vmax" simulationType="fixed" addNoise="false" initial_value="9000.0">
      </ModelValue>
      <ModelValue key="ModelValue_14" name="kRafPhos_n" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_15" name="kRafDephos_km" simulationType="fixed" addNoise="false" initial_value="8.0">
      </ModelValue>
      <ModelValue key="ModelValue_16" name="kRafDephosVmax" simulationType="fixed" addNoise="false" initial_value="3602.5">
      </ModelValue>
      <ModelValue key="ModelValue_17" name="kMekPhos_km1" simulationType="fixed" addNoise="false" initial_value="15.0">
      </ModelValue>
      <ModelValue key="ModelValue_18" name="_kMekPhos_ki" simulationType="fixed" addNoise="false" initial_value="0.25">
      </ModelValue>
      <ModelValue key="ModelValue_19" name="kMekPhos_kcat" simulationType="fixed" addNoise="false" initial_value="90.0">
      </ModelValue>
      <ModelValue key="ModelValue_20" name="AZD" simulationType="fixed" addNoise="false" initial_value="0.0">
      </ModelValue>
      <ModelValue key="ModelValue_21" name="kMekDephos_km" simulationType="fixed" addNoise="false" initial_value="15.0">
      </ModelValue>
      <ModelValue key="ModelValue_22" name="kMekDephos_Vmax" simulationType="fixed" addNoise="false" initial_value="2700.0">
      </ModelValue>
      <ModelValue key="ModelValue_23" name="kErkPhos_km1" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_24" name="kErkPhos_kcat" simulationType="fixed" addNoise="false" initial_value="200.0">
      </ModelValue>
      <ModelValue key="ModelValue_25" name="kErkDephos_km" simulationType="fixed" addNoise="false" initial_value="15.0">
      </ModelValue>
      <ModelValue key="ModelValue_26" name="kErkDephos_Vmax" simulationType="fixed" addNoise="false" initial_value="1800.0">
      </ModelValue>
      <ModelValue key="ModelValue_27" name="_kPI3KPhosByGF" simulationType="fixed" addNoise="false" initial_value="0.239474698704283">
      </ModelValue>
      <ModelValue key="ModelValue_28" name="_kPI3KDephosByS6K" simulationType="fixed" addNoise="false" initial_value="25.0">
      </ModelValue>
      <ModelValue key="ModelValue_29" name="kAktPhos_km" simulationType="fixed" addNoise="false" initial_value="12.5">
      </ModelValue>
      <ModelValue key="ModelValue_30" name="_kAktPhos_ki" simulationType="fixed" addNoise="false" initial_value="0.01">
      </ModelValue>
      <ModelValue key="ModelValue_31" name="_kAktPhos_kcat" simulationType="fixed" addNoise="false" initial_value="1.5">
      </ModelValue>
      <ModelValue key="ModelValue_32" name="MK2206" simulationType="fixed" addNoise="false" initial_value="0.0">
      </ModelValue>
      <ModelValue key="ModelValue_33" name="kAktDephos_km" simulationType="fixed" addNoise="false" initial_value="15.0">
      </ModelValue>
      <ModelValue key="ModelValue_34" name="kAktDephos_Vmax" simulationType="fixed" addNoise="false" initial_value="30.0">
      </ModelValue>
      <ModelValue key="ModelValue_35" name="kmTORC1Phos_km" simulationType="fixed" addNoise="false" initial_value="3.0">
      </ModelValue>
      <ModelValue key="ModelValue_36" name="_kmTORC1Phos_ki" simulationType="fixed" addNoise="false" initial_value="0.001">
      </ModelValue>
      <ModelValue key="ModelValue_37" name="_kmTORC1Phos_kcat" simulationType="fixed" addNoise="false" initial_value="0.35">
      </ModelValue>
      <ModelValue key="ModelValue_38" name="Everolimus" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_39" name="_kmTORCPhosBasal_Vmax" simulationType="fixed" addNoise="false" initial_value="0.1">
      </ModelValue>
      <ModelValue key="ModelValue_40" name="_kmTORCPhosBasal_km" simulationType="fixed" addNoise="false" initial_value="0.1">
      </ModelValue>
      <ModelValue key="ModelValue_41" name="kmTORC1Dephos_km" simulationType="fixed" addNoise="false" initial_value="100.0">
      </ModelValue>
      <ModelValue key="ModelValue_42" name="_kmTORC1Dephos_Vmax" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_43" name="kS6KPhosBymTORC1_km" simulationType="fixed" addNoise="false" initial_value="100.0">
      </ModelValue>
      <ModelValue key="ModelValue_44" name="_kS6KPhosBymTORC1_kcat" simulationType="fixed" addNoise="false" initial_value="0.5">
      </ModelValue>
      <ModelValue key="ModelValue_45" name="kS6KDephos_km" simulationType="fixed" addNoise="false" initial_value="10.0">
      </ModelValue>
      <ModelValue key="ModelValue_46" name="kS6KDephos_Vmax" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_47" name="kRafPhosByTGFbR_km" simulationType="fixed" addNoise="false" initial_value="25.0">
      </ModelValue>
      <ModelValue key="ModelValue_48" name="_kRafPhosByTGFbR_kcat" simulationType="fixed" addNoise="false" initial_value="265.0">
      </ModelValue>
      <ModelValue key="ModelValue_49" name="kRafPhosByPI3K_km" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_50" name="_kRafPhosByPI3K_kcat" simulationType="fixed" addNoise="false" initial_value="5.0">
      </ModelValue>
      <ModelValue key="ModelValue_51" name="kPI3KPhosByTGFbR_km" simulationType="fixed" addNoise="false" initial_value="10.0">
      </ModelValue>
      <ModelValue key="ModelValue_52" name="_kPI3KPhosByTGFbR_kcat" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_53" name="_kPI3KDephosByErk" simulationType="fixed" addNoise="false" initial_value="0.5">
      </ModelValue>
      <ModelValue key="ModelValue_54" name="kSmad2PhosByAkt_km" simulationType="fixed" addNoise="false" initial_value="40.0">
      </ModelValue>
      <ModelValue key="ModelValue_55" name="kSmad2PhosByAkt_kcat" simulationType="fixed" addNoise="false" initial_value="0.1">
      </ModelValue>
      <ModelValue key="ModelValue_56" name="kSmad2DephosByErk_km" simulationType="fixed" addNoise="false" initial_value="30.0">
      </ModelValue>
      <ModelValue key="ModelValue_57" name="kSmad2DephosByErk_kcat" simulationType="fixed" addNoise="false" initial_value="7.5">
      </ModelValue>
    </ListOfModelValues>
    <ListOfReactions>
      <Reaction key="Reaction_0" name="TGF_R1" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5003" name="TGFb" value="0.005"/>
          <Constant key="Parameter_5002" name="_kTGFbOn" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_48" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_299">
              <SourceParameter reference="ModelValue_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_300">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="TGF_R2" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5001" name="k1" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
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
      <Reaction key="Reaction_2" name="TGF_R3" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5000" name="k1" value="0.33"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_3" name="TGF_R4" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4999" name="k1" value="0.033"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_4" name="TGF_R5" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4998" name="k1" value="0.33"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_5" name="TGF_R6" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4997" name="k1" value="0.033"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
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
      <Reaction key="Reaction_6" name="TGF_R8" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4996" name="_kSmad2Phos_kcat" value="0.1"/>
          <Constant key="Parameter_4995" name="kSmad2Phos_km" value="50"/>
        </ListOfConstants>
        <KineticLaw function="Function_49" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_316">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_317">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_318">
              <SourceParameter reference="ModelValue_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_319">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="TGF_R9" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4994" name="kSmad2Dephos_Vmax" value="65"/>
          <Constant key="Parameter_4993" name="kSmad2Dephos_km" value="60"/>
        </ListOfConstants>
        <KineticLaw function="Function_50" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_314">
              <SourceParameter reference="ModelValue_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_324">
              <SourceParameter reference="ModelValue_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_325">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="MAPK_R0" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4992" name="GrowthFactors" value="1"/>
          <Constant key="Parameter_4991" name="kRafPhos_Vmax" value="9000"/>
          <Constant key="Parameter_4990" name="kRafPhos_ki" value="3.5"/>
          <Constant key="Parameter_4989" name="kRafPhos_km" value="10"/>
          <Constant key="Parameter_4988" name="kRafPhos_n" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_51" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_333">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_334">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_335">
              <SourceParameter reference="ModelValue_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_336">
              <SourceParameter reference="ModelValue_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_337">
              <SourceParameter reference="ModelValue_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_338">
              <SourceParameter reference="ModelValue_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_339">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="MAPK_R1" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4987" name="kRafDephosVmax" value="3602.5"/>
          <Constant key="Parameter_4986" name="kRafDephos_km" value="8"/>
        </ListOfConstants>
        <KineticLaw function="Function_52" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_315">
              <SourceParameter reference="ModelValue_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_329">
              <SourceParameter reference="ModelValue_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_332">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="MAPK_R2" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4985" name="AZD" value="0"/>
          <Constant key="Parameter_4984" name="_kMekPhos_ki" value="0.25"/>
          <Constant key="Parameter_4983" name="kMekPhos_kcat" value="90"/>
          <Constant key="Parameter_4982" name="kMekPhos_km1" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_53" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_352">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_353">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_354">
              <SourceParameter reference="ModelValue_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_355">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_356">
              <SourceParameter reference="ModelValue_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_357">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="MAPK_R3" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4981" name="AZD" value="0"/>
          <Constant key="Parameter_4980" name="_kMekPhos_ki" value="0.25"/>
          <Constant key="Parameter_4979" name="kMekPhos_kcat" value="90"/>
          <Constant key="Parameter_4978" name="kMekPhos_km1" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_54" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_364">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_365">
              <SourceParameter reference="ModelValue_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_366">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_367">
              <SourceParameter reference="ModelValue_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_368">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_369">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="MAPK_R4" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4977" name="kMekDephos_Vmax" value="2700"/>
          <Constant key="Parameter_4976" name="kMekDephos_km" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_55" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_313">
              <SourceParameter reference="ModelValue_22"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_350">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_331">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="MAPK_R5" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4975" name="kMekDephos_Vmax" value="2700"/>
          <Constant key="Parameter_4974" name="kMekDephos_km" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_56" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_379">
              <SourceParameter reference="ModelValue_22"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_380">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_381">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="MAPK_R6" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4973" name="kErkPhos_kcat" value="200"/>
          <Constant key="Parameter_4972" name="kErkPhos_km1" value="50"/>
        </ListOfConstants>
        <KineticLaw function="Function_57" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_386">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_387">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_388">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_389">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="MAPK_R7" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4971" name="kErkPhos_kcat" value="200"/>
          <Constant key="Parameter_4970" name="kErkPhos_km1" value="50"/>
        </ListOfConstants>
        <KineticLaw function="Function_58" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_394">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_395">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_396">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_397">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="MAPK_R8" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4969" name="kErkDephos_Vmax" value="1800"/>
          <Constant key="Parameter_4968" name="kErkDephos_km" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_59" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_349">
              <SourceParameter reference="ModelValue_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_402">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_403">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_17" name="MAPK_R9" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4967" name="kErkDephos_Vmax" value="1800"/>
          <Constant key="Parameter_4966" name="kErkDephos_km" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_60" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_407">
              <SourceParameter reference="ModelValue_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_408">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_409">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_18" name="PI3K_R1" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4965" name="GrowthFactors" value="1"/>
          <Constant key="Parameter_4964" name="_kPI3KPhosByGF" value="0.239475"/>
        </ListOfConstants>
        <KineticLaw function="Function_61" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_413">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_414">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_415">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_19" name="PI3K_R2" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4963" name="_kPI3KDephosByS6K" value="25"/>
        </ListOfConstants>
        <KineticLaw function="Function_62" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_419">
              <SourceParameter reference="ModelValue_28"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_420">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_421">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_20" name="PI3K_R3" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4962" name="MK2206" value="0"/>
          <Constant key="Parameter_4961" name="_kAktPhos_kcat" value="1.5"/>
          <Constant key="Parameter_4960" name="_kAktPhos_ki" value="0.01"/>
          <Constant key="Parameter_4959" name="kAktPhos_km" value="12.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_63" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_428">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_429">
              <SourceParameter reference="ModelValue_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_430">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_431">
              <SourceParameter reference="ModelValue_30"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_432">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_433">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_21" name="PI3K_R4" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4958" name="kAktDephos_Vmax" value="30"/>
          <Constant key="Parameter_4957" name="kAktDephos_km" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_64" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_351">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_426">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_330">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="PI3K_R5_1" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4956" name="Everolimus" value="1"/>
          <Constant key="Parameter_4955" name="_kmTORC1Phos_kcat" value="0.35"/>
          <Constant key="Parameter_4954" name="_kmTORC1Phos_ki" value="0.001"/>
          <Constant key="Parameter_4953" name="kmTORC1Phos_km" value="3"/>
        </ListOfConstants>
        <KineticLaw function="Function_65" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_446">
              <SourceParameter reference="ModelValue_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_447">
              <SourceParameter reference="ModelValue_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_448">
              <SourceParameter reference="ModelValue_36"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_449">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_450">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_451">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_23" name="PI3K_R5_2" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4952" name="Everolimus" value="1"/>
          <Constant key="Parameter_4951" name="_kmTORC1Phos_ki" value="0.001"/>
          <Constant key="Parameter_4950" name="_kmTORCPhosBasal_Vmax" value="0.1"/>
          <Constant key="Parameter_4949" name="_kmTORCPhosBasal_km" value="0.1"/>
        </ListOfConstants>
        <KineticLaw function="Function_66" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_444">
              <SourceParameter reference="ModelValue_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_458">
              <SourceParameter reference="ModelValue_36"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_459">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_460">
              <SourceParameter reference="ModelValue_40"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_461">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_24" name="PI3K_R6" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4948" name="_kmTORC1Dephos_Vmax" value="1"/>
          <Constant key="Parameter_4947" name="kmTORC1Dephos_km" value="100"/>
        </ListOfConstants>
        <KineticLaw function="Function_67" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_425">
              <SourceParameter reference="ModelValue_42"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_445">
              <SourceParameter reference="ModelValue_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_467">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_25" name="PI3K_R7" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4946" name="_kS6KPhosBymTORC1_kcat" value="0.5"/>
          <Constant key="Parameter_4945" name="kS6KPhosBymTORC1_km" value="100"/>
        </ListOfConstants>
        <KineticLaw function="Function_68" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_472">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_473">
              <SourceParameter reference="ModelValue_44"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_474">
              <SourceParameter reference="ModelValue_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_475">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_26" name="PI3K_R8" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4944" name="kS6KDephos_Vmax" value="50"/>
          <Constant key="Parameter_4943" name="kS6KDephos_km" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_69" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_385">
              <SourceParameter reference="ModelValue_46"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_480">
              <SourceParameter reference="ModelValue_45"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_481">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_27" name="CrossTalkR1" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4942" name="_kRafPhosByTGFbR_kcat" value="265"/>
          <Constant key="Parameter_4941" name="kRafPhosByTGFbR_km" value="25"/>
        </ListOfConstants>
        <KineticLaw function="Function_70" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_486">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_487">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_488">
              <SourceParameter reference="ModelValue_48"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_489">
              <SourceParameter reference="ModelValue_47"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_28" name="CrossTalkR2" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4940" name="_kRafPhosByPI3K_kcat" value="5"/>
          <Constant key="Parameter_4939" name="kRafPhosByPI3K_km" value="50"/>
        </ListOfConstants>
        <KineticLaw function="Function_71" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_494">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_495">
              <SourceParameter reference="ModelValue_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_496">
              <SourceParameter reference="ModelValue_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_497">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_29" name="CrossTalkR3" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4938" name="_kPI3KPhosByTGFbR_kcat" value="50"/>
          <Constant key="Parameter_4937" name="kPI3KPhosByTGFbR_km" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_72" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_502">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_503">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_504">
              <SourceParameter reference="ModelValue_52"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_505">
              <SourceParameter reference="ModelValue_51"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_30" name="CrossTalkR4" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4936" name="_kPI3KDephosByErk" value="0.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_73" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_485">
              <SourceParameter reference="ModelValue_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_510">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_511">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_31" name="CrossTalkR5" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4935" name="kSmad2PhosByAkt_kcat" value="0.1"/>
          <Constant key="Parameter_4934" name="kSmad2PhosByAkt_km" value="40"/>
        </ListOfConstants>
        <KineticLaw function="Function_74" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_516">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_517">
              <SourceParameter reference="ModelValue_55"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_518">
              <SourceParameter reference="ModelValue_54"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_519">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_32" name="CrossTalkR6" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4933" name="kSmad2DephosByErk_kcat" value="7.5"/>
          <Constant key="Parameter_4932" name="kSmad2DephosByErk_km" value="30"/>
        </ListOfConstants>
        <KineticLaw function="Function_75" unitType="Default" scalingCompartment="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_524">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_525">
              <SourceParameter reference="ModelValue_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_526">
              <SourceParameter reference="ModelValue_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_527">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfEvents>
      <Event key="Event_0" name="SerumStarveRemoveTGFb" delayAssignment="true" fireAtInitialTime="0" persistentTrigger="1">
        <TriggerExpression>
          &lt;CN=Root,Model=CrossTalkModel,Reference=Time&gt; gt 70.25
        </TriggerExpression>
        <DelayExpression>
          0
        </DelayExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_2">
            <Expression>
              0
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_1" name="SerumStarveRemoveGrowthFactors" delayAssignment="true" fireAtInitialTime="0" persistentTrigger="1">
        <TriggerExpression>
          &lt;CN=Root,Model=CrossTalkModel,Reference=Time&gt; gt 70.25
        </TriggerExpression>
        <DelayExpression>
          0
        </DelayExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_10">
            <Expression>
              0
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_2" name="AddTGFb" delayAssignment="true" fireAtInitialTime="0" persistentTrigger="1">
        <TriggerExpression>
          &lt;CN=Root,Model=CrossTalkModel,Reference=Time&gt; gt 71.25
        </TriggerExpression>
        <DelayExpression>
          0
        </DelayExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_2">
            <Expression>
              1
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_3" name="AddAZD" delayAssignment="true" fireAtInitialTime="0" persistentTrigger="1">
        <TriggerExpression>
          &lt;CN=Root,Model=CrossTalkModel,Reference=Time&gt; gt 24
        </TriggerExpression>
        <DelayExpression>
          0
        </DelayExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_20">
            <Expression>
              1
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
    </ListOfEvents>
    <ListOfModelParameterSets activeSet="ModelParameterSet_1">
      <ModelParameterSet key="ModelParameterSet_1" name="Initial State">
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=CrossTalkModel" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR]" value="46273944241830288" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_a]" value="582171684778969.5" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_EE]" value="7557984064814293" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_Cav]" value="5821716847789695" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Smad2]" value="29916735762944100" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2]" value="301446136082777" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Mek]" value="1.5228567762895856e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pMek]" value="33762689754202348" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Erk]" value="1.1040507301812789e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pErk]" value="70990349477934496" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[PI3K]" value="60197511655087616" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pPI3K]" value="23906244912320.023" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Akt]" value="59868063199575336" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt]" value="353354698618055.75" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[mTORC1]" value="54363353124623936" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pmTORC1]" value="5858064775376091" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[S6K]" value="54504590279959088" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K]" value="5716827620643109" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Raf]" value="52954255562812696" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pRaf]" value="7267162338328442" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppMek]" value="17481983859999028" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk]" value="25947158987048860" type="Species" simulationType="reactions"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[Smad2Tot]" value="50.178463000000001" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kTGFbOn]" value="0.10000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb]" value="0.0050000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbOff]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbRIntern]" value="0.33000000000000002" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbRRecyc]" value="0.033000000000000002" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Phos_km]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kSmad2Phos_kcat]" value="0.10000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Dephos_km]" value="60" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Dephos_Vmax]" value="65" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_km]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_ki]" value="3.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_Vmax]" value="9000" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_n]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafDephos_km]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafDephosVmax]" value="3602.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kMekPhos_km1]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kMekPhos_ki]" value="0.25" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kMekPhos_kcat]" value="90" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[AZD]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kMekDephos_km]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kMekDephos_Vmax]" value="2700" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kErkPhos_km1]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kErkPhos_kcat]" value="200" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kErkDephos_km]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kErkDephos_Vmax]" value="1800" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KPhosByGF]" value="0.23947469870428301" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KDephosByS6K]" value="25" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kAktPhos_km]" value="12.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kAktPhos_ki]" value="0.01" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kAktPhos_kcat]" value="1.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kAktDephos_km]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kAktDephos_Vmax]" value="30" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kmTORC1Phos_km]" value="3" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_ki]" value="0.001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_kcat]" value="0.34999999999999998" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORCPhosBasal_Vmax]" value="0.10000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORCPhosBasal_km]" value="0.10000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kmTORC1Dephos_km]" value="100" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Dephos_Vmax]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kS6KPhosBymTORC1_km]" value="100" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kS6KPhosBymTORC1_kcat]" value="0.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kS6KDephos_km]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kS6KDephos_Vmax]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhosByTGFbR_km]" value="25" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kRafPhosByTGFbR_kcat]" value="265" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhosByPI3K_km]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kRafPhosByPI3K_kcat]" value="5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kPI3KPhosByTGFbR_km]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KPhosByTGFbR_kcat]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KDephosByErk]" value="0.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2PhosByAkt_km]" value="40" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2PhosByAkt_kcat]" value="0.10000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2DephosByErk_km]" value="30" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2DephosByErk_kcat]" value="7.5" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R1],ParameterGroup=Parameters,Parameter=TGFb" value="0.0050000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R1],ParameterGroup=Parameters,Parameter=_kTGFbOn" value="0.10000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kTGFbOn],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R2],ParameterGroup=Parameters,Parameter=k1" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbOff],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R3],ParameterGroup=Parameters,Parameter=k1" value="0.33000000000000002" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbRIntern],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R4]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R4],ParameterGroup=Parameters,Parameter=k1" value="0.033000000000000002" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbRRecyc],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R5]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R5],ParameterGroup=Parameters,Parameter=k1" value="0.33000000000000002" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbRIntern],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R6]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R6],ParameterGroup=Parameters,Parameter=k1" value="0.033000000000000002" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbRRecyc],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R8]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R8],ParameterGroup=Parameters,Parameter=_kSmad2Phos_kcat" value="0.10000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kSmad2Phos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R8],ParameterGroup=Parameters,Parameter=kSmad2Phos_km" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Phos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R9]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R9],ParameterGroup=Parameters,Parameter=kSmad2Dephos_Vmax" value="65" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Dephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[TGF_R9],ParameterGroup=Parameters,Parameter=kSmad2Dephos_km" value="60" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Dephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R0]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=GrowthFactors" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=kRafPhos_Vmax" value="9000" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=kRafPhos_ki" value="3.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=kRafPhos_km" value="10" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=kRafPhos_n" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_n],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R1],ParameterGroup=Parameters,Parameter=kRafDephosVmax" value="3602.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kRafDephosVmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R1],ParameterGroup=Parameters,Parameter=kRafDephos_km" value="8" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kRafDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R2],ParameterGroup=Parameters,Parameter=AZD" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R2],ParameterGroup=Parameters,Parameter=_kMekPhos_ki" value="0.25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kMekPhos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R2],ParameterGroup=Parameters,Parameter=kMekPhos_kcat" value="90" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kMekPhos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R2],ParameterGroup=Parameters,Parameter=kMekPhos_km1" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kMekPhos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R3],ParameterGroup=Parameters,Parameter=AZD" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R3],ParameterGroup=Parameters,Parameter=_kMekPhos_ki" value="0.25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kMekPhos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R3],ParameterGroup=Parameters,Parameter=kMekPhos_kcat" value="90" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kMekPhos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R3],ParameterGroup=Parameters,Parameter=kMekPhos_km1" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kMekPhos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R4]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R4],ParameterGroup=Parameters,Parameter=kMekDephos_Vmax" value="2700" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kMekDephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R4],ParameterGroup=Parameters,Parameter=kMekDephos_km" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kMekDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R5]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R5],ParameterGroup=Parameters,Parameter=kMekDephos_Vmax" value="2700" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kMekDephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R5],ParameterGroup=Parameters,Parameter=kMekDephos_km" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kMekDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R6]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R6],ParameterGroup=Parameters,Parameter=kErkPhos_kcat" value="200" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kErkPhos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R6],ParameterGroup=Parameters,Parameter=kErkPhos_km1" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kErkPhos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R7]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R7],ParameterGroup=Parameters,Parameter=kErkPhos_kcat" value="200" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kErkPhos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R7],ParameterGroup=Parameters,Parameter=kErkPhos_km1" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kErkPhos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R8]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R8],ParameterGroup=Parameters,Parameter=kErkDephos_Vmax" value="1800" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kErkDephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R8],ParameterGroup=Parameters,Parameter=kErkDephos_km" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kErkDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R9]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R9],ParameterGroup=Parameters,Parameter=kErkDephos_Vmax" value="1800" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kErkDephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[MAPK_R9],ParameterGroup=Parameters,Parameter=kErkDephos_km" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kErkDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R1],ParameterGroup=Parameters,Parameter=GrowthFactors" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R1],ParameterGroup=Parameters,Parameter=_kPI3KPhosByGF" value="0.23947469870428301" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KPhosByGF],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R2],ParameterGroup=Parameters,Parameter=_kPI3KDephosByS6K" value="25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KDephosByS6K],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R3],ParameterGroup=Parameters,Parameter=MK2206" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R3],ParameterGroup=Parameters,Parameter=_kAktPhos_kcat" value="1.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kAktPhos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R3],ParameterGroup=Parameters,Parameter=_kAktPhos_ki" value="0.01" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kAktPhos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R3],ParameterGroup=Parameters,Parameter=kAktPhos_km" value="12.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kAktPhos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R4]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R4],ParameterGroup=Parameters,Parameter=kAktDephos_Vmax" value="30" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kAktDephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R4],ParameterGroup=Parameters,Parameter=kAktDephos_km" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kAktDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_1],ParameterGroup=Parameters,Parameter=Everolimus" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_1],ParameterGroup=Parameters,Parameter=_kmTORC1Phos_kcat" value="0.34999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_1],ParameterGroup=Parameters,Parameter=_kmTORC1Phos_ki" value="0.001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_1],ParameterGroup=Parameters,Parameter=kmTORC1Phos_km" value="3" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kmTORC1Phos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_2],ParameterGroup=Parameters,Parameter=Everolimus" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_2],ParameterGroup=Parameters,Parameter=_kmTORC1Phos_ki" value="0.001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_2],ParameterGroup=Parameters,Parameter=_kmTORCPhosBasal_Vmax" value="0.10000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORCPhosBasal_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R5_2],ParameterGroup=Parameters,Parameter=_kmTORCPhosBasal_km" value="0.10000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORCPhosBasal_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R6]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R6],ParameterGroup=Parameters,Parameter=_kmTORC1Dephos_Vmax" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Dephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R6],ParameterGroup=Parameters,Parameter=kmTORC1Dephos_km" value="100" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kmTORC1Dephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R7]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R7],ParameterGroup=Parameters,Parameter=_kS6KPhosBymTORC1_kcat" value="0.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kS6KPhosBymTORC1_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R7],ParameterGroup=Parameters,Parameter=kS6KPhosBymTORC1_km" value="100" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kS6KPhosBymTORC1_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R8]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R8],ParameterGroup=Parameters,Parameter=kS6KDephos_Vmax" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kS6KDephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[PI3K_R8],ParameterGroup=Parameters,Parameter=kS6KDephos_km" value="10" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kS6KDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR1],ParameterGroup=Parameters,Parameter=_kRafPhosByTGFbR_kcat" value="265" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kRafPhosByTGFbR_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR1],ParameterGroup=Parameters,Parameter=kRafPhosByTGFbR_km" value="25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhosByTGFbR_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR2],ParameterGroup=Parameters,Parameter=_kRafPhosByPI3K_kcat" value="5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kRafPhosByPI3K_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR2],ParameterGroup=Parameters,Parameter=kRafPhosByPI3K_km" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhosByPI3K_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR3],ParameterGroup=Parameters,Parameter=_kPI3KPhosByTGFbR_kcat" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KPhosByTGFbR_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR3],ParameterGroup=Parameters,Parameter=kPI3KPhosByTGFbR_km" value="10" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kPI3KPhosByTGFbR_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR4]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR4],ParameterGroup=Parameters,Parameter=_kPI3KDephosByErk" value="0.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KDephosByErk],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR5]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR5],ParameterGroup=Parameters,Parameter=kSmad2PhosByAkt_kcat" value="0.10000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2PhosByAkt_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR5],ParameterGroup=Parameters,Parameter=kSmad2PhosByAkt_km" value="40" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2PhosByAkt_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR6]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR6],ParameterGroup=Parameters,Parameter=kSmad2DephosByErk_kcat" value="7.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2DephosByErk_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=CrossTalkModel,Vector=Reactions[CrossTalkR6],ParameterGroup=Parameters,Parameter=kSmad2DephosByErk_km" value="30" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2DephosByErk_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_1"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Metabolite_18"/>
      <StateTemplateVariable objectReference="Metabolite_14"/>
      <StateTemplateVariable objectReference="Metabolite_12"/>
      <StateTemplateVariable objectReference="Metabolite_16"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_15"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="Metabolite_17"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Metabolite_20"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_19"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_21"/>
      <StateTemplateVariable objectReference="ModelValue_0"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
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
      <StateTemplateVariable objectReference="ModelValue_32"/>
      <StateTemplateVariable objectReference="ModelValue_33"/>
      <StateTemplateVariable objectReference="ModelValue_34"/>
      <StateTemplateVariable objectReference="ModelValue_35"/>
      <StateTemplateVariable objectReference="ModelValue_36"/>
      <StateTemplateVariable objectReference="ModelValue_37"/>
      <StateTemplateVariable objectReference="ModelValue_38"/>
      <StateTemplateVariable objectReference="ModelValue_39"/>
      <StateTemplateVariable objectReference="ModelValue_40"/>
      <StateTemplateVariable objectReference="ModelValue_41"/>
      <StateTemplateVariable objectReference="ModelValue_42"/>
      <StateTemplateVariable objectReference="ModelValue_43"/>
      <StateTemplateVariable objectReference="ModelValue_44"/>
      <StateTemplateVariable objectReference="ModelValue_45"/>
      <StateTemplateVariable objectReference="ModelValue_46"/>
      <StateTemplateVariable objectReference="ModelValue_47"/>
      <StateTemplateVariable objectReference="ModelValue_48"/>
      <StateTemplateVariable objectReference="ModelValue_49"/>
      <StateTemplateVariable objectReference="ModelValue_50"/>
      <StateTemplateVariable objectReference="ModelValue_51"/>
      <StateTemplateVariable objectReference="ModelValue_52"/>
      <StateTemplateVariable objectReference="ModelValue_53"/>
      <StateTemplateVariable objectReference="ModelValue_54"/>
      <StateTemplateVariable objectReference="ModelValue_55"/>
      <StateTemplateVariable objectReference="ModelValue_56"/>
      <StateTemplateVariable objectReference="ModelValue_57"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 582171684778969.5 29916735762944100 33762689754202348 70990349477934496 60197511655087616 52954255562812696 54363353124623936 59868063199575336 54504590279959088 5821716847789695 1.5228567762895856e+17 1.1040507301812789e+17 7557984064814293 5858064775376091 46273944241830288 5716827620643109 353354698618055.75 17481983859999028 301446136082777 7267162338328442 23906244912320.023 25947158987048860 50.178463000000001 1 0.10000000000000001 0.0050000000000000001 1 0.33000000000000002 0.033000000000000002 50 0.10000000000000001 60 65 1 10 3.5 9000 1 8 3602.5 15 0.25 90 0 15 2700 50 200 15 1800 0.23947469870428301 25 12.5 0.01 1.5 0 15 30 3 0.001 0.34999999999999998 1 0.10000000000000001 0.10000000000000001 100 1 100 0.5 10 50 25 265 50 5 10 50 0.5 40 0.10000000000000001 30 7.5 
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
    <Task key="Task_100" name="Time-Course" scheduled="false" type="timeCourse" update_model="false">
      <Report append="0" confirmOverwrite="0" reference="Report_30" target="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/CopasiModelFiles/E_A_48/TimeCourseData.txt"/>
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="720"/>
        <Parameter name="StepSize" type="float" value="0.1"/>
        <Parameter name="Duration" type="float" value="72"/>
        <Parameter name="TimeSeriesRequested" type="float" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-06"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-12"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_16" name="Scan" type="scan" scheduled="true" updateModel="0">
      <Report append="0" confirmOverwrite="0" reference="Report_87" target="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/CopasiModelFiles/E_A_48/MultipleParameterEstimationResults/PEData5.txt"/>
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="5"/>
        <ParameterGroup name="ScanItems">
        <ParameterGroup name="ScanItem"><Parameter name="Number of steps" type="unsignedInteger" value="1"/><Parameter name="Type" type="unsignedInteger" value="0"/><Parameter name="Object" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR],Reference=InitialConcentration"/></ParameterGroup></ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="0"/>
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
    <Task key="Task_19" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="0">
      <Report reference="Report_32" target="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/CopasiModelFiles/E_A_48/PEData.txt" append="0" confirmOverwrite="0"/>
      <Problem>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="1"/>
        <Parameter name="Calculate Statistics" type="bool" value="0"/>
        <ParameterGroup name="OptimizationItemList">
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kAktPhos_kcat],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kAktPhos_ki],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kMekPhos_ki],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KDephosByErk],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KDephosByS6K],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KPhosByGF],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KPhosByTGFbR_kcat],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kRafPhosByPI3K_kcat],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kRafPhosByTGFbR_kcat],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kS6KPhosBymTORC1_kcat],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kSmad2Phos_kcat],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kTGFbOn],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Dephos_Vmax],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_kcat],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_ki],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORCPhosBasal_Vmax],Reference=InitialValue"/>
          </ParameterGroup>
          <ParameterGroup name="FitItem">
            <ParameterGroup name="Affected Cross Validation Experiments"/>
            <ParameterGroup name="Affected Experiments"/>
            <Parameter name="LowerBound" type="cn" value="0.001"/>
            <Parameter name="UpperBound" type="cn" value="1000"/>
            <Parameter name="ObjectCN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORCPhosBasal_km],Reference=InitialValue"/>
          </ParameterGroup>
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
        <Parameter name="Steady-State" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <Parameter name="Time-Course" type="cn" value="CN=Root,Vector=TaskList[Time-Course]"/>
        <Parameter name="Create Parameter Sets" type="bool" value="0"/>
        <ParameterGroup name="Experiment Set">
          <ParameterGroup name="Experiment_18">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E_M_24.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_18"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_17">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/A_24.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_17"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_16">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_16"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_15">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E_A_24.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_15"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_14">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E_A_1.25.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_14"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_13">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/A_1.25.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_13"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_12">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/M_72.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_12"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_11">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/M_1.25.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_11"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_10">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E_M_48.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_10"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_9">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/A_48.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_9"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_8">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/D.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_8"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_7">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E_A_72.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_7"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_6">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E_M_72.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_6"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_5">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/A_72.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_5"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_4">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/M_24.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_4"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_3">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E_A_48.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_3"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_2">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/E_M_1.25.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_2"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_1">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/T.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_1"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
          <ParameterGroup name="Experiment_0">
            <Parameter name="Data is Row Oriented" type="bool" value="1"/>
            <Parameter name="Experiment Type" type="unsignedInteger" value="1"/>
            <Parameter name="File Name" type="file" value="/home/ncw135/Documents/MesiSTRAT/CrossTalkModel/data/CopasiDataFiles/M_48.csv"/>
            <Parameter name="First Row" type="unsignedInteger" value="1"/>
            <Parameter name="Key" type="key" value="Experiment_0"/>
            <Parameter name="Last Row" type="unsignedInteger" value="8"/>
            <Parameter name="Normalize Weights per Experiment" type="bool" value="1"/>
            <Parameter name="Number of Columns" type="unsignedInteger" value="10"/>
            <ParameterGroup name="Object Map">
              <ParameterGroup name="0">
                <Parameter name="Role" type="unsignedInteger" value="3"/>
              </ParameterGroup>
              <ParameterGroup name="1">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="2">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="3">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="4">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
                <Parameter name="Role" type="unsignedInteger" value="2"/>
              </ParameterGroup>
              <ParameterGroup name="5">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="6">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="7">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="8">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
              <ParameterGroup name="9">
                <Parameter name="Object CN" type="cn" value="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=InitialValue"/>
                <Parameter name="Role" type="unsignedInteger" value="1"/>
              </ParameterGroup>
            </ParameterGroup>
            <Parameter name="Row containing Names" type="unsignedInteger" value="1"/>
            <Parameter name="separator" type="string" value="&#9;"/>
            <Parameter name="Weight Method" type="unsignedInteger" value="1"/>
          </ParameterGroup>
        </ParameterGroup>
        <ParameterGroup name="Validation Set">
          <Parameter name="Weight" type="unsignedFloat" value="1"/>
          <Parameter name="Threshold" type="unsignedInteger" value="5"/>
        </ParameterGroup>
      </Problem>
      <Method name="Genetic Algorithm" type="GeneticAlgorithm">
        <Parameter name="Number of Generations" type="unsignedInteger" value="500"/>
        <Parameter name="Population Size" type="unsignedInteger" value="50"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
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
    <Report key="Report_30" name="Time-Course" precision="6" separator="&#9;" taskType="Time-Course">
      <Comment/>
      <Table printTitle="1">
        <Object cn="CN=Root,Model=CrossTalkModel,Reference=Time"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_a],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_EE],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_Cav],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Smad2],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Mek],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pMek],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Erk],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pErk],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[PI3K],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pPI3K],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Akt],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[mTORC1],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pmTORC1],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[S6K],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[Raf],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[pRaf],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppMek],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[Smad2Tot],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kTGFbOn],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[TGFb],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbOff],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbRIntern],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kTGFbRRecyc],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Phos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kSmad2Phos_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Dephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2Dephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[GrowthFactors],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_ki],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhos_n],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafDephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafDephosVmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kMekPhos_km1],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kMekPhos_ki],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kMekPhos_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[AZD],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kMekDephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kMekDephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kErkPhos_km1],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kErkPhos_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kErkDephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kErkDephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KPhosByGF],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KDephosByS6K],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kAktPhos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kAktPhos_ki],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kAktPhos_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[MK2206],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kAktDephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kAktDephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kmTORC1Phos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_ki],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Phos_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[Everolimus],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORCPhosBasal_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORCPhosBasal_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kmTORC1Dephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kmTORC1Dephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kS6KPhosBymTORC1_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kS6KPhosBymTORC1_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kS6KDephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kS6KDephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhosByTGFbR_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kRafPhosByTGFbR_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kRafPhosByPI3K_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kRafPhosByPI3K_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kPI3KPhosByTGFbR_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KPhosByTGFbR_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[_kPI3KDephosByErk],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2PhosByAkt_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2PhosByAkt_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2DephosByErk_km],Reference=Value"/>
        <Object cn="CN=Root,Model=CrossTalkModel,Vector=Values[kSmad2DephosByErk_kcat],Reference=Value"/>
      </Table>
    </Report>
    <Report precision="6" separator="&#9;" name="parameter_estimation" key="Report_32" taskType="parameterFitting">
      <Comment/>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Parameters"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Value"/>
      </Footer>
    </Report>
    <Report precision="6" separator="&#9;" name="multi_parameter_estimation" key="Report_87" taskType="parameterFitting">
      <Comment/>
      <Table printTitle="1">
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Parameters"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Value"/>
      </Table>
    </Report>
  </ListOfReports>
  <SBMLReference file="E_A_48.sbml">
    <SBMLMap SBMLid="AZD" COPASIkey="ModelValue_20"/>
    <SBMLMap SBMLid="AddAZD" COPASIkey="Event_3"/>
    <SBMLMap SBMLid="AddTGFb" COPASIkey="Event_2"/>
    <SBMLMap SBMLid="Akt" COPASIkey="Metabolite_12"/>
    <SBMLMap SBMLid="Cell" COPASIkey="Compartment_0"/>
    <SBMLMap SBMLid="CrossTalkR1" COPASIkey="Reaction_27"/>
    <SBMLMap SBMLid="CrossTalkR2" COPASIkey="Reaction_28"/>
    <SBMLMap SBMLid="CrossTalkR3" COPASIkey="Reaction_29"/>
    <SBMLMap SBMLid="CrossTalkR4" COPASIkey="Reaction_30"/>
    <SBMLMap SBMLid="CrossTalkR5" COPASIkey="Reaction_31"/>
    <SBMLMap SBMLid="CrossTalkR6" COPASIkey="Reaction_32"/>
    <SBMLMap SBMLid="Erk" COPASIkey="Metabolite_8"/>
    <SBMLMap SBMLid="Everolimus" COPASIkey="ModelValue_38"/>
    <SBMLMap SBMLid="GrowthFactors" COPASIkey="ModelValue_10"/>
    <SBMLMap SBMLid="MAPK_R0" COPASIkey="Reaction_8"/>
    <SBMLMap SBMLid="MAPK_R1" COPASIkey="Reaction_9"/>
    <SBMLMap SBMLid="MAPK_R2" COPASIkey="Reaction_10"/>
    <SBMLMap SBMLid="MAPK_R3" COPASIkey="Reaction_11"/>
    <SBMLMap SBMLid="MAPK_R4" COPASIkey="Reaction_12"/>
    <SBMLMap SBMLid="MAPK_R5" COPASIkey="Reaction_13"/>
    <SBMLMap SBMLid="MAPK_R6" COPASIkey="Reaction_14"/>
    <SBMLMap SBMLid="MAPK_R7" COPASIkey="Reaction_15"/>
    <SBMLMap SBMLid="MAPK_R8" COPASIkey="Reaction_16"/>
    <SBMLMap SBMLid="MAPK_R9" COPASIkey="Reaction_17"/>
    <SBMLMap SBMLid="MK2206" COPASIkey="ModelValue_32"/>
    <SBMLMap SBMLid="Mek" COPASIkey="Metabolite_6"/>
    <SBMLMap SBMLid="NonCompetitiveInhibition" COPASIkey="Function_39"/>
    <SBMLMap SBMLid="PI3K" COPASIkey="Metabolite_10"/>
    <SBMLMap SBMLid="PI3K_R1" COPASIkey="Reaction_18"/>
    <SBMLMap SBMLid="PI3K_R2" COPASIkey="Reaction_19"/>
    <SBMLMap SBMLid="PI3K_R3" COPASIkey="Reaction_20"/>
    <SBMLMap SBMLid="PI3K_R4" COPASIkey="Reaction_21"/>
    <SBMLMap SBMLid="PI3K_R5_1" COPASIkey="Reaction_22"/>
    <SBMLMap SBMLid="PI3K_R5_2" COPASIkey="Reaction_23"/>
    <SBMLMap SBMLid="PI3K_R6" COPASIkey="Reaction_24"/>
    <SBMLMap SBMLid="PI3K_R7" COPASIkey="Reaction_25"/>
    <SBMLMap SBMLid="PI3K_R8" COPASIkey="Reaction_26"/>
    <SBMLMap SBMLid="Raf" COPASIkey="Metabolite_18"/>
    <SBMLMap SBMLid="S6K" COPASIkey="Metabolite_16"/>
    <SBMLMap SBMLid="SerumStarveRemoveGrowthFactors" COPASIkey="Event_1"/>
    <SBMLMap SBMLid="SerumStarveRemoveTGFb" COPASIkey="Event_0"/>
    <SBMLMap SBMLid="Smad2" COPASIkey="Metabolite_4"/>
    <SBMLMap SBMLid="Smad2Tot" COPASIkey="ModelValue_0"/>
    <SBMLMap SBMLid="TGF_R1" COPASIkey="Reaction_0"/>
    <SBMLMap SBMLid="TGF_R2" COPASIkey="Reaction_1"/>
    <SBMLMap SBMLid="TGF_R3" COPASIkey="Reaction_2"/>
    <SBMLMap SBMLid="TGF_R4" COPASIkey="Reaction_3"/>
    <SBMLMap SBMLid="TGF_R5" COPASIkey="Reaction_4"/>
    <SBMLMap SBMLid="TGF_R6" COPASIkey="Reaction_5"/>
    <SBMLMap SBMLid="TGF_R8" COPASIkey="Reaction_6"/>
    <SBMLMap SBMLid="TGF_R9" COPASIkey="Reaction_7"/>
    <SBMLMap SBMLid="TGFb" COPASIkey="ModelValue_2"/>
    <SBMLMap SBMLid="TGFbR" COPASIkey="Metabolite_0"/>
    <SBMLMap SBMLid="TGFbR_Cav" COPASIkey="Metabolite_3"/>
    <SBMLMap SBMLid="TGFbR_EE" COPASIkey="Metabolite_2"/>
    <SBMLMap SBMLid="TGFbR_a" COPASIkey="Metabolite_1"/>
    <SBMLMap SBMLid="_kAktPhos_kcat" COPASIkey="ModelValue_31"/>
    <SBMLMap SBMLid="_kAktPhos_ki" COPASIkey="ModelValue_30"/>
    <SBMLMap SBMLid="_kMekPhos_ki" COPASIkey="ModelValue_18"/>
    <SBMLMap SBMLid="_kPI3KDephosByErk" COPASIkey="ModelValue_53"/>
    <SBMLMap SBMLid="_kPI3KDephosByS6K" COPASIkey="ModelValue_28"/>
    <SBMLMap SBMLid="_kPI3KPhosByGF" COPASIkey="ModelValue_27"/>
    <SBMLMap SBMLid="_kPI3KPhosByTGFbR_kcat" COPASIkey="ModelValue_52"/>
    <SBMLMap SBMLid="_kRafPhosByPI3K_kcat" COPASIkey="ModelValue_50"/>
    <SBMLMap SBMLid="_kRafPhosByTGFbR_kcat" COPASIkey="ModelValue_48"/>
    <SBMLMap SBMLid="_kS6KPhosBymTORC1_kcat" COPASIkey="ModelValue_44"/>
    <SBMLMap SBMLid="_kSmad2Phos_kcat" COPASIkey="ModelValue_7"/>
    <SBMLMap SBMLid="_kTGFbOn" COPASIkey="ModelValue_1"/>
    <SBMLMap SBMLid="_kmTORC1Dephos_Vmax" COPASIkey="ModelValue_42"/>
    <SBMLMap SBMLid="_kmTORC1Phos_kcat" COPASIkey="ModelValue_37"/>
    <SBMLMap SBMLid="_kmTORC1Phos_ki" COPASIkey="ModelValue_36"/>
    <SBMLMap SBMLid="_kmTORCPhosBasal_Vmax" COPASIkey="ModelValue_39"/>
    <SBMLMap SBMLid="_kmTORCPhosBasal_km" COPASIkey="ModelValue_40"/>
    <SBMLMap SBMLid="kAktDephos_Vmax" COPASIkey="ModelValue_34"/>
    <SBMLMap SBMLid="kAktDephos_km" COPASIkey="ModelValue_33"/>
    <SBMLMap SBMLid="kAktPhos_km" COPASIkey="ModelValue_29"/>
    <SBMLMap SBMLid="kErkDephos_Vmax" COPASIkey="ModelValue_26"/>
    <SBMLMap SBMLid="kErkDephos_km" COPASIkey="ModelValue_25"/>
    <SBMLMap SBMLid="kErkPhos_kcat" COPASIkey="ModelValue_24"/>
    <SBMLMap SBMLid="kErkPhos_km1" COPASIkey="ModelValue_23"/>
    <SBMLMap SBMLid="kMekDephos_Vmax" COPASIkey="ModelValue_22"/>
    <SBMLMap SBMLid="kMekDephos_km" COPASIkey="ModelValue_21"/>
    <SBMLMap SBMLid="kMekPhos_kcat" COPASIkey="ModelValue_19"/>
    <SBMLMap SBMLid="kMekPhos_km1" COPASIkey="ModelValue_17"/>
    <SBMLMap SBMLid="kPI3KPhosByTGFbR_km" COPASIkey="ModelValue_51"/>
    <SBMLMap SBMLid="kRafDephosVmax" COPASIkey="ModelValue_16"/>
    <SBMLMap SBMLid="kRafDephos_km" COPASIkey="ModelValue_15"/>
    <SBMLMap SBMLid="kRafPhosByPI3K_km" COPASIkey="ModelValue_49"/>
    <SBMLMap SBMLid="kRafPhosByTGFbR_km" COPASIkey="ModelValue_47"/>
    <SBMLMap SBMLid="kRafPhos_Vmax" COPASIkey="ModelValue_13"/>
    <SBMLMap SBMLid="kRafPhos_ki" COPASIkey="ModelValue_12"/>
    <SBMLMap SBMLid="kRafPhos_km" COPASIkey="ModelValue_11"/>
    <SBMLMap SBMLid="kRafPhos_n" COPASIkey="ModelValue_14"/>
    <SBMLMap SBMLid="kS6KDephos_Vmax" COPASIkey="ModelValue_46"/>
    <SBMLMap SBMLid="kS6KDephos_km" COPASIkey="ModelValue_45"/>
    <SBMLMap SBMLid="kS6KPhosBymTORC1_km" COPASIkey="ModelValue_43"/>
    <SBMLMap SBMLid="kSmad2DephosByErk_kcat" COPASIkey="ModelValue_57"/>
    <SBMLMap SBMLid="kSmad2DephosByErk_km" COPASIkey="ModelValue_56"/>
    <SBMLMap SBMLid="kSmad2Dephos_Vmax" COPASIkey="ModelValue_9"/>
    <SBMLMap SBMLid="kSmad2Dephos_km" COPASIkey="ModelValue_8"/>
    <SBMLMap SBMLid="kSmad2PhosByAkt_kcat" COPASIkey="ModelValue_55"/>
    <SBMLMap SBMLid="kSmad2PhosByAkt_km" COPASIkey="ModelValue_54"/>
    <SBMLMap SBMLid="kSmad2Phos_km" COPASIkey="ModelValue_6"/>
    <SBMLMap SBMLid="kTGFbOff" COPASIkey="ModelValue_3"/>
    <SBMLMap SBMLid="kTGFbRIntern" COPASIkey="ModelValue_4"/>
    <SBMLMap SBMLid="kTGFbRRecyc" COPASIkey="ModelValue_5"/>
    <SBMLMap SBMLid="kmTORC1Dephos_km" COPASIkey="ModelValue_41"/>
    <SBMLMap SBMLid="kmTORC1Phos_km" COPASIkey="ModelValue_35"/>
    <SBMLMap SBMLid="mTORC1" COPASIkey="Metabolite_14"/>
    <SBMLMap SBMLid="pAkt" COPASIkey="Metabolite_13"/>
    <SBMLMap SBMLid="pErk" COPASIkey="Metabolite_9"/>
    <SBMLMap SBMLid="pMek" COPASIkey="Metabolite_7"/>
    <SBMLMap SBMLid="pPI3K" COPASIkey="Metabolite_11"/>
    <SBMLMap SBMLid="pRaf" COPASIkey="Metabolite_19"/>
    <SBMLMap SBMLid="pS6K" COPASIkey="Metabolite_17"/>
    <SBMLMap SBMLid="pSmad2" COPASIkey="Metabolite_5"/>
    <SBMLMap SBMLid="pmTORC1" COPASIkey="Metabolite_15"/>
    <SBMLMap SBMLid="ppErk" COPASIkey="Metabolite_21"/>
    <SBMLMap SBMLid="ppMek" COPASIkey="Metabolite_20"/>
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
