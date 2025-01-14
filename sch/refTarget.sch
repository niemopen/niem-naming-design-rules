<?xml version="1.0" encoding="UTF-8"?>
<schema 
  xmlns="http://purl.oclc.org/dsdl/schematron" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  queryBinding="xslt2">
  
  <title>Rules for reference schema documents</title>
  
  <xsl:include href="ndr-functions.xsl"/>
  
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
  <ns prefix="nf" uri="https://docs.oasis-open.org/niemopen/ns/specification/NDR/6.0/#NDRFunctions"/>
  <ns prefix="ct" uri="https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/"/>
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
  <ns prefix="appinfo" uri="https://docs.oasis-open.org/niemopen/ns/model/appinfo/6.0/"/>
  <ns prefix="structures" uri="https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/"/>
  
  <!-- Rules applicable to all conforming schema documents -->
  
  <include href="rule/7-2a.xml"/>
  <include href="rule/7-2b.xml"/>
  <include href="rule/7-5.xml"/>
  <include href="rule/7-6.xml"/>
  <include href="rule/7-8.xml"/>
  <include href="rule/7-9.xml"/>
  <include href="rule/7-10.xml"/>
  <include href="rule/7-11.xml"/>
  <include href="rule/7-12a.xml"/>
  <include href="rule/7-12b.xml"/>
  <include href="rule/7-16.xml"/>
  <include href="rule/7-18.xml"/>
  <include href="rule/7-19.xml"/>
  <include href="rule/7-36.xml"/>
  <include href="rule/7-37.xml"/>
  <include href="rule/7-38a.xml"/>
  <include href="rule/7-38b.xml"/>
  <include href="rule/7-38c.xml"/>
  <include href="rule/7-38d.xml"/>
  <include href="rule/7-39.xml"/>
  <include href="rule/7-48.xml"/>
  <include href="rule/7-49.xml"/>
  <include href="rule/7-50.xml"/>
  <include href="rule/7-51.xml"/>
  <include href="rule/7-52.xml"/>
  <include href="rule/7-53.xml"/>
  <include href="rule/7-54.xml"/>
  <include href="rule/7-55.xml"/>
  <include href="rule/7-56.xml"/>
  <include href="rule/7-57.xml"/>
  <include href="rule/8-7.xml"/>
  <include href="rule/9-1a.xml"/>
  <include href="rule/9-1b.xml"/>
  <include href="rule/9-1c.xml"/>
  <include href="rule/9-2.xml"/>
  <include href="rule/9-5a.xml"/>
  <include href="rule/9-5b.xml"/> 
  <include href="rule/9-5c.xml"/> 
  <include href="rule/9-5d.xml"/> 
  <include href="rule/9-5e.xml"/> 
  <include href="rule/9-5f.xml"/>
  <include href="rule/9-5g.xml"/>
  <include href="rule/9-6a.xml"/>
  <include href="rule/9-6b.xml"/> 
  <include href="rule/9-6c.xml"/> 
  <include href="rule/9-6d.xml"/> 
  <include href="rule/9-6e.xml"/> 
  <include href="rule/9-6f.xml"/>
  <include href="rule/9-6g.xml"/>
  <include href="rule/9-6h.xml"/>
  <include href="rule/9-6i.xml"/>
  <include href="rule/9-7a.xml"/>
  <include href="rule/9-7b.xml"/> 
  <include href="rule/9-7c.xml"/> 
  <include href="rule/9-7d.xml"/>
  <include href="rule/9-8a.xml"/>
  <include href="rule/9-8b.xml"/> 
  <include href="rule/9-8c.xml"/> 
  <include href="rule/9-8d.xml"/> 
  <include href="rule/9-8e.xml"/> 
  <include href="rule/9-8f.xml"/>
  <include href="rule/9-9a.xml"/>
  <include href="rule/9-9b.xml"/> 
  <include href="rule/9-9c.xml"/> 
  <include href="rule/9-9d.xml"/> 
  <include href="rule/9-9e.xml"/> 
  <include href="rule/9-9f.xml"/>
  <include href="rule/9-10a.xml"/>
  <include href="rule/9-10b.xml"/>
  <include href="rule/9-11.xml"/>
  <include href="rule/9-12a.xml"/>
  <include href="rule/9-12b.xml"/>
  <include href="rule/9-13a.xml"/>
  <include href="rule/9-13b.xml"/>
  <include href="rule/9-14a.xml"/>
  <include href="rule/9-14b.xml"/>
  <include href="rule/9-15.xml"/>
  <include href="rule/9-16.xml"/>
  <include href="rule/9-17a.xml"/>
  <include href="rule/9-17b.xml"/>
  <include href="rule/9-17c.xml"/>
  <include href="rule/9-17d.xml"/>
  <include href="rule/9-18a.xml"/>
  <include href="rule/9-18b.xml"/>
  <include href="rule/9-19.xml"/>
  <include href="rule/9-20a.xml"/>
  <include href="rule/9-20b.xml"/>
  <include href="rule/9-21.xml"/>
  <include href="rule/9-22.xml"/>
  <include href="rule/9-23.xml"/>
  <include href="rule/9-25.xml"/>
  <include href="rule/9-26.xml"/>
  <include href="rule/9-28.xml"/>
  <include href="rule/9-29.xml"/>
  <include href="rule/9-30a.xml"/>
  <include href="rule/9-30b.xml"/>
  <include href="rule/9-32.xml"/>
  <include href="rule/9-34.xml"/>
  <include href="rule/9-35.xml"/>
  <include href="rule/9-36.xml"/>
  <include href="rule/9-37.xml"/>
  <include href="rule/9-38a.xml"/>
  <include href="rule/9-38b.xml"/>
  <include href="rule/9-39.xml"/>
  <include href="rule/9-41.xml"/>
  <include href="rule/9-42.xml"/>
  <include href="rule/9-45a.xml"/>
  <include href="rule/9-45b.xml"/>
  <include href="rule/9-46a.xml"/>
  <include href="rule/9-46b.xml"/>
  <include href="rule/9-47a.xml"/>
  <include href="rule/9-47b.xml"/>
  <include href="rule/9-48.xml"/>
  <include href="rule/9-51.xml"/>
  <include href="rule/9-53.xml"/>
  <include href="rule/9-54.xml"/>
  <include href="rule/9-55a.xml"/>
  <include href="rule/9-55b.xml"/>
  <include href="rule/9-56.xml"/>
  <include href="rule/9-58.xml"/>
  <include href="rule/9-60.xml"/>
  <include href="rule/9-61b.xml"/>
  <include href="rule/9-62.xml"/>
  <include href="rule/9-64.xml"/>
  <include href="rule/9-65.xml"/>
  <include href="rule/9-66.xml"/>
  <include href="rule/9-67.xml"/>
  <include href="rule/9-68.xml"/>
  <include href="rule/9-69.xml"/>
  <include href="rule/9-70.xml"/>
  <include href="rule/9-71a.xml"/>
  <include href="rule/9-71b.xml"/>
  <include href="rule/9-72.xml"/>
  <include href="rule/9-73.xml"/>
  <include href="rule/9-74.xml"/>
  <include href="rule/9-75.xml"/>
  <include href="rule/9-76.xml"/>
  <include href="rule/9-78.xml"/>
  <include href="rule/9-80.xml"/>
  <include href="rule/10-5.xml"/>
  <include href="rule/10-6.xml"/>
  
  <!-- Rules applicable only to reference schema documents -->
  
  <include href="rule/8-9.xml"/>
  <include href="rule/8-10.xml"/>
  <include href="rule/8-12.xml"/>
  <include href="rule/9-86.xml"/>
  <include href="rule/9-79.xml"/>
  <include href="rule/9-81a.xml"/>
  <include href="rule/9-81b.xml"/>
  <include href="rule/9-81c.xml"/>
  <include href="rule/9-82a.xml"/>
  <include href="rule/9-82b.xml"/>
  <include href="rule/9-82c.xml"/>
  <include href="rule/9-83.xml"/>
  <include href="rule/9-84.xml"/>
  <include href="rule/9-85.xml"/>
  
</schema>