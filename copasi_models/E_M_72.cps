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
    <Function key="Function_40" name="NonCompetitiveInhibition" type="UserDefined" reversible="unspecified">
      <Expression>
        Vmax*S/((km+S)*(1+(I/ki)^n))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_250" name="km" order="0" role="variable"/>
        <ParameterDescription key="FunctionParameter_265" name="ki" order="1" role="variable"/>
        <ParameterDescription key="FunctionParameter_266" name="Vmax" order="2" role="variable"/>
        <ParameterDescription key="FunctionParameter_267" name="n" order="3" role="variable"/>
        <ParameterDescription key="FunctionParameter_268" name="I" order="4" role="variable"/>
        <ParameterDescription key="FunctionParameter_269" name="S" order="5" role="variable"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_47" name="Function for TGF_R1" type="UserDefined" reversible="false">
      <Expression>
        kTGFbOn*TGFbR*TGFb
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_294" name="TGFb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_295" name="TGFbR" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_296" name="kTGFbOn" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="MMWithKcat_1" type="UserDefined" reversible="false">
      <Expression>
        kSmad2Phos_kcat*TGFbR_EE*Smad2/(kSmad2Phos_km+Smad2)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_311" name="Smad2" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_312" name="TGFbR_EE" order="1" role="modifier"/>
        <ParameterDescription key="FunctionParameter_313" name="kSmad2Phos_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_314" name="kSmad2Phos_km" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="MM_1" type="UserDefined" reversible="false">
      <Expression>
        kSmad2Dephos_Vmax*pSmad2/(kSmad2Dephos_km+pSmad2)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_309" name="kSmad2Dephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_319" name="kSmad2Dephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_320" name="pSmad2" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="Function for MAPK_R0" type="UserDefined" reversible="false">
      <Expression>
        GrowthFactors*NonCompetitiveInhibition(kRafPhos_km,kRafPhos_ki,kRafPhos_Vmax,kRafPhos_n,ppErk,Raf)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_328" name="GrowthFactors" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_329" name="Raf" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_330" name="kRafPhos_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_331" name="kRafPhos_ki" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_332" name="kRafPhos_km" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_333" name="kRafPhos_n" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_334" name="ppErk" order="6" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="MM_2" type="UserDefined" reversible="false">
      <Expression>
        kRafDephosVmax*pRaf/(kRafDephos_km+pRaf)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_310" name="kRafDephosVmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_324" name="kRafDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_327" name="pRaf" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="CompetitiveInhibition_1" type="UserDefined" reversible="false">
      <Expression>
        kMekPhos_kcat1*pRaf*Mek/(kMekPhos_km1+Mek+kMekPhos_km1*AZD/kMekPhos_ki1)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_347" name="AZD" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_348" name="Mek" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_349" name="kMekPhos_kcat1" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_350" name="kMekPhos_ki1" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_351" name="kMekPhos_km1" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_352" name="pRaf" order="5" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="CompetitiveInhibition_2" type="UserDefined" reversible="false">
      <Expression>
        kMekPhos_kcat1*pRaf*pMek/(kMekPhos_km1+pMek+kMekPhos_km1*AZD/kMekPhos_ki1)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_359" name="AZD" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_360" name="kMekPhos_kcat1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_361" name="kMekPhos_ki1" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_362" name="kMekPhos_km1" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_363" name="pMek" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_364" name="pRaf" order="5" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="MM_3" type="UserDefined" reversible="false">
      <Expression>
        kMekDephos_Vmax1*ppMek/(kMekDephos_km1+ppMek)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_345" name="kMekDephos_Vmax1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_308" name="kMekDephos_km1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_326" name="ppMek" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="MM_4" type="UserDefined" reversible="false">
      <Expression>
        kMekDephos_Vmax1*pMek/(kMekDephos_km1+pMek)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_374" name="kMekDephos_Vmax1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_375" name="kMekDephos_km1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_376" name="pMek" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="MMWithKcat_2" type="UserDefined" reversible="false">
      <Expression>
        kErkPhos_kcat1*ppMek*Erk/(kErkPhos_km1+Erk)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_381" name="Erk" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_382" name="kErkPhos_kcat1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_383" name="kErkPhos_km1" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_384" name="ppMek" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="MMWithKcat_3" type="UserDefined" reversible="false">
      <Expression>
        kErkPhos_kcat1*ppMek*pErk/(kErkPhos_km1+pErk)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_389" name="kErkPhos_kcat1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_390" name="kErkPhos_km1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_391" name="pErk" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_392" name="ppMek" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_58" name="MM_5" type="UserDefined" reversible="false">
      <Expression>
        kErkDephos_Vmax1*ppErk/(kErkDephos_km1+ppErk)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_344" name="kErkDephos_Vmax1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_397" name="kErkDephos_km1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_398" name="ppErk" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_59" name="MM_6" type="UserDefined" reversible="false">
      <Expression>
        kErkDephos_Vmax1*pErk/(kErkDephos_km1+pErk)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_402" name="kErkDephos_Vmax1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_403" name="kErkDephos_km1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_404" name="pErk" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_60" name="Function for PI3K_R1" type="UserDefined" reversible="false">
      <Expression>
        kPI3KPhosByGF*PI3K*GrowthFactors
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_408" name="GrowthFactors" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_409" name="PI3K" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_410" name="kPI3KPhosByGF" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_61" name="Function for PI3K_R2" type="UserDefined" reversible="false">
      <Expression>
        kPI3KDephosByS6K*pPI3K*pS6K
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_414" name="kPI3KDephosByS6K" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_415" name="pPI3K" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_416" name="pS6K" order="2" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_62" name="CompetitiveInhibition_3" type="UserDefined" reversible="false">
      <Expression>
        kAktPhos_kcat*pPI3K*Akt/(kAktPhos_km+Akt+kAktPhos_km*MK2206/kAktPhos_ki)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_423" name="Akt" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_424" name="MK2206" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_425" name="kAktPhos_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_426" name="kAktPhos_ki" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_427" name="kAktPhos_km" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_428" name="pPI3K" order="5" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_63" name="MM_7" type="UserDefined" reversible="false">
      <Expression>
        kAktDephos_Vmax*pAkt/(kAktDephos_km+pAkt)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_325" name="kAktDephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_421" name="kAktDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_346" name="pAkt" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_64" name="CompetitiveInhibition_4" type="UserDefined" reversible="false">
      <Expression>
        kmTORC1Phos_kcat*pAkt*mTORC1/(kmTORC1Phos_km+mTORC1+kmTORC1Phos_km*Everolimus/kmTORC1Phos_ki)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_441" name="Everolimus" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_442" name="kmTORC1Phos_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_443" name="kmTORC1Phos_ki" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_444" name="kmTORC1Phos_km" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_445" name="mTORC1" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_446" name="pAkt" order="5" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_65" name="MM_8" type="UserDefined" reversible="false">
      <Expression>
        kmTORC1Dephos_Vmax*pmTORC1/(kmTORC1Dephos_km+pmTORC1)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_440" name="kmTORC1Dephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_420" name="kmTORC1Dephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_439" name="pmTORC1" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_66" name="MMWithKcat_4" type="UserDefined" reversible="false">
      <Expression>
        kS6KPhosBymTORC1_kcat*pmTORC1*S6K/(kS6KPhosBymTORC1_km+S6K)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_457" name="S6K" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_458" name="kS6KPhosBymTORC1_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_459" name="kS6KPhosBymTORC1_km" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_460" name="pmTORC1" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_67" name="MM_9" type="UserDefined" reversible="false">
      <Expression>
        kS6KDephos_Vmax*pS6K/(kS6KDephos_km+pS6K)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_422" name="kS6KDephos_Vmax" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_465" name="kS6KDephos_km" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_466" name="pS6K" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_68" name="MMWithKcat_5" type="UserDefined" reversible="false">
      <Expression>
        kRafPhosByTGFbR_kcat*TGFbR_Cav*Raf/(kRafPhosByTGFbR_km+Raf)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_471" name="Raf" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_472" name="TGFbR_Cav" order="1" role="modifier"/>
        <ParameterDescription key="FunctionParameter_473" name="kRafPhosByTGFbR_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_474" name="kRafPhosByTGFbR_km" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_69" name="MMWithKcat_6" type="UserDefined" reversible="false">
      <Expression>
        kRafPhosByPI3K_kcat*pPI3K*Raf/(kRafPhosByPI3K_km+Raf)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_479" name="Raf" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_480" name="kRafPhosByPI3K_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_481" name="kRafPhosByPI3K_km" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_482" name="pPI3K" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_70" name="MMWithKcat_7" type="UserDefined" reversible="false">
      <Expression>
        kPI3KPhosByTGFbR_kcat*TGFbR_Cav*PI3K/(kPI3KPhosByTGFbR_km+PI3K)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_487" name="PI3K" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_488" name="TGFbR_Cav" order="1" role="modifier"/>
        <ParameterDescription key="FunctionParameter_489" name="kPI3KPhosByTGFbR_kcat" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_490" name="kPI3KPhosByTGFbR_km" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_71" name="Function for CrossTalkR4" type="UserDefined" reversible="false">
      <Expression>
        kPI3KDephosByErk*pPI3K*ppErk
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_470" name="kPI3KDephosByErk" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_495" name="pPI3K" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_496" name="ppErk" order="2" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_72" name="MMWithKcat_8" type="UserDefined" reversible="false">
      <Expression>
        kSmad2PhosByAkt_kcat*pAkt*Smad2/(kSmad2PhosByAkt_km+Smad2)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_501" name="Smad2" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_502" name="kSmad2PhosByAkt_kcat" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_503" name="kSmad2PhosByAkt_km" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_504" name="pAkt" order="3" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_1" name="TGFbModule" simulationType="time" timeUnit="h" volumeUnit="l" areaUnit="m&#178;" lengthUnit="m" quantityUnit="nmol" type="deterministic" avogadroConstant="6.0221417899999999e+23">
    <ListOfCompartments>
      <Compartment key="Compartment_0" name="Cell" simulationType="fixed" dimensionality="3" addNoise="false">
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_0" name="TGFbR" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="4.62739442418e+16">
      </Metabolite>
      <Metabolite key="Metabolite_1" name="TGFbR_a" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.82171684779e+14">
      </Metabolite>
      <Metabolite key="Metabolite_2" name="TGFbR_EE" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="7.55798406481e+15">
      </Metabolite>
      <Metabolite key="Metabolite_3" name="TGFbR_Cav" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.82171684779e+15">
      </Metabolite>
      <Metabolite key="Metabolite_4" name="Smad2" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.46556702139e+16">
      </Metabolite>
      <Metabolite key="Metabolite_5" name="pSmad2" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.56574768547e+15">
      </Metabolite>
      <Metabolite key="Metabolite_6" name="Mek" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="1.52285677629e+17">
      </Metabolite>
      <Metabolite key="Metabolite_7" name="pMek" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="3.37626897542e+16">
      </Metabolite>
      <Metabolite key="Metabolite_8" name="Erk" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="1.10405073018e+17">
      </Metabolite>
      <Metabolite key="Metabolite_9" name="pErk" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="7.09903494779e+16">
      </Metabolite>
      <Metabolite key="Metabolite_10" name="PI3K" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="6.01975116551e+16">
      </Metabolite>
      <Metabolite key="Metabolite_11" name="pPI3K" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="2.39062449123e+13">
      </Metabolite>
      <Metabolite key="Metabolite_12" name="Akt" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.98680631996e+16">
      </Metabolite>
      <Metabolite key="Metabolite_13" name="pAkt" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="3.53354698618e+14">
      </Metabolite>
      <Metabolite key="Metabolite_14" name="mTORC1" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.43633531246e+16">
      </Metabolite>
      <Metabolite key="Metabolite_15" name="pmTORC1" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.85806477538e+15">
      </Metabolite>
      <Metabolite key="Metabolite_16" name="S6K" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.450459028e+16">
      </Metabolite>
      <Metabolite key="Metabolite_17" name="pS6K" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.71682762064e+15">
      </Metabolite>
      <Metabolite key="Metabolite_18" name="Raf" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="5.29542555628e+16">
      </Metabolite>
      <Metabolite key="Metabolite_19" name="pRaf" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="7.26716233833e+15">
      </Metabolite>
      <Metabolite key="Metabolite_20" name="ppMek" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="1.748198386e+16">
      </Metabolite>
      <Metabolite key="Metabolite_21" name="ppErk" simulationType="reactions" compartment="Compartment_0" addNoise="false" particle_numbers="2.5947158987e+16">
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_0" name="kTGFbOn" simulationType="fixed" addNoise="false" initial_value="0.100647860357">
      </ModelValue>
      <ModelValue key="ModelValue_1" name="TGFb" simulationType="fixed" addNoise="false" initial_value="0.005">
      </ModelValue>
      <ModelValue key="ModelValue_2" name="kTGFbOff" simulationType="fixed" addNoise="false" initial_value="0.04">
      </ModelValue>
      <ModelValue key="ModelValue_3" name="kTGFbRIntern" simulationType="fixed" addNoise="false" initial_value="0.3333333333">
      </ModelValue>
      <ModelValue key="ModelValue_4" name="kTGFbRRecyc" simulationType="fixed" addNoise="false" initial_value="0.03333333333">
      </ModelValue>
      <ModelValue key="ModelValue_5" name="kSmad2Phos_km" simulationType="fixed" addNoise="false" initial_value="97.0531">
      </ModelValue>
      <ModelValue key="ModelValue_6" name="kSmad2Phos_kcat" simulationType="fixed" addNoise="false" initial_value="2.0">
      </ModelValue>
      <ModelValue key="ModelValue_7" name="kSmad2Dephos_km" simulationType="fixed" addNoise="false" initial_value="100.0">
      </ModelValue>
      <ModelValue key="ModelValue_8" name="kSmad2Dephos_Vmax" simulationType="fixed" addNoise="false" initial_value="58.8712661229">
      </ModelValue>
      <ModelValue key="ModelValue_9" name="GrowthFactors" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_10" name="kRafPhos_km" simulationType="fixed" addNoise="false" initial_value="10.0">
      </ModelValue>
      <ModelValue key="ModelValue_11" name="kRafPhos_ki" simulationType="fixed" addNoise="false" initial_value="3.5">
      </ModelValue>
      <ModelValue key="ModelValue_12" name="kRafPhos_Vmax" simulationType="fixed" addNoise="false" initial_value="9000.0">
      </ModelValue>
      <ModelValue key="ModelValue_13" name="kRafPhos_n" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_14" name="kRafDephos_km" simulationType="fixed" addNoise="false" initial_value="8.0">
      </ModelValue>
      <ModelValue key="ModelValue_15" name="kRafDephosVmax" simulationType="fixed" addNoise="false" initial_value="3602.5">
      </ModelValue>
      <ModelValue key="ModelValue_16" name="kMekPhos_km1" simulationType="fixed" addNoise="false" initial_value="15.0">
      </ModelValue>
      <ModelValue key="ModelValue_17" name="kMekPhos_ki1" simulationType="fixed" addNoise="false" initial_value="0.25">
      </ModelValue>
      <ModelValue key="ModelValue_18" name="kMekPhos_kcat1" simulationType="fixed" addNoise="false" initial_value="125.0">
      </ModelValue>
      <ModelValue key="ModelValue_19" name="AZD" simulationType="fixed" addNoise="false" initial_value="0.0">
      </ModelValue>
      <ModelValue key="ModelValue_20" name="kMekDephos_km1" simulationType="fixed" addNoise="false" initial_value="15.0">
      </ModelValue>
      <ModelValue key="ModelValue_21" name="kMekDephos_Vmax1" simulationType="fixed" addNoise="false" initial_value="2700.0">
      </ModelValue>
      <ModelValue key="ModelValue_22" name="kErkPhos_km1" simulationType="fixed" addNoise="false" initial_value="100.0">
      </ModelValue>
      <ModelValue key="ModelValue_23" name="kErkPhos_kcat1" simulationType="fixed" addNoise="false" initial_value="85.0103161451">
      </ModelValue>
      <ModelValue key="ModelValue_24" name="kErkDephos_km1" simulationType="fixed" addNoise="false" initial_value="15.0">
      </ModelValue>
      <ModelValue key="ModelValue_25" name="kErkDephos_Vmax1" simulationType="fixed" addNoise="false" initial_value="1800.0">
      </ModelValue>
      <ModelValue key="ModelValue_26" name="kPI3KPhosByGF" simulationType="fixed" addNoise="false" initial_value="0.239474698704">
      </ModelValue>
      <ModelValue key="ModelValue_27" name="kPI3KDephosByS6K" simulationType="fixed" addNoise="false" initial_value="7.5">
      </ModelValue>
      <ModelValue key="ModelValue_28" name="kAktPhos_km" simulationType="fixed" addNoise="false" initial_value="12.5">
      </ModelValue>
      <ModelValue key="ModelValue_29" name="kAktPhos_ki" simulationType="fixed" addNoise="false" initial_value="0.1">
      </ModelValue>
      <ModelValue key="ModelValue_30" name="kAktPhos_kcat" simulationType="fixed" addNoise="false" initial_value="6.0">
      </ModelValue>
      <ModelValue key="ModelValue_31" name="MK2206" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_32" name="kAktDephos_km" simulationType="fixed" addNoise="false" initial_value="15.0">
      </ModelValue>
      <ModelValue key="ModelValue_33" name="kAktDephos_Vmax" simulationType="fixed" addNoise="false" initial_value="31.1252344505">
      </ModelValue>
      <ModelValue key="ModelValue_34" name="kmTORC1Phos_km" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_35" name="kmTORC1Phos_ki" simulationType="fixed" addNoise="false" initial_value="0.001">
      </ModelValue>
      <ModelValue key="ModelValue_36" name="kmTORC1Phos_kcat" simulationType="fixed" addNoise="false" initial_value="0.5">
      </ModelValue>
      <ModelValue key="ModelValue_37" name="Everolimus" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_38" name="kmTORC1Dephos_km" simulationType="fixed" addNoise="false" initial_value="100.0">
      </ModelValue>
      <ModelValue key="ModelValue_39" name="kmTORC1Dephos_Vmax" simulationType="fixed" addNoise="false" initial_value="1.0">
      </ModelValue>
      <ModelValue key="ModelValue_40" name="kS6KPhosBymTORC1_km" simulationType="fixed" addNoise="false" initial_value="10.0">
      </ModelValue>
      <ModelValue key="ModelValue_41" name="kS6KPhosBymTORC1_kcat" simulationType="fixed" addNoise="false" initial_value="2.77975221288">
      </ModelValue>
      <ModelValue key="ModelValue_42" name="kS6KDephos_km" simulationType="fixed" addNoise="false" initial_value="10.0">
      </ModelValue>
      <ModelValue key="ModelValue_43" name="kS6KDephos_Vmax" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_44" name="kRafPhosByTGFbR_km" simulationType="fixed" addNoise="false" initial_value="25.0">
      </ModelValue>
      <ModelValue key="ModelValue_45" name="kRafPhosByTGFbR_kcat" simulationType="fixed" addNoise="false" initial_value="265.0">
      </ModelValue>
      <ModelValue key="ModelValue_46" name="kRafPhosByPI3K_km" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_47" name="kRafPhosByPI3K_kcat" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_48" name="kPI3KPhosByTGFbR_km" simulationType="fixed" addNoise="false" initial_value="10.0">
      </ModelValue>
      <ModelValue key="ModelValue_49" name="kPI3KPhosByTGFbR_kcat" simulationType="fixed" addNoise="false" initial_value="50.0">
      </ModelValue>
      <ModelValue key="ModelValue_50" name="kPI3KDephosByErk" simulationType="fixed" addNoise="false" initial_value="0.15">
      </ModelValue>
      <ModelValue key="ModelValue_51" name="kSmad2PhosByAkt_km" simulationType="fixed" addNoise="false" initial_value="8.0">
      </ModelValue>
      <ModelValue key="ModelValue_52" name="kSmad2PhosByAkt_kcat" simulationType="fixed" addNoise="false" initial_value="5.0">
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
          <Constant key="Parameter_5013" name="TGFb" value="0.005"/>
          <Constant key="Parameter_5012" name="kTGFbOn" value="0.100648"/>
        </ListOfConstants>
        <KineticLaw function="Function_47" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_295">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_296">
              <SourceParameter reference="ModelValue_0"/>
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
          <Constant key="Parameter_5011" name="k1" value="0.04"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_2"/>
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
          <Constant key="Parameter_5010" name="k1" value="0.333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
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
      <Reaction key="Reaction_3" name="TGF_R4" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5009" name="k1" value="0.0333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_4"/>
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
          <Constant key="Parameter_5008" name="k1" value="0.333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
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
      <Reaction key="Reaction_5" name="TGF_R6" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5007" name="k1" value="0.0333333"/>
        </ListOfConstants>
        <KineticLaw function="Function_13" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_80">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_81">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_6" name="TGF_R7" reversible="false" fast="false" addNoise="false">
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
          <Constant key="Parameter_5006" name="kSmad2Phos_kcat" value="2"/>
          <Constant key="Parameter_5005" name="kSmad2Phos_km" value="97.0531"/>
        </ListOfConstants>
        <KineticLaw function="Function_48" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_311">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_312">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_313">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_314">
              <SourceParameter reference="ModelValue_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="TGF_R8" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_5004" name="kSmad2Dephos_Vmax" value="58.8713"/>
          <Constant key="Parameter_5003" name="kSmad2Dephos_km" value="100"/>
        </ListOfConstants>
        <KineticLaw function="Function_49" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_309">
              <SourceParameter reference="ModelValue_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_319">
              <SourceParameter reference="ModelValue_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_320">
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
          <Constant key="Parameter_5002" name="GrowthFactors" value="1"/>
          <Constant key="Parameter_5001" name="kRafPhos_Vmax" value="9000"/>
          <Constant key="Parameter_5000" name="kRafPhos_ki" value="3.5"/>
          <Constant key="Parameter_4999" name="kRafPhos_km" value="10"/>
          <Constant key="Parameter_4998" name="kRafPhos_n" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_50" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_328">
              <SourceParameter reference="ModelValue_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_329">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_330">
              <SourceParameter reference="ModelValue_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_331">
              <SourceParameter reference="ModelValue_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_332">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_333">
              <SourceParameter reference="ModelValue_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_334">
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
          <Constant key="Parameter_4997" name="kRafDephosVmax" value="3602.5"/>
          <Constant key="Parameter_4996" name="kRafDephos_km" value="8"/>
        </ListOfConstants>
        <KineticLaw function="Function_51" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_310">
              <SourceParameter reference="ModelValue_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_324">
              <SourceParameter reference="ModelValue_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_327">
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
          <Constant key="Parameter_4995" name="AZD" value="0"/>
          <Constant key="Parameter_4994" name="kMekPhos_kcat1" value="125"/>
          <Constant key="Parameter_4993" name="kMekPhos_ki1" value="0.25"/>
          <Constant key="Parameter_4992" name="kMekPhos_km1" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_52" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_347">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_348">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_349">
              <SourceParameter reference="ModelValue_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_350">
              <SourceParameter reference="ModelValue_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_351">
              <SourceParameter reference="ModelValue_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_352">
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
          <Constant key="Parameter_4991" name="AZD" value="0"/>
          <Constant key="Parameter_4990" name="kMekPhos_kcat1" value="125"/>
          <Constant key="Parameter_4989" name="kMekPhos_ki1" value="0.25"/>
          <Constant key="Parameter_4988" name="kMekPhos_km1" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_53" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_359">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_360">
              <SourceParameter reference="ModelValue_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_361">
              <SourceParameter reference="ModelValue_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_362">
              <SourceParameter reference="ModelValue_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_363">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_364">
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
          <Constant key="Parameter_4987" name="kMekDephos_Vmax1" value="2700"/>
          <Constant key="Parameter_4986" name="kMekDephos_km1" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_54" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_345">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_308">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_326">
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
          <Constant key="Parameter_4985" name="kMekDephos_Vmax1" value="2700"/>
          <Constant key="Parameter_4984" name="kMekDephos_km1" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_55" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_374">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_375">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_376">
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
          <Constant key="Parameter_4983" name="kErkPhos_kcat1" value="85.0103"/>
          <Constant key="Parameter_4982" name="kErkPhos_km1" value="100"/>
        </ListOfConstants>
        <KineticLaw function="Function_56" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_381">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_382">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_383">
              <SourceParameter reference="ModelValue_22"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_384">
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
          <Constant key="Parameter_4981" name="kErkPhos_kcat1" value="85.0103"/>
          <Constant key="Parameter_4980" name="kErkPhos_km1" value="100"/>
        </ListOfConstants>
        <KineticLaw function="Function_57" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_389">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_390">
              <SourceParameter reference="ModelValue_22"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_391">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_392">
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
          <Constant key="Parameter_4979" name="kErkDephos_Vmax1" value="1800"/>
          <Constant key="Parameter_4978" name="kErkDephos_km1" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_58" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_344">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_397">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_398">
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
          <Constant key="Parameter_4977" name="kErkDephos_Vmax1" value="1800"/>
          <Constant key="Parameter_4976" name="kErkDephos_km1" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_59" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_402">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_403">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_404">
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
          <Constant key="Parameter_4975" name="GrowthFactors" value="1"/>
          <Constant key="Parameter_4974" name="kPI3KPhosByGF" value="0.239475"/>
        </ListOfConstants>
        <KineticLaw function="Function_60" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_408">
              <SourceParameter reference="ModelValue_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_409">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_410">
              <SourceParameter reference="ModelValue_26"/>
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
          <Constant key="Parameter_4973" name="kPI3KDephosByS6K" value="7.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_61" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_414">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_415">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_416">
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
          <Constant key="Parameter_4972" name="MK2206" value="1"/>
          <Constant key="Parameter_4971" name="kAktPhos_kcat" value="6"/>
          <Constant key="Parameter_4970" name="kAktPhos_ki" value="0.1"/>
          <Constant key="Parameter_4969" name="kAktPhos_km" value="12.5"/>
        </ListOfConstants>
        <KineticLaw function="Function_62" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_423">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_424">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_425">
              <SourceParameter reference="ModelValue_30"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_426">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_427">
              <SourceParameter reference="ModelValue_28"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_428">
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
          <Constant key="Parameter_4968" name="kAktDephos_Vmax" value="31.1252"/>
          <Constant key="Parameter_4967" name="kAktDephos_km" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_63" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_325">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_421">
              <SourceParameter reference="ModelValue_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_346">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="PI3K_R5" reversible="false" fast="false" addNoise="false">
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
          <Constant key="Parameter_4966" name="Everolimus" value="1"/>
          <Constant key="Parameter_4965" name="kmTORC1Phos_kcat" value="0.5"/>
          <Constant key="Parameter_4964" name="kmTORC1Phos_ki" value="0.001"/>
          <Constant key="Parameter_4963" name="kmTORC1Phos_km" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_64" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_441">
              <SourceParameter reference="ModelValue_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_442">
              <SourceParameter reference="ModelValue_36"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_443">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_444">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_445">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_446">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_23" name="PI3K_R6" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4962" name="kmTORC1Dephos_Vmax" value="1"/>
          <Constant key="Parameter_4961" name="kmTORC1Dephos_km" value="100"/>
        </ListOfConstants>
        <KineticLaw function="Function_65" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_440">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_420">
              <SourceParameter reference="ModelValue_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_439">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_24" name="PI3K_R7" reversible="false" fast="false" addNoise="false">
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
          <Constant key="Parameter_4960" name="kS6KPhosBymTORC1_kcat" value="2.77975"/>
          <Constant key="Parameter_4959" name="kS6KPhosBymTORC1_km" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_66" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_457">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_458">
              <SourceParameter reference="ModelValue_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_459">
              <SourceParameter reference="ModelValue_40"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_460">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_25" name="PI3K_R8" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4958" name="kS6KDephos_Vmax" value="50"/>
          <Constant key="Parameter_4957" name="kS6KDephos_km" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_67" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_422">
              <SourceParameter reference="ModelValue_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_465">
              <SourceParameter reference="ModelValue_42"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_466">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_26" name="CrossTalkR1" reversible="false" fast="false" addNoise="false">
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
          <Constant key="Parameter_4956" name="kRafPhosByTGFbR_kcat" value="265"/>
          <Constant key="Parameter_4955" name="kRafPhosByTGFbR_km" value="25"/>
        </ListOfConstants>
        <KineticLaw function="Function_68" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_471">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_472">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_473">
              <SourceParameter reference="ModelValue_45"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_474">
              <SourceParameter reference="ModelValue_44"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_27" name="CrossTalkR2" reversible="false" fast="false" addNoise="false">
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
          <Constant key="Parameter_4954" name="kRafPhosByPI3K_kcat" value="50"/>
          <Constant key="Parameter_4953" name="kRafPhosByPI3K_km" value="50"/>
        </ListOfConstants>
        <KineticLaw function="Function_69" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_479">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_480">
              <SourceParameter reference="ModelValue_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_481">
              <SourceParameter reference="ModelValue_46"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_482">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_28" name="CrossTalkR3" reversible="false" fast="false" addNoise="false">
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
          <Constant key="Parameter_4952" name="kPI3KPhosByTGFbR_kcat" value="50"/>
          <Constant key="Parameter_4951" name="kPI3KPhosByTGFbR_km" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_70" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_487">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_488">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_489">
              <SourceParameter reference="ModelValue_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_490">
              <SourceParameter reference="ModelValue_48"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_29" name="CrossTalkR4" reversible="false" fast="false" addNoise="false">
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
          <Constant key="Parameter_4950" name="kPI3KDephosByErk" value="0.15"/>
        </ListOfConstants>
        <KineticLaw function="Function_71" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_470">
              <SourceParameter reference="ModelValue_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_495">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_496">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_30" name="CrossTalkR5" reversible="false" fast="false" addNoise="false">
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
          <Constant key="Parameter_4949" name="kSmad2PhosByAkt_kcat" value="5"/>
          <Constant key="Parameter_4947" name="kSmad2PhosByAkt_km" value="8"/>
        </ListOfConstants>
        <KineticLaw function="Function_72" unitType="Default" scalingCompartment="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_501">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_502">
              <SourceParameter reference="ModelValue_52"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_503">
              <SourceParameter reference="ModelValue_51"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_504">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfEvents>
      <Event key="Event_0" name="SerumStarveRemoveTGFb" delayAssignment="true" fireAtInitialTime="0" persistentTrigger="1">
        <TriggerExpression>
          &lt;CN=Root,Model=TGFbModule,Reference=Time&gt; gt 70.25
        </TriggerExpression>
        <DelayExpression>
          0
        </DelayExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_1">
            <Expression>
              0
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_1" name="SerumStarveRemoveGrowthFactors" delayAssignment="true" fireAtInitialTime="0" persistentTrigger="1">
        <TriggerExpression>
          &lt;CN=Root,Model=TGFbModule,Reference=Time&gt; gt 70.25
        </TriggerExpression>
        <DelayExpression>
          0
        </DelayExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_9">
            <Expression>
              0
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_2" name="AddTGFb" delayAssignment="true" fireAtInitialTime="0" persistentTrigger="1">
        <TriggerExpression>
          &lt;CN=Root,Model=TGFbModule,Reference=Time&gt; gt 71.25
        </TriggerExpression>
        <DelayExpression>
          0
        </DelayExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_1">
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
          <ModelParameter cn="CN=Root,Model=TGFbModule" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[TGFbR]" value="46273944241830288" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_a]" value="582171684778969.5" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_EE]" value="7557984064814293" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_Cav]" value="5821716847789695" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Smad2]" value="54655670213925624" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pSmad2]" value="5565747685472119" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Mek]" value="1.5228567762895856e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pMek]" value="33762689754202348" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Erk]" value="1.1040507301812789e+17" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pErk]" value="70990349477934496" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[PI3K]" value="60197511655087616" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pPI3K]" value="23906244912320.023" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Akt]" value="59868063199575336" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pAkt]" value="353354698618055.75" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[mTORC1]" value="54363353124623936" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pmTORC1]" value="5858064775376091" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[S6K]" value="54504590279959088" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pS6K]" value="5716827620643109" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Raf]" value="52954255562812696" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pRaf]" value="7267162338328442" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[ppMek]" value="17481983859999028" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[ppErk]" value="25947158987048860" type="Species" simulationType="reactions"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kTGFbOn]" value="0.100647860357268" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[TGFb]" value="0.0050000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kTGFbOff]" value="0.040000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kTGFbRIntern]" value="0.33333333329999998" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kTGFbRRecyc]" value="0.033333333329999999" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2Phos_km]" value="97.053100000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2Phos_kcat]" value="2" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2Dephos_km]" value="100" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2Dephos_Vmax]" value="58.8712661228653" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[GrowthFactors]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_km]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_ki]" value="3.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_Vmax]" value="9000" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_n]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafDephos_km]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafDephosVmax]" value="3602.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_km1]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_ki1]" value="0.25" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_kcat1]" value="125" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[AZD]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kMekDephos_km1]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kMekDephos_Vmax1]" value="2700" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kErkPhos_km1]" value="100" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kErkPhos_kcat1]" value="85.010316145118196" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kErkDephos_km1]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kErkDephos_Vmax1]" value="1800" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByGF]" value="0.23947469870428301" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KDephosByS6K]" value="7.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_km]" value="12.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_ki]" value="0.10000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_kcat]" value="6" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[MK2206]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kAktDephos_km]" value="15" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kAktDephos_Vmax]" value="31.125234450478501" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_km]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_ki]" value="0.001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_kcat]" value="0.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[Everolimus]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Dephos_km]" value="100" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Dephos_Vmax]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kS6KPhosBymTORC1_km]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kS6KPhosBymTORC1_kcat]" value="2.7797522128827201" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kS6KDephos_km]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kS6KDephos_Vmax]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByTGFbR_km]" value="25" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByTGFbR_kcat]" value="265" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByPI3K_km]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByPI3K_kcat]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByTGFbR_km]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByTGFbR_kcat]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KDephosByErk]" value="0.14999999999999999" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2PhosByAkt_km]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2PhosByAkt_kcat]" value="5" type="ModelValue" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R1],ParameterGroup=Parameters,Parameter=TGFb" value="0.0050000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[TGFb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R1],ParameterGroup=Parameters,Parameter=kTGFbOn" value="0.100647860357268" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kTGFbOn],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R2],ParameterGroup=Parameters,Parameter=k1" value="0.040000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kTGFbOff],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R3],ParameterGroup=Parameters,Parameter=k1" value="0.33333333329999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kTGFbRIntern],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R4]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R4],ParameterGroup=Parameters,Parameter=k1" value="0.033333333329999999" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kTGFbRRecyc],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R5]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R5],ParameterGroup=Parameters,Parameter=k1" value="0.33333333329999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kTGFbRIntern],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R6]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R6],ParameterGroup=Parameters,Parameter=k1" value="0.033333333329999999" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kTGFbRRecyc],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R7]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R7],ParameterGroup=Parameters,Parameter=kSmad2Phos_kcat" value="2" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kSmad2Phos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R7],ParameterGroup=Parameters,Parameter=kSmad2Phos_km" value="97.053100000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kSmad2Phos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R8]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R8],ParameterGroup=Parameters,Parameter=kSmad2Dephos_Vmax" value="58.8712661228653" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kSmad2Dephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[TGF_R8],ParameterGroup=Parameters,Parameter=kSmad2Dephos_km" value="100" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kSmad2Dephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R0]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=GrowthFactors" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[GrowthFactors],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=kRafPhos_Vmax" value="9000" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=kRafPhos_ki" value="3.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=kRafPhos_km" value="10" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R0],ParameterGroup=Parameters,Parameter=kRafPhos_n" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_n],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R1],ParameterGroup=Parameters,Parameter=kRafDephosVmax" value="3602.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafDephosVmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R1],ParameterGroup=Parameters,Parameter=kRafDephos_km" value="8" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R2],ParameterGroup=Parameters,Parameter=AZD" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[AZD],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R2],ParameterGroup=Parameters,Parameter=kMekPhos_kcat1" value="125" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_kcat1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R2],ParameterGroup=Parameters,Parameter=kMekPhos_ki1" value="0.25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_ki1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R2],ParameterGroup=Parameters,Parameter=kMekPhos_km1" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R3],ParameterGroup=Parameters,Parameter=AZD" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[AZD],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R3],ParameterGroup=Parameters,Parameter=kMekPhos_kcat1" value="125" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_kcat1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R3],ParameterGroup=Parameters,Parameter=kMekPhos_ki1" value="0.25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_ki1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R3],ParameterGroup=Parameters,Parameter=kMekPhos_km1" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R4]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R4],ParameterGroup=Parameters,Parameter=kMekDephos_Vmax1" value="2700" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekDephos_Vmax1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R4],ParameterGroup=Parameters,Parameter=kMekDephos_km1" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekDephos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R5]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R5],ParameterGroup=Parameters,Parameter=kMekDephos_Vmax1" value="2700" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekDephos_Vmax1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R5],ParameterGroup=Parameters,Parameter=kMekDephos_km1" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kMekDephos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R6]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R6],ParameterGroup=Parameters,Parameter=kErkPhos_kcat1" value="85.010316145118196" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kErkPhos_kcat1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R6],ParameterGroup=Parameters,Parameter=kErkPhos_km1" value="100" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kErkPhos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R7]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R7],ParameterGroup=Parameters,Parameter=kErkPhos_kcat1" value="85.010316145118196" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kErkPhos_kcat1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R7],ParameterGroup=Parameters,Parameter=kErkPhos_km1" value="100" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kErkPhos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R8]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R8],ParameterGroup=Parameters,Parameter=kErkDephos_Vmax1" value="1800" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kErkDephos_Vmax1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R8],ParameterGroup=Parameters,Parameter=kErkDephos_km1" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kErkDephos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R9]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R9],ParameterGroup=Parameters,Parameter=kErkDephos_Vmax1" value="1800" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kErkDephos_Vmax1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[MAPK_R9],ParameterGroup=Parameters,Parameter=kErkDephos_km1" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kErkDephos_km1],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R1],ParameterGroup=Parameters,Parameter=GrowthFactors" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[GrowthFactors],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R1],ParameterGroup=Parameters,Parameter=kPI3KPhosByGF" value="0.23947469870428301" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByGF],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R2],ParameterGroup=Parameters,Parameter=kPI3KDephosByS6K" value="7.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kPI3KDephosByS6K],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R3],ParameterGroup=Parameters,Parameter=MK2206" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[MK2206],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R3],ParameterGroup=Parameters,Parameter=kAktPhos_kcat" value="6" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R3],ParameterGroup=Parameters,Parameter=kAktPhos_ki" value="0.10000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R3],ParameterGroup=Parameters,Parameter=kAktPhos_km" value="12.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R4]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R4],ParameterGroup=Parameters,Parameter=kAktDephos_Vmax" value="31.125234450478501" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kAktDephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R4],ParameterGroup=Parameters,Parameter=kAktDephos_km" value="15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kAktDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R5]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R5],ParameterGroup=Parameters,Parameter=Everolimus" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[Everolimus],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R5],ParameterGroup=Parameters,Parameter=kmTORC1Phos_kcat" value="0.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R5],ParameterGroup=Parameters,Parameter=kmTORC1Phos_ki" value="0.001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_ki],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R5],ParameterGroup=Parameters,Parameter=kmTORC1Phos_km" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R6]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R6],ParameterGroup=Parameters,Parameter=kmTORC1Dephos_Vmax" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Dephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R6],ParameterGroup=Parameters,Parameter=kmTORC1Dephos_km" value="100" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Dephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R7]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R7],ParameterGroup=Parameters,Parameter=kS6KPhosBymTORC1_kcat" value="2.7797522128827201" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kS6KPhosBymTORC1_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R7],ParameterGroup=Parameters,Parameter=kS6KPhosBymTORC1_km" value="10" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kS6KPhosBymTORC1_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R8]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R8],ParameterGroup=Parameters,Parameter=kS6KDephos_Vmax" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kS6KDephos_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[PI3K_R8],ParameterGroup=Parameters,Parameter=kS6KDephos_km" value="10" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kS6KDephos_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR1]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR1],ParameterGroup=Parameters,Parameter=kRafPhosByTGFbR_kcat" value="265" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByTGFbR_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR1],ParameterGroup=Parameters,Parameter=kRafPhosByTGFbR_km" value="25" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByTGFbR_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR2]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR2],ParameterGroup=Parameters,Parameter=kRafPhosByPI3K_kcat" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByPI3K_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR2],ParameterGroup=Parameters,Parameter=kRafPhosByPI3K_km" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByPI3K_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR3]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR3],ParameterGroup=Parameters,Parameter=kPI3KPhosByTGFbR_kcat" value="50" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByTGFbR_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR3],ParameterGroup=Parameters,Parameter=kPI3KPhosByTGFbR_km" value="10" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByTGFbR_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR4]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR4],ParameterGroup=Parameters,Parameter=kPI3KDephosByErk" value="0.14999999999999999" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kPI3KDephosByErk],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR5]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR5],ParameterGroup=Parameters,Parameter=kSmad2PhosByAkt_kcat" value="5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kSmad2PhosByAkt_kcat],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=TGFbModule,Vector=Reactions[CrossTalkR5],ParameterGroup=Parameters,Parameter=kSmad2PhosByAkt_km" value="8" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=TGFbModule,Vector=Values[kSmad2PhosByAkt_km],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_1"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Metabolite_18"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_12"/>
      <StateTemplateVariable objectReference="Metabolite_14"/>
      <StateTemplateVariable objectReference="Metabolite_16"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_17"/>
      <StateTemplateVariable objectReference="Metabolite_15"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Metabolite_20"/>
      <StateTemplateVariable objectReference="Metabolite_19"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_21"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
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
    </StateTemplate>
    <InitialState type="initialState">
      0 582171684778969.5 33762689754202348 70990349477934496 60197511655087616 52954255562812696 5565747685472119 59868063199575336 54363353124623936 54504590279959088 7557984064814293 1.5228567762895856e+17 1.1040507301812789e+17 5821716847789695 46273944241830288 54655670213925624 5716827620643109 5858064775376091 353354698618055.75 17481983859999028 7267162338328442 23906244912320.023 25947158987048860 1 0.100647860357268 0.0050000000000000001 0.040000000000000001 0.33333333329999998 0.033333333329999999 97.053100000000001 2 100 58.8712661228653 1 10 3.5 9000 1 8 3602.5 15 0.25 125 0 15 2700 100 85.010316145118196 15 1800 0.23947469870428301 7.5 12.5 0.10000000000000001 6 1 15 31.125234450478501 1 0.001 0.5 1 100 1 10 2.7797522128827201 10 50 25 265 50 50 10 50 0.14999999999999999 8 5 
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
    <Task key="Task_100" name="Time-Course" scheduled="true" type="timeCourse" update_model="false">
      <Report append="0" confirmOverwrite="0" reference="Report_30" target="D:\MesiSTRAT\CrossTalkModel\copasi_models\TimeCourseData.txt"/>
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
    <Report key="Report_30" name="Time-Course" precision="6" separator="&#9;" taskType="Time-Course">
      <Comment/>
      <Table printTitle="1">
        <Object cn="CN=Root,Model=TGFbModule,Reference=Time"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[ppMek],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[ppErk],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_Cav],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_EE],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[TGFbR_a],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[TGFbR],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pMek],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Mek],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pSmad2],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Smad2],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pErk],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Erk],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pS6K],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[S6K],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pmTORC1],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[mTORC1],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pAkt],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Akt],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pPI3K],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[PI3K],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[pRaf],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Compartments[Cell],Vector=Metabolites[Raf],Reference=Concentration"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[GrowthFactors],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2Dephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByPI3K_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kTGFbRIntern],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kTGFbOff],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[TGFb],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kTGFbOn],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2Dephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2Phos_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2Phos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kTGFbRRecyc],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kS6KPhosBymTORC1_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByTGFbR_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[AZD],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_kcat1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_ki1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kMekPhos_km1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafDephosVmax],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafDephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_n],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_ki],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[MK2206],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kAktDephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kAktDephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_ki],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[Everolimus],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Phos_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Dephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kmTORC1Dephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2PhosByAkt_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KDephosByErk],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kS6KPhosBymTORC1_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kS6KDephos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kS6KDephos_Vmax],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByTGFbR_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kSmad2PhosByAkt_kcat],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kRafPhosByPI3K_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kErkPhos_km1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kErkPhos_kcat1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kMekDephos_km1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kMekDephos_Vmax1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByGF],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KDephosByS6K],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kErkDephos_km1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kErkDephos_Vmax1],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kAktPhos_ki],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByTGFbR_km],Reference=Value"/>
        <Object cn="CN=Root,Model=TGFbModule,Vector=Values[kPI3KPhosByTGFbR_kcat],Reference=Value"/>
      </Table>
    </Report>
  </ListOfReports>
  <SBMLReference file="E_M_72.sbml">
    <SBMLMap SBMLid="AZD" COPASIkey="ModelValue_19"/>
    <SBMLMap SBMLid="AddTGFb" COPASIkey="Event_2"/>
    <SBMLMap SBMLid="Akt" COPASIkey="Metabolite_12"/>
    <SBMLMap SBMLid="Cell" COPASIkey="Compartment_0"/>
    <SBMLMap SBMLid="CrossTalkR1" COPASIkey="Reaction_26"/>
    <SBMLMap SBMLid="CrossTalkR2" COPASIkey="Reaction_27"/>
    <SBMLMap SBMLid="CrossTalkR3" COPASIkey="Reaction_28"/>
    <SBMLMap SBMLid="CrossTalkR4" COPASIkey="Reaction_29"/>
    <SBMLMap SBMLid="CrossTalkR5" COPASIkey="Reaction_30"/>
    <SBMLMap SBMLid="Erk" COPASIkey="Metabolite_8"/>
    <SBMLMap SBMLid="Everolimus" COPASIkey="ModelValue_37"/>
    <SBMLMap SBMLid="GrowthFactors" COPASIkey="ModelValue_9"/>
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
    <SBMLMap SBMLid="MK2206" COPASIkey="ModelValue_31"/>
    <SBMLMap SBMLid="Mek" COPASIkey="Metabolite_6"/>
    <SBMLMap SBMLid="NonCompetitiveInhibition" COPASIkey="Function_40"/>
    <SBMLMap SBMLid="PI3K" COPASIkey="Metabolite_10"/>
    <SBMLMap SBMLid="PI3K_R1" COPASIkey="Reaction_18"/>
    <SBMLMap SBMLid="PI3K_R2" COPASIkey="Reaction_19"/>
    <SBMLMap SBMLid="PI3K_R3" COPASIkey="Reaction_20"/>
    <SBMLMap SBMLid="PI3K_R4" COPASIkey="Reaction_21"/>
    <SBMLMap SBMLid="PI3K_R5" COPASIkey="Reaction_22"/>
    <SBMLMap SBMLid="PI3K_R6" COPASIkey="Reaction_23"/>
    <SBMLMap SBMLid="PI3K_R7" COPASIkey="Reaction_24"/>
    <SBMLMap SBMLid="PI3K_R8" COPASIkey="Reaction_25"/>
    <SBMLMap SBMLid="Raf" COPASIkey="Metabolite_18"/>
    <SBMLMap SBMLid="S6K" COPASIkey="Metabolite_16"/>
    <SBMLMap SBMLid="SerumStarveRemoveGrowthFactors" COPASIkey="Event_1"/>
    <SBMLMap SBMLid="SerumStarveRemoveTGFb" COPASIkey="Event_0"/>
    <SBMLMap SBMLid="Smad2" COPASIkey="Metabolite_4"/>
    <SBMLMap SBMLid="TGF_R1" COPASIkey="Reaction_0"/>
    <SBMLMap SBMLid="TGF_R2" COPASIkey="Reaction_1"/>
    <SBMLMap SBMLid="TGF_R3" COPASIkey="Reaction_2"/>
    <SBMLMap SBMLid="TGF_R4" COPASIkey="Reaction_3"/>
    <SBMLMap SBMLid="TGF_R5" COPASIkey="Reaction_4"/>
    <SBMLMap SBMLid="TGF_R6" COPASIkey="Reaction_5"/>
    <SBMLMap SBMLid="TGF_R7" COPASIkey="Reaction_6"/>
    <SBMLMap SBMLid="TGF_R8" COPASIkey="Reaction_7"/>
    <SBMLMap SBMLid="TGFb" COPASIkey="ModelValue_1"/>
    <SBMLMap SBMLid="TGFbR" COPASIkey="Metabolite_0"/>
    <SBMLMap SBMLid="TGFbR_Cav" COPASIkey="Metabolite_3"/>
    <SBMLMap SBMLid="TGFbR_EE" COPASIkey="Metabolite_2"/>
    <SBMLMap SBMLid="TGFbR_a" COPASIkey="Metabolite_1"/>
    <SBMLMap SBMLid="kAktDephos_Vmax" COPASIkey="ModelValue_33"/>
    <SBMLMap SBMLid="kAktDephos_km" COPASIkey="ModelValue_32"/>
    <SBMLMap SBMLid="kAktPhos_kcat" COPASIkey="ModelValue_30"/>
    <SBMLMap SBMLid="kAktPhos_ki" COPASIkey="ModelValue_29"/>
    <SBMLMap SBMLid="kAktPhos_km" COPASIkey="ModelValue_28"/>
    <SBMLMap SBMLid="kErkDephos_Vmax1" COPASIkey="ModelValue_25"/>
    <SBMLMap SBMLid="kErkDephos_km1" COPASIkey="ModelValue_24"/>
    <SBMLMap SBMLid="kErkPhos_kcat1" COPASIkey="ModelValue_23"/>
    <SBMLMap SBMLid="kErkPhos_km1" COPASIkey="ModelValue_22"/>
    <SBMLMap SBMLid="kMekDephos_Vmax1" COPASIkey="ModelValue_21"/>
    <SBMLMap SBMLid="kMekDephos_km1" COPASIkey="ModelValue_20"/>
    <SBMLMap SBMLid="kMekPhos_kcat1" COPASIkey="ModelValue_18"/>
    <SBMLMap SBMLid="kMekPhos_ki1" COPASIkey="ModelValue_17"/>
    <SBMLMap SBMLid="kMekPhos_km1" COPASIkey="ModelValue_16"/>
    <SBMLMap SBMLid="kPI3KDephosByErk" COPASIkey="ModelValue_50"/>
    <SBMLMap SBMLid="kPI3KDephosByS6K" COPASIkey="ModelValue_27"/>
    <SBMLMap SBMLid="kPI3KPhosByGF" COPASIkey="ModelValue_26"/>
    <SBMLMap SBMLid="kPI3KPhosByTGFbR_kcat" COPASIkey="ModelValue_49"/>
    <SBMLMap SBMLid="kPI3KPhosByTGFbR_km" COPASIkey="ModelValue_48"/>
    <SBMLMap SBMLid="kRafDephosVmax" COPASIkey="ModelValue_15"/>
    <SBMLMap SBMLid="kRafDephos_km" COPASIkey="ModelValue_14"/>
    <SBMLMap SBMLid="kRafPhosByPI3K_kcat" COPASIkey="ModelValue_47"/>
    <SBMLMap SBMLid="kRafPhosByPI3K_km" COPASIkey="ModelValue_46"/>
    <SBMLMap SBMLid="kRafPhosByTGFbR_kcat" COPASIkey="ModelValue_45"/>
    <SBMLMap SBMLid="kRafPhosByTGFbR_km" COPASIkey="ModelValue_44"/>
    <SBMLMap SBMLid="kRafPhos_Vmax" COPASIkey="ModelValue_12"/>
    <SBMLMap SBMLid="kRafPhos_ki" COPASIkey="ModelValue_11"/>
    <SBMLMap SBMLid="kRafPhos_km" COPASIkey="ModelValue_10"/>
    <SBMLMap SBMLid="kRafPhos_n" COPASIkey="ModelValue_13"/>
    <SBMLMap SBMLid="kS6KDephos_Vmax" COPASIkey="ModelValue_43"/>
    <SBMLMap SBMLid="kS6KDephos_km" COPASIkey="ModelValue_42"/>
    <SBMLMap SBMLid="kS6KPhosBymTORC1_kcat" COPASIkey="ModelValue_41"/>
    <SBMLMap SBMLid="kS6KPhosBymTORC1_km" COPASIkey="ModelValue_40"/>
    <SBMLMap SBMLid="kSmad2Dephos_Vmax" COPASIkey="ModelValue_8"/>
    <SBMLMap SBMLid="kSmad2Dephos_km" COPASIkey="ModelValue_7"/>
    <SBMLMap SBMLid="kSmad2PhosByAkt_kcat" COPASIkey="ModelValue_52"/>
    <SBMLMap SBMLid="kSmad2PhosByAkt_km" COPASIkey="ModelValue_51"/>
    <SBMLMap SBMLid="kSmad2Phos_kcat" COPASIkey="ModelValue_6"/>
    <SBMLMap SBMLid="kSmad2Phos_km" COPASIkey="ModelValue_5"/>
    <SBMLMap SBMLid="kTGFbOff" COPASIkey="ModelValue_2"/>
    <SBMLMap SBMLid="kTGFbOn" COPASIkey="ModelValue_0"/>
    <SBMLMap SBMLid="kTGFbRIntern" COPASIkey="ModelValue_3"/>
    <SBMLMap SBMLid="kTGFbRRecyc" COPASIkey="ModelValue_4"/>
    <SBMLMap SBMLid="kmTORC1Dephos_Vmax" COPASIkey="ModelValue_39"/>
    <SBMLMap SBMLid="kmTORC1Dephos_km" COPASIkey="ModelValue_38"/>
    <SBMLMap SBMLid="kmTORC1Phos_kcat" COPASIkey="ModelValue_36"/>
    <SBMLMap SBMLid="kmTORC1Phos_ki" COPASIkey="ModelValue_35"/>
    <SBMLMap SBMLid="kmTORC1Phos_km" COPASIkey="ModelValue_34"/>
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
