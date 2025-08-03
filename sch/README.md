Schematron rules for NDR6

* There are schematron and XSLT files for each of the three XSD conformance targets (reference, extension, and subset schema document)
  * The schematron files are assembled from individual rule files
  * The XSLT files are compiled schematron, with the xsl:include elements resolved
* Build automation for those SCH and XSLT files in the Ma
* Test suite doesn't work yet