<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:appinfo="https://docs.oasis-open.org/niemopen/ns/model/appinfo/6.0/"
                xmlns:ct="https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/3.0/"
                xmlns:nf="https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#NDRFunctions"
                xmlns:oxy="http://www.oxygenxml.com/schematron/validation"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:structures="https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0"
                xml:base="file:/C:/Work/NIEM/niem-naming-design-rules/sch/ndr-ct-ext.sch_xslt_cascade"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
   <xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>
   <!--PHASES-->
   <!--PROLOG-->
   <xsl:output xmlns:iso="http://purl.oclc.org/dsdl/schematron" method="xml"/>
   <!--XSD TYPES FOR XSLT2-->
   <!--KEYS AND FUNCTIONS-->
   <!--DEFAULT RULES-->
   <!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-get-full-path">
      <xsl:variable name="sameUri">
         <xsl:value-of select="saxon:system-id() = parent::node()/saxon:system-id()"
                       use-when="function-available('saxon:system-id')"/>
         <xsl:value-of select="oxy:system-id(.) = oxy:system-id(parent::node())"
                       use-when="not(function-available('saxon:system-id')) and function-available('oxy:system-id')"/>
         <xsl:value-of select="true()"
                       use-when="not(function-available('saxon:system-id')) and not(function-available('oxy:system-id'))"/>
      </xsl:variable>
      <xsl:if test="$sameUri = 'true'">
         <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      </xsl:if>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$sameUri = 'true'">
         <xsl:variable name="preceding"
                       select="count(preceding-sibling::*[local-name()=local-name(current())       and namespace-uri() = namespace-uri(current())])"/>
         <xsl:text>[</xsl:text>
         <xsl:value-of select="1+ $preceding"/>
         <xsl:text>]</xsl:text>
      </xsl:if>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:text>text()</xsl:text>
      <xsl:variable name="preceding" select="count(preceding-sibling::text())"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="comment()" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:text>comment()</xsl:text>
      <xsl:variable name="preceding" select="count(preceding-sibling::comment())"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:text>processing-instruction()</xsl:text>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::processing-instruction())"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
   <!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: GENERATE-ID-FROM-PATH -->
   <xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>
   <!--MODE: GENERATE-ID-2 -->
   <xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>
   <!--SCHEMA SETUP-->
   <xsl:template match="/">
      <xsl:apply-templates select="/" mode="M9"/>
      <xsl:apply-templates select="/" mode="M10"/>
      <xsl:apply-templates select="/" mode="M11"/>
      <xsl:apply-templates select="/" mode="M12"/>
      <xsl:apply-templates select="/" mode="M13"/>
      <xsl:apply-templates select="/" mode="M14"/>
      <xsl:apply-templates select="/" mode="M15"/>
      <xsl:apply-templates select="/" mode="M16"/>
      <xsl:apply-templates select="/" mode="M17"/>
      <xsl:apply-templates select="/" mode="M18"/>
      <xsl:apply-templates select="/" mode="M19"/>
      <xsl:apply-templates select="/" mode="M20"/>
      <xsl:apply-templates select="/" mode="M21"/>
      <xsl:apply-templates select="/" mode="M22"/>
      <xsl:apply-templates select="/" mode="M23"/>
      <xsl:apply-templates select="/" mode="M24"/>
      <xsl:apply-templates select="/" mode="M25"/>
      <xsl:apply-templates select="/" mode="M26"/>
      <xsl:apply-templates select="/" mode="M27"/>
      <xsl:apply-templates select="/" mode="M28"/>
      <xsl:apply-templates select="/" mode="M29"/>
      <xsl:apply-templates select="/" mode="M30"/>
      <xsl:apply-templates select="/" mode="M31"/>
      <xsl:apply-templates select="/" mode="M32"/>
      <xsl:apply-templates select="/" mode="M33"/>
      <xsl:apply-templates select="/" mode="M34"/>
      <xsl:apply-templates select="/" mode="M35"/>
      <xsl:apply-templates select="/" mode="M36"/>
      <xsl:apply-templates select="/" mode="M37"/>
      <xsl:apply-templates select="/" mode="M38"/>
      <xsl:apply-templates select="/" mode="M39"/>
      <xsl:apply-templates select="/" mode="M40"/>
      <xsl:apply-templates select="/" mode="M41"/>
      <xsl:apply-templates select="/" mode="M42"/>
      <xsl:apply-templates select="/" mode="M43"/>
      <xsl:apply-templates select="/" mode="M44"/>
      <xsl:apply-templates select="/" mode="M45"/>
      <xsl:apply-templates select="/" mode="M46"/>
      <xsl:apply-templates select="/" mode="M47"/>
      <xsl:apply-templates select="/" mode="M48"/>
      <xsl:apply-templates select="/" mode="M49"/>
      <xsl:apply-templates select="/" mode="M50"/>
      <xsl:apply-templates select="/" mode="M51"/>
      <xsl:apply-templates select="/" mode="M52"/>
      <xsl:apply-templates select="/" mode="M53"/>
      <xsl:apply-templates select="/" mode="M54"/>
      <xsl:apply-templates select="/" mode="M55"/>
      <xsl:apply-templates select="/" mode="M56"/>
      <xsl:apply-templates select="/" mode="M57"/>
      <xsl:apply-templates select="/" mode="M58"/>
      <xsl:apply-templates select="/" mode="M59"/>
      <xsl:apply-templates select="/" mode="M60"/>
      <xsl:apply-templates select="/" mode="M61"/>
      <xsl:apply-templates select="/" mode="M62"/>
      <xsl:apply-templates select="/" mode="M63"/>
      <xsl:apply-templates select="/" mode="M64"/>
      <xsl:apply-templates select="/" mode="M65"/>
      <xsl:apply-templates select="/" mode="M66"/>
      <xsl:apply-templates select="/" mode="M67"/>
      <xsl:apply-templates select="/" mode="M68"/>
      <xsl:apply-templates select="/" mode="M69"/>
      <xsl:apply-templates select="/" mode="M70"/>
      <xsl:apply-templates select="/" mode="M71"/>
      <xsl:apply-templates select="/" mode="M72"/>
      <xsl:apply-templates select="/" mode="M73"/>
      <xsl:apply-templates select="/" mode="M74"/>
      <xsl:apply-templates select="/" mode="M75"/>
      <xsl:apply-templates select="/" mode="M76"/>
      <xsl:apply-templates select="/" mode="M77"/>
      <xsl:apply-templates select="/" mode="M78"/>
      <xsl:apply-templates select="/" mode="M79"/>
      <xsl:apply-templates select="/" mode="M80"/>
      <xsl:apply-templates select="/" mode="M81"/>
      <xsl:apply-templates select="/" mode="M82"/>
      <xsl:apply-templates select="/" mode="M83"/>
      <xsl:apply-templates select="/" mode="M84"/>
      <xsl:apply-templates select="/" mode="M85"/>
      <xsl:apply-templates select="/" mode="M86"/>
      <xsl:apply-templates select="/" mode="M87"/>
      <xsl:apply-templates select="/" mode="M88"/>
      <xsl:apply-templates select="/" mode="M89"/>
      <xsl:apply-templates select="/" mode="M90"/>
      <xsl:apply-templates select="/" mode="M91"/>
      <xsl:apply-templates select="/" mode="M92"/>
      <xsl:apply-templates select="/" mode="M93"/>
      <xsl:apply-templates select="/" mode="M94"/>
      <xsl:apply-templates select="/" mode="M95"/>
      <xsl:apply-templates select="/" mode="M96"/>
      <xsl:apply-templates select="/" mode="M97"/>
      <xsl:apply-templates select="/" mode="M98"/>
      <xsl:apply-templates select="/" mode="M99"/>
      <xsl:apply-templates select="/" mode="M100"/>
      <xsl:apply-templates select="/" mode="M101"/>
      <xsl:apply-templates select="/" mode="M102"/>
      <xsl:apply-templates select="/" mode="M103"/>
      <xsl:apply-templates select="/" mode="M104"/>
      <xsl:apply-templates select="/" mode="M105"/>
      <xsl:apply-templates select="/" mode="M106"/>
      <xsl:apply-templates select="/" mode="M107"/>
      <xsl:apply-templates select="/" mode="M108"/>
      <xsl:apply-templates select="/" mode="M109"/>
      <xsl:apply-templates select="/" mode="M110"/>
      <xsl:apply-templates select="/" mode="M111"/>
      <xsl:apply-templates select="/" mode="M112"/>
      <xsl:apply-templates select="/" mode="M113"/>
      <xsl:apply-templates select="/" mode="M114"/>
      <xsl:apply-templates select="/" mode="M115"/>
      <xsl:apply-templates select="/" mode="M116"/>
      <xsl:apply-templates select="/" mode="M117"/>
      <xsl:apply-templates select="/" mode="M118"/>
      <xsl:apply-templates select="/" mode="M119"/>
      <xsl:apply-templates select="/" mode="M120"/>
      <xsl:apply-templates select="/" mode="M121"/>
      <xsl:apply-templates select="/" mode="M122"/>
      <xsl:apply-templates select="/" mode="M123"/>
      <xsl:apply-templates select="/" mode="M124"/>
      <xsl:apply-templates select="/" mode="M125"/>
      <xsl:apply-templates select="/" mode="M126"/>
      <xsl:apply-templates select="/" mode="M127"/>
      <xsl:apply-templates select="/" mode="M128"/>
      <xsl:apply-templates select="/" mode="M129"/>
      <xsl:apply-templates select="/" mode="M130"/>
      <xsl:apply-templates select="/" mode="M131"/>
      <xsl:apply-templates select="/" mode="M132"/>
      <xsl:apply-templates select="/" mode="M133"/>
      <xsl:apply-templates select="/" mode="M134"/>
      <xsl:apply-templates select="/" mode="M135"/>
      <xsl:apply-templates select="/" mode="M136"/>
      <xsl:apply-templates select="/" mode="M137"/>
      <xsl:apply-templates select="/" mode="M138"/>
      <xsl:apply-templates select="/" mode="M139"/>
      <xsl:apply-templates select="/" mode="M140"/>
      <xsl:apply-templates select="/" mode="M141"/>
      <xsl:apply-templates select="/" mode="M142"/>
      <xsl:apply-templates select="/" mode="M143"/>
      <xsl:apply-templates select="/" mode="M144"/>
      <xsl:apply-templates select="/" mode="M145"/>
      <xsl:apply-templates select="/" mode="M146"/>
      <xsl:apply-templates select="/" mode="M147"/>
      <xsl:apply-templates select="/" mode="M148"/>
      <xsl:apply-templates select="/" mode="M149"/>
      <xsl:apply-templates select="/" mode="M150"/>
      <xsl:apply-templates select="/" mode="M151"/>
      <xsl:apply-templates select="/" mode="M152"/>
      <xsl:apply-templates select="/" mode="M153"/>
      <xsl:apply-templates select="/" mode="M154"/>
      <xsl:apply-templates select="/" mode="M155"/>
      <xsl:apply-templates select="/" mode="M156"/>
      <xsl:apply-templates select="/" mode="M157"/>
      <xsl:apply-templates select="/" mode="M158"/>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <xsl:include xmlns:sch="http://purl.oclc.org/dsdl/schematron" href="ndr-functions.xsl"/>
   <!--PATTERN rule_4-6Document element has attribute ct:conformanceTargets-->
   <!--RULE -->
   <xsl:template match="*[. is nf:get-document-element(.)                       or exists(@ct:conformanceTargets)]"
                 priority="1000"
                 mode="M9">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(. is nf:get-document-element(.)) = exists(@ct:conformanceTargets)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 4-6: The [document element] of the XML document, and only the [document element], MUST own an attribute {https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/3.0/}conformanceTargets.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="@*|node()" mode="M9"/>
   </xsl:template>
   <!--PATTERN rule_4-8Schema claims extension conformance target-->
   <!--RULE -->
   <xsl:template match="*[. is nf:get-document-element(.)]"
                 priority="1000"
                 mode="M10">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="nf:has-effective-conformance-target-identifier(., xs:anyURI(https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ExtensionSchemaDocument'))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 4-8: The document MUST have an effective conformance target identifier of https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ExtensionSchemaDocument.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="@*|node()" mode="M10"/>
   </xsl:template>
   <!--PATTERN rule_9-1No base type in the XML namespace-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M11">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="namespace-uri-from-QName(resolve-QName(@base, .)) != xs:anyURI('http://www.w3.org/XML/1998/namespace')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-1: A schema component must not have a base type definition with a {target namespace} that is the XML namespace.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="@*|node()" mode="M11"/>
   </xsl:template>
   <!--PATTERN rule_9-2No base type of xs:ID-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M12">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:ID')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-2: A schema component MUST NOT have an attribute {}base with a value of xs:ID.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="@*|node()" mode="M12"/>
   </xsl:template>
   <!--PATTERN rule_9-3No base type of xs:IDREF-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M13">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:IDREF')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-3: A schema component MUST NOT have an attribute {}base with a value of xs:IDREF.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="@*|node()" mode="M13"/>
   </xsl:template>
   <!--PATTERN rule_9-4No base type of xs:IDREFS-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M14">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:IDREFS')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-4: A schema component MUST NOT have an attribute {}base with a value of xs:IDREFS.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="@*|node()" mode="M14"/>
   </xsl:template>
   <!--PATTERN rule_9-5No base type of xs:anyType-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M15">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:anyType')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-5: A schema component MUST NOT have an attribute {}base with a value of xs:anyType.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="@*|node()" mode="M15"/>
   </xsl:template>
   <!--PATTERN rule_9-6No base type of xs:anySimpleType-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M16">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:anySimpleType')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of xs:anySimpleType.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="@*|node()" mode="M16"/>
   </xsl:template>
   <!--PATTERN rule_9-7No base type of xs:NOTATION-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M17">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:NOTATION')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-7: A schema component MUST NOT have an attribute {}base with a value of xs:NOTATION.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="@*|node()" mode="M17"/>
   </xsl:template>
   <!--PATTERN rule_9-8No base type of xs:ENTITY-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M18">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:ENTITY')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-8: A schema component MUST NOT have an attribute {}base with a value of xs:ENTITY.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="@*|node()" mode="M18"/>
   </xsl:template>
   <!--PATTERN rule_9-9No base type of xs:ENTITIES-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M19">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:ENTITIES')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-9: A schema component MUST NOT have an attribute {}base with a value of xs:ENTITIES.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="@*|node()" mode="M19"/>
   </xsl:template>
   <!--PATTERN rule_9-10Simple type definition is top-level-->
   <!--RULE -->
   <xsl:template match="xs:simpleType" priority="1000" mode="M20">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:schema)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-10: A simple type definition MUST be top-level.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="@*|node()" mode="M20"/>
   </xsl:template>
   <!--PATTERN rule_9-12Simple type has data definition-->
   <!--RULE -->
   <xsl:template match="xs:simpleType" priority="1000" mode="M21">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                        string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-12: A simple type MUST have a data definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="@*|node()" mode="M21"/>
   </xsl:template>
   <!--PATTERN rule_9-14Enumeration has data definition-->
   <!--RULE -->
   <xsl:template match="xs:enumeration" priority="1000" mode="M22">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                        string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-14: An enumeration facet MUST have a data definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="@*|node()" mode="M22"/>
   </xsl:template>
   <!--PATTERN rule_9-15No list item type of xs:ID-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@itemType)]" priority="1000" mode="M23">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@itemType, .) != xs:QName('xs:ID')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-15: A schema component MUST NOT have an attribute {}itemType with a value of xs:ID.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="@*|node()" mode="M23"/>
   </xsl:template>
   <!--PATTERN rule_9-16No list item type of xs:IDREF-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@itemType)]" priority="1000" mode="M24">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@itemType, .) != xs:QName('xs:IDREF')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-16: A schema component MUST NOT have an attribute {}itemType with a value of xs:IDREF.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="@*|node()" mode="M24"/>
   </xsl:template>
   <!--PATTERN rule_9-17No list item type of xs:anySimpleType-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@itemType)]" priority="1000" mode="M25">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@itemType, .) != xs:QName('xs:anySimpleType')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-17: A schema component MUST NOT have an attribute {}itemType with a value of xs:anySimpleType.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="@*|node()" mode="M25"/>
   </xsl:template>
   <!--PATTERN rule_9-18No list item type of xs:ENTITY-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@itemType)]" priority="1000" mode="M26">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@itemType, .) != xs:QName('xs:ENTITY')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-18: A schema component MUST NOT have an attribute {}itemType with a value of xs:ENTITY.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="@*|node()" mode="M26"/>
   </xsl:template>
   <!--PATTERN rule_9-19No union member types of xs:ID-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M27">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                      in tokenize(normalize-space(@memberTypes), ' ')                      satisfies resolve-QName($type-qname, .) != xs:QName('xs:ID')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-19: A schema component MUST NOT have an attribute {}memberTypes that includes a value of xs:ID.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="@*|node()" mode="M27"/>
   </xsl:template>
   <!--PATTERN rule_9-20No union member types of xs:IDREF-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M28">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                      in tokenize(normalize-space(@memberTypes), ' ')                      satisfies resolve-QName($type-qname, .) != xs:QName('xs:IDREF')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-20: A schema component MUST NOT have an attribute {}memberTypes that includes a value of xs:IDREF.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="@*|node()" mode="M28"/>
   </xsl:template>
   <!--PATTERN rule_9-21No union member types of xs:IDREFS-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M29">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                      in tokenize(normalize-space(@memberTypes), ' ')                      satisfies resolve-QName($type-qname, .) != xs:QName('xs:IDREFS')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-21: A schema component MUST NOT have an attribute {}memberTypes that includes a value of xs:IDREFS.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="@*|node()" mode="M29"/>
   </xsl:template>
   <!--PATTERN rule_9-22No union member types of xs:anySimpleType-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M30">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                      in tokenize(normalize-space(@memberTypes), ' ')                      satisfies resolve-QName($type-qname, .) != xs:QName('xs:anySimpleType')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-22: A schema component MUST NOT have an attribute {}memberTypes that includes a value of xs:anySimpleType.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="@*|node()" mode="M30"/>
   </xsl:template>
   <!--PATTERN rule_9-23No union member types of xs:ENTITY-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M31">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                      in tokenize(normalize-space(@memberTypes), ' ')                      satisfies resolve-QName($type-qname, .) != xs:QName('xs:ENTITY')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-23: A schema component MUST NOT have an attribute {}memberTypes that includes a value of xs:ENTITY.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="@*|node()" mode="M31"/>
   </xsl:template>
   <!--PATTERN rule_9-24No union member types of xs:ENTITIES-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M32">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                      in tokenize(normalize-space(@memberTypes), ' ')                      satisfies resolve-QName($type-qname, .) != xs:QName('xs:ENTITIES')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-24: A schema component MUST NOT have an attribute {}memberTypes that includes a value of xs:ENTITIES.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="@*|node()" mode="M32"/>
   </xsl:template>
   <!--PATTERN rule_9-25Complex type definition is top-level-->
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M33">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:schema)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-25: A complex type definition MUST be top-level.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="@*|node()" mode="M33"/>
   </xsl:template>
   <!--PATTERN rule_9-26Complex type has data definition-->
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M34">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                        string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-26: A complex type MUST have a data definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="@*|node()" mode="M34"/>
   </xsl:template>
   <!--PATTERN rule_9-27No mixed content on complex type-->
   <!--RULE -->
   <xsl:template match="xs:complexType[exists(@mixed)]" priority="1000" mode="M35">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:boolean(@mixed) = false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-27: A complex type definition MUST NOT have mixed content.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="@*|node()" mode="M35"/>
   </xsl:template>
   <!--PATTERN rule_9-28No mixed content on complex content-->
   <!--RULE -->
   <xsl:template match="xs:complexContent[exists(@mixed)]"
                 priority="1000"
                 mode="M36">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:boolean(@mixed) = false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-28: A complex type definition with complex content MUST NOT have mixed content.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="@*|node()" mode="M36"/>
   </xsl:template>
   <!--PATTERN rule_9-29Complex type content is explicitly simple or complex-->
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M37">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(xs:simpleContent) or exists(xs:complexContent)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-29: An element xs:complexType MUST have a child element xs:simpleContent or xs:complexContent.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="@*|node()" mode="M37"/>
   </xsl:template>
   <!--PATTERN rule_9-31Base type of complex type with complex content must have complex content-->
   <!--RULE -->
   <xsl:template match="xs:complexType/xs:complexContent/xs:*[                       (self::xs:extension or self::xs:restriction)                       and (some $base-qname in resolve-QName(@base, .) satisfies                              namespace-uri-from-QName($base-qname) = nf:get-target-namespace(.))]"
                 priority="1000"
                 mode="M38">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $base-type in nf:resolve-type(., resolve-QName(@base, .)) satisfies                        empty($base-type/self::xs:complexType/xs:simpleContent)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-31: The base type of complex type that has complex content MUST be a complex type with complex content.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="@*|node()" mode="M38"/>
   </xsl:template>
   <!--PATTERN rule_9-36Element declaration is top-level-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name)]" priority="1000" mode="M39">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:schema)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-36: An element declaration MUST be top-level.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="@*|node()" mode="M39"/>
   </xsl:template>
   <!--PATTERN rule_9-37Element declaration has data definition-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name)]" priority="1000" mode="M40">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                        string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-37: An element declaration MUST have a data definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="@*|node()" mode="M40"/>
   </xsl:template>
   <!--PATTERN rule_9-38Untyped element is abstract-->
   <!--RULE -->
   <xsl:template match="xs:schema/xs:element[empty(@type)]"
                 priority="1000"
                 mode="M41">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@abstract)                      and xs:boolean(@abstract) = true()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-38: A top-level element declaration that does not set the {type definition} property via the attribute "type" MUST have the {abstract} property with a value of "true".</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="@*|node()" mode="M41"/>
   </xsl:template>
   <!--PATTERN rule_9-39Element of type xs:anySimpleType is abstract-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)                                and resolve-QName(@type, .) = xs:QName('xs:anySimpleType')]"
                 priority="1000"
                 mode="M42">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@abstract)                      and xs:boolean(@abstract) = true()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-39: An element declaration that has a type xs:anySimpleType MUST have the {abstract} property with a value of "true".</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="@*|node()" mode="M42"/>
   </xsl:template>
   <!--PATTERN rule_9-41Element type not in the XML namespace-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)]" priority="1000" mode="M43">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="namespace-uri-from-QName(resolve-QName(@type, .)) != 'http://www.w3.org/XML/1998/namespace'"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-41: An element type MUST NOT have a namespace name that is in the XML namespace.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="@*|node()" mode="M43"/>
   </xsl:template>
   <!--PATTERN rule_9-42Element type is not simple type-->
   <!--RULE -->
   <xsl:template match="xs:element[@type]" priority="1000" mode="M44">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname in resolve-QName(@type, .),                            $type-ns in namespace-uri-from-QName($type-qname),                            $type-local-name in local-name-from-QName($type-qname) satisfies (                        $type-qname = xs:QName('xs:anySimpleType')                        or (($type-ns = nf:get-target-namespace(.)                             or exists(nf:get-document-element(.)/xs:import[                                         xs:anyURI(@namespace) = $type-ns                                         and empty(@appinfo:externalImportIndicator)]))                            and not(ends-with($type-local-name, 'SimpleType'))))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-42: An element type that is not xs:anySimpleType MUST NOT be a simple type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="@*|node()" mode="M44"/>
   </xsl:template>
   <!--PATTERN rule_9-45No element default value-->
   <!--RULE -->
   <xsl:template match="xs:element" priority="1000" mode="M45">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@default)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-45: An element xs:element MUST NOT have an attribute {}default.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="@*|node()" mode="M45"/>
   </xsl:template>
   <!--PATTERN rule_9-46No element fixed value-->
   <!--RULE -->
   <xsl:template match="xs:element" priority="1000" mode="M46">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@fixed)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-46: An element xs:element MUST NOT have an attribute {}fixed.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="@*|node()" mode="M46"/>
   </xsl:template>
   <!--PATTERN rule_9-48Attribute declaration is top-level-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M47">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:schema)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-48: An attribute declaration MUST be top-level.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="@*|node()" mode="M47"/>
   </xsl:template>
   <!--PATTERN rule_9-49Attribute declaration has data definition-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M48">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                        string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-49: An attribute declaration MUST have a data definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="@*|node()" mode="M48"/>
   </xsl:template>
   <!--PATTERN rule_9-50Attribute declaration has type-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M49">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@type)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-50: A top-level attribute declaration MUST have a type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="@*|node()" mode="M49"/>
   </xsl:template>
   <!--PATTERN rule_9-51No attribute type of xs:ID-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M50">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:ID')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-51: A schema component MUST NOT have an attribute {}type with a value of xs:ID.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="@*|node()" mode="M50"/>
   </xsl:template>
   <!--PATTERN rule_9-52No attribute type of xs:IDREF-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M51">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:IDREF')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-52: A schema component MUST NOT have an attribute {}type with a value of xs:IDREF.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="@*|node()" mode="M51"/>
   </xsl:template>
   <!--PATTERN rule_9-53No attribute type of xs:IDREFS-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M52">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:IDREFS')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-53: A schema component MUST NOT have an attribute {}type with a value of xs:IDREFS.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="@*|node()" mode="M52"/>
   </xsl:template>
   <!--PATTERN rule_9-54No attribute type of xs:ENTITY-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M53">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:ENTITY')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-54: A schema component MUST NOT have an attribute {}type with a value of xs:ENTITY.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="@*|node()" mode="M53"/>
   </xsl:template>
   <!--PATTERN rule_9-55No attribute type of xs:ENTITIES-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M54">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:ENTITIES')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-55: A schema component MUST NOT have an attribute {}type with a value of xs:ENTITIES.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="@*|node()" mode="M54"/>
   </xsl:template>
   <!--PATTERN rule_9-56No attribute type of xs:anySimpleType-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M55">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:anySimpleType')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-56: A schema component MUST NOT have an attribute {}type with a value of xs:anySimpleType.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="@*|node()" mode="M55"/>
   </xsl:template>
   <!--PATTERN rule_9-57No attribute default values-->
   <!--RULE -->
   <xsl:template match="xs:attribute" priority="1000" mode="M56">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@default)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-57: An element xs:attribute MUST NOT have an attribute {}default.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="@*|node()" mode="M56"/>
   </xsl:template>
   <!--PATTERN rule_9-58No fixed values for optional attributes-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@ref) and @use eq 'required']"
                 priority="1001"
                 mode="M57">

		<!--REPORT warning-->
      <xsl:if test="false()">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>This rule does not constrain attribute uses that are required</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M57"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:attribute" priority="1000" mode="M57">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@fixed)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-58: An element xs:attribute that is not a required attribute use MUST NOT have an attribute {}fixed.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="@*|node()" mode="M57"/>
   </xsl:template>
   <!--PATTERN rule_9-59No use of element xs:notation-->
   <!--RULE -->
   <xsl:template match="xs:notation" priority="1000" mode="M58">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-59: The schema MUST NOT contain the element xs:notation.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="@*|node()" mode="M58"/>
   </xsl:template>
   <!--PATTERN rule_9-61No xs:all-->
   <!--RULE -->
   <xsl:template match="xs:all" priority="1000" mode="M59">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-61: The schema MUST NOT contain the element xs:all</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="@*|node()" mode="M59"/>
   </xsl:template>
   <!--PATTERN rule_9-63xs:sequence must be child of xs:extension or xs:restriction-->
   <!--RULE -->
   <xsl:template match="xs:sequence" priority="1000" mode="M60">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:extension) or exists(parent::xs:restriction)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-63: An element xs:sequence MUST be a child of element xs:extension or xs:restriction.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="@*|node()" mode="M60"/>
   </xsl:template>
   <!--PATTERN rule_9-65xs:choice must be child of xs:sequence-->
   <!--RULE -->
   <xsl:template match="xs:choice" priority="1000" mode="M61">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:sequence)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-65: An element xs:choice MUST be a child of element xs:sequence.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="@*|node()" mode="M61"/>
   </xsl:template>
   <!--PATTERN rule_9-66Sequence has minimum cardinality 1-->
   <!--RULE -->
   <xsl:template match="xs:sequence" priority="1000" mode="M62">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@minOccurs) or xs:integer(@minOccurs) = 1"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-66: An element xs:sequence MUST either not have the attribute {}minOccurs, or that attribute MUST have a value of 1.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="@*|node()" mode="M62"/>
   </xsl:template>
   <!--PATTERN rule_9-67Sequence has maximum cardinality 1-->
   <!--RULE -->
   <xsl:template match="xs:sequence" priority="1000" mode="M63">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@maxOccurs) or (@maxOccurs instance of xs:integer                                            and 1 = xs:integer(@maxOccurs))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-67: An element xs:sequence MUST either not have the attribute {}maxOccurs, or that attribute MUST have a value of 1.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="@*|node()" mode="M63"/>
   </xsl:template>
   <!--PATTERN rule_9-68Choice has minimum cardinality 1-->
   <!--RULE -->
   <xsl:template match="xs:choice" priority="1000" mode="M64">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@minOccurs) or 1 = xs:integer(@minOccurs)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-68: An element xs:choice MUST either not have the attribute {}minOccurs, or that attribute MUST have a value of 1.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="@*|node()" mode="M64"/>
   </xsl:template>
   <!--PATTERN rule_9-69Choice has maximum cardinality 1-->
   <!--RULE -->
   <xsl:template match="xs:choice" priority="1000" mode="M65">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@maxOccurs) or (@maxOccurs instance of xs:integer                                            and 1 = xs:integer(@maxOccurs))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-69: An element xs:choice MUST either not have the attribute {}maxOccurs, or that attribute MUST have a value of 1.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="@*|node()" mode="M65"/>
   </xsl:template>
   <!--PATTERN rule_9-72No use of xs:unique-->
   <!--RULE -->
   <xsl:template match="xs:unique" priority="1000" mode="M66">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-72: The schema MUST NOT contain the element xs:unique.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="@*|node()" mode="M66"/>
   </xsl:template>
   <!--PATTERN rule_9-73No use of xs:key-->
   <!--RULE -->
   <xsl:template match="xs:key" priority="1000" mode="M67">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-73: The schema MUST NOT contain the element xs:key.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="@*|node()" mode="M67"/>
   </xsl:template>
   <!--PATTERN rule_9-74No use of xs:keyref-->
   <!--RULE -->
   <xsl:template match="xs:keyref" priority="1000" mode="M68">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-74: The schema MUST NOT contain the element xs:keyref.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="@*|node()" mode="M68"/>
   </xsl:template>
   <!--PATTERN rule_9-75No use of xs:group-->
   <!--RULE -->
   <xsl:template match="xs:group" priority="1000" mode="M69">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-75: The schema MUST NOT contain the element xs:group.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="@*|node()" mode="M69"/>
   </xsl:template>
   <!--PATTERN rule_9-76No definition of attribute groups-->
   <!--RULE -->
   <xsl:template match="xs:attributeGroup[@name]" priority="1000" mode="M70">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-76: The schema MUST NOT contain an attribute group definition schema component.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="@*|node()" mode="M70"/>
   </xsl:template>
   <!--PATTERN rule_9-77Comment is not recommended-->
   <!--RULE -->
   <xsl:template match="node()[comment()]" priority="1000" mode="M71">

		<!--REPORT warning-->
      <xsl:if test="true()">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>An XML Comment is not an XML Schema annotation component; an XML comment SHOULD NOT appear in the schema.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="@*|node()" mode="M71"/>
   </xsl:template>
   <!--PATTERN rule_9-78Documentation element has no element children-->
   <!--RULE -->
   <xsl:template match="xs:documentation/node()" priority="1000" mode="M72">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="self::text() or self::comment()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-78: A child of element xs:documentation MUST be text or an XML comment.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="@*|node()" mode="M72"/>
   </xsl:template>
   <!--PATTERN rule_9-79xs:appinfo children are comments, elements, or whitespace-->
   <!--RULE -->
   <xsl:template match="xs:appinfo/node()" priority="1000" mode="M73">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="self::comment()                      or self::element()                      or self::text()[string-length(normalize-space(.)) = 0]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-79: A child of element xs:appinfo MUST be an element, a comment, or whitespace text.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="@*|node()" mode="M73"/>
   </xsl:template>
   <!--PATTERN rule_9-80Appinfo child elements have namespaces-->
   <!--RULE -->
   <xsl:template match="xs:appinfo/*" priority="1000" mode="M74">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="namespace-uri() != xs:anyURI('')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-80: An element that is a child of xs:appinfo MUST have a namespace name.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="@*|node()" mode="M74"/>
   </xsl:template>
   <!--PATTERN rule_9-81Appinfo descendants are not XML Schema elements-->
   <!--RULE -->
   <xsl:template match="xs:appinfo//xs:*" priority="1000" mode="M75">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-81: An element with a namespace name of xs: MUST NOT have an ancestor element xs:appinfo.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="@*|node()" mode="M75"/>
   </xsl:template>
   <!--PATTERN rule_9-82Schema has data definition-->
   <!--RULE -->
   <xsl:template match="xs:schema" priority="1000" mode="M76">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in (xs:annotation/xs:documentation)[1] satisfies                        string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-82: An element xs:schema MUST have a data definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="@*|node()" mode="M76"/>
   </xsl:template>
   <!--PATTERN rule_9-83Schema document defines target namespace-->
   <!--RULE -->
   <xsl:template match="xs:schema" priority="1000" mode="M77">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@targetNamespace)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-83: The schema MUST define a target namespace.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="@*|node()" mode="M77"/>
   </xsl:template>
   <!--PATTERN rule_9-85Schema has version-->
   <!--RULE -->
   <xsl:template match="xs:schema" priority="1000" mode="M78">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $version in @version satisfies                      string-length(normalize-space(@version)) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-85: An element xs:schema MUST have an attribute {}version that MUST NOT be empty.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="@*|node()" mode="M78"/>
   </xsl:template>
   <!--PATTERN rule_9-88No use of xs:redefine-->
   <!--RULE -->
   <xsl:template match="xs:redefine" priority="1000" mode="M79">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-88: The schema MUST NOT contain the element xs:redefine.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="@*|node()" mode="M79"/>
   </xsl:template>
   <!--PATTERN rule_9-89No use of xs:include-->
   <!--RULE -->
   <xsl:template match="xs:include" priority="1000" mode="M80">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-89: The schema MUST NOT contain the element xs:include.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="@*|node()" priority="-2" mode="M80">
      <xsl:apply-templates select="@*|node()" mode="M80"/>
   </xsl:template>
   <!--PATTERN rule_9-90xs:import must have namespace-->
   <!--RULE -->
   <xsl:template match="xs:import" priority="1000" mode="M81">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@namespace)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-90: An element xs:import MUST have an attribute {}namespace.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="@*|node()" priority="-2" mode="M81">
      <xsl:apply-templates select="@*|node()" mode="M81"/>
   </xsl:template>
   <!--PATTERN rule_9-92Namespace referenced by attribute type is imported-->
   <!--RULE -->
   <xsl:template match="xs:*[@type]" priority="1000" mode="M82">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $namespace in namespace-uri-from-QName(resolve-QName(@type, .)) satisfies (                        $namespace = nf:get-target-namespace(.)                        or $namespace = xs:anyURI('http://www.w3.org/2001/XMLSchema')                        or nf:get-document-element(.)/xs:import[xs:anyURI(@namespace) = $namespace])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-92: The namespace of a type referenced by @type MUST be the target namespace, the XML Schema namespace, or be imported.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="@*|node()" priority="-2" mode="M82">
      <xsl:apply-templates select="@*|node()" mode="M82"/>
   </xsl:template>
   <!--PATTERN rule_9-93Namespace referenced by attribute base is imported-->
   <!--RULE -->
   <xsl:template match="xs:*[@base]" priority="1000" mode="M83">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $namespace in namespace-uri-from-QName(resolve-QName(@base, .)) satisfies (                        $namespace = nf:get-target-namespace(.)                        or $namespace = xs:anyURI('http://www.w3.org/2001/XMLSchema')                        or nf:get-document-element(.)/xs:import[xs:anyURI(@namespace) = $namespace])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-93: The namespace of a type referenced by @base MUST be the target namespace, the XML Schema namespace, or be imported.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="@*|node()" priority="-2" mode="M83">
      <xsl:apply-templates select="@*|node()" mode="M83"/>
   </xsl:template>
   <!--PATTERN rule_9-94Namespace referenced by attribute itemType is imported-->
   <!--RULE -->
   <xsl:template match="xs:*[@itemType]" priority="1000" mode="M84">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $namespace in namespace-uri-from-QName(resolve-QName(@itemType, .)) satisfies (                        $namespace = nf:get-target-namespace(.)                        or $namespace = xs:anyURI('http://www.w3.org/2001/XMLSchema')                        or nf:get-document-element(.)/xs:import[xs:anyURI(@namespace) = $namespace])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-94: The namespace of a type referenced by @itemType MUST be the target namespace, the XML Schema namespace, or be imported.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M84"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M84"/>
   <xsl:template match="@*|node()" priority="-2" mode="M84">
      <xsl:apply-templates select="@*|node()" mode="M84"/>
   </xsl:template>
   <!--PATTERN rule_9-95Namespaces referenced by attribute memberTypes is imported-->
   <!--RULE -->
   <xsl:template match="xs:*[@memberTypes]" priority="1000" mode="M85">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type in tokenize(normalize-space(@memberTypes), ' '),                            $namespace in namespace-uri-from-QName(resolve-QName($type, .)) satisfies (                        $namespace = nf:get-target-namespace(.)                        or $namespace = xs:anyURI('http://www.w3.org/2001/XMLSchema')                        or nf:get-document-element(.)/xs:import[xs:anyURI(@namespace) = $namespace])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-95: The namespace of a type referenced by @memberTypes MUST be the target namespace, the XML Schema namespace, or be imported.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M85"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M85"/>
   <xsl:template match="@*|node()" priority="-2" mode="M85">
      <xsl:apply-templates select="@*|node()" mode="M85"/>
   </xsl:template>
   <!--PATTERN rule_9-96Namespace referenced by attribute ref is imported-->
   <!--RULE -->
   <xsl:template match="xs:*[@ref]" priority="1000" mode="M86">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies                        $namespace = nf:get-target-namespace(.)                        or nf:get-document-element(.)/xs:import[xs:anyURI(@namespace) = $namespace]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-96: The namespace of a component referenced by @ref MUST be the target namespace or be imported.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M86"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M86"/>
   <xsl:template match="@*|node()" priority="-2" mode="M86">
      <xsl:apply-templates select="@*|node()" mode="M86"/>
   </xsl:template>
   <!--PATTERN rule_9-97Namespace referenced by attribute substitutionGroup is imported-->
   <!--RULE -->
   <xsl:template match="xs:*[@substitutionGroup]" priority="1000" mode="M87">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $namespace in namespace-uri-from-QName(resolve-QName(@substitutionGroup, .)) satisfies                        $namespace = nf:get-target-namespace(.)                        or nf:get-document-element(.)/xs:import[xs:anyURI(@namespace) = $namespace]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 9-97: The namespace of a component referenced by @substitutionGroup MUST be the target namespace or be imported.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="@*|node()" priority="-2" mode="M87">
      <xsl:apply-templates select="@*|node()" mode="M87"/>
   </xsl:template>
   <!--PATTERN rule_10-2Object type with complex content is derived from structures:ObjectType-->
   <!--RULE -->
   <xsl:template match="xs:complexType[exists(xs:complexContent)                                    and not(ends-with(@name, 'AssociationType')                                        or ends-with(@name, 'MetadataType')                                        or ends-with(@name, 'AugmentationType'))]"
                 priority="1000"
                 mode="M88">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="        every $derivation-method in (xs:complexContent/xs:extension, xs:complexContent/xs:restriction),              $base in $derivation-method/@base,              $base-qname in resolve-QName($base, $derivation-method),              $base-local-name in local-name-from-QName($base-qname) satisfies (          $base-qname = xs:QName('structures:ObjectType')          or not(ends-with($base-local-name, 'AssociationType')                 or ends-with($base-local-name, 'AugmentationType')))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-2: An object type with complex content MUST be derived from structures:ObjectType or from another object type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M88"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M88"/>
   <xsl:template match="@*|node()" priority="-2" mode="M88">
      <xsl:apply-templates select="@*|node()" mode="M88"/>
   </xsl:template>
   <!--PATTERN rule_10-7Import of external namespace has data definition-->
   <!--RULE -->
   <xsl:template match="xs:import[@appinfo:externalImportIndicator]"
                 priority="1000"
                 mode="M89">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                        string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-7: An element xs:import that is annotated as importing an external schema document MUST be a documented component.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M89"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M89"/>
   <xsl:template match="@*|node()" priority="-2" mode="M89">
      <xsl:apply-templates select="@*|node()" mode="M89"/>
   </xsl:template>
   <!--PATTERN rule_10-9Structure of external adapter type definition follows pattern-->
   <!--RULE -->
   <xsl:template match="xs:complexType[@appinfo:externalAdapterTypeIndicator]"
                 priority="1000"
                 mode="M90">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:complexContent/xs:extension[                        resolve-QName(@base, .) = xs:QName('structures:ObjectType')                      ]/xs:sequence"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-9: An external adapter type definition MUST be a complex type definition with complex content that extends structures:ObjectType, and that uses xs:sequence as its top-level compositor.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="@*|node()" priority="-2" mode="M90">
      <xsl:apply-templates select="@*|node()" mode="M90"/>
   </xsl:template>
   <!--PATTERN rule_10-10Element use from external adapter type defined by external schema documents-->
   <!--RULE -->
   <xsl:template match="xs:element[@ref                                and exists(ancestor::xs:complexType[exists(@appinfo:externalAdapterTypeIndicator)])]"
                 priority="1000"
                 mode="M91">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies                        nf:get-document-element(.)/xs:import[                          $ref-namespace = xs:anyURI(@namespace)                          and @appinfo:externalImportIndicator]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-10: An element reference that appears within an external adapter type MUST have a target namespace that is imported as external.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M91"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M91"/>
   <xsl:template match="@*|node()" priority="-2" mode="M91">
      <xsl:apply-templates select="@*|node()" mode="M91"/>
   </xsl:template>
   <!--PATTERN rule_10-11External adapter type not a base type-->
   <!--RULE -->
   <xsl:template match="xs:*[(self::xs:extension or self::xs:restriction)                          and (some $base-qname in resolve-QName(@base, .),                                    $base-namespace in namespace-uri-from-QName($base-qname) satisfies                                 nf:get-target-namespace(.) = $base-namespace)]"
                 priority="1000"
                 mode="M92">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="nf:resolve-type(., resolve-QName(@base, .))[                        empty(@appinfo:externalAdapterTypeIndicator)]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-11: An external adapter type definition MUST NOT be a base type definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M92"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M92"/>
   <xsl:template match="@*|node()" priority="-2" mode="M92">
      <xsl:apply-templates select="@*|node()" mode="M92"/>
   </xsl:template>
   <!--PATTERN rule_10-14External attribute use has data definition-->
   <!--RULE -->
   <xsl:template match="xs:attribute[some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)),                                       $import in ancestor::xs:schema[1]/xs:import satisfies (                                    xs:anyURI($import/@namespace) = $ref-namespace                                    and exists(@appinfo:externalImportIndicator))]"
                 priority="1000"
                 mode="M93">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $documentation in xs:annotation/xs:documentation[1] satisfies                        string-length(normalize-space(string($documentation))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-14: An external attribute use MUST be a documented component with a non-empty data definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M93"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M93"/>
   <xsl:template match="@*|node()" priority="-2" mode="M93">
      <xsl:apply-templates select="@*|node()" mode="M93"/>
   </xsl:template>
   <!--PATTERN rule_10-16External element use has data definition-->
   <!--RULE -->
   <xsl:template match="xs:element[      some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies        nf:get-document-element(.)/self::xs:schema//xs:import[          xs:anyURI(@namespace) = $ref-namespace          and @appinfo:externalImportIndicator]]"
                 priority="1000"
                 mode="M94">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $documentation in xs:annotation/xs:documentation[1] satisfies                        string-length(normalize-space(string($documentation))) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-16: An external attribute use MUST be a documented component with a non-empty data definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M94"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M94"/>
   <xsl:template match="@*|node()" priority="-2" mode="M94">
      <xsl:apply-templates select="@*|node()" mode="M94"/>
   </xsl:template>
   <!--PATTERN rule_10-17Name of code type ends in "CodeType"-->
   <!--RULE -->
   <xsl:template match="xs:complexType[exists(xs:simpleContent[                       exists(xs:*[local-name() = ('extension', 'restriction')                                   and (ends-with(@base, 'CodeSimpleType')                                   or ends-with(@base, 'CodeType'))])])]"
                 priority="1000"
                 mode="M95">

		<!--REPORT warning-->
      <xsl:if test="not(ends-with(@name, 'CodeType'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>A complex type definition with a {base type definition} of a code type or code simple type SHOULD have a {name} that ends in 'CodeType'.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M95"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M95"/>
   <xsl:template match="@*|node()" priority="-2" mode="M95">
      <xsl:apply-templates select="@*|node()" mode="M95"/>
   </xsl:template>
   <!--PATTERN rule_10-19Element of code type has code representation term-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name) and exists(@type) and ends-with(@type, 'CodeType')]"
                 priority="1000"
                 mode="M96">

		<!--REPORT warning-->
      <xsl:if test="not(ends-with(@name, 'Code'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>An element with a type that is a code type SHOULD have a name with representation term "Code"</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="@*|node()" priority="-2" mode="M96">
      <xsl:apply-templates select="@*|node()" mode="M96"/>
   </xsl:template>
   <!--PATTERN rule_10-20Proxy type has designated structure-->
   <!--RULE -->
   <xsl:template match="xs:complexType[some $name in @name,                                    $extension in xs:simpleContent/xs:extension,                                    $base-qname in resolve-QName($extension/@base, $extension) satisfies                                    $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"
                 priority="1000"
                 mode="M97">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:simpleContent[                        xs:extension[                          empty(xs:attribute)                          and count(xs:attributeGroup) = 1                          and xs:attributeGroup[                                resolve-QName(@ref, .) = xs:QName('structures:SimpleObjectAttributeGroup')]]]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-20: A proxy type MUST have the designated structure. It MUST use xs:extension. It MUST NOT use xs:attribute. It MUST include exactly one xs:attributeGroup reference, which must be to structures:SimpleObjectAttributeGroup.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M97"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M97"/>
   <xsl:template match="@*|node()" priority="-2" mode="M97">
      <xsl:apply-templates select="@*|node()" mode="M97"/>
   </xsl:template>
   <!--PATTERN rule_10-21Association type derived from structures:AssociationType-->
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M98">
      <xsl:variable name="is-association-type"
                    select="exists(@name[ends-with(., 'AssociationType')])"/>
      <xsl:variable name="has-association-base-type"
                    select="      exists(xs:complexContent[        exists(xs:*[local-name() = ('extension', 'restriction')                    and exists(@base[ends-with(., 'AssociationType')])])])"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$is-association-type = $has-association-base-type"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-21: A type MUST have an association type name if and only if it is derived from an association type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M98"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M98"/>
   <xsl:template match="@*|node()" priority="-2" mode="M98">
      <xsl:apply-templates select="@*|node()" mode="M98"/>
   </xsl:template>
   <!--PATTERN rule_10-22Association element type is an association type-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name)]" priority="1000" mode="M99">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@type[ends-with(., 'AssociationType')])                      = exists(@name[ends-with(., 'Association')])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-22: An element MUST have a name that ends in 'Association' if and only if it has a type that is an association type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M99"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M99"/>
   <xsl:template match="@*|node()" priority="-2" mode="M99">
      <xsl:apply-templates select="@*|node()" mode="M99"/>
   </xsl:template>
   <!--PATTERN rule_10-24Augmentable type has at most one augmentation point element-->
   <!--RULE -->
   <xsl:template match="xs:complexType[                       @name[not(ends-with(., 'MetadataType'))                             and not(ends-with(., 'AugmentationType'))]                       and empty(@appinfo:externalAdapterTypeIndicator)                       and xs:complexContent]"
                 priority="1000"
                 mode="M100">
      <xsl:variable name="augmentation-point-qname"
                    select="QName(string(nf:get-target-namespace(.)),                          replace(./@name, 'Type$', 'AugmentationPoint'))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(xs:complexContent/xs:extension/xs:sequence/xs:element[                              @ref[resolve-QName(., ..) = $augmentation-point-qname]]) le 1"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-24: An augmentable type MUST contain no more than one element use of its corresponding augmentation point element.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M100"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M100"/>
   <xsl:template match="@*|node()" priority="-2" mode="M100">
      <xsl:apply-templates select="@*|node()" mode="M100"/>
   </xsl:template>
   <!--PATTERN rule_10-25Augmentation point element corresponds to its base type-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name[                                 matches(., 'AugmentationPoint$')])]"
                 priority="1000"
                 mode="M101">
      <xsl:variable name="element-name" select="@name"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(                        parent::xs:schema/xs:complexType[                          @name = replace($element-name, 'AugmentationPoint$', 'Type')                          and exists(@name[                                  not(ends-with(., 'MetadataType'))                                  and not(ends-with(., 'AugmentationType'))])                                and empty(@appinfo:externalAdapterTypeIndicator)                                and exists(child::xs:complexContent)])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-25: A schema document containing an element declaration for an augmentation point element MUST also contain a type definition for its base type, a corresponding augmentable type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M101"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M101"/>
   <xsl:template match="@*|node()" priority="-2" mode="M101">
      <xsl:apply-templates select="@*|node()" mode="M101"/>
   </xsl:template>
   <!--PATTERN rule_10-26An augmentation point element has no type-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name[                                 matches(., 'AugmentationPoint$')])]"
                 priority="1000"
                 mode="M102">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-26: An augmentation point element MUST have no type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M102"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M102"/>
   <xsl:template match="@*|node()" priority="-2" mode="M102">
      <xsl:apply-templates select="@*|node()" mode="M102"/>
   </xsl:template>
   <!--PATTERN rule_10-27An augmentation point element has no substitution group-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name[                                 matches(., 'AugmentationPoint$')])]"
                 priority="1000"
                 mode="M103">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@substitutionGroup)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-27: An augmentation point element MUST have no substitution group.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M103"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M103"/>
   <xsl:template match="@*|node()" priority="-2" mode="M103">
      <xsl:apply-templates select="@*|node()" mode="M103"/>
   </xsl:template>
   <!--PATTERN rule_10-28Augmentation point element is only referenced by its base type-->
   <!--RULE -->
   <xsl:template match="xs:complexType//xs:element[exists(@ref[                       matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"
                 priority="1000"
                 mode="M104">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="QName(string(nf:get-target-namespace(ancestor::xs:complexType[1])), ancestor::xs:complexType[1]/@name)                      = QName(string(namespace-uri-from-QName(resolve-QName(@ref, .))),                          replace(local-name-from-QName(resolve-QName(@ref, .)), 'AugmentationPoint$', 'Type'))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-28: An augmentation point element MUST only be referenced by its base type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M104"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M104"/>
   <xsl:template match="@*|node()" priority="-2" mode="M104">
      <xsl:apply-templates select="@*|node()" mode="M104"/>
   </xsl:template>
   <!--PATTERN rule_10-31Augmentation point element use must be last element in its base type-->
   <!--RULE -->
   <xsl:template match="xs:complexType//xs:element[exists(@ref[                           matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"
                 priority="1000"
                 mode="M105">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(following-sibling::*)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-31: An augmentation point element particle MUST be the last element occurrence in its content model.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M105"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M105"/>
   <xsl:template match="@*|node()" priority="-2" mode="M105">
      <xsl:apply-templates select="@*|node()" mode="M105"/>
   </xsl:template>
   <!--PATTERN rule_10-34Schema component with name ending in "AugmentationType" is an augmentation type-->
   <!--RULE -->
   <xsl:template match="xs:*[ends-with(@name, 'AugmentationType')]"
                 priority="1000"
                 mode="M106">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="self::xs:complexType/xs:complexContent/xs:*[                        (self::xs:extension or self::xs:restriction)                        and ends-with(@base, 'AugmentationType')]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-34: An augmentation type definition schema component with {name} ending in 'AugmentationType' MUST be an augmentation type definition that is a complex type definition with complex content that extends or restricts an augmentation type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M106"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M106"/>
   <xsl:template match="@*|node()" priority="-2" mode="M106">
      <xsl:apply-templates select="@*|node()" mode="M106"/>
   </xsl:template>
   <!--PATTERN rule_10-35Type derived from structures:AugmentationType is an augmentation type-->
   <!--RULE -->
   <xsl:template match="xs:*[(self::xs:restriction or self::xs:extension)                          and ends-with(@base, 'AugmentationType')]"
                 priority="1000"
                 mode="M107">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::xs:complexType[ends-with(@name, 'AugmentationType')]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-35: A type definition derived from an augmentation type MUST be an augmentation type definition</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M107"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M107"/>
   <xsl:template match="@*|node()" priority="-2" mode="M107">
      <xsl:apply-templates select="@*|node()" mode="M107"/>
   </xsl:template>
   <!--PATTERN rule_10-36Augmentation element type is an augmentation type-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name)]" priority="1000" mode="M108">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@type[ends-with(., 'AugmentationType')])                      = exists(@name[ends-with(., 'Augmentation')])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-36: An element declaration MUST have a name that ends in "Augmentation" if and only if it has a type that is an augmentation type.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M108"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M108"/>
   <xsl:template match="@*|node()" priority="-2" mode="M108">
      <xsl:apply-templates select="@*|node()" mode="M108"/>
   </xsl:template>
   <!--PATTERN rule_10-42Name of element that ends in "Representation" is abstract-->
   <!--RULE -->
   <xsl:template match="xs:element[@name[ends-with(., 'Representation')]]"
                 priority="1000"
                 mode="M109">

		<!--REPORT warning-->
      <xsl:if test="empty(@abstract) or xs:boolean(@abstract) = false()">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>An element declaration with a name that ends in 'Representation' SHOULD have the {abstract} property with a value of "true".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M109"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M109"/>
   <xsl:template match="@*|node()" priority="-2" mode="M109">
      <xsl:apply-templates select="@*|node()" mode="M109"/>
   </xsl:template>
   <!--PATTERN rule_10-45Schema component name has xml:lang-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name)]" priority="1000" mode="M110">
      <xsl:variable name="xml-lang-attribute"
                    select="ancestor-or-self::*[exists(@xml:lang)][1]/@xml:lang"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists($xml-lang-attribute)                      and string-length(normalize-space($xml-lang-attribute)) gt 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-45: The name of an XML Schema component defined by the schema MUST be in the scope of an occurrence of attribute xml:lang that has a value that is not empty.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M110"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M110"/>
   <xsl:template match="@*|node()" priority="-2" mode="M110">
      <xsl:apply-templates select="@*|node()" mode="M110"/>
   </xsl:template>
   <!--PATTERN rule_10-46Schema component names have only specific characters-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name)]" priority="1000" mode="M111">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@name, '^[A-Za-z0-9\-_\.]*$')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-46: The name of an XML Schema component defined by the schema must be composed of only the characters uppercase 'A' through 'Z', lowercase 'a' through 'z', numbers '0' through '9', underscore, hyphen, and period.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M111"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M111"/>
   <xsl:template match="@*|node()" priority="-2" mode="M111">
      <xsl:apply-templates select="@*|node()" mode="M111"/>
   </xsl:template>
   <!--PATTERN rule_10-49Attribute name begins with lower case letter-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M112">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@name, '^[a-z]')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-49: Within the schema, any attribute declaration MUST have a name that begins with a lowercase letter ('a'-'z').</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M112"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M112"/>
   <xsl:template match="@*|node()" priority="-2" mode="M112">
      <xsl:apply-templates select="@*|node()" mode="M112"/>
   </xsl:template>
   <!--PATTERN rule_10-50Name of schema component other than attribute and proxy type begins with upper case letter-->
   <!--RULE -->
   <xsl:template match="xs:attribute" priority="1002" mode="M113">

		<!--REPORT warning-->
      <xsl:if test="false()">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>This rule does not apply to an attribute.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M113"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:complexType[some $name in @name,                                    $extension in xs:simpleContent/xs:extension,                                    $base-qname in resolve-QName($extension/@base, $extension) satisfies                                    $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"
                 priority="1001"
                 mode="M113">

		<!--REPORT warning-->
      <xsl:if test="false()">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>This rule does not apply to a proxy types.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M113"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name)]" priority="1000" mode="M113">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@name, '^[A-Z]')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-50: Within the schema, an XML Schema component that is not an attribute declaration or proxy type MUST have a name that begins with an upper-case letter ('A'-'Z').</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M113"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M113"/>
   <xsl:template match="@*|node()" priority="-2" mode="M113">
      <xsl:apply-templates select="@*|node()" mode="M113"/>
   </xsl:template>
   <!--PATTERN rule_10-69Deprecated annotates schema component-->
   <!--RULE -->
   <xsl:template match="*[exists(@appinfo:deprecated)]" priority="1000" mode="M114">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="namespace-uri-from-QName(node-name(.)) = xs:anyURI('http://www.w3.org/2001/XMLSchema')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-69: The attribute appinfo:deprecated MUST be owned by an element with a namespace name http://www.w3.org/2001/XMLSchema.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M114"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M114"/>
   <xsl:template match="@*|node()" priority="-2" mode="M114">
      <xsl:apply-templates select="@*|node()" mode="M114"/>
   </xsl:template>
   <!--PATTERN rule_10-70External import indicator annotates import-->
   <!--RULE -->
   <xsl:template match="*[exists(@appinfo:externalImportIndicator)]"
                 priority="1000"
                 mode="M115">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(self::xs:import)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-70: The attribute {https://docs.oasis-open.org/niemopen/ns/model/appinfo/6.0/}externalImportIndicator MUST be owned by an element xs:import.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M115"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M115"/>
   <xsl:template match="@*|node()" priority="-2" mode="M115">
      <xsl:apply-templates select="@*|node()" mode="M115"/>
   </xsl:template>
   <!--PATTERN rule_10-71External adapter type indicator annotates complex type-->
   <!--RULE -->
   <xsl:template match="*[exists(@appinfo:externalAdapterTypeIndicator)]"
                 priority="1000"
                 mode="M116">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(self::xs:complexType)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-71: The attribute appinfo:externalAdapterTypeIndicator MUST be owned by an element xs:complexType.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M116"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M116"/>
   <xsl:template match="@*|node()" priority="-2" mode="M116">
      <xsl:apply-templates select="@*|node()" mode="M116"/>
   </xsl:template>
   <!--PATTERN rule_10-76appinfo:LocalTerm annotates schema-->
   <!--RULE -->
   <xsl:template match="appinfo:LocalTerm" priority="1000" mode="M117">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="parent::xs:appinfo[parent::xs:annotation[parent::xs:schema]]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-76: The element appinfo:LocalTerm MUST be application information on an element xs:schema.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M117"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M117"/>
   <xsl:template match="@*|node()" priority="-2" mode="M117">
      <xsl:apply-templates select="@*|node()" mode="M117"/>
   </xsl:template>
   <!--PATTERN rule_10-77appinfo:LocalTerm has literal or definition-->
   <!--RULE -->
   <xsl:template match="appinfo:LocalTerm" priority="1000" mode="M118">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@literal) or exists(@definition)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 10-77: The element {https://docs.oasis-open.org/niemopen/ns/model/appinfo/6.0/}LocalTerm MUST have a literal or definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M118"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M118"/>
   <xsl:template match="@*|node()" priority="-2" mode="M118">
      <xsl:apply-templates select="@*|node()" mode="M118"/>
   </xsl:template>
   <!--PATTERN rule_11-1Name of type ends in "Type"-->
   <!--RULE -->
   <xsl:template match="xs:complexType[some $name in @name,                                    $extension in xs:simpleContent/xs:extension,                                    $base-qname in resolve-QName($extension/@base, $extension) satisfies                                    $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"
                 priority="1001"
                 mode="M119">

		<!--REPORT warning-->
      <xsl:if test="false()">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The name of a proxy type does not end in "Type".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M119"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:*[(self::xs:simpleType or self::xs:complexType) and exists(@name)]"
                 priority="1000"
                 mode="M119">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ends-with(@name, 'Type')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-1: A type definition schema component that does not define a proxy type MUST have a name that ends in "Type".</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M119"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M119"/>
   <xsl:template match="@*|node()" priority="-2" mode="M119">
      <xsl:apply-templates select="@*|node()" mode="M119"/>
   </xsl:template>
   <!--PATTERN rule_11-2Only types have name ending in "Type" or "SimpleType"-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name) and ends-with(@name, 'SimpleType')]"
                 priority="1001"
                 mode="M120">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="local-name() = 'simpleType'"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-2: A schema component with a name that ends in 'SimpleType' MUST be a simple type definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M120"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name) and ends-with(@name, 'Type')]"
                 priority="1000"
                 mode="M120">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="local-name() = 'complexType'"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>A schema component with a name that ends in 'Type' and does not end in 'SimpleType' MUST be a complex type definition.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M120"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M120"/>
   <xsl:template match="@*|node()" priority="-2" mode="M120">
      <xsl:apply-templates select="@*|node()" mode="M120"/>
   </xsl:template>
   <!--PATTERN rule_11-3Base type definition defined by conformant schema-->
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M121">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $base-namespace in namespace-uri-from-QName(resolve-QName(@base, .)) satisfies (                        $base-namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema'))                        or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                                                   and $base-namespace = xs:anyURI(@namespace)                                                                   and empty(@appinfo:externalImportIndicator)]))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-3: The {base type definition} of a type definition MUST have the target namespace or the XML Schema namespace or a namespace that is imported as conformant.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M121"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M121"/>
   <xsl:template match="@*|node()" priority="-2" mode="M121">
      <xsl:apply-templates select="@*|node()" mode="M121"/>
   </xsl:template>
   <!--PATTERN rule_11-4Name of simple type ends in "SimpleType"-->
   <!--RULE -->
   <xsl:template match="xs:simpleType[@name]" priority="1000" mode="M122">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ends-with(@name, 'SimpleType')"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-4: A simple type definition schema component MUST have a name that ends in "SimpleType".</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M122"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M122"/>
   <xsl:template match="@*|node()" priority="-2" mode="M122">
      <xsl:apply-templates select="@*|node()" mode="M122"/>
   </xsl:template>
   <!--PATTERN rule_11-6List item type defined by conformant schemas-->
   <!--RULE -->
   <xsl:template match="xs:list[exists(@itemType)]" priority="1000" mode="M123">
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@itemType, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema'))                      or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                    and $namespace = xs:anyURI(@namespace)                                    and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-6: The item type of a list simple type definition MUST have a target namespace equal to the target namespace of the XML Schema document within which it is defined, or a namespace that is imported as conformant by the schema document within which it is defined.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M123"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M123"/>
   <xsl:template match="@*|node()" priority="-2" mode="M123">
      <xsl:apply-templates select="@*|node()" mode="M123"/>
   </xsl:template>
   <!--PATTERN rule_11-7Union member types defined by conformant schemas-->
   <!--RULE -->
   <xsl:template match="xs:union[exists(@memberTypes)]" priority="1000" mode="M124">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $qname in tokenize(normalize-space(@memberTypes), ' '),                            $namespace in namespace-uri-from-QName(resolve-QName($qname, .))                      satisfies ($namespace = nf:get-target-namespace(.)                                 or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                           and $namespace = xs:anyURI(@namespace)                                           and empty(@appinfo:externalImportIndicator)]))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-7: Every member type of a union simple type definition MUST have a target namespace that is equal to either the target namespace of the XML Schema document within which it is defined or a namespace that is imported as conformant by the schema document within which it is defined.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M124"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M124"/>
   <xsl:template match="@*|node()" priority="-2" mode="M124">
      <xsl:apply-templates select="@*|node()" mode="M124"/>
   </xsl:template>
   <!--PATTERN rule_11-8Name of a code simple type ends in "CodeSimpleType"-->
   <!--RULE -->
   <xsl:template match="xs:simpleType[exists(@name)      and (xs:restriction/xs:enumeration           or xs:restriction[ends-with(local-name-from-QName(resolve-QName(@base, .)), 'CodeSimpleType')])]"
                 priority="1000"
                 mode="M125">

		<!--REPORT warning-->
      <xsl:if test="not(ends-with(@name, 'CodeSimpleType'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>A simple type definition schema component that has an enumeration facet or that is derived from a code simple type SHOULD have a name that ends in "CodeSimpleType".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M125"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M125"/>
   <xsl:template match="@*|node()" priority="-2" mode="M125">
      <xsl:apply-templates select="@*|node()" mode="M125"/>
   </xsl:template>
   <!--PATTERN rule_11-10Attribute of code simple type has code representation term-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name) and exists(@type) and ends-with(@type, 'CodeSimpleType')]"
                 priority="1000"
                 mode="M126">

		<!--REPORT warning-->
      <xsl:if test="not(ends-with(@name, 'Code'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>An attribute with a type that is a code simple type SHOULD have a name with representation term "Code"</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M126"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M126"/>
   <xsl:template match="@*|node()" priority="-2" mode="M126">
      <xsl:apply-templates select="@*|node()" mode="M126"/>
   </xsl:template>
   <!--PATTERN rule_11-11Complex type with simple content has structures:SimpleObjectAttributeGroup-->
   <!--RULE -->
   <xsl:template match="xs:simpleContent/xs:extension[      some $base-qname in resolve-QName(@base, .) satisfies        namespace-uri-from-QName($base-qname) = xs:anyURI('http://www.w3.org/2001/XMLSchema')        or ends-with(local-name-from-QName($base-qname), 'SimpleType')]"
                 priority="1000"
                 mode="M127">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:attributeGroup[                        resolve-QName(@ref, .) = xs:QName('structures:SimpleObjectAttributeGroup')]"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-11: A complex type definition with simple content schema component with a derivation method of extension that has a base type definition that is a simple type MUST incorporate the attribute group {https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/}SimpleObjectAttributeGroup.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M127"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M127"/>
   <xsl:template match="@*|node()" priority="-2" mode="M127">
      <xsl:apply-templates select="@*|node()" mode="M127"/>
   </xsl:template>
   <!--PATTERN rule_11-12Element type does not have a simple type name-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)]" priority="1000" mode="M128">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(ends-with(@type, 'SimpleType'))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-12: The {type definition} of an element declaration MUST NOT have a {name} that ends in 'SimpleType'.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M128"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M128"/>
   <xsl:template match="@*|node()" priority="-2" mode="M128">
      <xsl:apply-templates select="@*|node()" mode="M128"/>
   </xsl:template>
   <!--PATTERN rule_11-13Element type is from conformant namespace-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)]" priority="1000" mode="M129">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="for $type-qname in resolve-QName(@type, .),                          $type-namespace in namespace-uri-from-QName($type-qname) return                        $type-namespace = nf:get-target-namespace(.)                        or exists(nf:get-document-element(.)/xs:import[                                    xs:anyURI(@namespace) = $type-namespace                                    and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-13: The {type definition} of an element declaration MUST have a {target namespace} that is the target namespace, or one that is imported as conformant.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M129"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M129"/>
   <xsl:template match="@*|node()" priority="-2" mode="M129">
      <xsl:apply-templates select="@*|node()" mode="M129"/>
   </xsl:template>
   <!--PATTERN rule_11-14Name of element that ends in "Abstract" is abstract-->
   <!--RULE -->
   <xsl:template match="xs:element[@name]" priority="1000" mode="M130">

		<!--REPORT warning-->
      <xsl:if test="not(exists(@abstract[xs:boolean(.) = true()])                  eq (ends-with(@name, 'Abstract')                      or ends-with(@name, 'AugmentationPoint')                      or ends-with(@name, 'Representation')))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>An element declaration SHOULD have a name that ends in 'Abstract', 'AugmentationPoint', or 'Representation' if and only if it has the {abstract} property with a value of "true".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M130"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M130"/>
   <xsl:template match="@*|node()" priority="-2" mode="M130">
      <xsl:apply-templates select="@*|node()" mode="M130"/>
   </xsl:template>
   <!--PATTERN rule_11-15Name of element declaration with simple content has representation term-->
   <!--RULE -->
   <xsl:template match="xs:element[@name and @type                                and (some $type-qname in resolve-QName(@type, .) satisfies (                                       nf:get-target-namespace(.) = namespace-uri-from-QName($type-qname)                                       and nf:resolve-type(., $type-qname)/xs:simpleContent))]"
                 priority="1000"
                 mode="M131">

		<!--REPORT warning-->
      <xsl:if test="every $representation-term              in ('Amount', 'BinaryObject', 'Graphic', 'Picture', 'Sound', 'Video', 'Code', 'DateTime', 'Date', 'Time', 'Duration', 'ID', 'URI', 'Indicator', 'Measure', 'Numeric', 'Value', 'Rate', 'Percent', 'Quantity', 'Text', 'Name', 'List')              satisfies not(ends-with(@name, $representation-term))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The name of an element declaration that is of simple content SHOULD use a representation term.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M131"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M131"/>
   <xsl:template match="@*|node()" priority="-2" mode="M131">
      <xsl:apply-templates select="@*|node()" mode="M131"/>
   </xsl:template>
   <!--PATTERN rule_11-17Element substitution group defined by conformant schema-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(@substitutionGroup)]"
                 priority="1000"
                 mode="M132">
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@substitutionGroup, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$namespace = nf:get-target-namespace(.)                      or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                    and $namespace = xs:anyURI(@namespace)                                    and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-17: An element substitution group MUST have either the target namespace or a namespace that is imported as conformant.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M132"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M132"/>
   <xsl:template match="@*|node()" priority="-2" mode="M132">
      <xsl:apply-templates select="@*|node()" mode="M132"/>
   </xsl:template>
   <!--PATTERN rule_11-18Attribute type defined by conformant schema-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M133">
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@type, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema'))                      or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                    and $namespace = xs:anyURI(@namespace)                                    and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-18: The type of an attribute declaration MUST have the target namespace or the XML Schema namespace or a namespace that is imported as conformant.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M133"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M133"/>
   <xsl:template match="@*|node()" priority="-2" mode="M133">
      <xsl:apply-templates select="@*|node()" mode="M133"/>
   </xsl:template>
   <!--PATTERN rule_11-19Attribute name uses representation term-->
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M134">

		<!--REPORT warning-->
      <xsl:if test="every $representation-term              in ('Amount', 'BinaryObject', 'Graphic', 'Picture', 'Sound', 'Video', 'Code', 'DateTime', 'Date', 'Time', 'Duration', 'ID', 'URI', 'Indicator', 'Measure', 'Numeric', 'Value', 'Rate', 'Percent', 'Quantity', 'Text', 'Name', 'List')              satisfies not(ends-with(@name, $representation-term))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>An attribute name SHOULD end with a representation term.</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M134"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M134"/>
   <xsl:template match="@*|node()" priority="-2" mode="M134">
      <xsl:apply-templates select="@*|node()" mode="M134"/>
   </xsl:template>
   <!--PATTERN rule_11-21Element reference defined by conformant schema-->
   <!--RULE -->
   <xsl:template match="xs:element[exists(ancestor::xs:complexType[empty(@appinfo:externalAdapterTypeIndicator)]) and @ref]"
                 priority="1000"
                 mode="M135">
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@ref, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$namespace = nf:get-target-namespace(.)                      or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                    and $namespace = xs:anyURI(@namespace)                                    and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-21: An element reference MUST be to a component that has a namespace that is either the target namespace of the schema document in which it appears, or which is imported as conformant by that schema document.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M135"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M135"/>
   <xsl:template match="@*|node()" priority="-2" mode="M135">
      <xsl:apply-templates select="@*|node()" mode="M135"/>
   </xsl:template>
   <!--PATTERN rule_11-22Referenced attribute defined by conformant schemas-->
   <!--RULE -->
   <xsl:template match="xs:attribute[@ref]" priority="1000" mode="M136">
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@ref, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies (                        $namespace = nf:get-target-namespace(.)                        or ancestor::xs:schema[1]/xs:import[                             @namespace                             and $namespace = xs:anyURI(@namespace)                             and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-22: An attribute {}ref MUST have the target namespace or a namespace that is imported as conformant. </xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M136"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M136"/>
   <xsl:template match="@*|node()" priority="-2" mode="M136">
      <xsl:apply-templates select="@*|node()" mode="M136"/>
   </xsl:template>
   <!--PATTERN rule_11-23Schema uses only known attribute groups-->
   <!--RULE -->
   <xsl:template match="xs:attributeGroup[@ref]" priority="1000" mode="M137">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $ref in resolve-QName(@ref, .) satisfies (                         $ref = xs:QName('structures:SimpleObjectAttributeGroup'))"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-23: An attribute group reference MUST be structures:SimpleObjectAttributeGroup</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M137"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M137"/>
   <xsl:template match="@*|node()" priority="-2" mode="M137">
      <xsl:apply-templates select="@*|node()" mode="M137"/>
   </xsl:template>
   <!--PATTERN rule_11-30xs:documentation has xml:lang-->
   <!--RULE -->
   <xsl:template match="xs:documentation" priority="1000" mode="M138">
      <xsl:variable name="xml-lang-attribute"
                    select="ancestor-or-self::*[exists(@xml:lang)][1]/@xml:lang"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists($xml-lang-attribute)                      and string-length(normalize-space($xml-lang-attribute)) gt 0"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-30: An occurrence of xs:documentation within the schema MUST be in the scope of an occurrence of attribute xml:lang that has a value that is not empty.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M138"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M138"/>
   <xsl:template match="@*|node()" priority="-2" mode="M138">
      <xsl:apply-templates select="@*|node()" mode="M138"/>
   </xsl:template>
   <!--PATTERN rule_11-31Standard opening phrase for augmentation point element data definition-->
   <!--RULE -->
   <xsl:template match="xs:element[ends-with(@name, 'AugmentationPoint')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M139">

		<!--REPORT warning-->
      <xsl:if test="not(starts-with(lower-case(normalize-space(.)), 'an augmentation point '))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an augmentation point element SHOULD begin with standard opening phrase "An augmentation point...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M139"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M139"/>
   <xsl:template match="@*|node()" priority="-2" mode="M139">
      <xsl:apply-templates select="@*|node()" mode="M139"/>
   </xsl:template>
   <!--PATTERN rule_11-32Standard opening phrase for augmentation element data definition-->
   <!--RULE -->
   <xsl:template match="xs:element[ends-with(@name, 'Augmentation')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M140">

		<!--REPORT warning-->
      <xsl:if test="every $phrase              in ('supplements ', 'additional information about ')              satisfies not(starts-with(lower-case(normalize-space(.)), $phrase))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an augmentation element SHOULD begin with the standard opening phrase "Supplements..." or "Additional information about...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M140"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M140"/>
   <xsl:template match="@*|node()" priority="-2" mode="M140">
      <xsl:apply-templates select="@*|node()" mode="M140"/>
   </xsl:template>
   <!--PATTERN rule_11-33Standard opening phrase for metadata element data definition-->
   <!--RULE -->
   <xsl:template match="xs:element[ends-with(@name, 'Metadata')                                and not(xs:boolean(@abstract) eq true())]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M141">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '(metadata about|information that further qualifies)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for a metadata element SHOULD begin with the standard opening phrase "Metadata about..." or "Information that further qualifies...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M141"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M141"/>
   <xsl:template match="@*|node()" priority="-2" mode="M141">
      <xsl:apply-templates select="@*|node()" mode="M141"/>
   </xsl:template>
   <!--PATTERN rule_11-34Standard opening phrase for association element data definition-->
   <!--RULE -->
   <xsl:template match="xs:element[ends-with(@name, 'Association')                                and not(xs:boolean(@abstract) eq true())]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M142">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (relationship|association)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an association element that is not abstract SHOULD begin with the standard opening phrase "An (optional adjectives) (relationship|association)...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M142"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M142"/>
   <xsl:template match="@*|node()" priority="-2" mode="M142">
      <xsl:apply-templates select="@*|node()" mode="M142"/>
   </xsl:template>
   <!--PATTERN rule_11-35Standard opening phrase for abstract element data definition-->
   <!--RULE -->
   <xsl:template match="xs:element[xs:boolean(@abstract) = true()                       and not(ends-with(@name, 'AugmentationPoint'))]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M143">

		<!--REPORT warning-->
      <xsl:if test="not(starts-with(lower-case(normalize-space(.)), 'a data concept'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an abstract element SHOULD begin with the standard opening phrase "A data concept...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M143"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M143"/>
   <xsl:template match="@*|node()" priority="-2" mode="M143">
      <xsl:apply-templates select="@*|node()" mode="M143"/>
   </xsl:template>
   <!--PATTERN rule_11-36Standard opening phrase for date element or attribute data definition-->
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                       and ends-with(@name, 'Date') and not(xs:boolean(@abstract) eq true())]                      /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M144">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (date|month|year)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an element or attribute with a date representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) (date|month|year)...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M144"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M144"/>
   <xsl:template match="@*|node()" priority="-2" mode="M144">
      <xsl:apply-templates select="@*|node()" mode="M144"/>
   </xsl:template>
   <!--PATTERN rule_11-37Standard opening phrase for quantity element or attribute data definition-->
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                       and ends-with(@name, 'Quantity') and not(xs:boolean(@abstract) eq true())]                      /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M145">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (count|number)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an element or attribute with a quantity representation term SHOULD begin with the standard opening phrase "An (optional adjectives) (count|number)...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M145"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M145"/>
   <xsl:template match="@*|node()" priority="-2" mode="M145">
      <xsl:apply-templates select="@*|node()" mode="M145"/>
   </xsl:template>
   <!--PATTERN rule_11-38Standard opening phrase for picture element or attribute data definition-->
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                       and ends-with(@name, 'Picture') and not(xs:boolean(@abstract) eq true())]                      /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M146">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (image|picture|photograph)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an element or attribute with a picture representation term SHOULD begin with the standard opening phrase "An (optional adjectives) (image|picture|photograph)".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M146"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M146"/>
   <xsl:template match="@*|node()" priority="-2" mode="M146">
      <xsl:apply-templates select="@*|node()" mode="M146"/>
   </xsl:template>
   <!--PATTERN rule_11-39Standard opening phrase for indicator element or attribute data definition-->
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                       and ends-with(@name, 'Indicator') and not(xs:boolean(@abstract) eq true())]                      /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M147">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^true if .*; false (otherwise|if)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an element or attribute with an indicator representation term SHOULD begin with the standard opening phrase "True if ...; false (otherwise|if)...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M147"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M147"/>
   <xsl:template match="@*|node()" priority="-2" mode="M147">
      <xsl:apply-templates select="@*|node()" mode="M147"/>
   </xsl:template>
   <!--PATTERN rule_11-40Standard opening phrase for identification element or attribute data definition-->
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                       and ends-with(@name, 'Identification') and not(xs:boolean(@abstract) eq true())]                      /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M148">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? identification'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an element or attribute with an identification representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) identification...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M148"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M148"/>
   <xsl:template match="@*|node()" priority="-2" mode="M148">
      <xsl:apply-templates select="@*|node()" mode="M148"/>
   </xsl:template>
   <!--PATTERN rule_11-41Standard opening phrase for name element or attribute data definition-->
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                       and ends-with(@name, 'Name') and not(xs:boolean(@abstract) eq true())]                      /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M149">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^(a|an)( .*)? name'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an element or attribute with a name representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) name...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M149"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M149"/>
   <xsl:template match="@*|node()" priority="-2" mode="M149">
      <xsl:apply-templates select="@*|node()" mode="M149"/>
   </xsl:template>
   <!--PATTERN rule_11-42Standard opening phrase for element or attribute data definition-->
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                       and @name                       and not(ends-with(@name, 'Indicator'))                       and not(ends-with(@name, 'Augmentation'))                       and not(ends-with(@name, 'Metadata'))                       and not(xs:boolean(@abstract) eq true())]                      /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M150">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an? '))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an element or attribute declaration SHOULD begin with the standard opening phrase "(A|An)".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M150"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M150"/>
   <xsl:template match="@*|node()" priority="-2" mode="M150">
      <xsl:apply-templates select="@*|node()" mode="M150"/>
   </xsl:template>
   <!--PATTERN rule_11-43Standard opening phrase for association type data definition-->
   <!--RULE -->
   <xsl:template match="xs:complexType[ends-with(@name, 'AssociationType')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M151">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^a data type for (a relationship|an association)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an association type SHOULD begin with the standard opening phrase "A data type for (a relationship|an association)...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M151"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M151"/>
   <xsl:template match="@*|node()" priority="-2" mode="M151">
      <xsl:apply-templates select="@*|node()" mode="M151"/>
   </xsl:template>
   <!--PATTERN rule_11-44Standard opening phrase for augmentation type data definition-->
   <!--RULE -->
   <xsl:template match="xs:complexType[ends-with(@name, 'AugmentationType')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M152">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)),                          '^a data type (that supplements|for additional information about)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for an augmentation type SHOULD begin with the standard opening phrase "A data type (that supplements|for additional information about)...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M152"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M152"/>
   <xsl:template match="@*|node()" priority="-2" mode="M152">
      <xsl:apply-templates select="@*|node()" mode="M152"/>
   </xsl:template>
   <!--PATTERN rule_11-45Standard opening phrase for metadata type data definition-->
   <!--RULE -->
   <xsl:template match="xs:complexType[ends-with(@name, 'MetadataType')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M153">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)),                          '^a data type for (metadata about|information that further qualifies)'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for a metadata type SHOULD begin with the standard opening phrase "A data type for (metadata about|information that further qualifies)...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M153"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M153"/>
   <xsl:template match="@*|node()" priority="-2" mode="M153">
      <xsl:apply-templates select="@*|node()" mode="M153"/>
   </xsl:template>
   <!--PATTERN rule_11-46Standard opening phrase for complex type data definition-->
   <!--RULE -->
   <xsl:template match="xs:complexType/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M154">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^a data type'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for a complex type SHOULD begin with the standard opening phrase "A data type...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M154"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M154"/>
   <xsl:template match="@*|node()" priority="-2" mode="M154">
      <xsl:apply-templates select="@*|node()" mode="M154"/>
   </xsl:template>
   <!--PATTERN rule_11-47Standard opening phrase for simple type data definition-->
   <!--RULE -->
   <xsl:template match="xs:simpleType/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M155">

		<!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^a data type'))">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
            <xsl:text>Warning:</xsl:text>
            <xsl:text>The data definition for a simple type SHOULD begin with a standard opening phrase "A data type...".</xsl:text>
         </xsl:message>
      </xsl:if>
      <xsl:apply-templates select="@*|node()" mode="M155"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M155"/>
   <xsl:template match="@*|node()" priority="-2" mode="M155">
      <xsl:apply-templates select="@*|node()" mode="M155"/>
   </xsl:template>
   <!--PATTERN rule_11-52Structures imported as conformant-->
   <!--RULE -->
   <xsl:template match="xs:import[exists(@namespace)                            and xs:anyURI(@namespace) = xs:anyURI(                    'https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/')]"
                 priority="1000"
                 mode="M156">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@appinfo:externalImportIndicator)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-52: An import of the structures namespace MUST NOT be labeled as an external import.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M156"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M156"/>
   <xsl:template match="@*|node()" priority="-2" mode="M156">
      <xsl:apply-templates select="@*|node()" mode="M156"/>
   </xsl:template>
   <!--PATTERN rule_11-53XML namespace imported as conformant-->
   <!--RULE -->
   <xsl:template match="xs:import[exists(@namespace)                               and xs:anyURI(@namespace) = xs:anyURI('http://www.w3.org/XML/1998/namespace')]"
                 priority="1000"
                 mode="M157">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@appinfo:externalImportIndicator)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-53: An import of the XML namespace MUST NOT be labeled as an external import.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M157"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M157"/>
   <xsl:template match="@*|node()" priority="-2" mode="M157">
      <xsl:apply-templates select="@*|node()" mode="M157"/>
   </xsl:template>
   <!--PATTERN rule_11-55Consistently marked namespace imports-->
   <!--RULE -->
   <xsl:template match="xs:import" priority="1000" mode="M158">
      <xsl:variable name="namespace" select="@namespace"/>
      <xsl:variable name="is-conformant" select="empty(@appinfo:externalImportIndicator)"/>
      <xsl:variable name="first"
                    select="exactly-one(parent::xs:schema/xs:import[@namespace = $namespace][1])"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test=". is $first                      or $is-conformant = empty($first/@appinfo:externalImportIndicator)"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron">
               <xsl:text>Rule 11-55: All xs:import elements that have the same namespace MUST have the same conformance marking via appinfo:externalImportIndicator.</xsl:text>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@*|node()" mode="M158"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M158"/>
   <xsl:template match="@*|node()" priority="-2" mode="M158">
      <xsl:apply-templates select="@*|node()" mode="M158"/>
   </xsl:template>
</xsl:stylesheet>
