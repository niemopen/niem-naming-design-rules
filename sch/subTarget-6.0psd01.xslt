<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:appinfo="https://docs.oasis-open.org/niemopen/ns/model/appinfo/6.0/"
                xmlns:ct="https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:nf="https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#NDRFunctions"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:structures="https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
   <xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <!--PHASES-->
   <!--PROLOG-->
   <xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>
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
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
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
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="Rules for subset schema documents"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/XSL/Transform" prefix="xsl"/>
         <svrl:ns-prefix-in-attribute-values uri="https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#NDRFunctions"
                                             prefix="nf"/>
         <svrl:ns-prefix-in-attribute-values uri="https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/"
                                             prefix="ct"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
         <svrl:ns-prefix-in-attribute-values uri="https://docs.oasis-open.org/niemopen/ns/model/appinfo/6.0/"
                                             prefix="appinfo"/>
         <svrl:ns-prefix-in-attribute-values uri="https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/"
                                             prefix="structures"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-2a</xsl:attribute>
            <xsl:attribute name="name">Name of Class, Datatype, and Property components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-2b</xsl:attribute>
            <xsl:attribute name="name">Name of Class, Datatype, and Property components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-4</xsl:attribute>
            <xsl:attribute name="name">Name of adapter classes</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-5</xsl:attribute>
            <xsl:attribute name="name">Name of association classes</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-6</xsl:attribute>
            <xsl:attribute name="name">rule7-6</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-8</xsl:attribute>
            <xsl:attribute name="name">Names ending in "CodeSimpleType"</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-9</xsl:attribute>
            <xsl:attribute name="name">Name of code list datatypes</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-10</xsl:attribute>
            <xsl:attribute name="name">Name of abstract properties</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-11</xsl:attribute>
            <xsl:attribute name="name">Name of association properties</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-12a</xsl:attribute>
            <xsl:attribute name="name">Name of code properties</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-12b</xsl:attribute>
            <xsl:attribute name="name">Name of code properties</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-16</xsl:attribute>
            <xsl:attribute name="name">Component names have only specific characters</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-18</xsl:attribute>
            <xsl:attribute name="name">Name of attribute properties begin with lower case letter</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-19</xsl:attribute>
            <xsl:attribute name="name">Name of components other than attribute properties begin with upper case letter</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-36</xsl:attribute>
            <xsl:attribute name="name">Local term has literal or definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-37</xsl:attribute>
            <xsl:attribute name="name">Namespace has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-38a</xsl:attribute>
            <xsl:attribute name="name">Model component has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-38b</xsl:attribute>
            <xsl:attribute name="name">Model component has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-38c</xsl:attribute>
            <xsl:attribute name="name">Model component has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-38d</xsl:attribute>
            <xsl:attribute name="name">Model component has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-39</xsl:attribute>
            <xsl:attribute name="name">Enumeration facet has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-48</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for abstract property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-49</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for association property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-50</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for date property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-51</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for quantity property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-52</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for picture property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-53</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for indicator property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-54</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for identification property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-55</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for name property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-56</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for property data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule7-57</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for association class data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule8-7</xsl:attribute>
            <xsl:attribute name="name">Namespace has version</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-1a</xsl:attribute>
            <xsl:attribute name="name">Schema is CTAS-conformant</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-1b</xsl:attribute>
            <xsl:attribute name="name">Schema is CTAS-conformant</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-1c</xsl:attribute>
            <xsl:attribute name="name">Schema is CTAS-conformant</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M43"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-2</xsl:attribute>
            <xsl:attribute name="name">Document element has attribute `ct:conformanceTargets`</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M44"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-4</xsl:attribute>
            <xsl:attribute name="name">Document element is `xs:schema`</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5a</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M46"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5b</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M47"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5c</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5d</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M49"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5e</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M50"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5f</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M51"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5g</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M52"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5h</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M53"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-5i</xsl:attribute>
            <xsl:attribute name="name">Prohibited schema components</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M54"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6a</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M55"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6b</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M56"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6c</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M57"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6d</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M58"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6e</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M59"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6f</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M60"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6g</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M61"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6h</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M62"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-6i</xsl:attribute>
            <xsl:attribute name="name">Prohibited base types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M63"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-7a</xsl:attribute>
            <xsl:attribute name="name">Prohibited list item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M64"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-7b</xsl:attribute>
            <xsl:attribute name="name">Prohibited list item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M65"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-7c</xsl:attribute>
            <xsl:attribute name="name">Prohibited list item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M66"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-7d</xsl:attribute>
            <xsl:attribute name="name">Prohibited list item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M67"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-8a</xsl:attribute>
            <xsl:attribute name="name">Prohibited union item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M68"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-8b</xsl:attribute>
            <xsl:attribute name="name">Prohibited union item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M69"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-8c</xsl:attribute>
            <xsl:attribute name="name">Prohibited union item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M70"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-8d</xsl:attribute>
            <xsl:attribute name="name">Prohibited union item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M71"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-8e</xsl:attribute>
            <xsl:attribute name="name">Prohibited union item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M72"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-8f</xsl:attribute>
            <xsl:attribute name="name">Prohibited union item types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M73"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-9a</xsl:attribute>
            <xsl:attribute name="name">Prohibited attribute types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M74"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-9b</xsl:attribute>
            <xsl:attribute name="name">Prohibited attribute types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M75"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-9c</xsl:attribute>
            <xsl:attribute name="name">Prohibited attribute types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M76"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-9d</xsl:attribute>
            <xsl:attribute name="name">Prohibited attribute types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M77"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-9e</xsl:attribute>
            <xsl:attribute name="name">Prohibited attribute types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M78"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-10a</xsl:attribute>
            <xsl:attribute name="name">No mixed content on complex type or complex content</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M79"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-10b</xsl:attribute>
            <xsl:attribute name="name">No mixed content on complex type or complex content</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M80"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-11</xsl:attribute>
            <xsl:attribute name="name">Complex type content is explicitly simple or complex</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M81"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-12a</xsl:attribute>
            <xsl:attribute name="name">Base type of complex type with complex content must have complex content</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M82"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-12b</xsl:attribute>
            <xsl:attribute name="name">Base type of complex type with complex content must have complex content</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M83"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-13a</xsl:attribute>
            <xsl:attribute name="name">Untyped element is abstract</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M84"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-13b</xsl:attribute>
            <xsl:attribute name="name">Untyped element is abstract</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M85"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-14a</xsl:attribute>
            <xsl:attribute name="name">Element type not in the XML or XML Schema namespace</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M86"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-14b</xsl:attribute>
            <xsl:attribute name="name">Element type not in the XML or XML Schema namespace</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M87"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-15</xsl:attribute>
            <xsl:attribute name="name">Element type is not simple type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M88"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-16</xsl:attribute>
            <xsl:attribute name="name">Attribute declaration has type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M89"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-17a</xsl:attribute>
            <xsl:attribute name="name">No default or fixed value</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M90"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-17b</xsl:attribute>
            <xsl:attribute name="name">No default or fixed value</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M91"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-17c</xsl:attribute>
            <xsl:attribute name="name">No default or fixed value</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M92"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-17d</xsl:attribute>
            <xsl:attribute name="name">No default or fixed value</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M93"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-18a</xsl:attribute>
            <xsl:attribute name="name">Sequence has minimum and maximum cardinality 1</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M94"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-18b</xsl:attribute>
            <xsl:attribute name="name">Sequence has minimum and maximum cardinality 1</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M95"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-19</xsl:attribute>
            <xsl:attribute name="name">`xs:choice` must be child of `xs:sequence`</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M96"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-20a</xsl:attribute>
            <xsl:attribute name="name">Choice has minimum and maximum cardinality 1</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M97"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-20b</xsl:attribute>
            <xsl:attribute name="name">Choice has minimum and maximum cardinality 1</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M98"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-21</xsl:attribute>
            <xsl:attribute name="name">Comment is not recommended</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M99"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-22</xsl:attribute>
            <xsl:attribute name="name">Documentation element has no element children</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M100"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-23</xsl:attribute>
            <xsl:attribute name="name">Import has namespace</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M101"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-25</xsl:attribute>
            <xsl:attribute name="name">Name of type definitions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M102"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-26</xsl:attribute>
            <xsl:attribute name="name">Name of simple type definitions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M103"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-28</xsl:attribute>
            <xsl:attribute name="name">`xs:sequence` must be child of `xs:extension`</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M104"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-29</xsl:attribute>
            <xsl:attribute name="name">`xs:sequence` must be child of `xs:extension` or `xs:restriction`</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M105"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-30a</xsl:attribute>
            <xsl:attribute name="name">Type definition is top-level</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M106"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-30b</xsl:attribute>
            <xsl:attribute name="name">Type definition is top-level</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M107"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-32</xsl:attribute>
            <xsl:attribute name="name">Object type with complex content is derived from `structures:ObjectType`</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M108"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="name">Association type derived form structures:AssociationType</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M109"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-35</xsl:attribute>
            <xsl:attribute name="name">Augmentation type derived from structures:AugmentationType</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M110"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-36</xsl:attribute>
            <xsl:attribute name="name">Complex type with simple content has `structures:SimpleObjectAttributeGroup`</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M111"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-37</xsl:attribute>
            <xsl:attribute name="name">Base type definition defined by conformant schema</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M112"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-38a</xsl:attribute>
            <xsl:attribute name="name">Component reference defined by conformant schema</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M113"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-38b</xsl:attribute>
            <xsl:attribute name="name">Component reference defined by conformant schema</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M114"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-39</xsl:attribute>
            <xsl:attribute name="name">Schema uses only known attribute groups</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M115"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-41</xsl:attribute>
            <xsl:attribute name="name">List item type defined by conformant schemas</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M116"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-42</xsl:attribute>
            <xsl:attribute name="name">Union member types defined by conformant schemas</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M117"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-45a</xsl:attribute>
            <xsl:attribute name="name">Declarations are top-level</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M118"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-45b</xsl:attribute>
            <xsl:attribute name="name">Declarations are top-level</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M119"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-46a</xsl:attribute>
            <xsl:attribute name="name">Element type is not simple type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M120"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-46b</xsl:attribute>
            <xsl:attribute name="name">Element type is not simple type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M121"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-47a</xsl:attribute>
            <xsl:attribute name="name">Attribute and element type is from conformant namespace</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M122"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-47b</xsl:attribute>
            <xsl:attribute name="name">Attribute and element type is from conformant namespace</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M123"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-48</xsl:attribute>
            <xsl:attribute name="name">Element substitution group defined by conformant schema</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M124"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-50</xsl:attribute>
            <xsl:attribute name="name">Prohibited attribute types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M125"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-52</xsl:attribute>
            <xsl:attribute name="name">Import of external namespace has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M126"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-54</xsl:attribute>
            <xsl:attribute name="name">Structure of external adapter type definition follows pattern</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M127"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-55</xsl:attribute>
            <xsl:attribute name="name">Element use from external adapter type defined by external schema documents</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M128"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-56a</xsl:attribute>
            <xsl:attribute name="name">External adapter type not a base type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M129"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-56b</xsl:attribute>
            <xsl:attribute name="name">External adapter type not a base type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M130"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-57</xsl:attribute>
            <xsl:attribute name="name">External attribute use has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M131"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-59</xsl:attribute>
            <xsl:attribute name="name">External element use has data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M132"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-61</xsl:attribute>
            <xsl:attribute name="name">Proxy type has designated structure</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M133"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-62b</xsl:attribute>
            <xsl:attribute name="name">Name of augmentation types</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M134"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-63</xsl:attribute>
            <xsl:attribute name="name">Name of augmentation elements</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M135"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-65</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for augmentation point element data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M136"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-66</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for augmentation element data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M137"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-67</xsl:attribute>
            <xsl:attribute name="name">Standard opening phrase for augmentation type data definition</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M138"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-68</xsl:attribute>
            <xsl:attribute name="name">Augmentation point element corresponds to its base type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M139"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-69</xsl:attribute>
            <xsl:attribute name="name">An augmentation point element has no type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M140"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-70</xsl:attribute>
            <xsl:attribute name="name">An augmentation point element has no substitution group</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M141"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-71</xsl:attribute>
            <xsl:attribute name="name">Augmentation point element is only referenced by its base type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M142"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-72a</xsl:attribute>
            <xsl:attribute name="name">Augmentation point element use is optional and unbounded</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M143"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-72b</xsl:attribute>
            <xsl:attribute name="name">Augmentation point element use is optional and unbounded</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M144"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-73</xsl:attribute>
            <xsl:attribute name="name">Augmentation point element use must be last element in its base type</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M145"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-74</xsl:attribute>
            <xsl:attribute name="name">Appinfo attribute annotates schema component</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M146"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-75</xsl:attribute>
            <xsl:attribute name="name">`xs:appinfo` children are comments, elements, or whitespace</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M147"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-76</xsl:attribute>
            <xsl:attribute name="name">Appinfo child elements have namespaces</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M148"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-77</xsl:attribute>
            <xsl:attribute name="name">Appinfo descendants are not XML Schema elements</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M149"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-79</xsl:attribute>
            <xsl:attribute name="name">LocalTerm appinfo applies to schema</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M150"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule9-81</xsl:attribute>
            <xsl:attribute name="name">No use of fixed on simple type facets</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M151"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule10-5</xsl:attribute>
            <xsl:attribute name="name">Consistent import schema document</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M152"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule10-6</xsl:attribute>
            <xsl:attribute name="name">Consistent import labels</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M153"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">rule8-15</xsl:attribute>
            <xsl:attribute name="name">Subset namespace asserts conformance</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M154"/>
      </svrl:schematron-output>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Rules for subset schema documents</svrl:text>
   <xsl:include xmlns="http://purl.oclc.org/dsdl/schematron" href="ndr-functions.xsl"/>
   <!--PATTERN rule7-2aName of Class, Datatype, and Property components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of Class, Datatype, and Property components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[some $name in @name,                                      $extension in xs:simpleContent/xs:extension,                                      $base-qname in resolve-QName($extension/@base, $extension) satisfies                                      $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"
                 priority="1001"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[some $name in @name,                                      $extension in xs:simpleContent/xs:extension,                                      $base-qname in resolve-QName($extension/@base, $extension) satisfies                                      $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"/>
      <!--REPORT warning-->
      <xsl:if test="false()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-2: A proxy type SHOULD NOT have a name ending in "Type".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:*[(self::xs:simpleType or self::xs:complexType) and exists(@name)]"
                 priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[(self::xs:simpleType or self::xs:complexType) and exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ends-with(@name, 'Type')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ends-with(@name, 'Type')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-2: Class and Datatype components MUST have a name ending in "Type"; Property components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <!--PATTERN rule7-2bName of Class, Datatype, and Property components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of Class, Datatype, and Property components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name) and ends-with(@name, 'SimpleType')]"
                 priority="1001"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@name) and ends-with(@name, 'SimpleType')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="local-name() = 'simpleType'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="local-name() = 'simpleType'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-2: Class and Datatype components MUST have a name ending in "Type"; Property components MUST NOT</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name) and ends-with(@name, 'Type')]"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@name) and ends-with(@name, 'Type')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="local-name() = 'complexType'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="local-name() = 'complexType'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-2: Class and Datatype components MUST have a name ending in "Type"; Property components MUST NOT</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <!--PATTERN rule7-4Name of adapter classes-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of adapter classes</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:complexType"/>
      <xsl:variable name="is-adapter-type"
                    select="exists(@name[ends-with(., 'AdapterType')])"/>
      <xsl:variable name="has-adapter-base-type"
                    select="         exists(xs:complexContent[         exists(xs:*[local-name() = ('extension', 'restriction')         and exists(@base[ends-with(., 'AdapterType')])])])"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$is-adapter-type = $has-adapter-base-type"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="$is-adapter-type = $has-adapter-base-type">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-4: An adapter class MUST have a name ending in "AdapterType"; all other components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <!--PATTERN rule7-5Name of association classes-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of association classes</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:complexType"/>
      <xsl:variable name="is-association-type"
                    select="exists(@name[ends-with(., 'AssociationType')])"/>
      <xsl:variable name="has-association-base-type"
                    select="         exists(xs:complexContent[         exists(xs:*[local-name() = ('extension', 'restriction')         and exists(@base[ends-with(., 'AssociationType')])])])"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$is-association-type = $has-association-base-type"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="$is-association-type = $has-association-base-type">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-5: An association class MUST have a name ending in "AssociationType"; all other components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <!--PATTERN rule7-6-->
   <!--RULE -->
   <xsl:template match="xs:complexType[exists(xs:simpleContent[                        exists(xs:*[local-name() = ('extension', 'restriction')                                    and (ends-with(@base, 'CodeSimpleType')                                    or ends-with(@base, 'CodeType'))])                        ])                        and exists(xs:attribute)                    ]"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[exists(xs:simpleContent[                        exists(xs:*[local-name() = ('extension', 'restriction')                                    and (ends-with(@base, 'CodeSimpleType')                                    or ends-with(@base, 'CodeType'))])                        ])                        and exists(xs:attribute)                    ]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(ends-with(@name, 'CodeType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not(ends-with(@name, 'CodeType'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-6: A literal class with a literal property that has a code list datatype MUST have a name ending in "CodeType"; all other literal classes MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <!--PATTERN rule7-8Names ending in "CodeSimpleType"-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Names ending in "CodeSimpleType"</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:simpleType[exists(@name)        and (xs:restriction/xs:enumeration             or xs:restriction[ends-with(local-name-from-QName(resolve-QName(@base, .)), 'CodeSimpleType')])]"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:simpleType[exists(@name)        and (xs:restriction/xs:enumeration             or xs:restriction[ends-with(local-name-from-QName(resolve-QName(@base, .)), 'CodeSimpleType')])]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ends-with(@name, 'CodeSimpleType')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="ends-with(@name, 'CodeSimpleType')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-8: A Datatype object with a name that ends in "CodeSimpleType" MUST be a code list datatype.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <!--PATTERN rule7-9Name of code list datatypes-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of code list datatypes</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[exists(xs:simpleContent[                         exists(xs:*[local-name() = ('extension', 'restriction')                                     and (ends-with(@base, 'CodeSimpleType')                                     or ends-with(@base, 'CodeType'))])])]"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[exists(xs:simpleContent[                         exists(xs:*[local-name() = ('extension', 'restriction')                                     and (ends-with(@base, 'CodeSimpleType')                                     or ends-with(@base, 'CodeType'))])])]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ends-with(@name, 'CodeType')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="ends-with(@name, 'CodeType')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-9: A code list datatype MUST have a name ending in "CodeType" or "CodeSimpleType"; all other Datatype components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <!--PATTERN rule7-10Name of abstract properties-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of abstract properties</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[@name]" priority="1000" mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:element[@name]"/>
      <!--REPORT warning-->
      <xsl:if test="not(exists(@abstract[xs:boolean(.) = true()])                    eq (ends-with(@name, 'Abstract')                        or ends-with(@name, 'AugmentationPoint')                        or ends-with(@name, 'Representation')))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(exists(@abstract[xs:boolean(.) = true()]) eq (ends-with(@name, 'Abstract') or ends-with(@name, 'AugmentationPoint') or ends-with(@name, 'Representation')))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-10: A Property object having an AbstractIndicator property with the value true SHOULD have a name ending in "Abstract" or "Representation"; all other components SHOULD NOT.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <!--PATTERN rule7-11Name of association properties-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of association properties</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name)]" priority="1000" mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@type[ends-with(., 'AssociationType')])                        = exists(@name[ends-with(., 'Association')])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(@type[ends-with(., 'AssociationType')]) = exists(@name[ends-with(., 'Association')])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-11: A Property with an association class MUST have a name ending in "Association"; all other components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <!--PATTERN rule7-12aName of code properties-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of code properties</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name) and exists(@type) and ends-with(@type, 'CodeType')]"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@name) and exists(@type) and ends-with(@type, 'CodeType')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ends-with(@name, 'Code')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ends-with(@name, 'Code')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-12: A Property with a Class or Datatype that represents a code list MUST have a name ending in "Code"; all other components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <!--PATTERN rule7-12bName of code properties-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of code properties</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name) and exists(@type) and ends-with(@type, 'CodeSimpleType')]"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@name) and exists(@type) and ends-with(@type, 'CodeSimpleType')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ends-with(@name, 'Code')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ends-with(@name, 'Code')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-12: A Property with a Class or Datatype that represents a code list MUST have a name ending in "Code"; all other components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <!--PATTERN rule7-16Component names have only specific characters-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Component names have only specific characters</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name)]" priority="1000" mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@name, '^[A-Za-z0-9\-_\.]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@name, '^[A-Za-z0-9\-_\.]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-16: The name of a model component MUST be entirely composed of specified  characters.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <!--PATTERN rule7-18Name of attribute properties begin with lower case letter-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of attribute properties begin with lower case letter</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@name, '^[a-z]')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="matches(@name, '^[a-z]')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-18: The name of an attribute property MUST begin with a lowercase character.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>
   <!--PATTERN rule7-19Name of components other than attribute properties begin with upper case letter-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of components other than attribute properties begin with upper case letter</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute" priority="1002" mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:attribute"/>
      <!--REPORT warning-->
      <xsl:if test="false()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-19: The name of a model component that is not an attribute property MUST begin with an uppercase character.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:complexType[some $name in @name,                                      $extension in xs:simpleContent/xs:extension,                                      $base-qname in resolve-QName($extension/@base, $extension) satisfies                                      $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"
                 priority="1001"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[some $name in @name,                                      $extension in xs:simpleContent/xs:extension,                                      $base-qname in resolve-QName($extension/@base, $extension) satisfies                                      $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"/>
      <!--REPORT warning-->
      <xsl:if test="false()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-19: This rule does not apply to a proxy type.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name)]" priority="1000" mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@name, '^[A-Z]')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="matches(@name, '^[A-Z]')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-19: The name of a model component that is not an attribute property MUST begin with an uppercase character.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <!--PATTERN rule7-36Local term has literal or definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Local term has literal or definition</svrl:text>
   <!--RULE -->
   <xsl:template match="appinfo:LocalTerm" priority="1000" mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="appinfo:LocalTerm"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@literal) or exists(@definition)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(@literal) or exists(@definition)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-36: A LocalTerm element MUST have a @definition attribute, or a @literal attribute, or both.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <!--PATTERN rule7-37Namespace has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Namespace has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:schema" priority="1000" mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:schema"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in (xs:annotation/xs:documentation)[1] satisfies                          string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $definition in (xs:annotation/xs:documentation)[1] satisfies string-length(normalize-space(string($definition))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-37: The xs:schema element MUST be a documented component.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <!--PATTERN rule7-38aModel component has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Model component has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:simpleType" priority="1000" mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:simpleType"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                          string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $definition in xs:annotation/xs:documentation[1] satisfies string-length(normalize-space(string($definition))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-38: A type definition, element declaration, or attribute declaration MUST be a documented component</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <!--PATTERN rule7-38bModel component has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Model component has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:complexType"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                          string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $definition in xs:annotation/xs:documentation[1] satisfies string-length(normalize-space(string($definition))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-38: A type definition, element declaration, or attribute declaration MUST be a documented component</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <!--PATTERN rule7-38cModel component has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Model component has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name)]" priority="1000" mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                          string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $definition in xs:annotation/xs:documentation[1] satisfies string-length(normalize-space(string($definition))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-38: A type definition, element declaration, or attribute declaration MUST be a documented component</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <!--PATTERN rule7-38dModel component has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Model component has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                          string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $definition in xs:annotation/xs:documentation[1] satisfies string-length(normalize-space(string($definition))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-38: A type definition, element declaration, or attribute declaration MUST be a documented component</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <!--PATTERN rule7-39Enumeration facet has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Enumeration facet has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:enumeration" priority="1000" mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:enumeration"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                          string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $definition in xs:annotation/xs:documentation[1] satisfies string-length(normalize-space(string($definition))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 7-39: An xs:enumeration facet MUST be a documented component.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <!--PATTERN rule7-48Standard opening phrase for abstract property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for abstract property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[xs:boolean(@abstract) = true()                         and not(ends-with(@name, 'AugmentationPoint'))]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[xs:boolean(@abstract) = true()                         and not(ends-with(@name, 'AugmentationPoint'))]/xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(starts-with(lower-case(normalize-space(.)), 'a data concept'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(starts-with(lower-case(normalize-space(.)), 'a data concept'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-48: The data definition for an abstract property SHOULD begin with the standard opening phrase "A data concept...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <!--PATTERN rule7-49Standard opening phrase for association property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for association property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[ends-with(@name, 'Association')                                  and not(xs:boolean(@abstract) eq true())]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[ends-with(@name, 'Association')                                  and not(xs:boolean(@abstract) eq true())]/xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (relationship|association)'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (relationship|association)'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-49: The data definition for a property that has an association type and is not abstract SHOULD begin with the standard opening phrase "An (optional adjectives) (relationship|association)...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <!--PATTERN rule7-50Standard opening phrase for date property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for date property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Date') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Date') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (date|month|year)'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (date|month|year)'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-50: The data definition for a property with a date representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) (date|month|year)...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <!--PATTERN rule7-51Standard opening phrase for quantity property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for quantity property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Quantity') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Quantity') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (count|number)'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (count|number)'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-51: The data definition for a property with a quantity representation term SHOULD begin with the standard opening phrase "An (optional adjectives) (count|number)...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <!--PATTERN rule7-52Standard opening phrase for picture property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for picture property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Picture') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Picture') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (image|picture|photograph)'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? (image|picture|photograph)'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-52: The data definition for a property with a picture representation term SHOULD begin with the standard opening phrase "An (optional adjectives) (image|picture|photograph)".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <!--PATTERN rule7-53Standard opening phrase for indicator property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for indicator property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Indicator') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Indicator') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^true if .*; false (otherwise|if)'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^true if .*; false (otherwise|if)'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-53: The data definition for a property with an indicator representation term SHOULD begin with the standard opening phrase "True if ...; false (otherwise|if)...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <!--PATTERN rule7-54Standard opening phrase for identification property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for identification property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Identification') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Identification') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? identification'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^an?( .*)? identification'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-54: The data definition for a property with an identification representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) identification...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <!--PATTERN rule7-55Standard opening phrase for name property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for name property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Name') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[(self::xs:element or self::xs:attribute)                         and ends-with(@name, 'Name') and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^(a|an)( .*)? name'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^(a|an)( .*)? name'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-55: The data definition for a property with a name representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) name...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <!--PATTERN rule7-56Standard opening phrase for property data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for property data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="*[(self::xs:element or self::xs:attribute)                         and @name                         and not(ends-with(@name, 'Indicator'))                         and not(ends-with(@name, 'Augmentation'))                         and not(ends-with(@name, 'Metadata'))                         and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[(self::xs:element or self::xs:attribute)                         and @name                         and not(ends-with(@name, 'Indicator'))                         and not(ends-with(@name, 'Augmentation'))                         and not(ends-with(@name, 'Metadata'))                         and not(xs:boolean(@abstract) eq true())]                        /xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^an? '))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^an? '))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-56: The data definition for a property SHOULD begin with the standard opening phrase "(A|An)".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <!--PATTERN rule7-57Standard opening phrase for association class data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for association class data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[ends-with(@name, 'AssociationType')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[ends-with(@name, 'AssociationType')]/xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)), '^a data type for (a relationship|an association)'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^a data type for (a relationship|an association)'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 7-57: The data definition for an association class SHOULD begin with the standard opening phrase "A data type for (a relationship|an association)...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <!--PATTERN rule8-7Namespace has version-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Namespace has version</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:schema" priority="1000" mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:schema"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $version in @version satisfies                        string-length(normalize-space(@version)) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $version in @version satisfies string-length(normalize-space(@version)) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 8-7: The namespace MUST have a version, which MUST NOT be empty.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <!--PATTERN rule9-1aSchema is CTAS-conformant-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Schema is CTAS-conformant</svrl:text>
   <!--RULE -->
   <xsl:template match="*[exists(@ct:*[local-name() != 'conformanceTargets'])]"
                 priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[exists(@ct:*[local-name() != 'conformanceTargets'])]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-1: A conformant document MUST NOT contain any element or attribute information item that has the namespace name https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/, other than attribute {https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/}conformanceTargets (CTAS Rule 3-3).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <!--PATTERN rule9-1bSchema is CTAS-conformant-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Schema is CTAS-conformant</svrl:text>
   <!--RULE -->
   <xsl:template match="ct:*" priority="1000" mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ct:*"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>A conformant document MUST NOT contain any element or attribute information item that has the namespace name http://release.niem.gov/conformanceTargets/3.0/, other than attribute {http://release.niem.gov/conformanceTargets/3.0/}conformanceTargets) (CTAS rule 3-3).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <!--PATTERN rule9-1cSchema is CTAS-conformant-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Schema is CTAS-conformant</svrl:text>
   <!--RULE -->
   <xsl:template match="*[exists(@xsi:type['http://release.niem.gov/niem/conformanceTargets/3.0/' = namespace-uri-from-QName(resolve-QName(., ..))])]"
                 priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[exists(@xsi:type['http://release.niem.gov/niem/conformanceTargets/3.0/' = namespace-uri-from-QName(resolve-QName(., ..))])]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>A conformant document MUST NOT contain an attribute {http://www.w3.org/2001/XMLSchema-instance}type with a value that has a namespace name of https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/d (CTAS Rule 3-4).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <!--PATTERN rule9-2Document element has attribute `ct:conformanceTargets`-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Document element has attribute `ct:conformanceTargets`</svrl:text>
   <!--RULE -->
   <xsl:template match="*[. is nf:get-document-element(.)                         or exists(@ct:conformanceTargets)]"
                 priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[. is nf:get-document-element(.)                         or exists(@ct:conformanceTargets)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(. is nf:get-document-element(.)) = exists(@ct:conformanceTargets)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(. is nf:get-document-element(.)) = exists(@ct:conformanceTargets)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-2: The document element of the XML document, and only the document element, MUST own an attribute {https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/}conformanceTargets.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <!--PATTERN rule9-4Document element is `xs:schema`-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Document element is `xs:schema`</svrl:text>
   <!--RULE -->
   <xsl:template match="*[. is nf:get-document-element(.)]"
                 priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[. is nf:get-document-element(.)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="self::xs:schema"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="self::xs:schema">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-4: The document element of the XSD representation of a namespace MUST be xs:schema.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <!--PATTERN rule9-5aProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:notation" priority="1000" mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:notation"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:notation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <!--PATTERN rule9-5bProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:all" priority="1000" mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:all"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:all.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <!--PATTERN rule9-5cProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:unique" priority="1000" mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:unique"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:unique.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <!--PATTERN rule9-5dProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:key" priority="1000" mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:key"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:key.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <!--PATTERN rule9-5eProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:keyref" priority="1000" mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:keyref"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:keyref.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <!--PATTERN rule9-5fProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:group" priority="1000" mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:group"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:group.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <!--PATTERN rule9-5gProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attributeGroup[@name]" priority="1000" mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attributeGroup[@name]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:attributeGroup.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <!--PATTERN rule9-5hProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:redefine[@name]" priority="1000" mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:redefine[@name]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:redefine.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <!--PATTERN rule9-5iProhibited schema components-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited schema components</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:include[@name]" priority="1000" mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:include[@name]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-5: A schema document MUST NOT contain xs:include.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <!--PATTERN rule9-6aProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="namespace-uri-from-QName(resolve-QName(@base, .)) != xs:anyURI('http://www.w3.org/XML/1998/namespace')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="namespace-uri-from-QName(resolve-QName(@base, .)) != xs:anyURI('http://www.w3.org/XML/1998/namespace')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have a base type in the XML namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <!--PATTERN rule9-6bProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:ID')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@base, .) != xs:QName('xs:ID')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of xs:ID.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <!--PATTERN rule9-6cProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M57">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:IDREF')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@base, .) != xs:QName('xs:IDREF')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of xs:IDREF.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <!--PATTERN rule9-6dProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:IDREFS')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@base, .) != xs:QName('xs:IDREFS')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of any of xs:IDREFS.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <!--PATTERN rule9-6eProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:anyType')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@base, .) != xs:QName('xs:anyType')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of xs:anyType.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <!--PATTERN rule9-6fProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:anySimpleType')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@base, .) != xs:QName('xs:anySimpleType')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of xs:anySimpleType.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <!--PATTERN rule9-6gProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:NOTATION')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@base, .) != xs:QName('xs:NOTATION')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of xs:NOTATION.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <!--PATTERN rule9-6hProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:ENTITY')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@base, .) != xs:QName('xs:ENTITY')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of xs:ENTITY.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <!--PATTERN rule9-6iProhibited base types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited base types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@base, .) != xs:QName('xs:ENTITIES')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@base, .) != xs:QName('xs:ENTITIES')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-6: A schema component MUST NOT have an attribute {}base with a value of xs:ENTITIES.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <!--PATTERN rule9-7aProhibited list item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited list item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@itemType)]" priority="1000" mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@itemType)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@itemType, .) != xs:QName('xs:ID')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@itemType, .) != xs:QName('xs:ID')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-7: A schema component MUST NOT have an attribute {}itemType with a value of xs:ID.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <!--PATTERN rule9-7bProhibited list item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited list item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@itemType)]" priority="1000" mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@itemType)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@itemType, .) != xs:QName('xs:IDREF')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@itemType, .) != xs:QName('xs:IDREF')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-7: A schema component MUST NOT have an attribute {}itemType with a value of xs:IDREF.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <!--PATTERN rule9-7cProhibited list item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited list item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@itemType)]" priority="1000" mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@itemType)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@itemType, .) != xs:QName('xs:anySimpleType')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@itemType, .) != xs:QName('xs:anySimpleType')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-7: A schema component MUST NOT have an attribute {}itemType with a value of xs:anySimpleType.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <!--PATTERN rule9-7dProhibited list item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited list item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@itemType)]" priority="1000" mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@itemType)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@itemType, .) != xs:QName('xs:ENTITY')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@itemType, .) != xs:QName('xs:ENTITY')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-7: A schema component MUST NOT have an attribute {}itemType with a value of xs:ENTITY.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <!--PATTERN rule9-8aProhibited union item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited union item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@memberTypes)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                        in tokenize(normalize-space(@memberTypes), ' ')                        satisfies resolve-QName($type-qname, .) != xs:QName('xs:ID')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $type-qname in tokenize(normalize-space(@memberTypes), ' ') satisfies resolve-QName($type-qname, .) != xs:QName('xs:ID')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-8: A schema component MUST NOT have an attribute {}memberTypes with a value of xs:ID.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <!--PATTERN rule9-8bProhibited union item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited union item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@memberTypes)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                        in tokenize(normalize-space(@memberTypes), ' ')                        satisfies resolve-QName($type-qname, .) != xs:QName('xs:IDREF')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $type-qname in tokenize(normalize-space(@memberTypes), ' ') satisfies resolve-QName($type-qname, .) != xs:QName('xs:IDREF')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-8: A schema component MUST NOT have an attribute {}memberTypes with a value of xs:IDREF.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <!--PATTERN rule9-8cProhibited union item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited union item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@memberTypes)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                        in tokenize(normalize-space(@memberTypes), ' ')                        satisfies resolve-QName($type-qname, .) != xs:QName('xs:IDREFS')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $type-qname in tokenize(normalize-space(@memberTypes), ' ') satisfies resolve-QName($type-qname, .) != xs:QName('xs:IDREFS')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-8: A schema component MUST NOT have an attribute {}memberTypes with a value of xs:IDREFS.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <!--PATTERN rule9-8dProhibited union item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited union item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M71">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@memberTypes)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                        in tokenize(normalize-space(@memberTypes), ' ')                        satisfies resolve-QName($type-qname, .) != xs:QName('xs:anySimpleType')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $type-qname in tokenize(normalize-space(@memberTypes), ' ') satisfies resolve-QName($type-qname, .) != xs:QName('xs:anySimpleType')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-8: A schema component MUST NOT have an attribute {}memberTypes with a value of xs:anySimpleType.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <!--PATTERN rule9-8eProhibited union item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited union item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@memberTypes)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                        in tokenize(normalize-space(@memberTypes), ' ')                        satisfies resolve-QName($type-qname, .) != xs:QName('xs:ENTITY')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $type-qname in tokenize(normalize-space(@memberTypes), ' ') satisfies resolve-QName($type-qname, .) != xs:QName('xs:ENTITY')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-8: A schema component MUST NOT have an attribute {}memberTypes with a value of xs:ENTITY.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <!--PATTERN rule9-8fProhibited union item types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited union item types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@memberTypes)]" priority="1000" mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@memberTypes)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname                        in tokenize(normalize-space(@memberTypes), ' ')                        satisfies resolve-QName($type-qname, .) != xs:QName('xs:ENTITIES')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $type-qname in tokenize(normalize-space(@memberTypes), ' ') satisfies resolve-QName($type-qname, .) != xs:QName('xs:ENTITIES')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-8: A schema component MUST NOT have an attribute {}memberTypes with a value of xs:ENTITIES.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <!--PATTERN rule9-9aProhibited attribute types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited attribute types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M74">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:ID')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@type, .) != xs:QName('xs:ID')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-9: A schema component MUST NOT have an attribute {}type with a value of xs:ID.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <!--PATTERN rule9-9bProhibited attribute types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited attribute types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M75">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:IDREF')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@type, .) != xs:QName('xs:IDREF')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-9: A schema component MUST NOT have an attribute {}type with a value of xs:IDREF.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <!--PATTERN rule9-9cProhibited attribute types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited attribute types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M76">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:ENTITY')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@type, .) != xs:QName('xs:ENTITY')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-9: A schema component MUST NOT have an attribute {}type with a value of xs:ENTITY.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <!--PATTERN rule9-9dProhibited attribute types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited attribute types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M77">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:ENTITIES')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@type, .) != xs:QName('xs:ENTITIES')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-9: A schema component MUST NOT have an attribute {}type with a value of xs:ENTITIES.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <!--PATTERN rule9-9eProhibited attribute types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited attribute types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M78">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="resolve-QName(@type, .) != xs:QName('xs:anySimpleType')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="resolve-QName(@type, .) != xs:QName('xs:anySimpleType')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-9: A schema component MUST NOT have an attribute {}type with a value of xs:anySimpleType.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <!--PATTERN rule9-10aNo mixed content on complex type or complex content-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">No mixed content on complex type or complex content</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[exists(@mixed)]" priority="1000" mode="M79">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[exists(@mixed)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:boolean(@mixed) = false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="xs:boolean(@mixed) = false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-10: A complex type definition MUST NOT have mixed content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
   <!--PATTERN rule9-10bNo mixed content on complex type or complex content-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">No mixed content on complex type or complex content</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexContent[exists(@mixed)]"
                 priority="1000"
                 mode="M80">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexContent[exists(@mixed)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:boolean(@mixed) = false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="xs:boolean(@mixed) = false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-10: A complex type definition MUST NOT have mixed content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="@*|node()" priority="-2" mode="M80">
      <xsl:apply-templates select="*" mode="M80"/>
   </xsl:template>
   <!--PATTERN rule9-11Complex type content is explicitly simple or complex-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Complex type content is explicitly simple or complex</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M81">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:complexType"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(xs:simpleContent) or exists(xs:complexContent)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(xs:simpleContent) or exists(xs:complexContent)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-11: A complex type definition MUST have a xs:complexContent or a xs:simpleContent child element</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="@*|node()" priority="-2" mode="M81">
      <xsl:apply-templates select="*" mode="M81"/>
   </xsl:template>
   <!--PATTERN rule9-12aBase type of complex type with complex content must have complex content-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Base type of complex type with complex content must have complex content</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType/xs:complexContent/xs:*[                         (self::xs:extension or self::xs:restriction)                         and (some $base-qname in resolve-QName(@base, .) satisfies                                namespace-uri-from-QName($base-qname) = nf:get-target-namespace(.))]"
                 priority="1000"
                 mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType/xs:complexContent/xs:*[                         (self::xs:extension or self::xs:restriction)                         and (some $base-qname in resolve-QName(@base, .) satisfies                                namespace-uri-from-QName($base-qname) = nf:get-target-namespace(.))]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $base-type in nf:resolve-type(., resolve-QName(@base, .)) satisfies                          empty($base-type/self::xs:complexType/xs:simpleContent)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $base-type in nf:resolve-type(., resolve-QName(@base, .)) satisfies empty($base-type/self::xs:complexType/xs:simpleContent)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-12: The base type of a complex type with complex content MUST have complex content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="@*|node()" priority="-2" mode="M82">
      <xsl:apply-templates select="*" mode="M82"/>
   </xsl:template>
   <!--PATTERN rule9-12bBase type of complex type with complex content must have complex content-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Base type of complex type with complex content must have complex content</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[          nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#ReferenceSchemaDocument'))          or nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#ExtensionSchemaDocument'))        ]/xs:complexContent"
                 priority="1000"
                 mode="M83">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[          nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#ReferenceSchemaDocument'))          or nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#ExtensionSchemaDocument'))        ]/xs:complexContent"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $derivation in xs:*[self::xs:extension or self::xs:restriction],                             $base-qname in resolve-QName($derivation/@base, $derivation),                             $base-type in nf:resolve-type($derivation, $base-qname) satisfies                           empty($base-type/self::xs:complexType/xs:simpleContent)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $derivation in xs:*[self::xs:extension or self::xs:restriction], $base-qname in resolve-QName($derivation/@base, $derivation), $base-type in nf:resolve-type($derivation, $base-qname) satisfies empty($base-type/self::xs:complexType/xs:simpleContent)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-12: The base type of a complex type with complex content MUST have complex content.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="@*|node()" priority="-2" mode="M83">
      <xsl:apply-templates select="*" mode="M83"/>
   </xsl:template>
   <!--PATTERN rule9-13aUntyped element is abstract-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Untyped element is abstract</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:schema/xs:element[empty(@type)]"
                 priority="1000"
                 mode="M84">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:schema/xs:element[empty(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@abstract)                        and xs:boolean(@abstract) = true()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(@abstract) and xs:boolean(@abstract) = true()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-13: An untyped element or an element of type xs:anySimpleType MUST be abstract.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M84"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M84"/>
   <xsl:template match="@*|node()" priority="-2" mode="M84">
      <xsl:apply-templates select="*" mode="M84"/>
   </xsl:template>
   <!--PATTERN rule9-13bUntyped element is abstract-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Untyped element is abstract</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)                                  and resolve-QName(@type, .) = xs:QName('xs:anySimpleType')]"
                 priority="1000"
                 mode="M85">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@type)                                  and resolve-QName(@type, .) = xs:QName('xs:anySimpleType')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@abstract)                        and xs:boolean(@abstract) = true()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(@abstract) and xs:boolean(@abstract) = true()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-13: An untyped element or an element of type xs:anySimpleType MUST be abstract.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M85"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M85"/>
   <xsl:template match="@*|node()" priority="-2" mode="M85">
      <xsl:apply-templates select="*" mode="M85"/>
   </xsl:template>
   <!--PATTERN rule9-14aElement type not in the XML or XML Schema namespace-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Element type not in the XML or XML Schema namespace</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)]" priority="1000" mode="M86">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="for $type-qname in resolve-QName(@type, .) return                          $type-qname = xs:QName('xs:anySimpleType')                          or namespace-uri-from-QName($type-qname) != xs:anyURI('http://www.w3.org/2001/XMLSchema')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="for $type-qname in resolve-QName(@type, .) return $type-qname = xs:QName('xs:anySimpleType') or namespace-uri-from-QName($type-qname) != xs:anyURI('http://www.w3.org/2001/XMLSchema')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-14: An element type MUST NOT be in the XML Schema namespace or the XML namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M86"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M86"/>
   <xsl:template match="@*|node()" priority="-2" mode="M86">
      <xsl:apply-templates select="*" mode="M86"/>
   </xsl:template>
   <!--PATTERN rule9-14bElement type not in the XML or XML Schema namespace-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Element type not in the XML or XML Schema namespace</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)]" priority="1000" mode="M87">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="namespace-uri-from-QName(resolve-QName(@type, .)) != 'http://www.w3.org/XML/1998/namespace'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="namespace-uri-from-QName(resolve-QName(@type, .)) != 'http://www.w3.org/XML/1998/namespace'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-14: An element type MUST NOT be in the XML Schema namespace or the XML namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="@*|node()" priority="-2" mode="M87">
      <xsl:apply-templates select="*" mode="M87"/>
   </xsl:template>
   <!--PATTERN rule9-15Element type is not simple type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Element type is not simple type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[@type]" priority="1000" mode="M88">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:element[@type]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname in resolve-QName(@type, .),         $type-ns in namespace-uri-from-QName($type-qname),         $type-local-name in local-name-from-QName($type-qname) satisfies (         $type-qname = xs:QName('xs:anySimpleType')         or (($type-ns = nf:get-target-namespace(.)         or exists(nf:get-document-element(.)/xs:import[         xs:anyURI(@namespace) = $type-ns         and empty(@appinfo:externalImportIndicator)]))         and not(ends-with($type-local-name, 'SimpleType'))))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $type-qname in resolve-QName(@type, .), $type-ns in namespace-uri-from-QName($type-qname), $type-local-name in local-name-from-QName($type-qname) satisfies ( $type-qname = xs:QName('xs:anySimpleType') or (($type-ns = nf:get-target-namespace(.) or exists(nf:get-document-element(.)/xs:import[ xs:anyURI(@namespace) = $type-ns and empty(@appinfo:externalImportIndicator)])) and not(ends-with($type-local-name, 'SimpleType'))))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-15: An element type that is not xs:anySimpleType MUST NOT be a simple type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M88"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M88"/>
   <xsl:template match="@*|node()" priority="-2" mode="M88">
      <xsl:apply-templates select="*" mode="M88"/>
   </xsl:template>
   <!--PATTERN rule9-16Attribute declaration has type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Attribute declaration has type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M89">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@type)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@type)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-16: An attribute declaration MUST have a type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M89"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M89"/>
   <xsl:template match="@*|node()" priority="-2" mode="M89">
      <xsl:apply-templates select="*" mode="M89"/>
   </xsl:template>
   <!--PATTERN rule9-17aNo default or fixed value-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">No default or fixed value</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element" priority="1000" mode="M90">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:element"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@default)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@default)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-17: An attribute or element declaration MUST NOT have an attribute {}default or {}fixed.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="@*|node()" priority="-2" mode="M90">
      <xsl:apply-templates select="*" mode="M90"/>
   </xsl:template>
   <!--PATTERN rule9-17bNo default or fixed value-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">No default or fixed value</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element" priority="1000" mode="M91">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:element"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@fixed)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@fixed)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-17: An atttribute or element declaration MUST NOT have an attribute {}default or {}fixed.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M91"/>
   <xsl:template match="@*|node()" priority="-2" mode="M91">
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <!--PATTERN rule9-17cNo default or fixed value-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">No default or fixed value</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute" priority="1000" mode="M92">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:attribute"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@default)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@default)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-17: An attribute or element declaration MUST NOT have an attribute {}default or {}fixed.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M92"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M92"/>
   <xsl:template match="@*|node()" priority="-2" mode="M92">
      <xsl:apply-templates select="*" mode="M92"/>
   </xsl:template>
   <!--PATTERN rule9-17dNo default or fixed value-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">No default or fixed value</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute" priority="1000" mode="M93">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:attribute"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@fixed)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@fixed)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-17: An element declaration MUST NOT have an attribute {}default or {}fixed.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M93"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M93"/>
   <xsl:template match="@*|node()" priority="-2" mode="M93">
      <xsl:apply-templates select="*" mode="M93"/>
   </xsl:template>
   <!--PATTERN rule9-18aSequence has minimum and maximum cardinality 1-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Sequence has minimum and maximum cardinality 1</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:sequence" priority="1000" mode="M94">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:sequence"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@minOccurs) or xs:integer(@minOccurs) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@minOccurs) or xs:integer(@minOccurs) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-18: An element xs:sequence MUST have minOccurs and maxOccurs of 1.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M94"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M94"/>
   <xsl:template match="@*|node()" priority="-2" mode="M94">
      <xsl:apply-templates select="*" mode="M94"/>
   </xsl:template>
   <!--PATTERN rule9-18bSequence has minimum and maximum cardinality 1-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Sequence has minimum and maximum cardinality 1</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:sequence" priority="1000" mode="M95">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:sequence"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@maxOccurs) or (@maxOccurs instance of xs:integer                                              and 1 = xs:integer(@maxOccurs))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@maxOccurs) or (@maxOccurs instance of xs:integer and 1 = xs:integer(@maxOccurs))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-18: An element xs:sequence MUST have minOccurs and maxOccurs of 1.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M95"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M95"/>
   <xsl:template match="@*|node()" priority="-2" mode="M95">
      <xsl:apply-templates select="*" mode="M95"/>
   </xsl:template>
   <!--PATTERN rule9-19`xs:choice` must be child of `xs:sequence`-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">`xs:choice` must be child of `xs:sequence`</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:choice" priority="1000" mode="M96">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:choice"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:sequence)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(parent::xs:sequence)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-19: An element xs:choice MUST be a child of xs:sequence.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="@*|node()" priority="-2" mode="M96">
      <xsl:apply-templates select="*" mode="M96"/>
   </xsl:template>
   <!--PATTERN rule9-20aChoice has minimum and maximum cardinality 1-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Choice has minimum and maximum cardinality 1</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:choice" priority="1000" mode="M97">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:choice"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@minOccurs) or 1 = xs:integer(@minOccurs)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@minOccurs) or 1 = xs:integer(@minOccurs)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-20: An element xs:choice MUST have minOccurs and maxOccurs of 1.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M97"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M97"/>
   <xsl:template match="@*|node()" priority="-2" mode="M97">
      <xsl:apply-templates select="*" mode="M97"/>
   </xsl:template>
   <!--PATTERN rule9-20bChoice has minimum and maximum cardinality 1-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Choice has minimum and maximum cardinality 1</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:choice" priority="1000" mode="M98">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:choice"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@maxOccurs) or (@maxOccurs instance of xs:integer                                              and 1 = xs:integer(@maxOccurs))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@maxOccurs) or (@maxOccurs instance of xs:integer and 1 = xs:integer(@maxOccurs))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-20: An element xs:choice MUST have minOccurs and maxOccurs of 1.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M98"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M98"/>
   <xsl:template match="@*|node()" priority="-2" mode="M98">
      <xsl:apply-templates select="*" mode="M98"/>
   </xsl:template>
   <!--PATTERN rule9-21Comment is not recommended-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Comment is not recommended</svrl:text>
   <!--RULE -->
   <xsl:template match="node()[comment()]" priority="1000" mode="M99">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="node()[comment()]"/>
      <!--REPORT warning-->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 9-21: An XML comment SHOULD NOT appear in the schema.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M99"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M99"/>
   <xsl:template match="@*|node()" priority="-2" mode="M99">
      <xsl:apply-templates select="*" mode="M99"/>
   </xsl:template>
   <!--PATTERN rule9-22Documentation element has no element children-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Documentation element has no element children</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:documentation/node()" priority="1000" mode="M100">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:documentation/node()"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="self::text() or self::comment()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="self::text() or self::comment()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-22: A child of element xs:documentation MUST be text or an XML comment.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M100"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M100"/>
   <xsl:template match="@*|node()" priority="-2" mode="M100">
      <xsl:apply-templates select="*" mode="M100"/>
   </xsl:template>
   <!--PATTERN rule9-23Import has namespace-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Import has namespace</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:import" priority="1000" mode="M101">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:import"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@namespace)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@namespace)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-23: An element xs:import MUST have an attribute {}namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M101"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M101"/>
   <xsl:template match="@*|node()" priority="-2" mode="M101">
      <xsl:apply-templates select="*" mode="M101"/>
   </xsl:template>
   <!--PATTERN rule9-25Name of type definitions-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of type definitions</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name) and ends-with(@name, 'SimpleType')]"
                 priority="1001"
                 mode="M102">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@name) and ends-with(@name, 'SimpleType')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="local-name() = 'simpleType'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="local-name() = 'simpleType'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-25: A type definition that does not define a *proxy type* MUST have a name ending in "Type"; all other XSD components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@name) and ends-with(@name, 'Type')]"
                 priority="1000"
                 mode="M102">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[exists(@name) and ends-with(@name, 'Type')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="local-name() = 'complexType'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="local-name() = 'complexType'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-25: A type definition that does not define a *proxy type* MUST have a name ending in "Type"; all other XSD components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M102"/>
   <xsl:template match="@*|node()" priority="-2" mode="M102">
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <!--PATTERN rule9-26Name of simple type definitions-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of simple type definitions</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:simpleType[@name]" priority="1000" mode="M103">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:simpleType[@name]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ends-with(@name, 'SimpleType')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="ends-with(@name, 'SimpleType')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-26: A simple type definition MUST have a name ending in "SimpleType"; all other XSD components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M103"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M103"/>
   <xsl:template match="@*|node()" priority="-2" mode="M103">
      <xsl:apply-templates select="*" mode="M103"/>
   </xsl:template>
   <!--PATTERN rule9-28`xs:sequence` must be child of `xs:extension`-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">`xs:sequence` must be child of `xs:extension`</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:sequence" priority="1000" mode="M104">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:sequence"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:extension)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(parent::xs:extension)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-28: An element xs:sequence MUST be a child of xs:extension.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M104"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M104"/>
   <xsl:template match="@*|node()" priority="-2" mode="M104">
      <xsl:apply-templates select="*" mode="M104"/>
   </xsl:template>
   <!--PATTERN rule9-29`xs:sequence` must be child of `xs:extension` or `xs:restriction`-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">`xs:sequence` must be child of `xs:extension` or `xs:restriction`</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:sequence" priority="1000" mode="M105">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:sequence"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:extension) or exists(parent::xs:restriction)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(parent::xs:extension) or exists(parent::xs:restriction)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-29: An element xs:sequence MUST be a child of xs:extension or xs:restriction.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M105"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M105"/>
   <xsl:template match="@*|node()" priority="-2" mode="M105">
      <xsl:apply-templates select="*" mode="M105"/>
   </xsl:template>
   <!--PATTERN rule9-30aType definition is top-level-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Type definition is top-level</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:simpleType" priority="1000" mode="M106">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:simpleType"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:schema)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(parent::xs:schema)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-30: A type definition MUST be top-level.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M106"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M106"/>
   <xsl:template match="@*|node()" priority="-2" mode="M106">
      <xsl:apply-templates select="*" mode="M106"/>
   </xsl:template>
   <!--PATTERN rule9-30bType definition is top-level-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Type definition is top-level</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M107">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:complexType"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:schema)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(parent::xs:schema)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-30: A type definition MUST be top-level.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M107"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M107"/>
   <xsl:template match="@*|node()" priority="-2" mode="M107">
      <xsl:apply-templates select="*" mode="M107"/>
   </xsl:template>
   <!--PATTERN rule9-32Object type with complex content is derived from `structures:ObjectType`-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Object type with complex content is derived from `structures:ObjectType`</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[exists(xs:complexContent)                                      and not(ends-with(@name, 'AssociationType')                                          or ends-with(@name, 'MetadataType')                                          or ends-with(@name, 'AugmentationType'))]"
                 priority="1000"
                 mode="M108">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[exists(xs:complexContent)                                      and not(ends-with(@name, 'AssociationType')                                          or ends-with(@name, 'MetadataType')                                          or ends-with(@name, 'AugmentationType'))]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="          every $derivation-method in (xs:complexContent/xs:extension, xs:complexContent/xs:restriction),                $base in $derivation-method/@base,                $base-qname in resolve-QName($base, $derivation-method),                $base-local-name in local-name-from-QName($base-qname) satisfies (            $base-qname = xs:QName('structures:ObjectType')            or not(ends-with($base-local-name, 'AssociationType')                   or ends-with($base-local-name, 'MetadataType')                   or ends-with($base-local-name, 'AugmentationType')))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $derivation-method in (xs:complexContent/xs:extension, xs:complexContent/xs:restriction), $base in $derivation-method/@base, $base-qname in resolve-QName($base, $derivation-method), $base-local-name in local-name-from-QName($base-qname) satisfies ( $base-qname = xs:QName('structures:ObjectType') or not(ends-with($base-local-name, 'AssociationType') or ends-with($base-local-name, 'MetadataType') or ends-with($base-local-name, 'AugmentationType')))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-32: A type with complex content that does not represent an adapter class, an association class, or an augmentation type MUST be derived from structures:ObjectType or from another object type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M108"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M108"/>
   <xsl:template match="@*|node()" priority="-2" mode="M108">
      <xsl:apply-templates select="*" mode="M108"/>
   </xsl:template>
   <!--PATTERN Association type derived form structures:AssociationType-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Association type derived form structures:AssociationType</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType" priority="1000" mode="M109">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:complexType"/>
      <xsl:variable name="is-association-type"
                    select="exists(@name[ends-with(., 'AssociationType')])"/>
      <xsl:variable name="has-association-base-type"
                    select="         exists(xs:complexContent[           exists(xs:*[local-name() = ('extension', 'restriction')                       and exists(@base[ends-with(., 'AssociationType')])])])"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$is-association-type = $has-association-base-type"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="$is-association-type = $has-association-base-type">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-34: A type definition that represents an association class MUST be derived from structures:AssociationType or from another association class.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M109"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M109"/>
   <xsl:template match="@*|node()" priority="-2" mode="M109">
      <xsl:apply-templates select="*" mode="M109"/>
   </xsl:template>
   <!--PATTERN rule9-35Augmentation type derived from structures:AugmentationType-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Augmentation type derived from structures:AugmentationType</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[(self::xs:restriction or self::xs:extension)                            and ends-with(@base, 'AugmentationType')]"
                 priority="1000"
                 mode="M110">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[(self::xs:restriction or self::xs:extension)                            and ends-with(@base, 'AugmentationType')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::xs:complexType[ends-with(@name, 'AugmentationType')]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="ancestor::xs:complexType[ends-with(@name, 'AugmentationType')]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-35: A type definition that is an augmentation type MUST be derived from structures:AugmentationType.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M110"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M110"/>
   <xsl:template match="@*|node()" priority="-2" mode="M110">
      <xsl:apply-templates select="*" mode="M110"/>
   </xsl:template>
   <!--PATTERN rule9-36Complex type with simple content has `structures:SimpleObjectAttributeGroup`-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Complex type with simple content has `structures:SimpleObjectAttributeGroup`</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:simpleContent/xs:extension[        some $base-qname in resolve-QName(@base, .) satisfies          namespace-uri-from-QName($base-qname) = xs:anyURI('http://www.w3.org/2001/XMLSchema')          or ends-with(local-name-from-QName($base-qname), 'SimpleType')]"
                 priority="1000"
                 mode="M111">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:simpleContent/xs:extension[        some $base-qname in resolve-QName(@base, .) satisfies          namespace-uri-from-QName($base-qname) = xs:anyURI('http://www.w3.org/2001/XMLSchema')          or ends-with(local-name-from-QName($base-qname), 'SimpleType')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:attributeGroup[                          resolve-QName(@ref, .) = xs:QName('structures:SimpleObjectAttributeGroup')]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="xs:attributeGroup[ resolve-QName(@ref, .) = xs:QName('structures:SimpleObjectAttributeGroup')]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-36: A complex type definition with simple content MUST include structures:SimpleObjectAttributeGroup.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M111"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M111"/>
   <xsl:template match="@*|node()" priority="-2" mode="M111">
      <xsl:apply-templates select="*" mode="M111"/>
   </xsl:template>
   <!--PATTERN rule9-37Base type definition defined by conformant schema-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Base type definition defined by conformant schema</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[exists(@base)]" priority="1000" mode="M112">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:*[exists(@base)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $base-namespace in namespace-uri-from-QName(resolve-QName(@base, .)) satisfies (                          $base-namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema'))                          or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                                                     and $base-namespace = xs:anyURI(@namespace)                                                                     and empty(@appinfo:externalImportIndicator)]))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $base-namespace in namespace-uri-from-QName(resolve-QName(@base, .)) satisfies ( $base-namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema')) or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace) and $base-namespace = xs:anyURI(@namespace) and empty(@appinfo:externalImportIndicator)]))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-37: The base type definition of a type definition MUST have the target namespace or the XML Schema namespace or a namespace that is imported as conformant.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M112"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M112"/>
   <xsl:template match="@*|node()" priority="-2" mode="M112">
      <xsl:apply-templates select="*" mode="M112"/>
   </xsl:template>
   <!--PATTERN rule9-38aComponent reference defined by conformant schema-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Component reference defined by conformant schema</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(ancestor::xs:complexType[not(ends-with(@name, 'AdapterType'))]) and @ref]"
                 priority="1000"
                 mode="M113">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(ancestor::xs:complexType[not(ends-with(@name, 'AdapterType'))]) and @ref]"/>
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@ref, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$namespace = nf:get-target-namespace(.)                        or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                      and $namespace = xs:anyURI(@namespace)                                      and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="$namespace = nf:get-target-namespace(.) or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace) and $namespace = xs:anyURI(@namespace) and empty(@appinfo:externalImportIndicator)])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-38: An attribute or element reference MUST have the target namespace or a namespace that is imported as conformant.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M113"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M113"/>
   <xsl:template match="@*|node()" priority="-2" mode="M113">
      <xsl:apply-templates select="*" mode="M113"/>
   </xsl:template>
   <!--PATTERN rule9-38bComponent reference defined by conformant schema-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Component reference defined by conformant schema</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[@ref]" priority="1000" mode="M114">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:attribute[@ref]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies (                          $namespace = nf:get-target-namespace(.)                          or ancestor::xs:schema[1]/xs:import[                               @namespace                               and $namespace = xs:anyURI(@namespace)                               and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies ( $namespace = nf:get-target-namespace(.) or ancestor::xs:schema[1]/xs:import[ @namespace and $namespace = xs:anyURI(@namespace) and empty(@appinfo:externalImportIndicator)])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-38: An attribute or element reference MUST have the target namespace or a namespace that is imported as conformant.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M114"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M114"/>
   <xsl:template match="@*|node()" priority="-2" mode="M114">
      <xsl:apply-templates select="*" mode="M114"/>
   </xsl:template>
   <!--PATTERN rule9-39Schema uses only known attribute groups-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Schema uses only known attribute groups</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attributeGroup[@ref]" priority="1000" mode="M115">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attributeGroup[@ref]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $ref in resolve-QName(@ref, .) satisfies (                          $ref = xs:QName('structures:SimpleObjectAttributeGroup')                          or namespace-uri-from-QName($ref) = (xs:anyURI('urn:us:gov:ic:ism'),                                                               xs:anyURI('urn:us:gov:ic:ntk')))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $ref in resolve-QName(@ref, .) satisfies ( $ref = xs:QName('structures:SimpleObjectAttributeGroup') or namespace-uri-from-QName($ref) = (xs:anyURI('urn:us:gov:ic:ism'), xs:anyURI('urn:us:gov:ic:ntk')))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-39: An attribute group reference MUST be structures:SimpleObjectAttributeGroup.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M115"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M115"/>
   <xsl:template match="@*|node()" priority="-2" mode="M115">
      <xsl:apply-templates select="*" mode="M115"/>
   </xsl:template>
   <!--PATTERN rule9-41List item type defined by conformant schemas-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">List item type defined by conformant schemas</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:list[exists(@itemType)]" priority="1000" mode="M116">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:list[exists(@itemType)]"/>
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@itemType, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema'))                        or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                      and $namespace = xs:anyURI(@namespace)                                      and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="$namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema')) or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace) and $namespace = xs:anyURI(@namespace) and empty(@appinfo:externalImportIndicator)])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-41: The item type of a list simple type definition MUST have a target namespace equal to the target namespace of the XML Schema document within which it is defined, or a namespace that is imported as conformant by the schema document within which it is defined.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M116"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M116"/>
   <xsl:template match="@*|node()" priority="-2" mode="M116">
      <xsl:apply-templates select="*" mode="M116"/>
   </xsl:template>
   <!--PATTERN rule9-42Union member types defined by conformant schemas-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Union member types defined by conformant schemas</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:union[exists(@memberTypes)]" priority="1000" mode="M117">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:union[exists(@memberTypes)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $qname in tokenize(normalize-space(@memberTypes), ' '),                              $namespace in namespace-uri-from-QName(resolve-QName($qname, .))                        satisfies ($namespace = nf:get-target-namespace(.)                                   or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                             and $namespace = xs:anyURI(@namespace)                                             and empty(@appinfo:externalImportIndicator)]))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $qname in tokenize(normalize-space(@memberTypes), ' '), $namespace in namespace-uri-from-QName(resolve-QName($qname, .)) satisfies ($namespace = nf:get-target-namespace(.) or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace) and $namespace = xs:anyURI(@namespace) and empty(@appinfo:externalImportIndicator)]))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-42: Every member type of a union simple type definition MUST have a target namespace that is equal to either the target namespace of the XML Schema document within which it is defined or a namespace that is imported as conformant by the schema document within which it is defined.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M117"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M117"/>
   <xsl:template match="@*|node()" priority="-2" mode="M117">
      <xsl:apply-templates select="*" mode="M117"/>
   </xsl:template>
   <!--PATTERN rule9-45aDeclarations are top-level-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Declarations are top-level</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name)]" priority="1000" mode="M118">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:schema)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(parent::xs:schema)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-45: An attribute declaration or element declaration MUST be top-level.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M118"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M118"/>
   <xsl:template match="@*|node()" priority="-2" mode="M118">
      <xsl:apply-templates select="*" mode="M118"/>
   </xsl:template>
   <!--PATTERN rule9-45bDeclarations are top-level-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Declarations are top-level</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@name)]" priority="1000" mode="M119">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(parent::xs:schema)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(parent::xs:schema)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-45: An attribute declaration or element declaration MUST be top-level.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M119"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M119"/>
   <xsl:template match="@*|node()" priority="-2" mode="M119">
      <xsl:apply-templates select="*" mode="M119"/>
   </xsl:template>
   <!--PATTERN rule9-46aElement type is not simple type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Element type is not simple type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[@type]" priority="1000" mode="M120">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:element[@type]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $type-qname in resolve-QName(@type, .),                              $type-ns in namespace-uri-from-QName($type-qname),                              $type-local-name in local-name-from-QName($type-qname) satisfies (                          $type-qname = xs:QName('xs:anySimpleType')                          or (($type-ns = nf:get-target-namespace(.)                               or exists(nf:get-document-element(.)/xs:import[                                           xs:anyURI(@namespace) = $type-ns                                           and empty(@appinfo:externalImportIndicator)]))                              and not(ends-with($type-local-name, 'SimpleType'))))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $type-qname in resolve-QName(@type, .), $type-ns in namespace-uri-from-QName($type-qname), $type-local-name in local-name-from-QName($type-qname) satisfies ( $type-qname = xs:QName('xs:anySimpleType') or (($type-ns = nf:get-target-namespace(.) or exists(nf:get-document-element(.)/xs:import[ xs:anyURI(@namespace) = $type-ns and empty(@appinfo:externalImportIndicator)])) and not(ends-with($type-local-name, 'SimpleType'))))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-46: An element declaration MUST NOT have a simple type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M120"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M120"/>
   <xsl:template match="@*|node()" priority="-2" mode="M120">
      <xsl:apply-templates select="*" mode="M120"/>
   </xsl:template>
   <!--PATTERN rule9-46bElement type is not simple type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Element type is not simple type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)]" priority="1000" mode="M121">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(ends-with(@type, 'SimpleType'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not(ends-with(@type, 'SimpleType'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-46: An element declaration MUST NOT have a simple type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M121"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M121"/>
   <xsl:template match="@*|node()" priority="-2" mode="M121">
      <xsl:apply-templates select="*" mode="M121"/>
   </xsl:template>
   <!--PATTERN rule9-47aAttribute and element type is from conformant namespace-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Attribute and element type is from conformant namespace</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@type)]" priority="1000" mode="M122">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="for $type-qname in resolve-QName(@type, .),                            $type-namespace in namespace-uri-from-QName($type-qname) return                          $type-namespace = nf:get-target-namespace(.)                          or exists(nf:get-document-element(.)/xs:import[                                      xs:anyURI(@namespace) = $type-namespace                                      and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="for $type-qname in resolve-QName(@type, .), $type-namespace in namespace-uri-from-QName($type-qname) return $type-namespace = nf:get-target-namespace(.) or exists(nf:get-document-element(.)/xs:import[ xs:anyURI(@namespace) = $type-namespace and empty(@appinfo:externalImportIndicator)])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-47: The type definition of an attribute or element declaration MUST have a target namespace that is the target namespace, or a namespace that is imported as conformant.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M122"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M122"/>
   <xsl:template match="@*|node()" priority="-2" mode="M122">
      <xsl:apply-templates select="*" mode="M122"/>
   </xsl:template>
   <!--PATTERN rule9-47bAttribute and element type is from conformant namespace-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Attribute and element type is from conformant namespace</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M123">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@type)]"/>
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@type, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema'))                        or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                      and $namespace = xs:anyURI(@namespace)                                      and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="$namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema')) or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace) and $namespace = xs:anyURI(@namespace) and empty(@appinfo:externalImportIndicator)])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-47: The type definition of an attribute or element declaration MUST have a target namespace that is the target namespace, or a namespace that is imported as conformant.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M123"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M123"/>
   <xsl:template match="@*|node()" priority="-2" mode="M123">
      <xsl:apply-templates select="*" mode="M123"/>
   </xsl:template>
   <!--PATTERN rule9-48Element substitution group defined by conformant schema-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Element substitution group defined by conformant schema</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@substitutionGroup)]"
                 priority="1000"
                 mode="M124">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@substitutionGroup)]"/>
      <xsl:variable name="namespace"
                    select="namespace-uri-from-QName(resolve-QName(@substitutionGroup, .))"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$namespace = nf:get-target-namespace(.)                        or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace)                                      and $namespace = xs:anyURI(@namespace)                                      and empty(@appinfo:externalImportIndicator)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="$namespace = nf:get-target-namespace(.) or exists(ancestor::xs:schema[1]/xs:import[exists(@namespace) and $namespace = xs:anyURI(@namespace) and empty(@appinfo:externalImportIndicator)])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-48: An element substitution group MUST have either the target namespace or a namespace that is imported as conformant.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M124"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M124"/>
   <xsl:template match="@*|node()" priority="-2" mode="M124">
      <xsl:apply-templates select="*" mode="M124"/>
   </xsl:template>
   <!--PATTERN rule9-50Prohibited attribute types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Prohibited attribute types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[exists(@type)]" priority="1000" mode="M125">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[exists(@type)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(resolve-QName(@type, .) = xs:QName('xs:IDREFS')) =                     (@appinfo:referenceAttributeIndicator = 'true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(resolve-QName(@type, .) = xs:QName('xs:IDREFS')) = (@appinfo:referenceAttributeIndicator = 'true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-50: The attribute declaration of a reference attribute MUST have type `xs:IDREFS`; all other components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M125"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M125"/>
   <xsl:template match="@*|node()" priority="-2" mode="M125">
      <xsl:apply-templates select="*" mode="M125"/>
   </xsl:template>
   <!--PATTERN rule9-52Import of external namespace has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Import of external namespace has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:import[@appinfo:externalImportIndicator]"
                 priority="1000"
                 mode="M126">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:import[@appinfo:externalImportIndicator]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $definition in xs:annotation/xs:documentation[1] satisfies                          string-length(normalize-space(string($definition))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $definition in xs:annotation/xs:documentation[1] satisfies string-length(normalize-space(string($definition))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-52: An xs:import element importing an external schema document MUST be a documented component.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M126"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M126"/>
   <xsl:template match="@*|node()" priority="-2" mode="M126">
      <xsl:apply-templates select="*" mode="M126"/>
   </xsl:template>
   <!--PATTERN rule9-54Structure of external adapter type definition follows pattern-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Structure of external adapter type definition follows pattern</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[@appinfo:externalAdapterTypeIndicator]"
                 priority="1000"
                 mode="M127">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[@appinfo:externalAdapterTypeIndicator]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:complexContent/xs:extension[                          resolve-QName(@base, .) = xs:QName('structures:ObjectType')                        ]/xs:sequence"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="xs:complexContent/xs:extension[ resolve-QName(@base, .) = xs:QName('structures:ObjectType') ]/xs:sequence">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-54: An adapter type definition MUST be a complex type definition with complex content that extends structures:ObjectType, and that uses xs:sequence as its top-level compositor.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M127"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M127"/>
   <xsl:template match="@*|node()" priority="-2" mode="M127">
      <xsl:apply-templates select="*" mode="M127"/>
   </xsl:template>
   <!--PATTERN rule9-55Element use from external adapter type defined by external schema documents-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Element use from external adapter type defined by external schema documents</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[@ref                                  and exists(ancestor::xs:complexType[exists(@appinfo:externalAdapterTypeIndicator)])]"
                 priority="1000"
                 mode="M128">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[@ref                                  and exists(ancestor::xs:complexType[exists(@appinfo:externalAdapterTypeIndicator)])]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies                          nf:get-document-element(.)/xs:import[                            $ref-namespace = xs:anyURI(@namespace)                            and @appinfo:externalImportIndicator]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies nf:get-document-element(.)/xs:import[ $ref-namespace = xs:anyURI(@namespace) and @appinfo:externalImportIndicator]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-55: An element reference that appears within an adapter type MUST have a target namespace that is imported as external.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M128"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M128"/>
   <xsl:template match="@*|node()" priority="-2" mode="M128">
      <xsl:apply-templates select="*" mode="M128"/>
   </xsl:template>
   <!--PATTERN rule9-56aExternal adapter type not a base type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">External adapter type not a base type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[(self::xs:extension or self::xs:restriction)       and (some $base-qname in resolve-QName(@base, .),       $base-namespace in namespace-uri-from-QName($base-qname) satisfies       nf:get-target-namespace(.) = $base-namespace)]"
                 priority="1000"
                 mode="M129">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[(self::xs:extension or self::xs:restriction)       and (some $base-qname in resolve-QName(@base, .),       $base-namespace in namespace-uri-from-QName($base-qname) satisfies       nf:get-target-namespace(.) = $base-namespace)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="nf:resolve-type(., resolve-QName(@base, .))[         empty(@appinfo:externalAdapterTypeIndicator)]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="nf:resolve-type(., resolve-QName(@base, .))[ empty(@appinfo:externalAdapterTypeIndicator)]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-56: An adapter type definition MUST NOT be a base type definition.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M129"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M129"/>
   <xsl:template match="@*|node()" priority="-2" mode="M129">
      <xsl:apply-templates select="*" mode="M129"/>
   </xsl:template>
   <!--PATTERN rule9-56bExternal adapter type not a base type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">External adapter type not a base type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[(self::xs:extension or self::xs:restriction)       and (nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#ReferenceSchemaDocument'))       or nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#ExtensionSchemaDocument')))       and (some $base-qname in resolve-QName(@base, .),       $base-namespace in namespace-uri-from-QName($base-qname) satisfies       not($base-namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema'))))]"
                 priority="1000"
                 mode="M130">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[(self::xs:extension or self::xs:restriction)       and (nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#ReferenceSchemaDocument'))       or nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#ExtensionSchemaDocument')))       and (some $base-qname in resolve-QName(@base, .),       $base-namespace in namespace-uri-from-QName($base-qname) satisfies       not($base-namespace = (nf:get-target-namespace(.), xs:anyURI('http://www.w3.org/2001/XMLSchema'))))]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="nf:resolve-type(., resolve-QName(@base, .))[         empty(@appinfo:externalAdapterTypeIndicator)]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="nf:resolve-type(., resolve-QName(@base, .))[ empty(@appinfo:externalAdapterTypeIndicator)]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-56: An external adapter type definition MUST NOT be a base type definition.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M130"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M130"/>
   <xsl:template match="@*|node()" priority="-2" mode="M130">
      <xsl:apply-templates select="*" mode="M130"/>
   </xsl:template>
   <!--PATTERN rule9-57External attribute use has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">External attribute use has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:attribute[some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)),                                         $import in ancestor::xs:schema[1]/xs:import satisfies (                                      xs:anyURI($import/@namespace) = $ref-namespace                                      and exists(@appinfo:externalImportIndicator))]"
                 priority="1000"
                 mode="M131">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:attribute[some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)),                                         $import in ancestor::xs:schema[1]/xs:import satisfies (                                      xs:anyURI($import/@namespace) = $ref-namespace                                      and exists(@appinfo:externalImportIndicator))]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $documentation in xs:annotation/xs:documentation[1] satisfies                          string-length(normalize-space(string($documentation))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $documentation in xs:annotation/xs:documentation[1] satisfies string-length(normalize-space(string($documentation))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-57: An external attribute use MUST be a documented component with a non-empty data definition.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M131"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M131"/>
   <xsl:template match="@*|node()" priority="-2" mode="M131">
      <xsl:apply-templates select="*" mode="M131"/>
   </xsl:template>
   <!--PATTERN rule9-59External element use has data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">External element use has data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[        some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies          nf:get-document-element(.)/self::xs:schema//xs:import[            xs:anyURI(@namespace) = $ref-namespace            and @appinfo:externalImportIndicator]]"
                 priority="1000"
                 mode="M132">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[        some $ref-namespace in namespace-uri-from-QName(resolve-QName(@ref, .)) satisfies          nf:get-document-element(.)/self::xs:schema//xs:import[            xs:anyURI(@namespace) = $ref-namespace            and @appinfo:externalImportIndicator]]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="some $documentation in xs:annotation/xs:documentation[1] satisfies                          string-length(normalize-space(string($documentation))) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="some $documentation in xs:annotation/xs:documentation[1] satisfies string-length(normalize-space(string($documentation))) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-59: An external attribute use MUST be a documented component with a non-empty data definition.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M132"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M132"/>
   <xsl:template match="@*|node()" priority="-2" mode="M132">
      <xsl:apply-templates select="*" mode="M132"/>
   </xsl:template>
   <!--PATTERN rule9-61Proxy type has designated structure-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Proxy type has designated structure</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[some $name in @name,       $extension in xs:simpleContent/xs:extension,       $base-qname in resolve-QName($extension/@base, $extension) satisfies       $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"
                 priority="1000"
                 mode="M133">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[some $name in @name,       $extension in xs:simpleContent/xs:extension,       $base-qname in resolve-QName($extension/@base, $extension) satisfies       $base-qname = QName('http://www.w3.org/2001/XMLSchema', $name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="xs:simpleContent[         xs:extension[         empty(xs:attribute)         and count(xs:attributeGroup) = 1         and xs:attributeGroup[         resolve-QName(@ref, .) = xs:QName('structures:SimpleObjectAttributeGroup')]]]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="xs:simpleContent[ xs:extension[ empty(xs:attribute) and count(xs:attributeGroup) = 1 and xs:attributeGroup[ resolve-QName(@ref, .) = xs:QName('structures:SimpleObjectAttributeGroup')]]]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>A proxy type MUST have the designated structure. It MUST use xs:extension. It MUST NOT use xs:attribute. It MUST include exactly one xs:attributeGroup reference, which must be to structures:SimpleObjectAttributeGroup.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M133"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M133"/>
   <xsl:template match="@*|node()" priority="-2" mode="M133">
      <xsl:apply-templates select="*" mode="M133"/>
   </xsl:template>
   <!--PATTERN rule9-62bName of augmentation types-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of augmentation types</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[ends-with(@name, 'AugmentationType')]"
                 priority="1000"
                 mode="M134">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[ends-with(@name, 'AugmentationType')]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="self::xs:complexType/xs:complexContent/xs:*[                          (self::xs:extension or self::xs:restriction)                          and ends-with(@base, 'AugmentationType')]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="self::xs:complexType/xs:complexContent/xs:*[ (self::xs:extension or self::xs:restriction) and ends-with(@base, 'AugmentationType')]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-62: The XSD definition of an augmentation type MUST have a name ending in "AugmentationType"; all other XSD components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M134"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M134"/>
   <xsl:template match="@*|node()" priority="-2" mode="M134">
      <xsl:apply-templates select="*" mode="M134"/>
   </xsl:template>
   <!--PATTERN rule9-63Name of augmentation elements-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Name of augmentation elements</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name)]" priority="1000" mode="M135">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@name)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@type[ends-with(., 'AugmentationType')])                        = exists(@name[ends-with(., 'Augmentation')])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(@type[ends-with(., 'AugmentationType')]) = exists(@name[ends-with(., 'Augmentation')])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-63: The XSD declaration of an augmentation element MUST have a name ending in "Augmentation"; all other XSD components MUST NOT.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M135"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M135"/>
   <xsl:template match="@*|node()" priority="-2" mode="M135">
      <xsl:apply-templates select="*" mode="M135"/>
   </xsl:template>
   <!--PATTERN rule9-65Standard opening phrase for augmentation point element data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for augmentation point element data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[ends-with(@name, 'AugmentationPoint')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M136">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[ends-with(@name, 'AugmentationPoint')]/xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(starts-with(lower-case(normalize-space(.)), 'an augmentation point '))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(starts-with(lower-case(normalize-space(.)), 'an augmentation point '))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 9-65: The data definition for an augmentation point element SHOULD begin with standard opening phrase "An augmentation point...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M136"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M136"/>
   <xsl:template match="@*|node()" priority="-2" mode="M136">
      <xsl:apply-templates select="*" mode="M136"/>
   </xsl:template>
   <!--PATTERN rule9-66Standard opening phrase for augmentation element data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for augmentation element data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[ends-with(@name, 'Augmentation')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M137">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[ends-with(@name, 'Augmentation')]/xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="every $phrase                in ('supplements ', 'additional information about ')                satisfies not(starts-with(lower-case(normalize-space(.)), $phrase))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="every $phrase in ('supplements ', 'additional information about ') satisfies not(starts-with(lower-case(normalize-space(.)), $phrase))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 9-66: The data definition for an augmentation element SHOULD begin with the standard opening phrase "Supplements..." or "Additional information about...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M137"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M137"/>
   <xsl:template match="@*|node()" priority="-2" mode="M137">
      <xsl:apply-templates select="*" mode="M137"/>
   </xsl:template>
   <!--PATTERN rule9-67Standard opening phrase for augmentation type data definition-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Standard opening phrase for augmentation type data definition</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType[ends-with(@name, 'AugmentationType')]/xs:annotation/xs:documentation[1]"
                 priority="1000"
                 mode="M138">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType[ends-with(@name, 'AugmentationType')]/xs:annotation/xs:documentation[1]"/>
      <!--REPORT warning-->
      <xsl:if test="not(matches(lower-case(normalize-space(.)),                            '^a data type (that supplements|for additional information about)'))">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test="not(matches(lower-case(normalize-space(.)), '^a data type (that supplements|for additional information about)'))">
            <xsl:attribute name="role">warning</xsl:attribute>
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Rule 9-67: The data definition for an augmentation type SHOULD begin with the standard opening phrase "A data type (that supplements|for additional information about)...".</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M138"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M138"/>
   <xsl:template match="@*|node()" priority="-2" mode="M138">
      <xsl:apply-templates select="*" mode="M138"/>
   </xsl:template>
   <!--PATTERN rule9-68Augmentation point element corresponds to its base type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Augmentation point element corresponds to its base type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name[                                   matches(., 'AugmentationPoint$')])]"
                 priority="1000"
                 mode="M139">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@name[                                   matches(., 'AugmentationPoint$')])]"/>
      <xsl:variable name="element-name" select="@name"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(                          parent::xs:schema/xs:complexType[                            @name = replace($element-name, 'AugmentationPoint$', 'Type')                            and exists(@name[not(ends-with(., 'AugmentationType'))])                                  and empty(@appinfo:externalAdapterTypeIndicator)                                  and exists(child::xs:complexContent)])"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists( parent::xs:schema/xs:complexType[ @name = replace($element-name, 'AugmentationPoint$', 'Type') and exists(@name[not(ends-with(., 'AugmentationType'))]) and empty(@appinfo:externalAdapterTypeIndicator) and exists(child::xs:complexContent)])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-68: A schema document containing an element declaration for an augmentation point element MUST also contain a type definition for its augmented base type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M139"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M139"/>
   <xsl:template match="@*|node()" priority="-2" mode="M139">
      <xsl:apply-templates select="*" mode="M139"/>
   </xsl:template>
   <!--PATTERN rule9-69An augmentation point element has no type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">An augmentation point element has no type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name[                                   matches(., 'AugmentationPoint$')])]"
                 priority="1000"
                 mode="M140">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@name[                                   matches(., 'AugmentationPoint$')])]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@type)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-69: An augmentation point element MUST have no type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M140"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M140"/>
   <xsl:template match="@*|node()" priority="-2" mode="M140">
      <xsl:apply-templates select="*" mode="M140"/>
   </xsl:template>
   <!--PATTERN rule9-70An augmentation point element has no substitution group-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">An augmentation point element has no substitution group</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:element[exists(@name[                                   matches(., 'AugmentationPoint$')])]"
                 priority="1000"
                 mode="M141">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:element[exists(@name[                                   matches(., 'AugmentationPoint$')])]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@substitutionGroup)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@substitutionGroup)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-70: An augmentation point element MUST have no substitution group.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M141"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M141"/>
   <xsl:template match="@*|node()" priority="-2" mode="M141">
      <xsl:apply-templates select="*" mode="M141"/>
   </xsl:template>
   <!--PATTERN rule9-71Augmentation point element is only referenced by its base type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Augmentation point element is only referenced by its base type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType//xs:element[exists(@ref[       matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"
                 priority="1000"
                 mode="M142">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType//xs:element[exists(@ref[       matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="QName(string(nf:get-target-namespace(ancestor::xs:complexType[1])), ancestor::xs:complexType[1]/@name)         = QName(string(namespace-uri-from-QName(resolve-QName(@ref, .))),         replace(local-name-from-QName(resolve-QName(@ref, .)), 'AugmentationPoint$', 'Type'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="QName(string(nf:get-target-namespace(ancestor::xs:complexType[1])), ancestor::xs:complexType[1]/@name) = QName(string(namespace-uri-from-QName(resolve-QName(@ref, .))), replace(local-name-from-QName(resolve-QName(@ref, .)), 'AugmentationPoint$', 'Type'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-71: An augmentation point element MUST only be referenced by its base type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M142"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M142"/>
   <xsl:template match="@*|node()" priority="-2" mode="M142">
      <xsl:apply-templates select="*" mode="M142"/>
   </xsl:template>
   <!--PATTERN rule9-72aAugmentation point element use is optional and unbounded-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Augmentation point element use is optional and unbounded</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType//xs:element[exists(@ref[                             matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"
                 priority="1000"
                 mode="M143">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType//xs:element[exists(@ref[                             matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@minOccurs) and xs:integer(@minOccurs) = 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(@minOccurs) and xs:integer(@minOccurs) = 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-72: An augmentation point element particle MUST have attribute minOccurs equal to 0 and attribute maxOccurs set to unbounded.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M143"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M143"/>
   <xsl:template match="@*|node()" priority="-2" mode="M143">
      <xsl:apply-templates select="*" mode="M143"/>
   </xsl:template>
   <!--PATTERN rule9-72bAugmentation point element use is optional and unbounded-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Augmentation point element use is optional and unbounded</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType//xs:element[exists(@ref[                             matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"
                 priority="1000"
                 mode="M144">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType//xs:element[exists(@ref[                             matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@maxOccurs) and string(@maxOccurs) = 'unbounded'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(@maxOccurs) and string(@maxOccurs) = 'unbounded'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-72: An augmentation point element particle MUST have attribute minOccurs equal to 0 and attribute maxOccurs set to unbounded.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M144"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M144"/>
   <xsl:template match="@*|node()" priority="-2" mode="M144">
      <xsl:apply-templates select="*" mode="M144"/>
   </xsl:template>
   <!--PATTERN rule9-73Augmentation point element use must be last element in its base type-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Augmentation point element use must be last element in its base type</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:complexType//xs:element[exists(@ref[                             matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"
                 priority="1000"
                 mode="M145">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:complexType//xs:element[exists(@ref[                             matches(local-name-from-QName(resolve-QName(., ..)), 'AugmentationPoint$')]) ]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(following-sibling::*)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(following-sibling::*)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-73: An augmentation point element particle MUST be the last element occurrence in the content model of its augmentable type.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M145"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M145"/>
   <xsl:template match="@*|node()" priority="-2" mode="M145">
      <xsl:apply-templates select="*" mode="M145"/>
   </xsl:template>
   <!--PATTERN rule9-74Appinfo attribute annotates schema component-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Appinfo attribute annotates schema component</svrl:text>
   <!--RULE -->
   <xsl:template match="*[exists(@appinfo:deprecated)]" priority="1000" mode="M146">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[exists(@appinfo:deprecated)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="namespace-uri-from-QName(node-name(.)) = xs:anyURI('http://www.w3.org/2001/XMLSchema')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="namespace-uri-from-QName(node-name(.)) = xs:anyURI('http://www.w3.org/2001/XMLSchema')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-74: An attribute in the appinfo namespace MUST be owned by an element with a namespace name http://www.w3.org/2001/XMLSchema .</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M146"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M146"/>
   <xsl:template match="@*|node()" priority="-2" mode="M146">
      <xsl:apply-templates select="*" mode="M146"/>
   </xsl:template>
   <!--PATTERN rule9-75`xs:appinfo` children are comments, elements, or whitespace-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">`xs:appinfo` children are comments, elements, or whitespace</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:appinfo/node()" priority="1000" mode="M147">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:appinfo/node()"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="self::comment()                        or self::element()                        or self::text()[string-length(normalize-space(.)) = 0]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="self::comment() or self::element() or self::text()[string-length(normalize-space(.)) = 0]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-75: A child of element xs:appinfo MUST be an element, a comment, or whitespace text.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M147"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M147"/>
   <xsl:template match="@*|node()" priority="-2" mode="M147">
      <xsl:apply-templates select="*" mode="M147"/>
   </xsl:template>
   <!--PATTERN rule9-76Appinfo child elements have namespaces-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Appinfo child elements have namespaces</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:appinfo/*" priority="1000" mode="M148">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:appinfo/*"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="namespace-uri() != xs:anyURI('')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="namespace-uri() != xs:anyURI('')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-76: An element that is a child of xs:appinfo MUST have a namespace name.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M148"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M148"/>
   <xsl:template match="@*|node()" priority="-2" mode="M148">
      <xsl:apply-templates select="*" mode="M148"/>
   </xsl:template>
   <!--PATTERN rule9-77Appinfo descendants are not XML Schema elements-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Appinfo descendants are not XML Schema elements</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:appinfo//xs:*" priority="1000" mode="M149">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:appinfo//xs:*"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="false()">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-77: An element that is a descendent of xs:appinfo MUST NOT have the XML Schema namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M149"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M149"/>
   <xsl:template match="@*|node()" priority="-2" mode="M149">
      <xsl:apply-templates select="*" mode="M149"/>
   </xsl:template>
   <!--PATTERN rule9-79LocalTerm appinfo applies to schema-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">LocalTerm appinfo applies to schema</svrl:text>
   <!--RULE -->
   <xsl:template match="appinfo:LocalTerm" priority="1000" mode="M150">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="appinfo:LocalTerm"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="parent::xs:appinfo[parent::xs:annotation[parent::xs:schema]]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="parent::xs:appinfo[parent::xs:annotation[parent::xs:schema]]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-79: When the element appinfo:LocalTerm appears in a schema document, it MUST be application information on an element xs:schema.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M150"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M150"/>
   <xsl:template match="@*|node()" priority="-2" mode="M150">
      <xsl:apply-templates select="*" mode="M150"/>
   </xsl:template>
   <!--PATTERN rule9-81No use of fixed on simple type facets-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">No use of fixed on simple type facets</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:*[self::xs:length or self::xs:minLength or self::xs:maxLength or self::xs:whiteSpace       or self::xs:maxInclusive or self::xs:maxExclusive or self::xs:minExclusive or self::xs:minInclusive       or self::xs:totalDigits or self::xs:fractionDigits]"
                 priority="1000"
                 mode="M151">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:*[self::xs:length or self::xs:minLength or self::xs:maxLength or self::xs:whiteSpace       or self::xs:maxInclusive or self::xs:maxExclusive or self::xs:minExclusive or self::xs:minInclusive       or self::xs:totalDigits or self::xs:fractionDigits]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@fixed)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@fixed)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 9-81: A simple type constraining facet in a reference schema document MUST NOT have an attribute {}fixed.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M151"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M151"/>
   <xsl:template match="@*|node()" priority="-2" mode="M151">
      <xsl:apply-templates select="*" mode="M151"/>
   </xsl:template>
   <!--PATTERN rule10-5Consistent import schema document-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Consistent import schema document</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:schema[exists(@targetNamespace)                                 and (some $element                                     in nf:resolve-namespace(., xs:anyURI(@targetNamespace))                                     satisfies $element is .)]"
                 priority="1000"
                 mode="M152">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="xs:schema[exists(@targetNamespace)                                 and (some $element                                     in nf:resolve-namespace(., xs:anyURI(@targetNamespace))                                     satisfies $element is .)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(nf:resolve-namespace(., xs:anyURI(@targetNamespace))) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(nf:resolve-namespace(., xs:anyURI(@targetNamespace))) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 10-5: The members of a schema document set MUST NOT contain two xs:import elements that have the same {}namespace attribute but specify different schema documents.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M152"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M152"/>
   <xsl:template match="@*|node()" priority="-2" mode="M152">
      <xsl:apply-templates select="*" mode="M152"/>
   </xsl:template>
   <!--PATTERN rule10-6Consistent import labels-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Consistent import labels</svrl:text>
   <!--RULE -->
   <xsl:template match="xs:import" priority="1000" mode="M153">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="xs:import"/>
      <xsl:variable name="namespace" select="@namespace"/>
      <xsl:variable name="is-conformant" select="empty(@appinfo:externalImportIndicator)"/>
      <xsl:variable name="first"
                    select="exactly-one(parent::xs:schema/xs:import[@namespace = $namespace][1])"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test=". is $first                        or $is-conformant = empty($first/@appinfo:externalImportIndicator)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test=". is $first or $is-conformant = empty($first/@appinfo:externalImportIndicator)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 10-6: The members of a schema document set MUST NOT contain two xs:import elements with the same namespace but different values for appinfo:externalImportIndicator.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M153"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M153"/>
   <xsl:template match="@*|node()" priority="-2" mode="M153">
      <xsl:apply-templates select="*" mode="M153"/>
   </xsl:template>
   <!--PATTERN rule8-15Subset namespace asserts conformance-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Subset namespace asserts conformance</svrl:text>
   <!--RULE -->
   <xsl:template match="*[. is nf:get-document-element(.)]"
                 priority="1000"
                 mode="M154">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[. is nf:get-document-element(.)]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#SubsetSchemaDocument'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="nf:has-effective-conformance-target-identifier(., xs:anyURI('https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#SubsetSchemaDocument'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Rule 8-15: A subset namespace must assert the conformance target identifier https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#SubsetSchemaDocument.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M154"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M154"/>
   <xsl:template match="@*|node()" priority="-2" mode="M154">
      <xsl:apply-templates select="*" mode="M154"/>
   </xsl:template>
</xsl:stylesheet>
