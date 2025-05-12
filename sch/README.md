# NIEM 6 Schematron

Schematron rules for NDR6 rules on XSD model representations.

* *extTarget.sch:*  Schematron for extension schema documents.  It assembles the separate rule files from the *rule* directory as needed.
* *refTarget.sch:*  Schematron for reference schema documents.  A different assembly of rule files.
* *subTarget.sch:*  Schematron for subset schema documents.  Yet another assembly.
* *rule:*  Directory with schematron fragments for each rule.  Most of these are copied from the NIEM 5 schematron, hand-edited as needed.  Some are new compositions.
* *rtest*: Directory with test XSD files for some rules.  Some elements in a test file are supposed to generate error or warning messages.  Those elements are marked with a comment.
* *bin:*  Directory with Perl scripts for managing rule files in this directory
  * *dotest:* Evaluate the rule corresponding to one or more of the test files in *rtest* directory.  Make sure only the expected error/warning messages are generated.
  * *renumber:* Fix up changed rule numbers when they change in the document.  The *reindex* script that renumbers the markdown source (*ndr6src.md*) also writes a listing of the changes it makes.  This script takes that listing as its input.
  * *extract:*  Generate N5->6 mappings from *../ndr6src.md*.  Hopefully we don't need this one again.
  * *convert:*  Generate separate rule fragment files from *niem5/*.sch*.  Also probably don't need to do this again.
* *ndr-functions.xsl:*  Same as in NIEM 5, included in *extTarget.sch*, *refTarget.sch*, and *subTarget.sch*.