<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd xsl dc fn"
    xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dct="http://purl.org/dc/terms/" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:functx="http://www.functx.com" xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:vann="http://purl.org/vocab/vann/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Criado em:</xd:b> Jul 2026</xd:p>
            <xd:p><xd:b>Autor:</xd:b> Meu Validador</xd:p>
            <xd:p>Modulo de definicao de parametros do projeto modelo pessoa</xd:p>
        </xd:desc>
    </xd:doc>

    <!-- Mapeamento de arquivos auxiliares de configuracao -->
    <xsl:variable name="namespacePrefixes" select="fn:doc('namespaces.xml')"/>
    <xsl:variable name="umlDataTypesMapping" select="fn:doc('umlToXsdDataTypes.xml')"/>
    <xsl:variable name="xsdAndRdfDataTypes" select="fn:doc('xsdAndRdfDataTypes.xml')"/>
    <xsl:variable name="metadataJson" select="fn:json-doc('metadata.json')"/>

    <xsl:variable name="defaultNamespaceInterpretation" select="fn:true()"/>

    <!-- URIs Base para a Ontologia, Shapes (SHACL) e Restricoes -->
    <xsl:variable name="base-ontology-uri" select="'http://exemplo.org/ontologia/pessoa'"/>
    <xsl:variable name="base-shape-uri" select="'http://exemplo.org/ontologia/pessoa/data-shape'"/>
    <xsl:variable name="base-restriction-uri" select="$base-ontology-uri"/>

    <xsl:variable name="defaultDelimiter" select="'#'"/>
    <xsl:variable name="moduleReference" select="'core'"/>

    <!-- URIs dos artefatos gerados -->
    <xsl:variable name="shapeArtefactURI"
        select="fn:concat($base-shape-uri, $defaultDelimiter, $moduleReference, '-shape')"/>
    <xsl:variable name="restrictionsArtefactURI"
        select="fn:concat($base-restriction-uri, $defaultDelimiter, $moduleReference, '-restriction')"/>
    <xsl:variable name="coreArtefactURI"
        select="fn:concat($base-ontology-uri, $defaultDelimiter, $moduleReference)"/>

    <!-- Sufixo para as Shapes SHACL -->
    <xsl:variable name="nodeShapeURIsuffix" select="'Shape'"/>

    <!-- Tipos aceitaveis para Object Properties e Listas Controladas -->
    <xsl:variable name="acceptableTypesForObjectProperties" select="('rdfs:Literal')"/>
    <xsl:variable name="controlledListType" select="''"/>

    <!-- Estereotipos Validos -->
    <xsl:variable name="stereotypeValidOnAttributes" select="()"/>
    <xsl:variable name="stereotypeValidOnObjects" select="()"/>
    <xsl:variable name="stereotypeValidOnGeneralisations" select="('Disjoint', 'Equivalent', 'Complete')"/>
    <xsl:variable name="stereotypeValidOnAssociations" select="()"/>
    <xsl:variable name="stereotypeValidOnDependencies" select="('Disjoint', 'disjoint', 'join')"/>
    <xsl:variable name="stereotypeValidOnClasses" select="('Abstract')"/>
    <xsl:variable name="stereotypeValidOnDatatypes" select="()"/>
    <xsl:variable name="stereotypeValidOnEnumerations" select="()"/>
    <xsl:variable name="stereotypeValidOnPackages" select="()"/>
    <xsl:variable name="abstractClassesStereotypes" select="('Abstract', 'abstract class', 'abstract')"/>

    <!-- Geracao de SKOS Concepts para enumeracoes -->
    <xsl:variable name="enableGenerationOfSkosConcept" select="fn:false()"/>
    <xsl:variable name="enableGenerationOfConceptSchemes" select="fn:false()"/>
    <xsl:variable name="cvConstraintLevelProperty" select="''"/>

    <!-- Caracteres permitidos para strings normalizadas -->
    <xsl:variable name="allowedStrings" select="'^[\w\d-_:]+$'"/>

    <!-- Prefixos incluidos para reaproveitamento (Ajustado para o seu prefixo 'ex') -->
    <xsl:variable name="includedPrefixesList" select="('ex')"/>

    <!-- Controle de geracao de conceitos reutilizados nos artefatos -->
    <xsl:variable name="generateReusedConceptsSHACL" select="fn:true()"/>
    <xsl:variable name="generateReusedConceptsOWLcore" select="fn:true()"/>
    <xsl:variable name="generateReusedConceptsOWLrestrictions" select="fn:true()"/>
    <xsl:variable name="generateReusedConceptsGlossary" select="fn:true()"/>
    <xsl:variable name="generateReusedConceptsJSONLDcontext" select="fn:true()"/>

    <!-- Configuracoes de comentarios e notas -->
    <xsl:variable name="commentsGeneration" select="fn:true()"/>
    <xsl:variable name="commentProperty" select="'rdfs:comment'"/>

    <xsl:variable name="statusProperty" select="''"/>
    <xsl:variable name="excludedTagNamesList" select="()"/>
    <xsl:variable name="usageNoteTagName" select="'skos:note'"/>
    <xsl:variable name="mandatoryStatusTagName" select="'cfg:usage'"/>
    <xsl:variable name="referenceTagName" select="'dct:references'"/>
    <xsl:variable name="propertyReferenceRespecLabel" select="'Reuse'"/>
    <xsl:variable name="classReferenceRespecLabel" select="'Reference'"/>
    <xsl:variable name="showReferencesInRespec" select="fn:true()"/>
    <xsl:variable name="customTermLabelTagName" select="'rdfs:label'"/>

    <!-- Filtro de Status Desativado (Para processar todas as suas classes sem descartar nada) -->
    <xsl:variable name="validStatusesList" select="()"/>
    <xsl:variable name="excludedElementStatusesList" select="()"/>
    <xsl:variable name="unspecifiedStatusInterpretation" select="'implemented'"/>

    <xsl:variable name="generateObjectsAndRealisations" select="fn:false()"/>

    <!-- Versoes UML Suportadas -->
    <xsl:variable name="supportedUmlVersions"
        select="('http://www.omg.org/spec/UML/20090901',
            'http://www.omg.org/spec/UML/20131001',
            'https://www.omg.org/spec/UML/20131001',
            'http://www.omg.org/spec/UML/20161101',
            'https://www.omg.org/spec/UML/20161101'
        )"/>

    <xsl:variable name="translatePlainLiteralToStringTypesInSHACL" select="fn:true()"/>
    <xsl:variable name="annotateShaclConceptsWithOntology" select="fn:true()"/>

    <!-- Data de Emissao / Geracao -->
    <xsl:variable name="issuedDate" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>

</xsl:stylesheet>