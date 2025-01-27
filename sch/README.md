# NIEM 6 Schematron

Schematron rules for NDR6 rules on XSD model representations.

* *extTarget.sch:*  Schematron for extension schema documents
* *refTarget.sch:*  Schematron for reference schema documents
* *rule:*  Directory with schematron fragments for each rule, hand-edited as needed
* *rtest*: Directory with test XSD files for some rules
* *bin:*  Directory with Perl scripts for managing rule files in *rule* directory
  * *dotest:* Execute one or more test files in *rtest* directory
  * *renumber:* Fix up changed rule numbers when they change in the document
  * *extract:*  Generate N5->6 mappings from *../ndr6src.md*
  * *convert:*  Generate separate rule fragment files from *niem5/*.sch*
* *ndr-functions.xsl:*  Same as in NIEM 5, included in *extRules.sch* and *refRules.sch*