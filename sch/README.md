# NIEM 6 Schematron

Schematron rules for NDR6 rules on XSD model representations.

* *extTarget.sch:*  Schematron for extension schema documents
* *refTarget.sch:*  Schematron for reference schema documents
* *rule:*  Directory with schematron fragments for each rule, hand-edited as needed
* *bin:*  Directory with Perl scripts for NIEM 5 -> 6 conversion
  * *extract:*  Generate N5->6 mappings from *../ndr6src.md*
  * *convert:*  Generate separate rule fragment files from *niem5/*.sch*
* *niem6-gen:*  Schematron rule fragments created by *bin/convert*
* *niem5:*  NIEM 5 schematron, prepared for conversion
* *ndr-functions.xsl:*  Same as in NIEM 5, included in *extRules.sch* and *refRules.sch*