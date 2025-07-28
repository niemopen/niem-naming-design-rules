<?xml version="1.0" encoding="UTF-8"?>
<schema 
  xmlns="http://purl.oclc.org/dsdl/schematron" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  queryBinding="xslt2">
  
  <ns prefix="appinfo" uri="https://docs.oasis-open.org/niemopen/ns/model/appinfo/6.0/"/>  
  <ns prefix="catalog" uri="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>
  <ns prefix="ct" uri="https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/"/>
  <ns prefix="impl" uri="http://example.org/impl"/>
  <ns prefix="nf" uri="https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#NDRFunctions"/>
  <ns prefix="saxon" uri="http://saxon.sf.net/"/>
  <ns prefix="structures" uri="https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/"/>
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>

  <xsl:include href="src/ndr-functions.xsl"/>

