<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  version="2.0"
  xmlns:catalog="urn:oasis:names:tc:entity:xmlns:xml:catalog"
  xmlns:ct="https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/"
  xmlns:impl="http://example.org/impl"
  xmlns:nf="https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#NDRFunctions"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform">

  <!-- begin NDR-FUNCTIONS -->

  <xsl:param name="xml-catalog" as="document-node()?"/>

  <!-- Yields document element of the document containing element $context. -->
  <xsl:function name="nf:get-document-element" as="element()">
    <xsl:param name="context" as="element()"/>
    <xsl:sequence select="root($context)/*"/>
  </xsl:function>

  <!-- Yields:
       if element is within a schema
         if there is a target namespace -> xs:anyURI( $namespace )
         if there is no target namespace -> xs:anyURI('')
       otherwise -> ()
  -->
  <xsl:function name="nf:get-target-namespace" as="xs:anyURI?">
    <xsl:param name="element" as="element()"/>
    <xsl:variable name="schema" as="element(xs:schema)?" select="root($element)/xs:schema"/>
    <xsl:choose>
      <xsl:when test="empty($schema)">
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="target-namespace-attr" as="attribute()?" select="$schema/@targetNamespace"/>
        <xsl:sequence select="xs:anyURI(if (exists($target-namespace-attr))                                     then string($target-namespace-attr)                                     else '')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- Yields:
       if the namespace is found in the catalog, and the first entry has /xs:schema  -> element(xs:schema)
       otherwise -> ()
  -->
  <xsl:function name="nf:resolve-namespace" as="element(xs:schema)?">
    <xsl:param name="context" as="element()"/>
    <xsl:param name="namespace-uri" as="xs:anyURI"/>
    <xsl:variable name="context-target-namespace-uri" as="xs:anyURI?" select="nf:get-target-namespace($context)"/>
    <xsl:choose>
      <!-- this SHOULD work for target namespace = xs:anyURI('') -->
      <xsl:when test="exists($context-target-namespace-uri)                                       and exactly-one($context-target-namespace-uri) = $namespace-uri">
        <xsl:sequence select="root($context)/xs:schema"/>
      </xsl:when>
      <xsl:when test="empty($xml-catalog)">
        <xsl:sequence select="error(xs:QName('impl:xml-catalog-not-set'), 'Error: $xml-catalog is not set')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="catalog-element" as="element(catalog:catalog)?" select="$xml-catalog/catalog:catalog"/>
        <xsl:choose>
          <xsl:when test="empty($catalog-element)">
            <xsl:message>
              <xsl:value-of select="impl:get-location($context)"/>
              <xsl:text>: resolved catalog does not have document element catalog:catalog.</xsl:text>
            </xsl:message>
            <xsl:sequence select="()"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="$catalog-element" mode="impl:resolve-namespace">
              <xsl:with-param name="namespace-uri" tunnel="yes" select="$namespace-uri"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- Yields:
       if the type resolves -> the first entry of xs:complexType or xs:simpleType
       if not -> ()
  -->
  <xsl:function name="nf:resolve-type" as="element()?">
    <xsl:param name="context" as="element()"/>
    <xsl:param name="qname" as="xs:QName"/>
    <xsl:variable name="namespace-uri" as="xs:anyURI" select="namespace-uri-from-QName($qname)"/>
    <xsl:variable name="schema" as="element(xs:schema)?" select="nf:resolve-namespace($context, $namespace-uri)"/>
    <xsl:choose>
      <xsl:when test="empty($schema)">
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="type" as="element()?" select="$schema/*[(self::xs:complexType or self::xs:simpleType)                                     and @name = local-name-from-QName($qname)][1]"/>
        <xsl:choose>
          <xsl:when test="empty($type)">
            <xsl:message>
              <xsl:value-of select="impl:get-location($context)"/>
              <xsl:text>: type not found: </xsl:text>
              <xsl:value-of select="impl:get-clark-name($qname)"/>
              <xsl:text>.</xsl:text>
            </xsl:message>
            <xsl:sequence select="()"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="$type"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- Yields:
       if the element resolves -> the first xs:element
       if not -> ()
  -->
  <xsl:function name="nf:resolve-element" as="element(xs:element)?">
    <xsl:param name="context" as="element()"/>
    <xsl:param name="qname" as="xs:QName"/>
    <xsl:variable name="namespace-uri" as="xs:anyURI" select="namespace-uri-from-QName($qname)"/>
    <xsl:variable name="schema" as="element(xs:schema)?" select="nf:resolve-namespace($context, $namespace-uri)"/>
    <xsl:choose>
      <xsl:when test="empty($schema)">
        <!-- error message has already been dispatched by the catalog resolver -->
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="element" as="element(xs:element)?" select="$schema/xs:element[@name = local-name-from-QName($qname)][1]"/>
        <xsl:choose>
          <xsl:when test="empty($element)">
            <xsl:message>
              <xsl:value-of select="impl:get-location($context)"/>
              <xsl:text>: element not found.</xsl:text>
            </xsl:message>
            <xsl:sequence select="()"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="$element"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="nf:has-effective-conformance-target-identifier" as="xs:boolean">
    <xsl:param name="context" as="element()"/>
    <xsl:param name="match" as="xs:anyURI"/>
    <xsl:variable name="effective-conformance-targets-attribute" as="attribute()?" select="(root($context)//*[exists(@ct:conformanceTargets)])[1]/@ct:conformanceTargets"/>
    <xsl:sequence select="if (empty($effective-conformance-targets-attribute))                       then false()                       else some $effective-conformance-target-string                            in tokenize(normalize-space(string($effective-conformance-targets-attribute)), ' ')                            satisfies ($effective-conformance-target-string castable as xs:anyURI                                       and xs:anyURI($effective-conformance-target-string) = $match)"/>
  </xsl:function>

  <!-- ================================================================== -->
  <!-- implementation details -->
  <!-- ================================================================== -->

  <xsl:function name="impl:get-clark-name" as="xs:string">
    <xsl:param name="qname" as="xs:QName"/>
    <xsl:value-of select="concat( '{', namespace-uri-from-QName($qname), '}', local-name-from-QName($qname) )"/>
  </xsl:function>

  <xsl:function name="impl:get-location" as="xs:string">
    <xsl:param name="context" as="node()"/>
    <xsl:value-of>
      <xsl:value-of select="base-uri($context)"/>
      <xsl:value-of use-when="function-available('saxon:line-number')" select="concat(':', saxon:line-number($context))"/>
    </xsl:value-of>
  </xsl:function>

  <!-- ================================================================== -->
  <!-- mode = impl:resolve-namespace -->
  <!-- XML Catalog processing code -->
  <!-- ================================================================== -->

  <xsl:template match="/catalog:catalog" mode="impl:resolve-namespace" as="element(xs:schema)?">
    <xsl:param name="namespace-uri" as="xs:anyURI" tunnel="yes"/>
    <xsl:variable name="next" as="element()?" select="(catalog:uri|catalog:nextCatalog)[1]"/>
    <xsl:choose>
      <xsl:when test="empty($next)">
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="$next" mode="#current"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="catalog:uri" mode="impl:resolve-namespace" as="element(xs:schema)?">
    <xsl:param name="namespace-uri" as="xs:anyURI" tunnel="yes"/>
    <xsl:choose>
      <xsl:when test="empty(@name)">
        <xsl:message>
          <xsl:value-of select="impl:get-location(.)"/>
          <xsl:text>: catalog:uri has no @name.</xsl:text>
        </xsl:message>
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:when test="xs:anyURI(@name) = $namespace-uri">
        <xsl:variable name="uri" as="xs:anyURI?" select="resolve-uri(@uri, base-uri(.))"/>
        <xsl:choose>
          <xsl:when test="empty($uri)">
            <xsl:message>
              <xsl:value-of select="impl:get-location(.)"/>
              <xsl:text>: catalog:uri has no @uri.</xsl:text>
            </xsl:message>
            <xsl:sequence select="()"/>
          </xsl:when>
          <xsl:when test="not(doc-available($uri))">
            <xsl:message>
              <xsl:value-of select="impl:get-location(.)"/>
              <xsl:text>: catalog:uri @uri (</xsl:text>
              <xsl:value-of select="$uri"/>
              <xsl:text>) does not resolve.</xsl:text>
            </xsl:message>
            <xsl:sequence select="()"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="doc" as="element(xs:schema)?" select="doc($uri)/xs:schema"/>
            <xsl:choose>
              <xsl:when test="empty($doc)">
                <xsl:message>
                  <xsl:value-of select="impl:get-location(.)"/>
                  <xsl:text>: catalog:uri @uri does not resolve to schema</xsl:text>
                </xsl:message>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$doc"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="#current" select="following-sibling::*[1]"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="catalog:nextCatalog" mode="impl:resolve-namespace" as="element(xs:schema)?">
    <xsl:param name="namespace-uri" as="xs:anyURI" tunnel="yes"/>
    <xsl:variable name="catalog-uri" as="xs:anyURI" select="resolve-uri(@catalog, base-uri(.))"/>
    <xsl:choose>
      <xsl:when test="empty($catalog-uri)">
        <xsl:message>
          <xsl:value-of select="impl:get-location(.)"/>
          <xsl:text>: catalog:nextCatalog does not have @catalog.</xsl:text>
        </xsl:message>
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:when test="not(doc-available($catalog-uri))">
        <xsl:message>
          <xsl:value-of select="impl:get-location(.)"/>
          <xsl:text>: catalog:nextCatalog/@catalog does not resolve.</xsl:text>
        </xsl:message>
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="catalog" as="element(catalog:catalog)?" select="doc($catalog-uri)/catalog:catalog"/>
        <xsl:choose>
          <xsl:when test="empty($catalog)">
            <xsl:message>
              <xsl:value-of select="impl:get-location(.)"/>
              <xsl:text>: catalog:nextCatalog/@catalog resolves to something that is not a catalog.</xsl:text>
            </xsl:message>
            <xsl:sequence select="()"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates mode="#current" select="$catalog"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- end NDR-FUNCTIONS -->
</xsl:stylesheet>
