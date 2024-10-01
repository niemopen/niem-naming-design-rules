
<link rel="stylesheet" href="https://docs.oasis-open.org/templates/css/markdown-styles-v1.7.3a.css" />

<div class="row">
  <div class="column">
    <img
      src="https://docs.oasis-open.org/templates/OASIS-logo/2020/OASIS-Primary-Logo-Full-Colour.png"
      alt="OASIS OP Logo" style="width:100%" />
  </div>
  <div class="column">
    <img
      src="https://github.com/niemopen/oasis-open-project/raw/main/artwork/NIEM-NO-Logo-v5.png"
      alt="NIEMOpen Logo" style="width:65%" />
  </div>
</div>

-------

# NIEM Naming and Design Rules (NDR) Version 6.0

## Project Specification Draft 01

## 30 September 2024 draft

&nbsp;

#### This stage:
https://docs.oasis-open.org/niemopen/ndr/v6.0/psd01/ndr-v6.0-psd01.md (Authoritative) \
https://docs.oasis-open.org/niemopen/ndr/v6.0/psd01/ndr-v6.0-psd01.html \
https://docs.oasis-open.org/niemopen/ndr/v6.0/psd01/ndr-v6.0-psd01.pdf

#### Previous stage:
N/A

#### Latest stage:
https://docs.oasis-open.org/niemopen/ndr/v6.0/ndr-v6.0.md (Authoritative) \
https://docs.oasis-open.org/niemopen/ndr/v6.0/ndr-v6.0.html \
https://docs.oasis-open.org/niemopen/ndr/v6.0/ndr-v6.0.pdf

#### Open Project:
[OASIS NIEMOpen OP](http://www.niemopen.org/)

#### Project Chair:
Katherine Escobar (katherine.b.escobar.civ@mail.mil), [Joint Staff J6](https://www.jcs.mil/Directorates/J6-C4-Cyber/)

#### NTAC Technical Steering Committee Chairs:
Scott Renner (sar@mitre.org), [MITRE](https://mitre.org/) \
James Cabral (jim@cabral.org), Individual

#### Editors:
Scott Renner (sar@mitre.org), [MITRE](https://mitre.org/) \
James Cabral (jim@cabral.org), Individual \
Tom Carlson (Thomas.Carlson@gtri.gatech.edu), [Georgia Tech Research Institute](https://gtri.gatech.edu/)

#### Additional artifacts:s
* Other parts (list titles and/or file names)
* `(Note: Any normative computer language definitions that are part of the Work Product, such as XML instances, schemas and Java(TM) code, including fragments of such, must be (a) well formed and valid, (b) provided in separate plain text files, (c) referenced from the Work Product; and (d) where any definition in these separate files disagrees with the definition found in the specification, the definition in the separate file prevails. Remove this note before submitting for publication.)`

#### Related work:
This specification replaces or supersedes:
* _National Information Exchange Model Naming and Design Rules_. Version 5.0 December 18, 2020. NIEM Technical Architecture Committee (NTAC). https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html.

This specification is related to:
* _NIEM Model Version 6.0_. Edited by Christina Medlin. Latest stage: https://docs.oasis-open.org/niemopen/niem-model/v6.0/niem-model-v6.0.html.
* Related specifications (include hyperlink, preferably to HTML format)

#### Abstract:
This Naming and Design Rules (NDR) document specifies XML Schema documents for use with the National Information Exchange Model (NIEM). NIEM is an information sharing framework based on the World Wide Web Consortium (W3C) Extensible Markup Language (XML) Schema standard.

#### Status:
This document was last revised or approved by the Project Governing Board of the OASIS NIEMOpen OP on the above date. The level of approval is also listed above. Check the "Latest stage" location noted above for possible later revisions of this document. Any other numbered Versions and other technical work produced by the Open Project (OP) are listed at http://www.niemopen.org/.

Comments on this work can be provided by opening issues in the project repository or by sending email to the project’s public comment list: niemopen@lists.oasis-open-projects.org. List information is available at https://lists.oasis-open-projects.org/g/niemopen.

Note that any machine-readable content ([Computer Language Definitions](https://www.oasis-open.org/policies-guidelines/tc-process-2017-05-26/#wpComponentsCompLang)) declared Normative for this Work Product is provided in separate plain text files. In the event of a discrepancy between any such plain text file and display content in the Work Product's prose narrative document(s), the content in the separate plain text file prevails.

#### Key words:
The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [[RFC2119](#rfc2119)] and [[RFC8174](#rfc8174)] when, and only when, they appear in all capitals, as shown here.

#### Citation format:
When referencing this specification the following citation format should be used:

**[NIEM-NDR-v6.0]**

_NIEM Naming and Design Rules (NDR) Version 6.0_. Edited by Tom Carlson. 22 February 2024. OASIS Project Specification Draft 01. https://docs.oasis-open.org/niemopen/ndr/v6.0/psd01/ndr-v6.0-psd01.html. Latest stage: https://docs.oasis-open.org/niemopen/ndr/v6.0/ndr-v6.0.html.

-------

## Notices
Copyright &copy; OASIS Open 2024. All Rights Reserved.

Distributed under the terms of the OASIS [IPR Policy](https://www.oasis-open.org/policies-guidelines/ipr/).

For complete copyright information please see the Notices section in the Appendix.

-------

# Table of Contents
[[TOC will be inserted here]]

-------

# 1 Introduction



<!--
Here is a customized command line which will generate HTML from this markdown file (named ndr-v6.0-psd01.md), if needed:

r

NOTES:
- The two .css files included in the "styles" directory are also online:
  - https://docs.oasis-open.org/templates/css/markdown-styles-v1.7.3.css
  - https://docs.oasis-open.org/templates/css/markdown-styles-v1.7.3a.css (this one produces HTML that resembles the github display more closely, especially for blocks of code)
  - If you want to use one of the included .css files in pandoc, or develop a different .css file, simply link to it (using -c styles/markdown-styles-v1.7.3a.css) instead of the online files.

OASIS staff are currently using pandoc 3.0 from https://github.com/jgm/pandoc/releases/tag/3.0.

This also requires the presence of a .css file containing the HTML styles (like styles/markdown-styles-v1.7.3.css).

Note this command generates a Table of Contents (TOC) in HTML which is located at the top of the HTML document, and which requires additional editing in order to be published in the expected OASIS style. This editing will be handled by OASIS staff during publication.
A TC may use other ways to generate HTML from markdown, and may generate a TOC in a different way.
-->

NIEM, formerly known as the "National Information Exchange Model,” is a framework for exchanging information among public and private sector organizations. The framework includes a [reference data model](https://docs.oasis-open.org/niemopen/niem-model/v6.0/niem-model-v6.0.html) for objects, properties, and relationships; and a set of technical specifications for using and extending the data model in information exchanges. The NIEM framework supports developer-level specifications of data that form a contract between developers. The data being specified is called a *message* in NIEM. While a message is usually something passed between applications, NIEM works equally well to specify an information resource published on the web, an input or output for a web service or remote procedure, and so forth, basically, any package of data that crosses a system or organization boundary.

NIEM promotes scalability and reusability of messages between information systems, allowing organizations to share data and information more efficiently. It was launched in 2005 in response to the U.S. Homeland Security Presidential Directives to improve information sharing between agencies following 9/11. Until 2023, NIEM was updated and maintained in a collaboration between the U.S. federal government, state and local government agencies, private sector, and non-profit and international organizations, with new versions released around once per year. NIEM defines a set of common objects, the *NIEM Core*, and 17 sets of objects that are specific to certain government or industry verticals, the *NIEM Domains*.

In 2023, NIEM became the NIEMOpen OASIS Open Project. NIEMOpen welcomes participation by anyone irrespective of affiliation with OASIS. Substantive contributions to NIEMOpen and feedback are invited from all parties, following the OASIS rules and the usual conventions for participation in GitHub public repository projects.

NIEMOpen is the term generally used when referring to the organization such as Project Governing Board (PGB), NIEMOpen Technical Architecture Committee (NTAC), NIEMOpen Business Architecture Committee (NBAC), organization activities or processes. NIEM is the term used when directly referring to the model i.e. NIEM Domain, NIEM Model version.

This document specifies principles and enforceable rules for NIEM data components and schemas. Schemas and components that obey the rules set forth here are conformant to specific conformance targets. Conformance targets may include more than the level of conformance defined by this NDR, and may include specific patterns of use, additional quality criteria, and requirements to reuse NIEM release schemas.

## 1.1 Changes from earlier Versions

This optional section provides a description of significant differences from previously published, differently numbered Versions of this specification, if any. (Detailed revision history of this numbered Version should be tracked in an Appendix.)

## 1.2 Glossary

### 1.2.1 Definitions of terms

| Term | Definition |
| :---- | :--- |
|Abstract class|A class that is a base for extension, and must be specialized to be used directly|
|Adapter class|A class that contains only properties from a single external namespace|
|Artifact||
|Association class|Represents a specific relationship between objects|
|Atomic class|Contains no object properties, one or more attribute properties, and exactly one data property that is not an attribute property.  Does not have a special name.|
|Attribute||
|Attribute declaration||
|Attribute property|A data property in which `isAttribute` is true|
|Augmentable class|A class that can be augmented with additional properties|
|Augmentation element|Element based on an augmentation type that is substitutable for the augmentation point element in the augmented type.|
|Augmentation point element|An abstract element declaration that provides a place for any augmtation properties.|
|Augmentation type|Contains the augmenting properties|
|Cardinality|How many times a property may/must appear in an object|
|Class|Defines the content of a corresponding object (or resource) in a message.|
|Code datatype|A restriction in which each value that is valid for the datatype corresponds to a code value in a code list.|
|Code list|A list of distinct conceptual entities, each represented by a code value that has a known meaning beyond its text representation.  These codes may be meaningful text or may be a string of alphanumeric identifiers that represent abbreviations for literals.|
|Common Model Format (CMF)|A NIEM representation of the matamodel.|
|Complete model|A model including a definition for every referenced component.|
|Complex content|A object or type with  child elements.|
|Complex type||
|Component||
|Conformance target|A class of artifact, such as an interface, protocol, document, platform, process or service, that is the subject of conformance clauses and normative statements.|
|Conformance target identifier||
|Conforming namespace||
|Constraint||
|Constraint rule|A requirement on an artifact with respect to its conformance to a conformance target.|
|Data definition|A text definition of each component, describing what the component means.|
|Data property|Defines a relationship between an object and a literal value.|
|Datatype|Defines the allowed values of a corresponding atomic literal value in a message|
|Deprecated|A component that is provided, but the use of which is not recommended.|
|Document element|A property of a CMF object or XSD schema - defined by [ref Infoset]()|
|Documentation|A human-readable text documentation of a component.|
|Documented component|A CMF object or XSD schema component that has an associated data definition.|
|Element||
|Element declaration||
|Enumeration||
|Extension||
|Extension namespace|Expresses the additional vocabulary required for an information exchange, above and beyond the vocabulary available from the NIEM model|
|Extension schema document||
|External adapter type|A set of data that embodies a single concept from an external standard.|
|External components|A schema component defined by an external schema document.|
|External namespace||
|External schema document|Non-NIEM-conformant schema documents.|
|Facet|A data concept for a facet that restricts an aspect of a data type.|
|Imported namespace||
|Informative|Material that appears as supporting text, description, and rationales for the normative material.|
|Interpretation rule|Defines a methodology, pattern, or procedure for understanding some aspect of an instance of a conformance target.|
|JSON ||
|JSON document ||
|JSON schema ||
|JSON text ||
|JSON-LD ||
|List|An object that defines a datatype as a whitespace-separated list of atomic values.|
|Literal||
|Local term|A word, phrase, acronym, or other string of characters that is used in the name of a namespace component, but that is not defined in OED, or that has a non-OED definition in this nameespace, or has a word sense that is in some way unclear.|
|Local type||
|Message|The data in an information exchange|
|Message designer|A person that creates a message type and format from an information requirement, so that a message at runtime will contain all the facts that need to be conveyed.|
|Message developer|A person that writes software to implement a message specification, producing or processing messages that conform to the message format.|
|Message schema document|A XSD representation of a message namespace|
|Message specification|A collection of related message formats and types|
|Metadata||
|Mixed content|The mixing of data tags with text|
|Model object|Represents a complete or partial NIEM model.|
|Namespace|A collection of uniquely-named components.|
|Namespace author||
|Namespace prefix||
|Namespace URI|A unique URI for a namespace.|
|NIEM|A framework for exchanging information among public and private sector organizations.|
|NIEM Core|A set of common objects.|
|NIEM Domain|A set of objects that are specific to certain government or industry vertical|
|NIEM metamodel|An abstract model for NIEM data models.|
|NIEMOpen Business Architecture Committee (NBAC)||
|NIEMOpen Project Governing Board (PGB)||
|NIEMOpen Technical Architecture Committee (NTAC)||
|Normative|Required for conformance (e.g. rules).|
|Object class|Represents a class of objects defined by a NIEM model|
|Object class term||
|Object property|Defines a subject-predicate-value relationship between an object and another object.|
|Ordered/Ordinality||
|Particle||
|Property term|Describes or represents a characteristic or subpart of an entity or concept.|
|Proxy type|A complex type definition wrapper for a simple type in the XML Schema namespace.|
|Qualifier term|Provide additional context to resolve subtleties between properties of objects.|
|Range|The class or datatype of a property.|
|Reference attribute|A pointer to an element in a message.|
|Reference data model|A model of objects, properties, and relationships|
|Reference namespace|Namespaces that include all components in the NIEM model.|
|Reference property|An attribute property that contains a reference to an object in a message. |
|Reference schema document||
|Representation term|Indicate the style of component, prevents name conflicts or indicates the nature of the value.|
|Restriction object|Defines a datatype as a restriction of a base datatype plus zero or more restricting Facet objects.|
|Schema document||
|Simple content|An object or type that has only attributes, not elements.|
|Simple type||
|Subset|A collection of NIEM components required for an information exchange.|
|Subset namespace|A subset of the components in a reference or extension namespace.|
|Subset schema document||
|Target namespace||
|Type definition||
|Union|Defines a datatype as the union of one or more datatypes.|
|XML catalog||
|XML schema document set|Defines an XML Schema that may be used to validate an XML document|

### 1.2.2 Acronyms and abbreviations

| Term | Literal |
| :---- | :--- |
|APPINFO|Application Information|
|CCC|Complex type with Complex Content|
|CMF|Common Model Format|
|CSC|Complex type with Simple Content|
|CSV|Comma Separated Values|
|CTAS|Conformance Targets Attribute Specification|
|EXT|Extension namespace conformance target|
|ID|Identifier|
|IEP|Information Exchange Package|
|IEPD|Information Exchange Package Documentation|
|ISO|International Organization for Standardization|
|JSON|JavaScript Object Notation|
|JSON-LD|JavaScript Object Notation Linked Data|
|MSG|Message namespace conformance target|
|N5R|NIEM 5 Rule|
|NBAC|NIEMOpen Business Architecture Committee|
|NC|NIEM Core|
|NIEM|Formerly National Information Exchange Model|
|NS|Namespace|
|NTAC|NIEMOpen Technical Architecture Committee|
|OED|Oxford English Dictionary|
|OP|Open Project|
|OWL|Web Ontology Language|
|PGB|Project Governing Board|
|Qname|Qualified Name|
|RDF|Resource Description Framework|
|RDFS|Resource Description Framework Schema|
|REF|Reference namespace conformance target|
|RFC|Request For Comments|
|SUB|Subset namespace conformance target|
|UML|Unified Modeling Language|
|URI|Uniform Resource Identifier|
|URL|Uniform Resource Locator|
|URN|Uniform Resource Name|
|XML|Extensible Markup Language|
|XSD|XML Schema Definition|

### 1.2.3 Document conventions

- Naming conventions
- Font colors and styles
- Typographic conventions

-------

# 2. How To Read This Document

This document provides normative specifications for NIEM-conforming data models. It also describes the goals and principles behind those specifications. It includes examples and explanations to help users of NIEM understand the goals, principles, and specifications. The relevant sections of this document will depend on the role of the user. Figure 2-1 illustrates the relationships between these roles and NIEM.

<center>
  <figure>
    <a name="fig2-1"/></a>
      <img src="images/context.png" alt="figure" style="zoom: 100%;" />
    <figcaption><i>Figure 2-1: NIEM-based machine-to-machine data exchange</i>
  </figure>
</center>

Figure 2-1 above emphasizes the design and implementation of NIEM-based data exchange specifications. Figure 2-2 below instead emphasizes the community agreement that forms the NIEM data model.

<center>
  <figure class="image">
    <a name="fig2-2"/></a>
    <img src="images/community.png" alt="figure" style="zoom:100%"/>
    <figcaption><i>Figure 2-2: NIEM communities and data models</i></figcaption>
  </figure>
</center>

The remaining sections of this document most relevant to each of these roles are shown in the following table:

|Section | Manager | Business Analyst | Message Designer | Message Developer |
| :---- | :---: | :----: | :---: | :---: |
| 3. Overview of NIEM technical architecture | x | x | x | x |
| 4. Data models in NIEM | | | x | |
| 5. Data modeling patterns | | | x | |
| 6. Conformance | | x | x | x |
| 7. Rules for names of components | | x | x | |
| 8. Rules for documentation | | x | x |  |
| 9. Rules for the NIEM profile of XSD | | | x | |
| 10. Rules for models in XSD | |  | x |  |
| 11. Rules for NIEM messages in XML | |  | x | x |
| 12. Rules for the NIEM profile of JSON-LD | | | x | |
| 13. Rules for NIEM messages in JSON| |  | x | x |

## 2.1 Document references

This document relies on references to many outside documents. Such references are noted by bold, bracketed inline terms. For example, a reference to RFC 3986 is shown as [[RFC 3986]](#appendix-b-references). All reference documents are recorded in [Appendix B, References, below](#appendix-b-references).

## 2.2 Clark notation and qualified names

This document uses both Clark notation and QName notation to represent qualified names.

QName notation is defined by [XML Namespaces] Section 4, Qualified Names. A QName for the XML Schema string datatype is xs:string. Namespace prefixes used within this specification are listed in Section 2.3, Use of namespaces and namespace prefixes, below.

This document sometimes uses Clark notation to represent qualified names in normative text. Clark notation is described by [ClarkNS], and provides the information in a QName without the need to first define a namespace prefix, and then to reference that namespace prefix. A Clark notation representation for the qualified name for the XML Schema string datatype is {http://www.w3.org/2001/XMLSchema}string.

Each Clark notation value usually consists of a namespace URI surrounded by curly braces, concatenated with a local name. The exception to this is when Clark notation is used to represent the qualified name for an attribute with no namespace, which is ambiguous when represented using QName notation. For example, the element targetNamespace, which has no [namespace name] property, is represented in Clark notation as {}targetNamespace.

## 2.3 Use of namespaces and namespace prefixes

The following namespace prefixes are used consistently within this specification. These prefixes are not normative; this document issues no requirement that these prefixes be used in any conformant artifact. Although there is no requirement for a schema or XML document to use a particular namespace prefix, the meaning of the following namespace prefixes have fixed meaning in this document.

* `xs`: The namespace for the XML Schema definition language as defined by [XML Schema Structures] and [XML Schema Datatypes], http://www.w3.org/2001/XMLSchema.
* `xsi`: The XML Schema instance namespace, defined by [XML Schema Structures] Section 2.6, Schema-Related Markup in Documents Being Validated, for use in XML documents, http://www.w3.org/2001/XMLSchema-instance.
* `ct`: The namespace defined by [CTAS] for the conformanceTargets attribute, https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/.
* `appinfo`: The namespace for the appinfo namespace, https://docs.oasis-open.org/niemopen/ns/model/appinfo/6.0/.
* `structures`: The namespace for the structures namespace, https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/.
* `cmf`: The namespace for the CMF model representation, https://docs.oasis-open.org/niemopen/ns/specification/cmf/1.0/.

-------

# 3. Overview of the NIEM Technical Architecture

This overview describes NIEM's design goals and principles. It introduces key features of the architecture that will be defined in more detail later in the document.

## 3.1 Machine-to-machine data specifications

NIEM is a framework for developer-level specifications of data. A NIEM-based data specification – which is built *using* NIEM and in *conformance* to NIEM, but is not itself a *part* of NIEM – describes data to the developers of producing and consuming systems. This data may be shared via:

* a message passed between applications
* an information resource published on the web
* an API for a system or service

NIEM is potentially useful for any mechanism that transfers a package of data across a system or organization boundary. (Within a large system, NIEM may be useful when data passes between components belonging to different developer teams.)

The primary purpose of a NIEM-based data specification is to establish a common understanding among developers, so that they can write software that correctly handles the shared data, hence "machine-to-machine". (The content of a NIEM message may also be directly presented to human consumers, and NIEM can help these consumers understand what they see, but that is not the main purpose of NIEM.)

In NIEM terms, the package of data shared at runtime is a *message*. A *message type* defines the mandatory and optional information content of a class of messages without prescribing a particular syntax. A *message format* defines a syntax for the content of a message type. Both of these definitions are expressed in terms of a machine-readable *data model*, using either of NIEM's two *modeling formats*, the Common Model Format (CMF) or XML Schema (XSD). A collection of related message formats and types is a *message specification.* The usual case is a message specification with one message type and one message format, but a more complex arrangements is possible, illustrated in figure 3-1 below.

<center>
  <figure class="image">
    <a name="fig3-1"/></a>
    <img src="images/messageSpec.png" alt="figure" style="zoom:100%"/>
    <figcaption><i>Figure 3-1: Message specification, types, and formats</i></figcaption>
  </figure>
</center>

> A NIEM message was originally known as an *information exchange package (IEP)*, a term that found its way into the U.S. Federal Enterprise Architecture (2005).  A message specification was originally known as an *information exchange package documentation (IEPD).*  These terms are still in widespread use within the NIEM community today, and will not go away soon (if ever). 

A *message designer* creates a message type and format from an information requirement, so that a message at runtime will contain all the facts that need to be conveyed. Then any number of *message developers* write software to implement the specification, producing or processing messages that conform to the message format. Message designers need some understanding of NIEM, but the message developers do not. (Sometimes the message developers do not even know that NIEM exists.) [Figure 2-1](#fig2-1) above illustrates the relationships between message designers, message developers, and message formats.

NIEM supports XML and JSON message formats; support for other formats may be added in the future. One important feature of NIEM is that messages of the same type are convertable across serializations; for example, a NIEM XML message can be converted to NIEM JSON, and vice versa, with no bespoke programming required. 

## 3.2 Reuse of community-agreed data models

NIEM is also a framework for communities to create data models for concepts that are useful in multiple data specifications. These community models are typically not *complete* for any particular specification. Instead, they reflect the community's judgement on which definitions are *worth the trouble of agreement*. The NIEM core model contains definitions found useful by the NIEM community as a whole. NIEM domain models reuse the core, extending it with definitions found useful by the domain community. The core model plus the domain models comprise the "NIEM model". [Figure 2-2]() above illustrates the relationships between domain communities and community models.

Message designers reuse definitions from the NIEM model, selecting a (usually small) subset of definitions that express part of their information requirement. Message designers then create model extensions, adding definitions that they require but have not (so far!) been found worthy of inclusion in the NIEM model. 

Data model reuse is especially useful in a large enterprise. Its value grows with the number of developer teams, and with the degree of commonality in the shared data. NIEM was originally designed for data sharing among federal, state, and local governments – where commonality and number of developer teams is large indeed.

## 3.3 Reuse of open standards

NIEM is built on a foundation of open standards, primarily:

* XML and XSD – message serialization and validation; also a modeling formalism
* JSON and JSON-LD – message serialization and linked data
* RDF, RDFS, and OWL – formal semantics
* ISO 11179 – data element conventions

One of NIEM's principles is to reuse well-known information technology standards when these are supported by free and open-source software. NIEM avoids reuse of standards that effectively depend on proprietary software. When the NIEMOpen project defines a standard of its own, it also provides free and open-source software to support it.

## 3.4 The NIEM metamodel

A data model in NIEM defines the syntax and semantics of a message format, or the information content of a message type, or the agreed definitions of a community. The information required for those purposes can itself be modeled. The model of that information is the *NIEM metamodel* -- an abstract model for NIEM data models. The metamodel is expressed in UML, and is described in detail in [section 4](). At a high level, the major components of the metamodel are classes, datatypes, properties, and namespaces. Figure 3-2 provides an lllustration.

<center>
  <figure class="image">
    <a name="fig3-2"/></a>
    <img src="images/highLevel.png" style="zoom:75%"/>
    <figcaption><i>Figure 3-2: High-level view of the NIEM metamodel</i></figcaption>
  </figure>
</center>

- A *class* defines the content of a corresponding *object* (or *resource*) in a message.

- A *datatype* defines the allowed values of a corresponding atomic *literal value* in a message.

- A class has one or more *properties*. An *object property* defines a subject-predicate-value relationship between an object and another object.  A *data property* defines a relationship between an object and a literal value.

- A *namespace* is a collection of uniquely-named components defined by an authority.

Figure 3-3 below illustrates the relationships among metamodel components, NIEM model components, and the corresponding message objects and values.

<center>
  <figure class="image">
    <a name="fig3-3"/></a>
    <img src="images/msg+meta.png" style="zoom:100%"/>
    <figcaption><i>Figure 3-3: Message object and metamodel components</i></figcaption>
  </figure>
</center>

A NIEM message contains objects, properties, and literal values. These are specified by the Class, Property, and Datatype objects in a NIEM data model, which defines the content of a conforming message and the meaning of that content. In figure 3-3, the name object is defined by the `nc:PersonNameType` Class object; the literal value is defined by the `xs:string` Datatype object, and the property relationship between the two is defined by the `nc:PersonFullName` DataProperty object.

## 3.5 NIEM model representations: XSD and CMF

The abstract metamodel has two concrete representations:  NIEM XSD and NIEM CMF. These are equivalent representations and may be converted from one to the other without loss.

Every version of NIEM uses a profile of XML Schema (XSD) as a NIEM model representation. In XSD, a NIEM model is represented as a schema assembled from a collection of schema documents. Every aspect of the metamodel is represented in some way by a schema component.

XSD as a model representation directly supports conformance testing of NIEM XML messages through schema validation. However, JSON developers (and developers working with other formats) cannot use XSD to validate their messages. Nor do they want to read XSD specifications of message content.

NIEM 6 introduces the Common Model Format (CMF), a NIEM model representation intended to support all developers. CMF is itself a NIEM-based message type, the result of applying the NIEM framework to the information requirements in the metamodel.  A CMF message represents a NIEM data model, which is an instance of the NIEM metamodel. CMF is a technology-neutral model representation, because:

* A CMF model that specifies a message type also specifies the corresponding XML and JSON message formats. 

* A CMF model can be transformed into XSD for conformance testing of XML messages, and into JSON Schema for conformance testing of JSON messages.

* A CMF model can itself be represented in XML or JSON, according to developer preference.

[Section 4](#4-data-models-in-niem) defines the mappings between the metamodel, NIEM XSD, and CMF.

## 3.6 Namespaces

The components of a NIEM model are partitioned into *namespaces.* This prevents name clashes among communities or domains that have different business perspectives, even when they choose identical data names to represent different data concepts.

Each namespace has an author, a person or organization that is the authoritative source for the namespace definitions. A namespace is the collection of model components for concepts of interest to the namespace author. Namespace cohesion is important; a namespace should be designed so that its components are consistent, may be used together, and may be updated at the same time.

Each namespace must be uniquely identified by a URI. The namespace author should also be the URI's owner, as defined by [webarch](#ref). Both URNs and URLs are allowed. It is helpful, but not required, for the namespace URI to be accessible, returning the definition of the namespace content in a supported model format. (See [ref repositories?](#ref) for an alternative way to obtain namespace definitions.)

Namespaces are the units of model configuration management. Once published, the components in a namespace may not be removed or changed in meaning. Those changes may only be made in a new namespace with a different URI. As a result, a change by one namespace author does not force a change by any other author – the revisions may be adopted, if desired, whenever convenient; the older namespace continues to be valid regardless.

## 3.7 NIEM messages in XML and JSON

The content of a NIEM message may be formatted as XML or JSON. Any NIEM message may be converted from one supported format to another, without loss of information. Figures 3-4 and 3-5 show the equivalent NIEM XML and JSON serializations of the information depicted in figure 3-3.

```
<nc:Person
  xmlns:nc="https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/">
  <nc:PersonName>
    <nc:PersonFullName>Clark Kent</nc:PersonFullName>
  </nc:PersonName>
</nc:Person>
```
<center><i><a name="fig3-4"></a>Figure 3-4: Sample NIEM XML message</i></center><p/>

```
{ 
  "nc:Person": {
    "nc:PersonName": {
      "nc:PersonFullName": "Clark Kent"
    }
  },
  "@context": { "nc": "https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/" }
}
```
<center><i><a name="fig3-5"></a>Figure 3-5: Sample NIEM JSON message</i></center><p/>

-------

# 4. Data models in NIEM

The NIEM metamodel is an abstract model, defined in the UML diagram below, that specifies the content of a NIEM data model. CMF is a NIEM message type that implements the metamodel. A CMF message is a representation of a NIEM data model. A NIEM data model may also be represented in NIEM XSD. This section specifies:

* the meaning of the classes, attributes, and relationships in the metamodel
* the meaning of the classes, datatypes, and properties in CMF that implement the metamodel
* the XSD constructs that correspond to CMF classes, datatypes, and properties

<center>
  <figure class="image">
    <a name="fig4-1"/></a>
    <img src="images/metamodel.png" style="zoom:60%"/>
    <figcaption><i>Figure 4-1:The NIEM metamodel </i></figcaption>
  </figure>
</center>

The table format used to document classes, attributes, relationships, and properties in the metamodel and in CMF has the following columns:

| Column | Definition |
| ------ | ---------- |
| UML | the name of the UML class, attribute, or relationship |
| CMF | the name of the corresponding CMF class or property |
| Definition | the definition of the object or property |
| Card | the cardinality of the property (how many times it may/must appear in an object) |
| Ord | true when the order of the instances of a repeatable property in an object is significant |
| Range | the class or datatype of a property |
</br>

## 4.1 Model class

A Model object represents a complete or partial NIEM model.  (A complete model has a definition for every referenced component.)

<center>
  <figure class="image">
    <a name="fig4-2"/></a>
    <img src="images/modelClass.png" style="zoom:100%"/>
    <figcaption><i>Figure 4-2: Model class diagram</i></figcaption>
  </figure>
</center>

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| Model | ModelType | A data type for a NIEM data model. |
| comp | Component | A data concept for a component of a NIEM data model. | 0..* | - | ComponentType |
| ns | Namespace | A namespace of a data model component | 0..* | - | NamespaceType |

A Model object is represented in CMF as a CMF model file; that is, a CMF message.

A Model object is represented in XSD as a set of XML schema documents. One or more schema documents are provided to begin the set. Other documents are added, according to the @schemaLocation attribute in the import elements in each document encountered. Documents may also be added according to the @namespace attribute, as resolved through XML Catalog files, if provided. There is one namespace object in the model for each namespace defined by the schema documents. The components in each namespace are those specified by the XSD to CMF mappings defined in this section.

## 4.2 Namespace class

A Namespace object represents a namespace in a model. For example, the namespace with the URI `https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/` is a namespace in the NIEM 6.0 model.

<center>
  <figure class="image">
    <a name="fig4-3"/></a>
    <img src="images/namespaceClass.png" style="zoom:100%"/>
    <figcaption><i>Figure 4-3: Namespace class diagram</i></figcaption>
  </figure>
</center>

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| Namespace | NamespaceType | A data type for a namespace. ||||
| uri | NamespaceURI | A URI for a namespace. | 1 | - | xs:anyURI |
| prefix | NamespacePrefixText | A namespace prefix name for a namespace. | 1 | - | xs:NCName |
| documentation | DocumentationText | A human-readable text documentation of a namespace. | 1..* | Y | TextType |
| lang | NamespaceLanguageName | A name of a default language of the terms and documentation text in a namespace. | 1 | - | xs:language |
| version | NamespaceVersionText | A version of a namespace; for example, used to distinguish a namespace subset, bug fix, documentation change, etc. | 1 | - | xs:token |
| kind | NamespaceKindCode | A kind of namespace in a NIEM model (external, core, domain, etc.). | 1 | - | NamespaceKindCodeType |
| confTarg | ConformanceTargetURI | A [conformance target identifier](#def). | 0..* | - | xs:anyURI |
| niemVersion | NIEMVersionText | A NIEM version number of the builtin schema components used in a namespace; e.g. "5" or "6". | 0..1 | - | xs:token |
| docPath | DocumentFilePathText | A relative file path from the top schema directory to a schema document for this namespace. | 0..1 | - | xs:string |
| importDoc | ImportDocumentationText | Human-readable documentation from the first `xs:import` element importing this namespace. | 0..1 | - | xs:string |
| aug | AugmentationRecord | An augmentation of a class with a property by a namespace. | 0..* | - | AugmentationType|
| term | LocalTerm | A data type for the meaning of a term that may appear within the name of a model component. | 0..* | - | LocalTermType |

> Note: I'm now thinking we don't need `NIEMVersionText`. We can work that out from the conformance target assertions.  And we don't need `NamespaceKindCode`. We can work that out from the namespace URI and conformance target assertions -- or if we can't show it's BUILTIN, CORE, DOMAIN, EXTENSION, OTHERNIEM, XML, or XSD, then in a conforming schema pile it must be EXTERNAL. So I think these properties will go away when I have time to fool with it.

Figure 4-4 shows the representation of a Namespace object in CMF and in the corresponding XSD.


```
<Namespace>
  <NamespaceURI>https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/</NamespaceURI>
  <NamespacePrefixText>nc</NamespacePrefixText>
  <DocumentationText>NIEM Core.</DocumentationText>
  <ConformanceTargetURI>
    https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ReferenceSchemaDocument
  </ConformanceTargetURI>
  <NamespaceVersionText>ps02</NamespaceVersionText>
  <NamespaceLanguageName>en-US</NamespaceLanguageName>
</Namespace>
---------------
<xs:schema
  targetNamespace="https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/"
  xmlns:ct="https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/"
  xmlns:nc="https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  ct:conformanceTargets="https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ReferenceSchemaDocument"
  version="ps02"
  xml:lang="en-US">
  <xs:annotation>
    <xs:documentation>NIEM Core.</xs:documentation>
  </xs:annotation>    
</xs:schema>
```
<center><i><a name="fig4-4"></a>Figure 4-4: Namespace object in CMF and XSD</i></center><p/>

The following table shows the mapping between Namespace object representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| NamespaceURI | `xs:schema/@targetNamespace` |
| NamespacePrefixText | The prefix in the first namespace declaration of the target namespace |
| DocumentationText | `xs:schema/xs:annotation/xs:documentation` |
| ConformanceTargetURI | Each of the URIs in the list attribute `xs:schema/@ct:conformanceTargets` |
| NamespaceVersionText | `xs:schema/@version` |
| NamespaceLanguageName | `xs:schema/@xml:lang` |
</br>

## 4.3 Component class (abstract)

A model component in a namespace is either a Class object, a Property object, or a Datatype object in a NIEM model. The abstract component class defines the common properties.

<center>
  <figure class="image">
    <a name="fig4-4"/></a>
    <img src="images/component.png" style="zoom:100%"/>
    <figcaption><i>Figure 4-5: Component class diagram</i></figcaption>
  </figure>
</center>

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| Component | ComponentType | A data type for common properties of a data model component in NIEM. |
| name | Name | The name of a data model component. | 1 | - | xs:NCName |
| documentation | DocumentationText | A human-readable text definition of a data model component. | 0..* | Y | TextType |
| isDeprecated | DeprecatedIndicator | True for a deprecated schema component; that is, a component that is provided, but the use of which is not recommended. | 0..1 | - | xs:boolean |
| ns | Namespace | The namespace of a data model component. | 1 | - | NamespaceType |
</br>

## 4.4 Class class

A Class object represents a class of objects defined by a NIEM model; that is, an [object class](#def).  For example, `nc:PersonType` is a Class object in the NIEM Core model.

<center>
  <figure class="image">
    <a name="fig4-6"/></a>
    <img src="images/class.png" style="zoom:100%"/>
    <figcaption><i>Figure 4-6: Class and HasProperty class diagram</i></figcaption>
  </figure>
</center>

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| Class | ClassType | A data type for a class. |
| isAbstract | AbstractIndicator | True if a class is a base for extension, and must be specialized to be used directly; false if a class may be used directly. | 0..1 | - | xs:boolean |
| isAugmentable | AugmentableIndicator | True for an [augmentable class](#def); that is, if a class can be augmented with additional properties. | 0..1 | - | xs:boolean |
| referenceCode | ReferenceCode | A code describing how a property may be referenced (or must appear inline). | 0..1 | - | ReferenceCodeType |
| subClassOf | ExtensionOfClass | A base class of a subclass. | 0..1 | - | ClassType |  
| hasProp | HasProperty | An occurrence of a property as content of a class. | 0..* | Y | HasPropertyType |

There are three special categories of [object class](#def):

* An [adapter class](#def) contains only properties from a single [external namespace](#def).  It acts as a conformance wrapper around data components defined in standards that are not NIEM conforming.  An [adapter class](#def) has a name ending in "AdapterType".

* An [association class](#def) represents a specific relationship between objects.   Associations are used when a simple NIEM property is insufficient to model the relationship clearly, or to model properties of the relationship itself.  An [association class](#def) has a name ending in "AssociationType".

* An [atomic class](#def) contains no object properties, at least one [attribute property](#def), and exactly one data property that is not an attribute property.  An [atomic class](#def) does not have a special name.

Most classes are represented in XSD as a complex type with complex content ("CCC type"); that is, a type with  child elements.  [Figure 4-7](#fig4-7) below shows a Class object represented in CMF, and then in XSD as a complex type with child elements.

```
<Class structures:id="ex.ExampleType">
  <Name>ExampleType</Name>
  <Namespace structures:ref="ex" xsi:nil="true"/>
  <DocumentationText>
    A data type for a conveyance designed to carry an operator, passengers and/or cargo, over land.
  </DocumentationText>
  <DeprecatedIndicator>true</DeprecatedIndicator>
  <AbstractIndicator>true</AbstractIndicator>
  <ExtensionOfClass structures:ref="ex.ConveyanceType" xsi:nil="true"/>
  <AugmentableIndicator>true</AugmentableIndicator>
  <ReferenceCode>REF</ReferenceCode>
  <HasProperty>
    <DataProperty structures:ref="ex.ExampleDoorQuantity" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>unbounded</MaxOccursQuantity>
  </HasProperty>
  <HasProperty>
    <DataProperty structures:ref="ex.aProperty" xsi:nil="true"/>
    <MinOccursQuantity>1</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
  </HasProperty>
</Class>
---------------
<xs:complexType name="ExampleType" abstract="true" appinfo:deprecated="true" appinfo:referenceCode="REF">
  <xs:annotation> 
    <xs:documentation>
       A data type for a conveyance designed to carry an operator, passengers and/or cargo, over land.
    </xs:documentation>
  </xs:annotation>
  <xs:complexContent>
    <xs:extension base="ex:ConveyanceType">
      <xs:sequence>
        <xs:element ref="ex:ExampleDoorQuantity" minOccurs="0" maxOccurs="unbounded"/>
        <xs:element ref="ex:ExampleAugmentationPoint" minOccurs="0" maxOccurs="unbounded"/>
      </xs:sequence>
      <xs:attribute ref="ex:aProperty" use="required"/>
    </xs:extension>
  </xs:complexContent>
</xs:complexType>

```
<center><i><a name="fig4-7"></a>Figure 4-7: A Class object in CMF and in XSD (CCC type)</i></center><p/>

The following table shows the mapping between Class object representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| Namespace | The namespace object for the containing schema document. |
| Name | `xs:complexType/@name` |
| DocumentationText | `xs:complexType/xs:annotation/xs:documentation` |
| DeprecatedIndicator | `xs:complexType/@appinfo:deprecated` |
| AbstractIndicator | `xs:complexType/@abstract` |
| ExtensionOfClass | `xs:complexType/xs:complexContent/xs:extension/@base` |
| AugmentableIndicator | True if the last element in the sequence is an [*augmentation point*](). |
| ReferenceCode | `xs:complexType/@appinfo:referenceCode` |
| HasProperty | `xs:complexType/xs:complexContent/xs:extension/xs:sequence/xs:element` or `xs:complexType/xs:complexContent/xs:extension/xs:attribute` |

An [atomic class](#def) is represented in XSD as a complex type with simple content ("CSC type") that has attributes.  This is illustrated in [figure 4-8](#fig4-8) below, which shows an [atomic class](#def) object in CMF, and then in XSD as a complex type with attributes but no child elements.

```
---------------
<Class structures:id="ex.Example2Type">
  <Name>Example2Type</Name>
  <Namespace structures:ref="ex" xsi:nil="true"/>
  <HasProperty>
    <DataProperty structures:ref="ex.Example2Literal" xsi:nil="true"/>
    <MinOccursQuantity>1</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
  </HasProperty>
  <HasProperty>
    <DataProperty structures:ref="ex.aProperty" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
    <DocumentationText>A reason why a data value was not provided.</DocumentationText>
  </HasProperty>
</Class>
---------------
<xs:complexType name="Example2Type">
  <xs:simpleContent>
    <xs:extension base="xs:integer">
      <xs:attribute ref="ex:aProperty"/>
      <xs:attributeGroup ref="structures:SimpleObjectAttributeGroup"/>
    </xs:extension>
  </xs:simpleContent>
</xs:complexType>
```
<center><i><a name="fig4-8"></a>Figure 4-8: Class object in CMF and XSD (CSC type)</i></center><p/>

An [atomic class](#def) always has a DataProperty object named after the class, with "Type" replaced by "Literal".  In CMF these appear as two separate objects. In XSD, the representation of an [atomic class](#def) also represents the DataProperty object. 

## 4.5 HasProperty class

A HasProperty object represents the occurrence of a property in a class. For example, the `nc:PersonType` class object in the NIEM core model has a HasProperty object for the `nc:PersonName` property.

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| HasProperty | HasPropertyType | A data type for an occurrence of a property as content of a class. |
| minOccurs | MinOccursQuantity | The minimum number of times a property may occur within an object of a class. | 1 | - | xs:integer |
| maxOccurs | MaxOccursQuantity | The maximum number of times a property may occur within an object of a class. | 1 | - | MaxOccursType |
| documentation | DocumentationText | A human-readable documentation of a property that is content of a class. | 0..* | Y | TextType |
| isOrdered | OrderedPropertyIndicator | True if the order of a repeated property within an object is significant. | 0..1 | - | xs:boolean |
| augNamespace | AugmentingNamespace | A namespace responsible for augmenting a class with a property. | 0..* | - | NamespaceType |
| property | Property | The property that occurs in the class. | 1 | - | PropertyType |

A HasProperty object is represented in XSD as an element or attribute reference within a complex type definition. Figure 4-9 shows two HasProperty objects in CMF and the corresponding XSD.

```
<HasProperty>
  <DataProperty structures:ref="ex.PersonMiddleName" xsi:nil="true"/>
  <MinOccursQuantity>0</MinOccursQuantity>
  <MaxOccursQuantity>unbounded</MaxOccursQuantity>
  <DocumentationText>
    Documentation here refers to the relationship between the object and this property.
  </DocumentationText>
  <OrderedPropertyIndicator>true</OrderedPropertyIndicator>
</HasProperty>
<HasProperty>
  <DataProperty structures:ref="ex.aProperty" xsi:nil="true"/>
  <MinOccursQuantity>1</MinOccursQuantity>
  <MaxOccursQuantity>1</MaxOccursQuantity>
</HasProperty>
---------------
<xs:sequence>
  <xs:element ref="ex:PersonMiddleName" 
    minOccurs="0" maxOccurs="unbounded" appinfo:orderedPropertyIndicator="true">
    <xs:annotation>
      <xs:documentation>
        Documentation here refers to the relationship between the object and this property.
      </xs:documentation>
    </xs:annotation>
  </xs:element>
</xs:sequence>
<xs:attribute ref="ex:aProperty" use="required"/>
```
<center><i><a name="fig4-9"></a>Figure 4-9: HasProperty object in CMF and XSD</i></center><p/>

The following table shows the mapping between HasProperty representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| Property | The property object for `xs:element/@ref`. |
| MinOccursQuantity | `xs:element/@minOccurs` |
| MaxOccursQuantity | `xs:element/@maxOccurs` |
| DocumentationText | `xs:element/xs:annotation/xs:documentation` |
| OrderedPropertyIndicator | `xs:element/@appinfo:orderedPropertyIndicator` |
| AugmentingNamespace | `xs:element/@appinfo:augmentingNamespace` |
</br>

## 4.6 Property class (abstract)

A Property object represents a data property or an object property in a NIEM model. 

<center>
  <figure class="image">
    <a name="fig4-10"/></a>
    <img src="images/property.png" style="zoom:100%"/>
    <figcaption><i>Figure 4-10: Property class diagram</i></figcaption>
  </figure>
</center>

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| Property | PropertyType | A data type for a property. |
| isAbstract | AbstractIndicator | True if a property must be specialized; false if a property may be used directly. | 0..1 | - | xs:boolean |
| isRelationship | RelationshipPropertyIndicator | True for a property that applies to the relationship between two objects (instead of to a single object). | 0..1 | - | xs:boolean |
| subPropertyOf | SubPropertyOf | A property of which a property is a subproperty. | 0..1 | - | PropertyType |
</br>

## 4.7 ObjectProperty class

An ObjectProperty object represents a property with a range that is a class. For example, the `nc:PersonName` object in the NIEM core model is a property with a range of `nc:PersonNameType`.

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| ObjectProperty | ObjectPropertyType | A data type for an object property. |
| referenceCode | ReferenceCode | A code describing how a property may be referenced (or must appear inline). | 0..1 | - | ReferenceCodeType |
| class | Class | The class of this object property. | 1 | - | ClassType |

An ObjectProperty object is represented in XSD as an element declaration with a type that is a Class object. Figure 4-11 shows an ObjectProperty object in XSD and the corresponding CMF.

```
<ObjectProperty structures:id="ex.ExampleProperty">
  <Name>ExampleProperty</Name>
  <Namespace structures:ref="ex" xsi:nil="true"/>
  <DocumentationText>Documentation text for ExampleProperty.</DocumentationText>
  <DeprecatedIndicator>true</DeprecatedIndicator>
  <AbstractIndicator>true</AbstractIndicator>
  <SubPropertyOf structures:ref="ex.PropertyAbstract" xsi:nil="true"/>
  <RelationshipPropertyIndicator>true</RelationshipPropertyIndicator>
  <Class structures:ref="ex.ExType" xsi:nil="true"/>
  <ReferenceCode>ANY</ReferenceCode>
</ObjectProperty>
---------------
<xs:element name="ExampleProperty" type="ex:ExType" abstract="true" substitutionGroup="ex:PropertyAbstract" 
  appinfo:deprecated="true" 
  appinfo:relationshipPropertyIndicator="true"
  appinfo:referenceCode="ANY">
  <xs:annotation>
    <xs:documentation>Documentation text for ExampleProperty.</xs:documentation>
  </xs:annotation>
</xs:element>
```
<center><i><a name="fig4-11"></a>Figure 4-11: ObjectProperty object in CMF and XSD</i></center><p/>

The following table shows the mapping between ObjectProperty object representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| Namespace | The namespace object for the containing schema document. |
| Name | `xs:complexType/@name` |
| DocumentationText | `xs:complexType/xs:annotation/xs:documentation` |
| DeprecatedIndicator | `xs:complexType/@appinfo:deprecated` |
| AbstractIndicator | `xs:complexType/@abstract` |
| SubPropertyOf | The property object for `xs:element/@substitutionGroup` |
| RelationshipPropertyIndicator | `xs:element/@appinfo:relationshipPropertyIndicator`
| Class | The class object for `xs:element/@type` |
| ReferenceCode | `xs:complexType/@appinfo:referenceCode` |
</br>

## 4.8 DataProperty class

A DataProperty object represents a property with a range that is a datatype. For example, the `nc:PersonFullName` object shown in [figure 3-3](fig3-3) is a property with a range of `xs:string`.

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| DataProperty | DataPropertyType | 
| isAttribute* | AttributeIndicator | True for a property that is represented as attributes in XML. | 0..1 | - | xs:boolean |
| isRefAttribute* | RefAttributeIndicator | True for a property that is an [object reference attribute](). | 0..1 | - | xs:boolean |
| datatype | Datatype | The datatype of this data property. | 1 | - | DatatypeType |

An [attribute property](#def) is a data property in which `isAttribute` is true.  These are represented in XSD as an attribute declaration.

A [reference property](#def) is an attribute property that contains a reference to an object in a message.  (Object references are described in [section ref message rules]().)

DataProperty objects are represented in XSD as an attribute declaration, or as an element declaration with a type that is a Datatype object. Figure 4-12 shows the CMF and XSD representations of two DataProperty objects.

```
<DataProperty structures:id="ex.ExampleProperty">
  <Name>ExampleProperty</Name>
  <Namespace structures:ref="ex" xsi:nil="true"/>
  <DocumentationText>Documentation text for ExampleProperty.</DocumentationText>
  <DeprecatedIndicator>true</DeprecatedIndicator>
  <AbstractIndicator>true</AbstractIndicator>
  <SubPropertyOf structures:ref="ex.PropertyAbstract" xsi:nil="true"/>
  <Datatype structures:ref="ex.ExType" xsi:nil="true"/>
</DataProperty>
<DataProperty structures:id="ex.AttributeProperty">
  <Name>AttributeProperty</Name>
  <Namespace structures:ref="ex" xsi:nil="true"/>
  <DocumentationText>Documentation text for AttributeProperty.</DocumentationText>
  <DeprecatedIndicator>true</DeprecatedIndicator>
  <Datatype structures:ref="xs.string" xsi:nil="true"/>
  <AttributeIndicator>true</AttributeIndicator>
  <RefAttributeIndicator>true</RefAttributeIndicator>
</DataProperty> 
---------------
<xs:element name="ExampleProperty" type="ex:ExType" abstract="true" substitutionGroup="ex:PropertyAbstract" 
  appinfo:deprecated="true">
  <xs:annotation>
    <xs:documentation>Documentation text for ExampleProperty.</xs:documentation>
  </xs:annotation>
</xs:element>
<xs:attribute name="AttributeProperty" type="xs:string" 
  appinfo:deprecated="true" 
  appinfo:referenceAttributeIndicator="true">
  <xs:annotation>
    <xs:documentation>Documentation text for ExampleProperty.</xs:documentation>
  </xs:annotation>
</xs:attribute> 
```
<center><i><a name="fig4-12"></a>Figure 4-12: DataProperty object in CMF and XSD</i></center><p/>

The following table shows the mapping between DataProperty representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| Namespace | The namespace object for the containing schema document. |
| Name | `xs:complexType/@name` |
| DocumentationText | `xs:complexType/xs:annotation/xs:documentation` |
| DeprecatedIndicator | `xs:complexType/@appinfo:deprecated` |
| AbstractIndicator | `xs:complexType/@abstract` |
| SubPropertyOf | The property object for `xs:element/@substitutionGroup` |
| RelationshipPropertyIndicator | `xs:element/@appinfo:relationshipPropertyIndicator`
| Datatype | The datatype object for `xs:element/@type` |
| AttributeIndicator | True for an attribute declaration. |
| RefAttributeIndicator | `xs:attribute/@appinfo:referenceAttributeIndicator` |
</br>

## 4.9 Datatype class

<center>
  <figure class="image">
    <a name="fig4-13"/></a>
    <img src="images/datatype.png" style="zoom:100%"/>
    <figcaption><i>Figure 4-13: Datatype classes</i></figcaption>
  </figure>
</center>

A Datatype object defines the allowed values of a corresponding atomic literal value in a message. Objects for primitive data types, corresponding to the XSD data types, have only the *name*, *namespace*, and *documentation* properties inherited from the Component class. For example, figure 4-14 shows the CMF representation of the `xs:string` primitive data type. All other datatypes are represented by either a Restriction, List, or Union object.

```
<Datatype>
  <Name>string</Name>
  <Namespace structures:ref="xs" xsi:nil="true"/>
</Datatype>
```
<center><i><a name="fig4-14"></a>Figure 4-14: Plain CMF datatype object for `xs:string`</i></center><p/>

## 4.10 List class

A List object defines a datatype as a whitespace-separated list of atomic values.

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| List | ListDatatype | A data type for a NIEM model datatype that is a whitespace-separated list of atomic values.||||
| isOrdered | OrderedPropertyIndicator | True if the order of a repeated property within an object is significant. | 0..1 | - | xs:boolean |
| listType | ListOf | The datatype of the atomic values in a list. | 1 | - | DatatypeType |

A List object is represented in XSD as a complex type definition that extends a simple type definition with an `xs:list` element.  Figure 4-15 shows the CMF and XSD representation of a List object.

```
<ListDatatype structures:id="ex.ExListType">
  <Name>ExListType</Name>
  <Namespace structures:ref="ex" xsi:nil="true"/>
  <DocumentationText>A data type for a list ofintegers.</DocumentationText>
  <ListOf structures:ref="xs.integer" xsi:nil="true"/>
  <OrderedPropertyIndicator>true</OrderedPropertyIndicator>
</ListDatatype>
---------------
<xs:simpleType name="ExListSimpleType">
  <xs:list itemType="xs:integer"/>
</xs:simpleType>
<xs:complexType name="ExListType" appinfo:orderedPropertyIndicator="true">
  <xs:annotation>
    <xs:documentation>A data type for a list of integers.</xs:documentation>
  </xs:annotation>
  <xs:simpleContent>
    <xs:extension base="ex:ExListSimpleType">
      <xs:attributeGroup ref="structures:SimpleObjectAttributeGroup"/>
    </xs:extension>
  </xs:simpleContent>
</xs:complexType>
```
<center><i><a name="fig4-15"></a>Figure 4-15: List object in CMF and XSD</i></center><p/>

The following table shows the mapping between List object representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| Namespace | The namespace object for the containing schema document. |
| Name | `xs:complexType/@name` |
| DocumentationText | `xs:complexType/xs:annotation/xs:documentation` |
| DeprecatedIndicator | `xs:complexType/@appinfo:deprecated` |
| ListOf | `xs:simpleType/xs:list/@itemType` |
| OrderedPropertyIndicator | `xs:complexType/@appinfo:orderedPropertyIndicator` |
</br>

## 4.11 Union class

A Union object defines a datatype as the union of one or more datatypes.

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| Union | UnionDatatype | A data type for a NIEM model datatype that is a union of datatypes.
| unionType | UnionOf | A NIEM model datatype that is a member of a union datatype. | 1..* | - | DatatypeType |

A Union object is represented in XSD as a complex type definition that extends a simple type definition with an `xs:union` element. Figure 4-16 shows the XSD and CMF representations of a Union object.

```
<UnionDatatype structures:id="ex.UnionType">
  <Name>UnionType</Name>
  <Namespace structures:ref="test" xsi:nil="true"/>
  <DocumentationText>A data type for a union of integer and float datatypes.</DocumentationText>
  <UnionOf structures:ref="xs.integer" xsi:nil="true"/>
  <UnionOf structures:ref="xs.float" xsi:nil="true"/>
</UnionDatatype>
---------------
<xs:simpleType name="UnionSimpleType">
  <xs:union memberTypes="xs:integer xs:float"/>
</xs:simpleType>
<xs:complexType name="UnionType">
  <xs:annotation>
    <xs:documentation>A data type for a union of integer and float datatypes.</xs:documentation>
  </xs:annotation>  <xs:simpleContent>
    <xs:extension base="ex:UnionSimpleType">
      <xs:attributeGroup ref="structures:SimpleObjectAttributeGroup"/>
    </xs:extension>
  </xs:simpleContent>
</xs:complexType>
```
<center><i><a name="fig4-16"></a>Figure 4-16: Union object in CMF and XSD</i></center><p/>

The following table shows the mapping between UnionDatatype object representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| Namespace | The namespace object for the containing schema document. |
| Name | `xs:complexType/@name` |
| DocumentationText | `xs:complexType/xs:annotation/xs:documentation` |
| DeprecatedIndicator | `xs:complexType/@appinfo:deprecated` |
| UnionOf | `xs:simpleType/xs:union/@memberTypes` |
</br>

## 4.12 Restriction class

A Restriction object defines a datatype as a restriction of a base datatype plus zero or more restricting Facet objects.

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| Restriction | RestrictionType | A data type for a restriction of a data type. |
| restricts | RestrictionBase | The NIEM model datatype that is restricted by this datatype. | 1 | - | DatatypeType |
| facet | Facet | A data concept for a facet that restricts an aspect of a data type. | 0..* | - | FacetType |
| clb | CodeListBinding | A property for connecting atomic values defined by a data type to a a column of a code list. | 0..1 | - | CodeListBindingType |

A Restriction object is represented in XSD as a complex type with simple content containing an `xs:restriction` element. Figure 4-17 shows the CMF and XSD representations of a Restriction object.

```
<RestrictionDatatype structures:id="test.RestrictionType">
  <Name>RestrictionType</Name>
  <Namespace structures:ref="test" xsi:nil="true"/>
  <DocumentationText>Exercise code list binding</DocumentationText>
  <RestrictionBase structures:ref="xs.token" xsi:nil="true"/>
  <Enumeration>
    <StringValue>GB</StringValue>
  </Enumeration>
  <Enumeration>
    <StringValue>US</StringValue>
  </Enumeration>
  <CodeListBinding>
    <CodeListURI>http://api.nsgreg.nga.mil/geo-political/GENC/2/3-11</CodeListURI>
    <CodeListColumnName>foo</CodeListColumnName>
    <CodeListConstrainingIndicator>true</CodeListConstrainingIndicator>
  </CodeListBinding>
</RestrictionDatatype>
---------------
<xs:complexType name="RestrictionType">
  <xs:annotation>
    <xs:appinfo>
      <clsa:SimpleCodeListBinding codeListURI="http://api.nsgreg.nga.mil/geo-political/GENC/2/3-11" 
        columnName="foo" constrainingIndicator="true"/>
    </xs:appinfo>
  </xs:annotation>
  <xs:simpleContent>
    <xs:restriction base="niem-xs:token">
      <xs:enumeration value="GB"/>
      <xs:enumeration value="US"/>
    </xs:restriction>
  </xs:simpleContent>
</xs:complexType>
```
<center><i><a name="fig4-17"></a>Figure 4-17: Restriction object in CMF and XSD</i></center><p/>

The following table shows the mapping between Restriction object representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| Namespace | The namespace object for the containing schema document. |
| Name | `xs:complexType/@name` |
| DocumentationText | `xs:complexType/xs:annotation/xs:documentation` |
| DeprecatedIndicator | `xs:complexType/@appinfo:deprecated` |
| RestrictionBase | The datatype object for `xs:complexType/xs:simpleContent/xs:restriction/@base` |
| Facet | `xs:complexType/xs:simpleContent/xs:restriction/`*XSD-Facet-element* |
| CodeListBinding | `xs:complexType/xs:annotation/xs:appinfo/clsa:SimpleCodeListBinding` |

A [code list](#def) is a list of distinct conceptual entities, each represented by a code value that has a known meaning beyond its text representation.  These codes may be meaningful text or may be a string of alphanumeric identifiers that represent abbreviations for literals.

A [code list datatype](#def) is a Restriction in which each value that is valid for the datatype corresponds to a code value in a code list.

Many code datatypes have simple content composed of xs:enumeration values. Code types may also be  constructed using the NIEM Code Lists Specification [[Code Lists]](#ref), which supports code lists defined using a variety of methods, including CSV spreadsheets; these are represented by a [CodeListBinding](#414-codelistbinding-class) object, described below.

## 4.13 Facet class

There are twelve Facet subclasses in the metamodel, and twelve Facet properties in CMF, each with the same meaning as the corresponding twelve constraining facets in XML Schema. 

A Facet object is represented in XSD as one of the twelve XSD constraining facet elements. Each XSD facet element has a corresponding CMF facet object, as shown in the following table.

| XSD element | CMF Facet object | CMF class |
| --- | ---------- | --------- |
| `xs:enumeration`     | Enumeration    | AnyValueFacetType
| `xs:fractionDigits ` | FractionDigits | NonNegativeValueFacetType
| `xs:length`          | Length         | NonNegativeValueFacetType
| `xs:maxExclusive`    | MaxExclusive   | AnyValueFacetType
| `xs:maxInclusive`    | MaxInclusive   | AnyValueFacetType
| `xs:maxLength`       | MaxLength      | NonNegativeValueFacetType
| `xs:minExclusive`    | MinExclusive   | AnyValueFacetType
| `xs:minInclusive`    | MinInclusive   | AnyValueFacetType
| `xs:minLength`       | MinLength      | NonNegativeValueFacetType
| `xs:pattern`         | Pattern        | PatternFacetType
| `xs:totalDigits`     | TotalDigits    | PositiveValueFacetType
| `xs:whiteSpace`      | WhiteSpace     | WhiteSpaceFacetType

The value property of each CMF facet type is represented in XSD as the `@value` attribute of the XSD element; for example, `xs:length/@value`.

The DocumentationText property of each CMF facet type is represented in XSD as the `xs:enumeration/xs:annotation/xs:documentation`.

## 4.14 CodeListBinding class

A CodeListBinding object establishes a relationship between a Restriction object and a code list specification. The detailed meaning of the object properties is provided in [ref code list specification]().

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| CodeListBinding | CodeListBinding |
| uri | CodeListURI | A universal identifier for a code list. |  1 | - | xs:anyURI |
| column | CodeListColumnName | A local name for a code list column within a code list. | 0..1 | - | xs:string |
| isConstraining | CodeListConstrainingIndicator | True when a code list binding constrains the validity of a code list value, false otherwise. | 0..1 | - | xs:boolean |

A CodeListBinding object is represented in XSD as a `clsa:SimpleCodeListBinding` element in an `xs:appinfo` element. Figure 4-15 above shows the XSD and CMF representation of a CodeListBinding object. The following table shows the mapping between CodeListBinding object representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| CodeListURI | `clsa:SimpleCodeListBinding/@codeListURI` |
| CodeListColumnName | `clsa:SimpleCodeListBinding/@columnName` |
| CodeListConstrainingIndicator | `clsa:SimpleCodeListBinding/@constrainingIndicator` |
</br>

## 4.15 Augmentation class

<center>
  <figure class="image">
    <a name="fig4-18"/></a>
    <img src="images/augment.png" style="zoom:100%"/>
    <figcaption><i>Figure 4-18: Augmentation class diagram</i></figcaption>
  </figure>
</center>

Developers of domain schemas and other schemas that build on and extend the NIEM release schemas need to be able to define additional characteristics of common types. For example, the *NIEM Justice* domain, which addresses justice and public safety concerns, considers the following elements to be characteristics of a person, as defined by `nc:PersonType`:

* `j:PersonAdultIndicator`
* `j:PersonForeignNationalIndicator`

There are several approaches that could be used by a domain to add elements to a common type. One method is to have each domain create a subclass of nc:PersonType that adds elements and attributes for the needed content. Some of the problems with this approach include:

* It results in numerous, domain-specific specializations of `nc:PersonType`, each with common content and extension-specific content.

* There is no method for a message designer to bring these types back together into a single type that carries the desired properties. XML Schema does not support multiple inheritance, so there would be no way to join together `nc:PersonType, `j:PersonType`, and `im:PersonType`.

* There is no standard or easy way for the developer to express that the various element instances of the various person types represent the same person, or which parts of those instances are required to be populated; does each person restate the name and birth-date, or is that handled by just one instance?

NIEM's alternative to subclassing is *augmentation*. This is the NIEM mechanism allowing the author of one namespace (the *augmenting namespace*) to add a property to a class in another namespace (the *augmented namespace*) -- without making any change to the augmented namespace. For example:

* `https://docs.oasis-open.org/niemopen/ns/model/domains/justice/6.0/` is an augmenting namespace
* `https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/` is an augmented namespace
* `j:PersonAdultIndicator` is an *augmentation property*
* `nc:PersonType` is an *augmented class*

The XSD representation of an augmentation is complex, and is explained below. In CMF, an augmentation is represented as an AugmentationRecord object belonging to the augmenting namespace. In this way, each namespace object contains a complete list of all the augmentations it makes.

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| Augmentation | AugmentationRecordType | A data type for a class that is augmented with a property by a namespace. |
| minOccurs | MinOccursQuantity | The minimum number of times a property may occur within an object of a class. | 1 | - | xs:integer |
| maxOccurs | MaxOccursQuantity | The maximum number of times a property may occur within an object of a class. | 1 | - | MaxOccursType |
| index | AugmentationIndex | The ordinal position of an augmentation property that is part of an [augmentation type](). | 0..1 | - | xs:integer |
| global | AugmentedGlobalComponentID | The identifer for a NIEM version and kind of component that is the target of this global augmentation. | 0..1 | - | xs:QName |
| class | Class | The augmented class. | 0..1 | - | ClassType |
| property | Property | The augmentation property . | 1 | - | PropertyType |

For example, augmentation of `nc:PersonType` with `j:PersonAdultIndicator` and `j:PersonForeignNationalIndicator` by the justice namespace results in the following CMF:

```
<Namespace>
  <NamespaceURI>https://docs.oasis-open.org/niemopen/ns/model/domains/justice/6.0/</NamespaceURI>
  <NamespacePrefix>j</NamespacePrefix>
  <AugmentationRecord>
    <Class structures:ref="nc.PersonType" xsi:nil="true"/>
    <Property structures:ref="j.PersonAdultIndicator" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>unbounded</MaxOccursQuantity>
    <AugmentationIndex>0</AugmentationIndex>
  </AugmentationRecord>
  <AugmentationRecord>
    <Class structures:ref="nc.PersonType" xsi:nil="true"/>
    <Property structures:ref="j.PersonForeignNationalIndicator" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>unbounded</MaxOccursQuantity>
    <AugmentationIndex>1</AugmentationIndex>
  </AugmentationRecord>  
</Namespace>
```
<center><i><a name="fig4-19"></a>Figure 4-19: Augmentation object in CMF</i></center><p/>

In CMF, the augmentation property appears in the augmented Class object -- like any other property, except that the augmenting namespace is recorded. For example, augmentation of `nc:PersonType` with `j:PersonAdultIndicator` and `j:PersonForeignNationalIndicator` by the justice namespace results in the following CMF:

```
<Class>
  <Name>PersonType</Name>
  <Namespace structures:ref="nc" xsi:nil="true"/>
  <!-- documentation and other HasProperty objects omitted -->
  <HasProperty>
    <DataProperty structures:ref="j.PersonAdultIndicator" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>unbounded</MaxOccursQuantity>
    <AugmentingNamespace>
      https://docs.oasis-open.org/niemopen/ns/model/domains/justice/6.0/
    </AugmentingNamespace>
  </HasProperty>
  <HasProperty>
    <DataProperty structures:ref="j.PersonForeignNationalIndicator" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>unbounded</MaxOccursQuantity>
    <AugmentingNamespace>
      https://docs.oasis-open.org/niemopen/ns/model/domains/justice/6.0/
    </AugmentingNamespace>
  </HasProperty>  
</Class>
```
<center><i><a name="fig4-20"></a>Figure 4-20: AugmentingNamespace property in CMF</i></center><p/>

### 4.15.1 Augmentations in NIEM XSD

Augmentations are represented in NIEM XSD in four different ways, depending on the augmenting property and the augmented class:

* The augmenting property may be represented in XSD by an attribute or by an element.

* The augmented class may be represented in XSD by:

  * a type with child elements -- that is, a complex type with complex content (abbreviated "CCC type")
  
  * a type with an atomic value -- that is, a complex type with simple content (abbreviated "CSC type") 

The four combinations iare described in the following sections:

|     | Augmenting</br> Property | Augmenting</br> Property |
| --- | --- | ---------- | 
| **Augmented</br> Class** | *Element* | *Attribute* |
| *Type with child elements</br> (CCC type)* | [Section 4.15.2](#4152-augmenting-a-ccc-type-with-an-element) and</br> [Section 4.15.3](#4153-augmenting-a-ccc-type-with-an-augmentation-element-only) | [Section 4.15.4](#4154-augmenting-a-ccc-type-with-an-attribute) |
| *Type with an atomic value</br> (CSC type)* | [Section 4.15.5](#4155-augmenting-a-csc-type-with-an-attribute) | [Section 4.15.6](#4156-augmenting-simple-content-with-an-element) |
</br>

### 4.15.2 Augmenting a CCC type with an augmentation element and type

Every CCC type in a reference or extension schema document contains an [*augmentation point element*](#def), which provides a place for any augmentation properties.

```
<xs:complexType name="PersonType">
  <xs:annotation>
    <xs:documentation>A data type for a human being.</xs:documentation>
  </xs:annotation>
  <xs:complexContent>
    <xs:extension base="structures:ObjectType">
      <xs:sequence>
        <xs:element ref="nc:PersonBirthDate" minOccurs="0" maxOccurs="unbounded"/>
        <xs:element ref="nc:PersonName" minOccurs="0" maxOccurs="unbounded"/>
        <xs:element ref="nc:PersonAugmentationPoint" minOccurs="0" maxOccurs="unbounded"/>
      </xs:sequence>
    </xs:extension>
  </xs:complexContent>
</xs:complexType>
<xs:element name="PersonAugmentationPoint" abstract="true">
  <xs:annotation>
    <xs:documentation>An augmentation point for PersonType.<</xs:documentation>
  </xs:annotation>
</xs:element>
```
<center><i><a name="fig4-21"></a>Figure 4-21: An augmentation point element</i></center><p/>

An [augmentation point element](#def) is an abstract element declaration having the same name as its augmented base type, with the final "Type" replaced with "AugmentationPoint", and in the same namespace.

For example, `nc:PersonAugmentationPoint` is the augmentation point element for the augmentation base type `nc:PersonType`.

Because an augmentation point element is abstract, it cannot appear in messages - it is a placeholder for element substitution only.

The augmentation point element may be constrained in subset or message schema documents, or omitted if not needed in a particular message specification.

One way to augment a CCC type with an element is to define:

- An [augmentation type](#def) to contain the augmenting properties, and
- An [augmentation element](#def) having the augmentation type, and substitutable for the augmentation point element in the augmented type.

Figure 4-22 shows the XSD for a namespace augmenting `nc:PersonType` with two properties. (The corresponding CMF is shown in figures 4-19 and 4-20 above.)

```
<xs:complexType name="PersonAugmentationType">
  <xs:complexContent>
    <xs:extension base="structures:AugmentationType">
      <xs:sequence>
        <xs:element ref="j:PersonAdultIndicator" minOccurs="0" maxOccurs="unbounded"/>
        <xs:element ref="j:PersonForeignNationalIndicator" minOccurs="0" maxOccurs="unbounded"/>
      </xs:sequence>
    </xs:extension>
  </xs:complexContent>
</xs:complexType>
<xs:element name="PersonAugmentation" type="j:ExampleAugmentationType" substitutionGroup="nc:PersonAugmentationPoint"/>
```
<center><i><a name="fig4-22"></a>Figure 4-22: Augmenting a CCC type via an augmentation element and type</i></center><p/>

In an XML message, the augmentation element is only a container for the augmenting properties; it has no meaning of its own. Figure 4-23 shows a NIEM XML message with this augmentation.

```
<nc:Person>
  <nc:PersonFullName>Tommy Atkins</nc:PersonFullName>
  <j:PersonAugmentation>
    <j:PersonAdultIndicator>true</j:PersonAdultIndicator>
    <j:PersonForeignNationalIndicator>true</j:PersonForeignNationalIndicator>
  </j:PersonAugmentation>
</nc:Person>
```
<center><i><a name="fig4-23"></a>Figure 4-23: An XML message from a CCC type with an augmentation element</i></center><p/>

There is no need for the augmentation element in a NIEM JSON message. It does not appear in the equivalent JSON message, shown in figure 4-24 below.

```
{
  "nc:Person": {
    "nc:PersonFullName": "Tommy Atkins",
    "j:PersonAdultIndicator": true,
    "j:PersonForeignNationalIndicator": true
  }
}
```
<center><i><a name="fig4-24"></a>Figure 4-24: A JSON message from a CCC type with an augmentation element</i></center><p/>

### 4.15.3 Augmenting a CCC type with an ordinary element

Another way to augment a CCC type with an element is to substitute an ordinary element (that is, one that does not have an augmentation type) for the augmentation point. In this case there is no augmentation element in the XML message. Figure 4-25 shows the XSD from the augmenting namespace (`http://example.com/s4figs/`). It also shows the CMF for this augmentation. Figure 4-26 shows an XML message with this augmentation, and the equivalent JSON message.

```
<xs:element name="PersonFictionalIndicator" type="niem-xs:boolean"
    substitionGroup="nc:PersonAugmentationPoint">
  <xs:annotation>
    <xs:documentation>True if a person is a character in a work of fiction.</xs:documentation>
  </xs:annotation>
</xs:element>
----------------
<Namespace>
  <NamespaceURI>http://example.com/s4figs/</NamespaceURI>
  <NamespacePrefix>ex</NamespacePrefix>
  <DocumentationText>Example namespace for NDR6</DocumentationText>
  <AugmentationRecord>
    <Class structures:ref="nc.PersonType" xsi:nil="true"/>
    <DataProperty structures:ref="ex.PersonFictionalCharacterIndicator" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
  </AugmentationRecord>
</Namespace>
<Class>
  <Name>PersonType</Name>
  <Namespace structures:ref="nc" xsi:nil="true"/>
  <!-- documentation and other HasProperty objects omitted -->
  <HasProperty>
    <DataProperty structures:ref="j.PersonFictionalIndicator" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>unbounded</MaxOccursQuantity>
    <AugmentingNamespace>http://example.com/s4figs/</AugmentingNamespace>
  </HasProperty>
</Class>
<DataProperty>
  <Name>PersonFictionalIndicator</Name>
  <Namespace>ex</Namespace>
  <DocumentationText>True if a person is a character in a work of fiction.</DocumentationText>
  <Datatype structures:ref="xs:boolean" xsi:nil="true"/>
</DataProperty>
```
<center><i><a name="fig4-25"></a>Figure 4-25: Augmenting a CCC type by substituting an ordinary element</i></center><p/>

```
<nc:Person>
  <nc:PersonFullName>Peter Wimsey</nc:PersonFullName>
  <ex:PersonFictionalIndicator>true</ex:PersonFictionalIndicator>
</nc:Person>
---------------
{
  "nc:Person": {
    "nc:PersonFullName": "Peter Wimsey",
    "ex:PersonFictionalIndicator": true
  }
}
```
<center><i><a name="fig4-26"></a>Figure 4-26: Equivalent XML and JSON messages from a CCC type augmented by an ordinary element</i></center></p>

### 4.15.4 Augmenting a CCC type with an attribute

A CCC type is augmented with an attribute property by addding an `xs:attribute` element to the complex type definition. This must be done in a subset schema document for the augmented namespace (and not the reference or extension schema document). The `xs:attribute` element must include *appinfo* to specify the augmenting namespace. Figure 4-27 shows the XSD representation of `nc:PersonType` augmented with the attribute `ex:detectiveIndicator`, and the CMF for this augmentation. Figure 4-28 shows an XML message that includes this augmentation, and the equivalent JSON message.

```
<xs:complexType name="PersonType">
  <xs:annotation>
    <xs:documentation>A data type for a human being.</xs:documentation>
  </xs:annotation>
  <xs:complexContent>
    <xs:extension base="structures:ObjectType">
      <xs:sequence>
        <xs:element ref="nc:PersonBirthDate" minOccurs="0" maxOccurs="unbounded"/>
        <xs:element ref="nc:PersonName" minOccurs="0" maxOccurs="unbounded"/>
        <xs:element ref="nc:PersonAugmentationPoint" minOccurs="0" maxOccurs="unbounded"/>
      </xs:sequence>
      <xs:attribute ref="ex:detectiveIndicator 
          appinfo:augmentingNamespace="http://example.com/s4figs"/>
    </xs:extension>
  </xs:complexContent>
</xs:complexType>
----------------
<Class>
  <Name>PersonType</Name>
  <Namespace structures:ref="nc" xsi:nil="true"/>
  <!-- documentation and other HasProperty objects omitted -->
  <HasProperty>
    <DataProperty structures:ref="ex:detectiveIndicator" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>unbounded</MaxOccursQuantity>
    <AugmentingNamespace>http://example.com/s4figs/</AugmentingNamespace>
  </HasProperty>
</Class>
```
<center><i><a name="fig4-27"></a>Figure 4-27: Augmenting a CCC type with an attribute</i></center><p/>

```
<nc:Person>
  <nc:PersonFullName>Peter Wimsey</nc:PersonFullName>
  <ex:detectiveIndicator>true</ex:detectiveIndicator>
</nc:Person>
---------------
{
  "nc:Person": {
    "nc:PersonFullName": "Peter Wimsey",
    "ex:detectiveIndicator": true
  }
}
```
<center><i><a name="fig4-28"></a>Figure 4-28: Equivalent XML and JSON messages from a CCC type augmented with an attribute</i></center><p/>

### 4.15.5 Augmenting a CSC type with an attribute

A CSC type is also augmented with an attribute property by addding an `xs:attribute` to the complex type definition. This must be done in a subset schema document for the augmented namespace. The attribute reference must include *appinfo* to specify the augmenting namespace. Figure 4-29 shows the XSD representation of `nc:DirectionCodeType` augmented with the attribute `ex:magneticIndicator`, and the equivalent CMF.  Figure 4-30 shows part of an XML message that includes this augmentation, and the equivalent JSON message.

```
  <xs:complexType name="DirectionCodeType">
    <xs:annotation>
      <xs:documentation>A data type for compass directions.</xs:documentation>
    </xs:annotation>
    <xs:simpleContent>
      <xs:extension base="nc:DirectionCodeSimpleType">
        <xs:attribute ref="ex:magneticIndicator"
            appinfo:augmentingNamespace="http://example.com/s4figs/">
        <xs:attributeGroup ref="structures:SimpleObjectAttributeGroup"/>
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>
---------------
<Namespace>
  <NamespaceURI>http://example.com/s4figs/</NamespaceURI>
  <NamespacePrefix>ex</NamespacePrefix>
  <DocumentationText>Example namespace for NDR6</DocumentationText>
  <AugmentationRecord>
    <Class structures:ref="nc.DirectionCodeType" xsi:nil="true"/>
    <DataProperty structures:ref="ex.magneticIndicator" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
  </AugmentationRecord>
</Namespace>
<Class>
  <Name>DirectionCodeType</Name>
  <Namespace>nc</Namespace>
  <DocumentationText>A data type for compass directions.</DocumentationText>
  <HasProperty>
    <DataProperty structures:ref="nc:DirectionCodeLiteral" xsi:nil="true"/>
    <MinOccursQuantity>1</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
  </HasProperty>
  <HasProperty>
    <DataProperty structures:ref="ex:magneticIndicator">
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
    <AugmentingNamespace>http://example.com/s4figs/</AugmentingNamespace>
  </HasProperty>
</Class>
```
<center><i><a name="fig4-29"></a>Figure 4-29: Augmenting a CSC type with an attribute</i></center><p/>

```
<nc:RelativeLocationDirectionCode ex:magneticIndicator="true">E</nc:RelativeLocationDirectionCode>
---------------
{
  "nc:RelativeLocationDirectionCode": {
    "nc:DirectionCodeLiteral": "E",
    "ex:magneticIndicator": true
  }
}
```
<center><i><a name="fig4-30"></a>Figure 4-30: Equivalent XML and JSON messages from a CSC type augmented with an attribute</i></center><p/>

### 4.15.6 Augmenting a CSC type with an ordinary element

XML simple content cannot contain a child element. A CSC type is augmented with an element property by adding a *reference attribute* to the complex type definition. A reference attribute is a pointer to an element in a message. Figure 4-31 shows the XSD representation of `nc:DirectionCodeType` augmented with the element `nc:Metadata`, and the equivalent CMF.

```
  <xs:complexType name="DirectionCodeType">
    <xs:annotation>
      <xs:documentation>A data type for compass directions.</xs:documentation>
    </xs:annotation>
    <xs:simpleContent>
      <xs:extension base="nc:DirectionCodeSimpleType">
        <xs:attribute ref="nc:metadataRef"
            appinfo:augmentingNamespace="http://example.com/s4figs/">
        <xs:attributeGroup ref="structures:SimpleObjectAttributeGroup"/>
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>
  <xs:attribute name="metadataRef" type="xs:IDREFS">
    <xs:annotation>
      <xs:documentation>
        A list of metadata objects that apply to a node or object represented by an XML element.
      </xs:documentation>
    </xs:annotation>
  </xs:attribute>  
---------------
<Namespace>
  <NamespaceURI>http://example.com/s4figs/</NamespaceURI>
  <NamespacePrefix>ex</NamespacePrefix>
  <DocumentationText>Example namespace for NDR6</DocumentationText>
  <AugmentationRecord>
    <Class structures:ref="nc.DirectionCodeType" xsi:nil="true"/>
    <DataProperty structures:ref="nc:metadataRef" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
  </AugmentationRecord>
</Namespace>
<Class>
  <Name>DirectionCodeType</Name>
  <Namespace>nc</Namespace>
  <DocumentationText>A data type for compass directions.</DocumentationText>
  <HasProperty>
    <DataProperty structures:ref="nc:DirectionCodeLiteral" xsi:nil="true"/>
    <MinOccursQuantity>1</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
  </HasProperty>
  <HasProperty>
    <DataProperty structures:ref="nc:metadataRef">
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
    <AugmentingNamespace>http://example.com/s4figs/</AugmentingNamespace>
  </HasProperty>
</Class>
<DataProperty structures:id="nc.metadataRef">
  <Name>privacyAssertionRef</Name>
  <Namespace structures:ref="nc" xsi:nil="true"/>
  <DocumentationText>
    A list of metadata objects that apply to a node or object represented by an XML element.
  </DocumentationText>
  <Datatype structures:ref="xs.IDREFS" xsi:nil="true"/>
  <AttributeIndicator>true</AttributeIndicator>
</DataProperty>
```
<center><i><a name="fig4-31"></a>Figure 4-31: Augmenting a CSC type with an element</i></center><p/>

A property with a name ending in "Ref" is a reference attribute. It refers to an element in the same namespace with the same name, first letter in uppercase, and "Ref" deleted; for example, "nc:metadataRef" points to an "nc:Metadata" element. Figure 4-32 shows part of an XML message that includes the above augmentation, and the equivalent JSON message.

```
<nc:RelativeLocationDirectionCode nc:metadataRef="#MD01">E</nc:RelativeLocationDirectionCode>
<nc:Metadata structures:id="#MD01">
  <nc:Comment>Our best guess</nc:Comment>
</nc:Metadata>
---------------
{
  "nc:RelativeLocationDirectionCode": {
    "nc:DirectionCodeLiteral": "E",
    "nc:metadataRef": { "@id": "#MD01" }
  },
  "nc:Metadata": {
    "nc:Comment": "Our best guess"
  }
}
```
<center><i><a name="fig4-32"></a>Figure 4-32: Equivalent XML and JSON messages from a CSC type augmented with an attribute</i></center><p/>

### 4.15.7 Global element augmentations

### 4.15.8 Global attribute augmentations

## 4.16 LocalTerm class

A [*local term*](#def) is a word, phrase, acronym, or other string of characters that is used in the name of a namespace component, but that is not defined in [OED](), or that has a non-OED definition in this namespace, or has a word sense that is in some way unclear. A LocalTerm object captures the namespace author's definition of such a local term. For example, the Justice domain namespace in the NIEM model has a LocalTerm object defining the name "CLP" with documentation "Commercial Learners Permit".

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| LocalTerm | LocalTermType | A data type for the meaning of a term that may appear within the name of a model component. |
| name | TermName | The name of the local term. | 1 | - | xs:token |
| documentation | DocumentationText | A human-readable text definition of a data model component or term, or the documentation of a namespace. | 0..1 | - | TextType |
| literal | TermLiteralText | A meaning of a local term provided as a full, plain-text form. | 0..1 | - | xs:string |
| sourceURI | SourceURI | A URI that is an identifier or locator for an originating or authoritative document defining a local term. | 0..* | - | xs:anyURI |
| citation | SourceCitationText | A plain text citation of, reference to, or bibliographic entry for an originating or authoritative document defining a local term. | 0..* | - | xs:string |

A LocalTerm object is represented in XSD by a `appinfo:LocalTerm` element within `xs:appinfo` element in the `xs:schema` element. Figure 4-33 shows a LocalTerm object in XSD and the corresponding CMF.

```
<LocalTerm>
  <TermName>2D</TermName>
  <TermLiteralText>Two-dimensional</TermLiteralText>
</LocalTerm>
<LocalTerm>
  <TermName>3D</TermName>
  <DocumentationText>Three-dimensional</DocumentationText>
</LocalTerm>
<LocalTerm>
  <TermName>Test</TermName>
  <DocumentationText>only for test purposes</DocumentationText>
  <SourceURI>http://example.com/1 http://example.com/2</SourceURI>
  <SourceCitationText>citation #1</SourceCitationText>
  <SourceCitationText>citation #2</SourceCitationText>
</LocalTerm>
---------------
<xs:appinfo>
  <appinfo:LocalTerm term="2D" literal="Two-dimensional"/>
  <appinfo:LocalTerm term="3D" definition="Three-dimensional"/>
  <appinfo:LocalTerm term="Test" definition="only for test purposes" sourceURIs="http://example.com/1 http://example.com/2">
    <appinfo:SourceText>citation #1</appinfo:SourceText>
    <appinfo:SourceText>citation #2</appinfo:SourceText>
  </appinfo:LocalTerm>
</xs:appinfo>
```
<center><i><a name="fig4-33"></a>Figure 4-33: Example LocalTerm objects in CMF and XSD</i></center><p/>

The following table shows the mapping between LocalTerm object representations in CMF and XSD.

| CMF | XSD |
| --- | --- |
| TermName | `appinfo:LocalTerm/@term` |
| DocumentationText | `appinfo:LocalTerm/@definition` |
| TermLiteralText | `appinfo:LocalTerm/@literal` |
| SourceURI | Each URI in the `appinfo:LocalTerm/@sourceURIs` list |
| SourceCitationText | `appinfo:LocalTerm/appinfo:SourceText` |
</br>

## 4.17 TextType class

A TextType object combines a string property with a language property.

| UML | CMF | Definition | Card | Ord | Range |
| --- | --- | ---------- | :--: | :-: | ----- |
| TextType | TextType | A data type for a character string with a language code.||||
| literal | TextLiteral | A literal value of a character string. | 1 | - | xs:string |
| lang | lang | A name of the language of a character string. | 0..1 | - | xs:language |
</br>

-------

# 5. Data modeling patterns

> NOTE: I think the sections on container objects and representation terms belong here, along with any other modeling patterns we want to describe.  NDR 5 buries these things in section 10, "Rules for NIEM modeling", but I don't think that makes sense in the NDR 6 organization.  This might also be a good place to talk about metadata in NIEM 6.

-------

# 6. Conformance

NIEM defines *conformance* with the rules in this document. NIEM does not define *compliance*. The distinction is based on assessment authority: Anyone may assess conformance with rules; compliance is assessed by an authority who can compel change or withhold approval. The authoritative assessment in a compliance evaluation is out of scope for NIEMOpen.

This document defines conformance for models and messages. It does not define conformance for applications, systems, databases, or tools. It is therefore impossible for any of these to properly claim "NIEM conformance".  However, they *may* properly claim to generate conforming messages or to employ conforming models.

The rules in this document are designed to be used with or without the component definitions in the NIEM model.  These rules define conformance to the *NIEM architecture*.  Conformance to the *NIEM model* is a separate thing, and is not specified by this document.

## 6.1 Conformance targets

Each rule in this document applies to at least one [*conformance target*](#def). That term is defined by [[CTAS]](#ref), as follows:

> A conformance target is a class of artifact, such as an interface, protocol, document, platform, process or service, that is the subject of conformance clauses and normative statements. There may be several conformance targets defined within a specification, and these targets may be diverse so as to reflect different aspects of a specification. For example, a protocol message and a protocol engine may be different conformance targets.

Model representations and messages are the conformance targets defined in this document. Each conformance target has a URI, which may be used in a [*conformance target assertion*](#63-conformance-target-assertions). Each conformance target has a code, which is used to specify the applicability of rules in this document; for example, a rule with an applicability of `REF,EXT` applies to reference and extension schema documents. Each conformance target falls into one of four categories:

* An XML Schema document, the XSD representation of a single namespace. There are three targets in this category:
  * Reference schema document (`REF`)\
   `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ReferenceSchemaDocument`

  * Extension schema document (`EXT`)\
    `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ExtensionSchemaDocument`

  * Subset schema document (`SUB`)\
    `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#SubsetSchemaDocument`

* A schema document set (`SET`), the XSD representation of a complete model\
  `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#SchemaDocumentSet`

* A CMF model file (`CMF`), the representation of one or more namespaces, or of a complete model\
  `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#CMFModel`

* A message, in XML or JSON syntax
  * XML message (`XML`) -- `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#XMLMessage`
  * JSON message (`JSON`) -- `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#JSONMessage`

A model representation or message conforms to the NIEM architecture when it satisfies all rules applicable to all conformance targets:

* For XSD model representations, `REF`, `EXT`, `SUB`, and `SET` 
* For CMF model representations, `CMF`
* For messages, `XML` or `JSON` 

### 6.1.1 Reference schema document (REF)

A [reference schema document](#def) is the XSD representation of a [reference namespace](#def). (The equivalent CMF representation is a [reference namespace file](#def), described in [section 6.1.6](#616-cmf-model-cmf).)

The components in a reference namespace are intended for the widest possible reuse. They provide names and definitions for concepts, and relations among them. These namespaces are characterized by "optionality and over-inclusiveness". That is, they define more concepts than needed for any particular data exchange specification, without cardinality constraints, so it is easy to select the concepts that are needed and omit the rest. They also omit unnecessary range or length constraints on property datatypes. A reference namespace is intended to capture the meaning of its components. It is not intended for a complete definition of any particular message type or format. Message designers are expected to subset, profile, and extend the components in reference namespaces as needed to match their information exchange requirements.

The rules for a reference schema document amplify and constrain the use of XML Schema, for three reasons:

1. For reuse: To permit XML schema documents created by independent communities to be composed into a single data exchange specification, and to forbid schema constructs that limit such reuse.  The rules for this conformance target are intended to maximize reuse, at some expense to message designer and developer convenience. These rules are more stringent than the rules for other classes of NIEM-conformant schemas.

2. For semantics: To impose meaning on the definitions and declarations in a NIEM XML schema document, and on the elements and attributes in a NIEM XML message; and also to forbid those XSD constructs which do not have a useful NIEM interpretation.

3. For developer convenience: To forbid, where consistent with #1 and #2, constructs in XSD that cause difficulties with COTS XML tooling.

A reference schema document is authoritative for the components in its namespace. Once published, those components may not be removed or changed in meaning. There is only one reference schema document for a namespace. 

All of the components in the NIEM model are defined according to the rules in this conformance target; that is, within reference namespaces.  A data modeler defining an extension to the NIEM model (or an alternative to the NIEM model) may also choose to follow these rules, in order to maximize reusability.

### 6.1.2 Extension schema document (EXT)

An [extension schema document](#def) is the XSD representation of an [extension namespace](#def). (The equivalent CMF representation is an [extension namespace file](#def); see [section 6.1.6](#616-cmf-model-cmf).)

The components in an extension namespace are intended for reuse within a more narrow scope than those defined in a reference namespace. These components express the additional vocabulary required for an information exchange, above and beyond the vocabulary available from the NIEM model.  The intended scope is often a particular message specification. Sometimes a community or organization will define an extension namespace for components to be reused in several related message specifications. Message designers are  also encouraged to subset, profile, and extend the components in extension namespaces created by another author.

Several rules applicable to reference schema documents are relaxed for extension schema documents in order to provide more designer and developer convenience at the expense of some reusability.

The representation of an extension namespace is authoritative for its components. Once published, those components may not be removed or changed in meaning. There is only one extension schema document for an extension namespace.

### 6.1.3 Subset schema document (SUB)

A [subset schema document](#def) is the XSD representation of a [namespace subset](#def). (The equivalent CMF representation is a [subset namespace file](#def); see [section 6.1.6](#616-cmf-model-cmf).)

A [namespace subset](#def) is a subset of the components defined by the reference or extension namespace with the same URI. It provides components for reuse, while enabling message designers and developers to:

* Omit optional components in a reference or extension namespace that they do not need.

* Provide cardinality and datatype constraints that precisely define the content of one or more message types. (Those constraints are typically omitted from reference and extension namespaces to provide more opportunity for reuse.) 

* [Augment](#4154) a reference or extension namespace with an [attribute property](#def).

All message content that is valid for a subset namespace must also be valid for the reference or extension namespace with the same URI.  Widening the value space of a component is not allowed. With the exception of attribute augmentations, adding components is not allowed. Changing the documentation of a component is not allowed.

A subset schema document is the XSD representation of a subset namespace. Several rules applicable to reference and extension schema documents are relaxed for subset schema documents in order to provide more designer and developer convenience at the expense of some reusability. 

There may be any number of subset schema documents for a subset namespace. 

### 6.1.4 XML schema document (XSD)

The rules in this conformance target apply to the XSD representation of a reference, extension, or subset schema document. Effectively it is a shorthand for (REF,EXT,SUB).

### 6.1.5 Schema document set (SET)

The documents in a [schema document set](#def) are capable of validating an XML document; that is, they can be assembled into a complete schema according to the rules of [[XML Schema]](#ref). The rules in this conformance target are tests for conditions that cannot be evaluated on the basis of a single schema document, but instead apply to the document set as a whole.

### 6.1.6 CMF model (CMF)

A [CMF model](#def) is a NIEM-based message conforming to the CMF message specification. It may represent any of:

* A single reference namespace. This is a [reference namespace file](#def), a unit of configuration management equivalent to a reference schema document. There can be only one reference namespace file for a reference namespace.

* A single extension namespace. This is an [extension namespace file](#def), a unit of configuration management equivalent to an extension schema document. There can be only one extension namespace file for an extension namespace.

* A single namespace subset. This is a [subset namespace file](#def), equivalent to a subset schema document. There can be any number of subset namespace files for a subset namespace.

* A collection of reference, extension, and/or subset namespaces. This is a [model file](#def). A model file that contains a definition of every referenced component is a [complete model](#def), and is equivalent to a [schema document set](#def).

### 6.1.7 XML message (XML)

### 6.1.8 JSON message (JSON)

> NOTE:  Formerly I believed we needed a conformance target for message schema documents and message namespaces. Don't think so now.

## 6.2 Conformance target assertions

It is often helpful for an artifact to contain an assertion of the kind of thing it is supposed to be. These assertions can inform both people and tools. The *Conformance Targets Attribute Specification* [[CTAS]](#ref) defines an attribute that, when it appears in an XML document, asserts the document conforms to one or more conformance targets. 

For XSD, NIEMOpen makes use of [[CTAS]](#ref) to indicate whether a [schema document](#def) is intended to represent a reference, extension, or subset namespace. For example, a [reference schema document](#def) contains the conformance target assertion shown in figure 5-1 below:

```
<xs:schema
  targetNamespace="https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/"
  xmlns:ct="https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/"
  xmlns:nc="https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/"
  ct:conformanceTargets="https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ReferenceSchemaDocument"
  version="1"
  xml:lang="en-US">
```
<center><i><a name="fig5-1"></a>Figure 5-1: Conformance target assertion in XSD</i></center><p/>

In CMF, the `ConformanceTargetURI` property indicates whether a Namespace object represents a reference, extension, or subset namespace. For example, the Namespace object equivalent to the namespace in figure 5-1 is shown below:

```
<Namespace structures:id="nc">
  <NamespaceURI>https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/</NamespaceURI>
  <NamespacePrefixText>nc</NamespacePrefixText>
  <DocumentationText>NIEM Core.</DocumentationText>
  <ConformanceTargetURI>
    https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ReferenceSchemaDocument
  </ConformanceTargetURI>
  <NIEMVersionText>6</NIEMVersionText>
  <NamespaceVersionText>1</NamespaceVersionText>
  <NamespaceLanguageName>en-US</NamespaceLanguageName>
</Namespace>
```
<center><i><a name="fig5-2"></a>Figure 5-2: Conformance target in CMF</i></center><p/>

## 6.3 Rules

Some content of this document is [normative](#def), while other content is [informative](#def). In general, the informative material appears as supporting text, description, and rationales for the normative material. Rules are normative. In this document, rules appear as follows:

> <b>Rule</b> <i>section <b>-</b> number</i> <b>(</b><i>applicability</i><b>) (</b><i>classification</i><b>)</b>

* *section* and *number*: For example, the first rule in section 6 is numbered 6-1.

* *classification*: The kind of rule; one of:

  * **Constraint**: A [constraint rule](#def) is a requirement on an artifact with respect to its conformance to a conformance target.

  * **Interpretation**: An [interpretation rule](#def) defines a methodology, pattern, or procedure for understanding some aspect of an instance of a conformance target.
  
* *applicability*: Identifies the conformance targets to which the rule applies. These conformance targets are described in [section 6.2](#62) below.

For example, **Rule 8-1 (XSD)(Constraint):** The document MUST be an XML Schema document.

Many rules in this document apply to more than one conformance target. For this reason, rules are organized by purpose, as follows:

* [*Section 7: Rules for names of components*](#7-rules-for-names-of-components). Consistency in names improves human understanding. Most of these rules are adopted from [ISO 11179](#ref).

* [*Section 8: Rules for data definitions*](#8-rules-for-documentation). Human understanding ultimately rests on natural language documentation for data components. These rules are also largely borrowed from [ISO 11179](#ref).

* [*Section 9: Rules for namespaces*](#9-rules-for-namespaces). Requirements for namespace representations in both CMF and XSD.

* [*Section 10: Rules for models*](#10-rules-for-complete-models). Rules concerning completeness of models and conformance of all model parts.

* [*Section 11: Rules for XSD*](#11-rules-for-niem-xsd). NIEM employes a profile of XSD. Many legal XSD constructs are not permitted in NIEM. Most rules fall into this category.

* [*Rules for messages*](). A NIEM message must be valid according to its message format. These rules apply to all messages, regardless of format.

The following table shows the correlation between a categories of rules category and conformance targets:

| Purpose             | CMF | REF | EXT | SUB | SET | XML | JSON |
| :------             | :-: | :-: | :-: | :-: | :-: | :-: | :--: |
| Names of components |  X  |  X  |  X  |  X  |  -  |  -  |  -   |
| Data definitions    |  X  |  X  |  X  |  X  |  -  |  -  |  -   |
| Namespaces          |  X  |  X  |  X  |  X  |  -  |  -  |  -   |
| Models              |  X  |  -  |  -  |  -  |  X  |  -  |  -   |
| XSD                 |  -  |  X  |  X  |  X  |  -  |  -  |  -   |
| Messages            |  -  |  -  |  -  |  -  |  -  |  X  |  X   |

</br>

## 6.4 Testing conformance

Namespaces, models, and messages may be tested for conformance by applying the rules in this document.  Messages may also be tested for conformance to their message format in the following ways:

1. *XML message, XSD model:* Perform XML Schema validation.
2. *XML message, CMF model:* Generate XSD from CMF, perform XML Schema validation.
3. *JSON message, CMF model:* Generate JSON Schema from CMF, perform JSON Schema validation
4. *JSON message, XSD model:* Convert the XSD model to CMF, generate JSON Schema from CMF, perform JSON Schema validation

NIEMOpen provides free and open-source tools to support #2, #3, and #4. These can be found at [ref tools](#ref).

-------

# 7. Rules for names of components

Data component names must be understood easily both by humans and by machine processes. These rules improve name consistency by restricting characters, terms, and syntax that could otherwise allow too much variety and potential ambiguity. These rules also improve readability of names for humans, facilitate parsing of individual terms that compose names, and support various automated tasks associated with dictionary and controlled vocabulary maintenance.

These rules apply to all namespaces. In a CMF representation, they apply to the Name property of a Component object. In an XSD representation, they apply to the `{}name` attribute of a complex type definition, element declaration, or attribute declaration.

## 7.1 Rules based on kind of component

**Rule 7-1 (CMF,XSD)(Constraint):** Name of Class, Datatype, and Property components || Class and Datatype components MUST have a name ending in "Type"; Property components MUST NOT. (N5R 11-1,11-2)

This rule immediately distinguishes Property components from Class and Datatype components. In an XSD representation, it also avoids naming collisions between type definitions and element/attribute declarations.

**Rule 7-2 (CMF)(Constraint):** No augmentation components in CMF || A Property MUST NOT have a name ending in "Augmentation", "AugmentationPoint", or "AugmentationType". (NEW)

Augmentation components appear only in the XSD representation of a model.

### 7.1.1 Rules for names of Class components

**Rule 7-3 (CMF,XSD)(Constraint):** Name of adapter classes || An [adapter class](#def) MUST have a name ending in "AdapterType"; all other components MUST NOT. (NEW)

**Rule 7-4 (CMF,XSD)(Constraint):** Name of association classes || An [association class](#def) MUST have a name ending in "AssociationType"; all other components MUST NOT. (N5R 10-21)

**Rule 7-5 (CMF,XSD)(Constraint):** Name of code list atomic classes || An [atomic class](#def) with a [literal property](#def) that has a [code list datatype](#def) MUST have a name ending in "CodeType"; all other Class components MUST NOT. (N5R 10-17,10-18)

These rules immediately distinguish special Class components from ordinary. [Rule 7-5](#rule-7-5) handles an unusual case in XSD. A code list in XSD is represented as a complex type with simple content. This usually corresponds to a Datatype component; however, when that complex type definition includes attribute properties, then it corresponds to a Class component.

### 7.1.2 Rules for names of Datatype components

**Rule 7-6 (CMF,XSD)(Constraint):** Names ending in "SimpleType" || A component with a name ending in "SimpleType" MUST be a Datatype. (NEW)

A Datatype with a name ending in "SimpleType" is sometimes needed for a [literal property](#def), or for a member type in a Union component.

**Rule 7-7 (CMF,XSD)(Constraint):** Names ending in "CodeSimpleType" || A Datatype object with a name that ends in "CodeSimpleType" MUST be a [code list datatype](#def). (N5R 11-8,11-9)

**Rule 7-8 (CMF,XSD)(Constraint):** Name of code list datatypes || A [code list datatype](#def) MUST have a name ending in "CodeType" or "CodeSimpleType"; all other Datatype components MUST NOT. (N5R 10-17,10-18)

The component representing a [code list](#def) is usually a Datatype.  However, when the XSD represenation of a code list includes attributes, it is a Class.

### 7.1.3 Rules for names of Property components

**Rule 7-9 (CMF,XSD)(Constraint):** Name of abstract properties || A Property object having an `isAbstract` property with the value `true` SHOULD have a name ending in "Abstract" or "Representation"; all other components SHOULD NOT. (N5R 10-42,11-14)

 A property name ending in "Abstract" reminds message designers that it cannot be used directly but must be specialized. A property name ending in "Representation" is an instance of the [representation pattern](#def), described in [section 5](#5-data-modeling-patterns).

**Rule 7-10 (CMF,XSD)(Constraint):** Name of association properties || A Property with an [association class](#def) MUST have a name ending in "Association"; all other components MUST NOT. (N5R 10-22)

**Rule 7-11 (CMF,XSD)(Constraint):** Name of code properties || A Property with a Class or Datatype that represents a [code list](#def) MUST have a name ending in "Code"; all other components MUST NOT. (N5R 10-19,11-10)

**Rule 7-12 (CMF)(Constraint):** Name of literal properties in CMF || The [literal property](#def) of an [atomic class](#def) MUST have a name ending in "Literal"; all other components MUST NOT. (NEW)

Component names ending in "Literal" only occur in the CMF representation of an [atomic class](#def).

**Rule 7-13 (CMF,XSD)(Constraint):** Name of representation attributes || A Property that is a [reference attribute](#def) property MUST have a name ending in "Ref"; all other components MUST NOT. (NEW)

### 7.1.4 Rules for names of XSD components

Certain components that appear in the XSD representation of a model do not have an equivalent component in the metamodel or CMF. This section describes the naming rules for these XSD components.

**Rule 7-14 (XSD)(Constraint):** Name of augmentation types || The XSD definition of an [augmentation type](#def) MUST have a name ending in "AugmentationType"; all other XSD components MUST NOT. (N5R 10-33,10-34)

**Rule 7-15 (XSD)(Constraint):** Name of augmentation elements || The XSD declaration of an [augmentation element](#def) MUST have a name ending in "Augmentation"; all other XSD components MUST NOT. (N5R 10-36)

**Rule 7-16 (XSD)(Constraint):** Name of augmentation point elements || The XSD declaration of an [augmentation point element](#def) MUST have a name ending in "AugmentationPoint"; all other XSD components MUST NOT. (NEW)

**Rule 7-17 (XSD)(Constraint):** No literal properties in XSD || The name of an element declaration or attribute declaration MUST NOT end in "Literal". (NEW)

Literal properties appear only in the CMF representation of an [atomic class])(#def).

**Rule 7-18 (XSD)(Constraint):** Name of type definitions || A type definition that does not define a [*proxy type*](#def) MUST have a name ending in "Type"; all other XSD components MUST NOT. (N5R 11-2)

Use of the representation term Type immediately identifies XML types in a NIEM-conformant schema and prevents naming collisions with corresponding XML elements and attributes. The exception for proxy types ensures that simple NIEM-compatible uses of base XML Schema types are familiar to people with XML Schema experience.

**Rule 7-19 (XSD)(Constraint):** Name of simple type definitions || A simple type definition MUST have a name ending in "SimpleType"; all other XSD components MUST NOT. (N5R 11-4)

Specific uses of type definitions have similar syntax but very different effects on data definitions. Schemas that clearly identify complex and simple type definitions are easier to understand without tool support. This rule ensures that names of simple types end in "SimpleType".

**Rule 7-20 (XSD)(Constraint):** Name of complex type definition || A complex type definition MUST be a Class component, a Datatype component, or a [proxy type](#def). (NEW)

**Rule 7-21 (XSD)(Constraint):** Proxy types || The XSD declaration of a [proxy type](#def) MUST have the same name as the simple type it extends. (N5R 10-20)

A [proxy type](#def) is an XSD complex type definition with simple content that extends one of the simple types in the XML Schema namespace with `structures:SimpleObjectAttributeGroup`; for example:

```
<xs:complexType name="string">
  <xs:simpleContent>
    <xs:extension base="xs:string">
      <xs:attributeGroup ref="structures:SimpleObjectAttributeGroup"/>
    </xs:extension>
  </xs:simpleContent>
</xs:complexType>
```

Proxy types are intended to make XSD model representations more understandable to people that are familiar with the names of the XML Schema namespace simple types.

## 7.2 Rules for composition of all component names

**Rule 7-22 (REF)(Constraint):** Component name composed of English words || Except as otherwise provided in this document, the name of a model component MUST be composed of words from the English language, using the prevalent U.S. spelling, as provided by the Oxford English Dictionary [[OED]](#ref). (N5R 10-44)

The English language has many spelling variations for the same word. For example, American English program has a corresponding British spelling programme. This variation has the potential to cause interoperability problems when XML components are exchanged because of the different names used by the same elements. Providing users with a dictionary standard for spelling will mitigate this potential interoperability issue.

NIEM supports internationalization in several ways, described in [[I18N]](#ref-i18n). NIEM allows (but does not encourage) component names that are not from the English language in extension schema documents.

**Rule 7-23 (CMF,XSD)(Constraint):** Component names have only specific characters || The name of a model component MUST be entirely composed of specified  characters. (N5R 10-46)

* Upper-case letters (A–Z)
* Lower-case letters (a–z)
* Digits (0–9)
* Underscore (_)
* Hyphen (-)
* Period (.)

Other characters, such as unicode characters outside the ASCII character set, are explicitly prohibited from the name of an XML Schema component defined by the schema.

**Rule 7-24 (CMF,XSD)(Constraint):** Component names use camel case || The name of a model component MUST use the camel case formatting convention. (N5R 10-48)

Camel case is the convention of writing compound words or phrases with no spaces and an initial lowercase or uppercase letter, with each remaining word element beginning with an uppercase letter. *UpperCamelCase* is written with an initial uppercase letter, and *lowerCamelCase* is written with an initial lowercase letter.

**Rule 7-25 (CMF,XSD)(Constraint):** Name of attribute properties begin with lower case letter || The name of an attribute property MUST begin with a lowercase character. (N5R 10-49)

**Rule 7-26 (CMF,XSD)(Constraint):** Name of components other than attribute properties begin with upper case letter || The name of a model component that is not an attribute property MUST begin with an uppercase character. (N5R 10-50)

**Rule 7-27 (CMF,XSD)(Constraint):** Punctuation in component name is a separator || The characters hyphen (-), underscore (_) MUST NOT appear in a component name unless used as a separator between parts of a word, phrase, or value, which would otherwise be incomprehensible without the use of a separator. The character period (.) MUST NOT appear in a component name unless as a decimal within a numeric value, or unless used as a separator between parts of a word, phrase, or value, which would otherwise be incomprehensible without the use of a separator. (N5R 10-47)

Names of standards and specifications, in particular, tend to consist of series of discrete numbers. Such names require some explicit separator to keep the values from running together.

## 7.3 General rules from ISO 11179-5

Names are a simple but incomplete means of providing semantics to data components. Data definitions, structure, and context help to fill the gap left by the limitations of naming. The goals for data component names should be syntactic consistency, semantic precision, and simplicity. In many cases, these goals conflict and it is sometimes necessary to compromise or to allow exceptions to ensure clarity and understanding. To the extent possible, NIEM applies [[ISO 11179-5]](#ref) to construct NIEM data component names.

**Rule 7-28 (CMF,XSD)(Constraint):** Singular form is preferred in name || A noun used as a term in the name of an XML Schema component MUST be in singular form unless the concept itself is plural. (N5R 10-54)

**Rule 7-29 (CMF,XSD)(Constraint):** Present tense is preferred in name || A verb used as a term in the name of an XML Schema component MUST be used in the present tense unless the concept itself is past tense. (N5R 10-55)

**Rule 7-30 (CMF,XSD)(Constraint):** Name does not have nonessential words || Articles, conjunctions, and prepositions MUST NOT be used in NIEM component names except where they are required for clarity or by standard convention. (N5R 10-56)

Articles (e.g., a, an, the), conjunctions (e.g., and, or, but), and prepositions (e.g., at, by, for, from, in, of, to) are all disallowed in NIEM component names, unless they are required. For example, PowerOfAttorneyCode requires the preposition. These rules constrain slight variations in word forms and types to improve consistency and reduce potentially ambiguous or confusing component names.

## 7.4 Property name rules from ISO 11179-5

The set of NIEM data components is a collection of data representations for real-world objects and concepts, along with their associated properties and relationships. Thus, names for these components would consist of the terms (words) for object classes or that describe object classes, their characteristic properties, subparts, and relationships.

**Rule 7-31 (CMF,XSD)(Constraint):** Property name follows ISO 11179-5 pattern || Except as specified elsewhere in this document, the name of a property object MUST be formed by the composition of object class qualifier terms, object class term, property qualifier terms, property term, representation qualifier terms, and representation term, as detailed in Annex A of [[ISO 11179-5]](#ref). (N5R 7-5,10-57)

For example, the NIEM component name `AircraftFuselageColorCode` is composed of the following:

* Object class term = Aircraft
* Qualifier term = Fuselage
* Property term = Color
* Representation term = Code

### 7.4.1 Object-class term

**Rule 7-32 (CMF,XSD)(Constraint):** Object-class term identifies concrete category || The object-class term of a NIEM component MUST consist of a term identifying a category of concepts or entities. (N5R 10-58)

NIEM adopts an object-oriented approach to representation of data. Object classes represent what [ISO 11179-5](#ref) refers to as things of interest in a universe of discourse that may be found in a model of that universe. An object class or object term is a word that represents a class of real-world entities or concepts. An object-class term describes the applicable context for a NIEM component.

The object-class term indicates the object category that this data component describes or represents. This term provides valuable context and narrows the scope of the component to an actual class of things or concepts.  An example of a conept term is Activity.  An example of an entity term is Vehicle.

### 7.4.2 Property term

**Rule 7-33 (CMF,XSD)(Constraint):** Property term describes characteristic or subpart || A property term MUST describe or represent a characteristic or subpart of an entity or concept. (N5R 10-59)

Objects or concepts are usually described in terms of their characteristic properties, data attributes, or constituent subparts. Most objects can be described by several characteristics. Therefore, a property term in the name of a data component represents a characteristic or subpart of an object class and generally describes the essence of that data component.  It describes the central meaning of the component.

### 7.4.3 Qualifer terms

**Rule 7-34 (CMF,XSD)(Constraint):** Name may have multiple qualifier terms || Multiple qualifier terms MAY be used within a component name as necessary to ensure clarity and uniqueness within its namespace and usage context. (N5R 10-60)

**Rule 7-35 (CMF,XSD)(Constraint):** Name avoids unnecessary qualifier terms || The number of qualifier terms SHOULD be limited to the absolute minimum required to make the component name unique and understandable. (N5R 10-61)

**Rule 7-36 (CMF,XSD)(Constraint):** Order of qualifiers is not significant || The order of qualifiers MUST NOT be used to differentiate components. (N5R 10-62)

Very large vocabularies may have many similar and closely related properties and concepts. The use of object, property, and representation terms alone is often not sufficient to construct meaningful names that can uniquely distinguish such components. Qualifier terms provide additional context to resolve these subtleties. However, swapping the order of qualifiers rarely (if ever) changes meaning; qualifier ordering is no substitute for meaningful terms.

### 7.4.4 Representation term

The representation terms for a property name serve several purposes in NIEM:

1. It can indicate the style of component. For example, types are clearly labeled with the representation term Type.

2. It helps prevent name conflicts and confusion. For example, elements and types may not be given the same name.

3. It indicates the nature of the value carried by element. Labeling elements and attributes with a notional indicator of the content eases discovery and comprehension.

The valid value set of a data element or value domain is described by the representation term. NIEM uses a standard set of representation terms in the representation portion of a NIEM-conformant component name. Table 6-1, Property representation terms, below, lists the primary representation terms and a definition for the concept associated with the use of that term. The table also lists secondary representation terms that may represent more specific uses of the concept associated with the primary representation term.

| Primary</br>Representation</br>Term |Secondary</br>Representation</br>Term | Definition | 
| --- | --- | ---------- |
| Amount | - | A number of monetary units specified in a currency where the unit of currency is explicit or implied. |
| BinaryObject | -| A set of finite-length sequences of binary octets. |
| | Graphic	| A diagram, graph, mathematical curves, or similar representation |
| | Picture	| A visual representation of a person, object, or scene | 
| | Sound	| A representation for audio |
| | Video	| A motion picture representation; may include audio encoded within |
|Code	| | 	A character string (i.e., letters, figures, and symbols) that for brevity, language independence, or precision represents a definitive value of an attribute. |
| DateTime | |	A particular point in the progression of time together with relevant supplementary information. |
| | Date	| A continuous or recurring period of time, of a duration greater than or equal to a day. |
| | Time	| A particular point in the progression of time within an unspecified 24-hour day.| 
| | Duration	| An amount of time; the length of a time span. |
| ID	| |	A character string to identify and distinguish uniquely one instance of an object in an identification scheme from all other objects in the same scheme together with relevant supplementary information. |
| | URI	| A string of characters used to identify (or name) a resource. The main purpose of this identifier is to enable interaction with representations of the resource over a network, typically the World Wide Web, using specific protocols. A URI is either a Uniform Resource Locator (URL) or a Uniform Resource Name (URN). The specific syntax for each is defined by [[RFC 3986]](#ref). |
| Indicator | | A list of two mutually exclusive Boolean values that express the only possible states of a property. |
| Measure	| | 	A numeric value determined by measuring an object along with the specified unit of measure. |
| Numeric	| | 	Numeric information that is assigned or is determined by calculation, counting, or sequencing. It does not require a unit of quantity or unit of measure. |
| | Value	| A result of a calculation. |
| | Rate	| A relative speed of change or progress. |
| | Percent	| A representation of a unitless ratio, expressed as parts of a hundred, with 100 percent representing a ratio of 1 to 1. |
| Quantity	| | 	A counted number of non-monetary units possibly including fractions. |
| Text | -	| A character string (i.e., a finite sequence of characters) generally in the form of words of a language. |
| | Name	| A word or phrase that constitutes the distinctive designation of a person, place, thing, or concept. |
| List | | 		A sequence of values. This representation term is used in tandem with another of the listed representation terms.| 
| Abstract	| | 	An element that may represent a concept, rather than a concrete property. This representation term may be used in tandem with another of the listed representation terms. |
| Representation	| | 	An element that acts as a placeholder for alternative representations of the value of a type (see Section 5, The Representation pattern, above).  **TBD**|

<center><i><a name="tab6-1"></a>Table 6-1: Property representation terms</i></center><p/>

**Rule 7-37 (CMF,XSD)(Constraint):** Redundant term in name is omitted || If any word in the representation term is redundant with any word in the property term, one occurrence SHOULD be deleted. (N5R 10-63)

This rule, carried over from 11179, is designed to prevent repeating terms unnecessarily within component names. For example, this rule allows designers to avoid naming an element PersonFirstNameName.

**Rule 7-38 (CMF,XSD)(Constraint):** Data property uses representation term || The name of a data property SHOULD use an appropriate representation term as found in table 6-1, Property representation terms. (N5R 10-64, 11-15, 11-16, 11-19)

**Rule 7-39 (CMF,XSD)(Constraint):** Object property uses representation term when appropriate || The name of an object property that corresponds to a concept listed in table 6-1, Property representation terms, SHOULD use a representation term from that table. (N5R 10-65)

**Rule 7-40 (CMF,XSD)(Constraint):** Object property uses representation term only when appropriate || The name of an object property that does not correspond to a concept listed in table 6-1, Property representation terms SHOULD NOT use a representation term. (N5R 10-66)

## 7.5 Acronyms, abbreviations, and jargon

**Rule 7-41 (CMF,XSD)(Constraint):** Names use common abbreviations || A component name SHOULD use the abbreviations shown in the table below. (N5R 10-51)

| Abbreviation | Full Meaning |
| --- | --- |
| ID | Identifier |
| URI | Uniform Resource Identifier |

A [LocalTerm object](#416-localterm-class) introduces an acronym, abbreviation, or jargon term into the namespace to which it belongs. These terms may be used within the name of a model component (in addition to terms defined within [[OED]](#ref)). These terms may also be used within the documetation of a model component.

**Rule 7-42 (CMF,XSD)(Constraint):** Local term has literal or definition || In CMF, a LocalTerm object MUST have a DocumentationText property, or a TermLiteralText property, or both. In XSD, a LocalTerm element MUST have a `@definition` attribute, or a `@literal` attribute, or both. (N5R 10-77)

**Rule 7-43 (CMF,XSD)(Interpretation):** Local term declaration applies only to its namespace || A local term object establishes the meaning of a local term only within the namespace to which it belongs. There MUST NOT be any transitive inheritance of local terminology within schema documents that import the containing schema document. (N5R 10-52)

**Rule 7-44 (XSD)(Constraint):** LocalTerm appinfo applies to schema || The element `appinfo:LocalTerm` MUST be application information on an element `xs:schema`. (N5R 10-76)

-------

# 8. Rules for documentation

NIEM models are composed of data components for the purpose of information exchange. A major part of defining data models is the proper definition of the contents of the model. What does a component mean, and what might it contain? How should it be used?

Reference and extension namespaces provide the authoritative definition of the components they contain.  These definitions include:

1. The structural definition of each component, expressed in CMF objects or XSD schema components.  Where possible, meaning is expressed in this way.

2. A text definition of each component, describing what the component means.  The term used in this specification for such a text definition is *data definition*.

A [data definition](#def) is the DocumentText property of a CMF object, or the content of the first occurrence of the element xs:documentation that is an immediate child of an occurrence of an element xs:annotation that is an immediate child of an XSD schema component.

A [documented component](#def) is a CMF object or XSD schema component that has an associated data definition.

## 8.1 Rules for documented components

**Rule 8-1 (CMF,XSD)(Constraint):** Namespace has data definition || In CMF, a Namespace object MUST be a documented component. In XSD, the `xs:schema` element MUST be a documented component. (N5R 9-82)

**Rule 8-2 (CMF,XSD)(Constraint):** Model component has data definition || In CMF, a Component object MUST be a documented component.  In XSD, a type definition, element declaration, and attribute declaration MUST be a documented component (N5R 9-12,9-26,9-37,9-49)

**Rule 8-3 (CMF,XSD)(Constraint):** Facet has data definition || In CMF, a `Facet` object MUST be a documented component. In XSD, an enumeration facet MUST be a documented component. (N5R 9-14)

**Rule 8-4 (CMF,SUB)(Constraint):** Subset does not alter data definition || The data definition of a component, if it exists, MUST NOT be different than the data definition of the component in its reference or extension namespace. (NEW)

A subset namespace must not change the text definition of the components it selects from its reference or extension namespace.

**Rule 8-5 (CMF,XSD)(Constraint):** Documentation is provided in US English || The language name for the first instance of the *documentation* property in any Namespace or Component object MUST be `en-US`. Subsequent instances, if provided, MUST have a different language name.(NEW)

A model file or schema document always contains data definitions in US English. It may contain equivalent data definitions in other languages.

## 8.2 Rules for data definitions

**Rule 8-6 (CMF,XSD)(Constraint):**  Data definition does not introduce ambiguity || Words or synonyms for the words within a data definition MUST NOT be reused as terms in the corresponding component name if those words dilute the semantics and understanding of, or impart ambiguity to, the entity or concept that the component represents. (N5R 11-24)

**Rule 8-7 (CMF,XSD)(Constraint):** Object class has only one meaning || An object class MUST have one and only one associated semantic meaning (i.e., a single word sense) as described in the definition of the component that represents that object class. (N5R 11-25)

**Rule 8-8 (CMF,XSD)(Constraint):** Data definition of a part does not redefine the whole || An object class MUST NOT be redefined within the definitions of the components that represent properties or subparts of that entity or class. (N5R 11-26)

Data definitions should be concise, precise, and unambiguous without embedding additional definitions of data elements that have already been defined once elsewhere (such as object classes). [ISO 11179-4] says that definitions should not be nested inside other definitions. Furthermore, a data dictionary is not a language dictionary. It is acceptable to reuse terms (object class, property term, and qualifier terms) from a component name within its corresponding definition to enhance clarity, as long as the requirements and recommendations of [ISO 11179-4] are not violated. This further enhances brevity and precision.

**Rule 8-9 (CMF,XSD)(Constraint):** Do not leak representation into data definition || A data definition SHOULD NOT contain explicit representational or data typing information such as number of characters, classes of characters, range of mathematical values, etc., unless the very nature of the component can be described only by such information. (N5R 11-27)

A component definition is intended to describe semantic meaning only, not representation or structure. How a component with simple content is represented is indicated through the representation term, but the primary source of representational information should come from the XML Schema definition of the types themselves. A developer should try to keep a component’s data definition decoupled from its representation.

## 8.3 Rules from ISO 11179-4

These rules are adopted from [[ISO 11179-4]](#ref), *Information technology — Metadata
registries: Formulation of data definitions*

**Rule 8-10 (CMF,XSD)(Constraint):** Data definition follows 11179-4 requirements || Each data definition MUST conform to the requirements for data definitions provided by [ISO 11179-4] Section 5.2, *Requirements*; namely, a data definition MUST: (N5R 11-28)

* be stated in the singular
* state what the concept is, not only what it is not
* be stated as a descriptive phrase or sentence(s)
* contain only commonly understood abbreviations
* be expressed without embedding definitions of other data or underlying concepts

**Rule 8-11 (CMF,XSD)(Constraint):** Data definition follows 11179-4 recommendations || Each data definition SHOULD conform to the recommendations for data definitions provided by [ISO 11179-4] Section 5.2, *Recommendations*; namely, a data definition SHOULD: (N5R 11-29)

* state the essential meaning of the concept
* be precise and unambiguous
* be concise
* be able to stand alone
* be expressed without embedding rationale, functional usage, or procedural information
* avoid circular reasoning
* use the same terminology and consistent logical structure for related definitions
* be appropriate for the type of metadata item being defined

## 8.4 Data definition opening phrases

In order to provide a more consistent voice across NIEM, a model built from requirements from many different sources, component data definitions should begin with a standard opening phrase, as defined below.

### 8.4.1 Opening phrases for properties

These rules apply to Property objects in CMF, and to element and attribute declarations in XSD.

**Rule 8-12 (CMF,XSD)(Constraint):** Standard opening phrase for abstract property data definition || The data definition for an abstract property SHOULD begin with the standard opening phrase "A data concept...". (N5R 11-35)

**Rule 8-13 (CMF,XSD)(Constraint):** Standard opening phrase for association property data definition || The data definition for a property that has an association type and is not abstract SHOULD begin with the standard opening phrase "An (optional adjectives) (relationship|association)...". (N5R 11-34)

**Rule 8-14 (CMF,XSD)(Constraint):** Standard opening phrase for date property data definition || The data definition for a property with a date representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) (date|month|year)...". (N5R 11-36)

**Rule 8-15 (CMF,XSD)(Constraint):** Standard opening phrase for quantity property data definition || The data definition for a property with a quantity representation term SHOULD begin with the standard opening phrase "An (optional adjectives) (count|number)...". (N5R 11-37)

**Rule 8-16 (CMF,XSD)(Constraint):** Standard opening phrase for picture property data definition || The data definition for a property with a picture representation term SHOULD begin with the standard opening phrase "An (optional adjectives) (image|picture|photograph)". (N5R 11-38)

**Rule 8-17 (CMF,XSD)(Constraint):** Standard opening phrase for indicator property data definition || The data definition for a property with an indicator representation term SHOULD begin with the standard opening phrase "True if ...; false (otherwise|if)...". (N5R 11-39)

**Rule 8-18 (CMF,XSD)(Constraint):** Standard opening phrase for identification property data definition || The data definition for a property with an identification representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) identification...". (N5R 11-40)

**Rule 8-19 (CMF,XSD)(Constraint):** Standard opening phrase for name property data definition || The data definition for a property with a name representation term SHOULD begin with the standard opening phrase "(A|An) (optional adjectives) name...". (N5R 11-41)

**Rule 8-20 (CMF,XSD)(Constraint):** Standard opening phrase for property data definition || The data definition for a property SHOULD begin with the standard opening phrase "(A|An)". (N5R 11-42)

### 8.4.2 Opening phrases for classes

These rules apply to Class objects in CMF, and to complex type definitions in XSD.

**Rule 8-21 (CMF,XSD)(Constraint):** Standard opening phrase for association class data definition || The data definition for an association class SHOULD begin with the standard opening phrase "A data type for (a relationship|an association)...". (N5R 11-43)

**Rule 8-22 (CMF,XSD)(Constraint):** Standard opening phrase for class data definition || The data definition for a class SHOULD begin with the standard opening phrase "A data type..." (N5R 11-46, 11-47)

### 8.4.3 Opening phrases for XSD definitions and declarations

**Rule 8-23 (XSD)(Constraint):** Standard opening phrase for augmentation point element data definition || The data definition for an augmentation point element SHOULD begin with standard opening phrase "An augmentation point...". (N5R 11-31)

**Rule 8-24 (XSD)(Constraint):** Standard opening phrase for augmentation element data definition || The data definition for an augmentation element SHOULD begin with the standard opening phrase "Supplements..." or "Additional information about...". (N5R 11-32)

**Rule 8-25 (XSD)(Constraint):** Standard opening phrase for augmentation type data definition || The data definition for an augmentation type SHOULD begin with the standard opening phrase "A data type (that supplements|for additional information about)...". (N5R 11-44) 

-------

# 9. Rules for namespaces

The components in a namespace have equivalent representations in CMF and XSD. This section contains the rules applicable to both representations.

## 9.1 Rules for mandatory namespace properties

**Rule 9-1 (CMF)(Constraint):** Namespace identifier is absolute URI || The value of the `NamespaceURI` property in a Namespace object MUST match the production `<absolute-URI>` as defined by [[RFC 3986]](#ref). (N5R 9-84)

**Rule 9-2 (XSD)(Constraint):** Namespace identifier is absolute URI || The `<xs:schema>` element MUST have the attribute `{}targetNamespace`, which MUST match the production `<absoluteURI>` as defined by [[RFC 3986]](#ref). (N5R 9-83, 9-84)

**Rule 9-3 (CMF)(Constraint):** Namespace has a prefix || The value of the `NamespacePrefix` property in a Namespace object MUST match the production *NCName* as defined by [[XML Namespaces]](#ref). (NEW)

**Rule 9-4 (XSD)(Constraint):** Namespace has a prefix || The `<xs:schema>` element MUST declare a namespace binding with a prefix for the target namespace URI. (NEW)

**Rule 9-5 (CMF)(Constraint):** Namespace has version || The value of the `NamespaceVersionText` property in a Namespace object MUST NOT be empty. (N5R 9-85)

**Rule 9-6 (XSD)(Constraint):** Namespace has version || The `xs:schema` element MUST have an attribute `{}version`, which MUST NOT be empty. (N5R 9-85)

**Rule 9-7 (CMF)(Constraint):** Namespace has language || The value of the `NamespaceLanguageName` property in a Namespace object MUST be a well-formed language tag, as defined by [[RFC 4646]](#ref). (N5R 10-45, 11-30)

**Rule 9-8 (XSD)(Constraint):** Namespace has language || The `xs:schema` element MUST have an attribute `xml:lang`, with a value that MUST be a a well-formed language tag, as defined by [[RFC 4646]](#ref). (N5R 10-45, 11-30)

## 9.2 Rules for namespace conformance targets

**Rule 9-9 (XSD)(Constraint):** Schema is CTAS-conformant || The schema document MUST be a conformant document as defined by the [[NIEM Conformance Targets Attribute Specification]](#ref). (N5R 4-3)

**Rule 9-10 (XSD)(Constraint):** Document element has attribute `ct:conformanceTargets` || The [document element](#def) of the XML document, and only the [document element](#def), MUST own an attribute `{https://docs.oasis-open.org/niemopen/ns/specification/conformanceTargets/6.0/}conformanceTargets`. (N5R 4-4)

**Rule 9-11 (CMF)(Constraint):** Reference namespace has proper conformance target || A Namespace object representing a [reference namespace](#def) MUST have a `ConformanceTargetURI` property with the value `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ReferenceSchemaDocument`. (N5R 4-5)

**Rule 9-12 (REF)(Constraint):** Reference namespace has proper conformance target || The `<xs:schema>` element in a [reference schema document](#def) MUST have the attribute `ct:conformanceTargets` with a value that includes the value `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ReferenceSchemaDocument`. (N5R 4-5)

**Rule 9-13 (CMF)(Constraint):** Extension namespace has proper conformance target || A Namespace object representing an [extension namespace](#def) MUST have a `ConformanceTargetURI` property with the value `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ExtensionSchemaDocument`. (N5R 4-6)

**Rule 9-14 (EXT)(Constraint):** Extension namespace has proper conformance target || The `<xs:schema>` element in an [extension schema document](#def) MUST have the attribute `ct:conformanceTargets` with a value that includes the value `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ExtensionSchemaDocument`. (N5R 4-6)

**Rule 9-15 (CMF)(Constraint):** Subset namespace has proper conformance target || A Namespace object representing an [namespace subset](#def) MUST have a `ConformanceTargetURI` property with the value `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#SubsetSchemaDocument`. (NEW)

**Rule 9-16 (SUB)(Constraint):** Subset namespace has proper conformance target || The `<xs:schema>` element in a [subset schema document](#def) MUST have the attribute `ct:conformanceTargets` with a value that includes the value `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#SubsetSchemaDocument`. (NEW)

## 9.3 Rules for components in a namespace

**Rule 9-17 (CMF)(Constraint):** Reference namespace does not have wildcard || In CMF, yada yada yada TBD. (N5R 9-70, 9-71)

**Rule 9-18 (REF)(Constraint):** Reference namespace does not have wildcard || The schema document MUST NOT contain the element `xs:any` or `xs:anyAttribute`. (N5R 9-70, 9-71)

Wildcards are permitted in extension namespaces, but not in reference namespaces.

**Rule 9-19 (CMF,REF)(Constraint):** Reference namespace uses reference namespace components || A component that is used in a reference namespace MUST be defined in a reference namespace. (N5R 11-50)

**Rule 9-20 (CMF,EXT)(Constraint):** Extension namespace uses reference or extension namespace components || A component that is used in a reference namespace MUST be defined in a reference namespace or an extension namespace. (N5R 11-51)

**Rule 9-21 (CMF,XSD)(Constraint):** Property occurs only once in a Class || A Property MUST NOT be introduced more than once into a Class definition. (N5R 11-20)

This applies to content acquired by a class by any means: in CMF, through inheritance and subproperties, in XSD, through base types and element substitution groups. This rule is intended to avoid difficulties in integrating XSD representations.  It is also intended to prevent developers from creating complicated sequences of recurring elements. If an element is needed more than once, or if a particular sequence of elements is needed, a developer should consider the use of flexible content models (via substitution groups) along with additional rules.

**Rule 9-22 (CMF)(Constraint):** Object properties in reference and extension namespace are referencable || An ObjectProperty object in a reference namespace or extension namespace MUST NOT have a ReferenceCode property of `ID`, `URI`, or `NONE`. (NEW) 

**Rule 9-23 (REF,EXT)(Constraint):** Object properties in reference and extension namespace are referencable || An element declaration MUST NOT have an `@appinfo:referenceCode` property of `ID`, `URI`, or `NONE`. (NEW)

To promote reuse, object properties defined in reference and extension namespaces are always referencable. In a namespace subset, message designers may specify that some properties must be referenced by IDREF, or by URI, or must appear inline.

## 9.4 Rules for namespace subsets

**Rule 9-24 (CMF,SUB)(Constraint):** Subset has corresponding reference or extension namespace || A namespace subset MUST have a corresponding reference or extension namespace. (NEW)

**Rule 9-25 (SUB)(Constraint):** Subset does not extend component range || A subset namespace MUST NOT extend the valid range of a component in the corresponding reference or extension namespace. (NEW)

**Rule 9-26 (SUB)(Constraint):** Subset does not add components || With the exception of an augmentation property, a subset namespace MUST NOT contain a component not found in the corresponding reference or extension namespace. (NEW)

**Rule 9-27 (CMF)(Constraint):** Augmentations declare augmenting namespace || In the CMF representation of a subset schema, a HasProperty object for an attribute or element augmentation MUST have an AugmentingNamespace property containing the URI of the augmenting namespace. (NEW)

**Rule 9-28 (SUB)(Constraint):** Augmentations declare augmenting namespace || In the XSD representation of a subset schema, the element reference for an attribute augmentation must have the attribute `appinfo:augmentingNamespace` containing the URI of the augmenting namespace. (NEW)

-------

# 10. Rules for complete models

A complete model must have a definition for every component that is referenced. There must be no conficts among the namespaces in the model. This section contains the rules applicable to both a CMF model file and a XSD schema document set.


-------

# 11. Rules for NIEM XSD

This section contains rules that apply only to the XSD representation of NIEM models.  (Equivalent rules are not required for CMF, because the cardinalities and datatypes in the CMF format have the same effect.)

## 11.1 Rules for the NIEM profile of XSD

The W3C XML Schema Language provides many features that allow a developer to represent a data model many different ways. A number of XML Schema constructs are not used within NIEM-conformant schemas. Many of these constructs provide capability that is not currently needed within NIEM. Some of these constructs create problems for interoperability, with tool support, or with clarity or precision of data model definition. The rules in this section establish a profile of XML Schema for NIEM-conformant schemas by forbidding use of the problematic constructs.

Note that external schema documents (i.e., non-NIEM-conformant schema documents) do not need to obey the rules set forth in this section. So long as schema components from external schema documents are adapted for use with NIEM according to the modeling rules in Section 9.2.5, External adapter types and external components, below, they may be used as they appear in the external standard, even if the schema components themselves violate the rules for NIEM-conformant schemas.

**Rule 11-1 (XSD)(Constraint):** Document is a schema document || The XSD representation of a namespace must be a [schema document](#def), as defined in [[XML Schema Structures]](). (N5R 7-1,7-2,7-3)

**Rule 11-2 (XSD)(Constraint):** Document element is `xs:schema` || The [document element](#def) of the XSD representation of a namespace must be `xs:schema`. (N5R 7-4)

> NOTE: Do we still need this rule?  Isn't it part of 9-1?

**Rule 11-3 (XSD)(Constraint):** Prohibited schema components || A schema document MUST NOT contain any of the following elements:(N5R 9-59,9-61,9-72,9-73,9-74,9-75,9-76,9-88,9-89)

* `xs:notation`
* `xs:all`
* `xs:unique`
* `xs:key`
* `xs:keyref`
* `xs:group`
* `xs:attributeGroup`
* `xs:redefine`
* `xs:include`

**Rule 11-4 (XSD)(Constraint):** Prohibited base types || A schema component MUST NOT have an attribute `{}base` with a value of any of these types:  (N5R 9-1,9-2,9-3,9-4,9-5,9-6,9-7,9-8,9-9)
- `xs:ID`
- 'xs:IDREF`
- `xs:IDREFS`
- `xs:anyType`
- `xs:anySimpleType`
- `xs:NOTATION`
- `xs:ENTITY`
- `xs:ENTITES`
- any type in the XML namespace `http://www.w3.org/XML/1998/namespace`

**Rule 11-5 (XSD)(Constraint):** Prohibited list item types || A schema component MUST NOT have an attribute `{}itemType` with any of the following values: (N5R 9-15,9-16,9-17,9-18)

* `xs:ID`
* `xs:IDREF`
* `xs:anySimpleType`
* `xs:ENTITY`

**Rule 11-6 (XSD)(Constraint):** Prohibited union item types || A schema component MUST NOT have an attribute `{}memberTypes` with any of the following values: (N5R 9-19,9-20,9-21,9-22,9-23,9-24)

* `xs:ID`
* `xs:IDREF`
* `xs:IDREFS`
* `xs:anySimpleType`
* `xs:ENTITY`
* `xs:ENTITIES`

**Rule 11-7 (XSD)(Constrant):** Prohibited attribute types || A schema component MUST NOT have an attribute `{}type` with any of the following types: (N5R 9-51,9-52,9-53,9-54,9-55,9-56)

* `xs:ID`
* `xs:IDREF`
* `xs:IDREFS`
* `xs:anySimpleType`
* `xs:ENTITY`
* `xs:ENTITIES`

**Rule 11-8 (XSD)(Constraint):** No mixed content on complex type or complex content || A complex type definition MUST NOT have mixed content. (N5R 9-27,9-28)

Mixed content allows the mixing of data tags with text. Languages such as XHTML use this syntax for markup of text. NIEM-conformant schemas define XML that is for data exchange, not text markup. Mixed content creates complexity in processing, defining, and constraining content. Well-defined markup languages exist outside NIEM and may be used with NIEM data, and so [*external schema documents*](#def) may include mixed content and may be used with NIEM. 

**Rule 11-9 (XSD)(Constraint):** Complex type content is explicitly simple or complex || A complex type definition MUST have a `xs:complexContent` or a `xs:simpleContent` child element (N5R 9-29)

XML Schema provides shorthand to defining complex content of a complex type, which is to define the complex type with immediate children that specify elements, or other groups, and attributes. In the desire to normalize schema representation of types and to be explicit, NIEM forbids the use of that shorthand.

**Rule 11-10 (XSD,SET)(Constraint):** Base type of complex type with complex content must have complex content || The base type of a complex type with complex content MUST have complex content. (N5R 9-31,9-32)

This rule addresses a peculiarity of the XML Schema definition language, which allows a complex type to be constructed using xs:complexContent, and yet is derived from a complex type that uses xs:simpleContent. These rules ensure that each type has the content style indicated by the schema.

**Rule 11-11 (XSD)(Constraint):** Untyped element is abstract || An untyped elememt or an element of type `xs:anySimpleType` MUST be abstract. (N5R 9-38,9-39)

Untyped element declarations act as wildcards that may carry arbitrary data. By declaring such types abstract, NIEM allows the creation of type independent semantics without allowing arbitrary content to appear in XML instances.

**Rule 11-12 (XSD)(Constraint):** Element type not in the XML or XML Schema namespace || An element type MUST NOT be in the XML Schema namespace or the XML namespace. (N5R 9-40,9-41)

**Rule 11-13 (XSD)(Constraint):** Element type is not simple type ||  An element type that is not `xs:anySimpleType` MUST NOT be a simple type. (NSR 9-42)

**Rule 11-14 (XSD)(Constraint):** Attribute declaration has type || An attribute declaration MUST have a type. (N5R 9-50)

**Rule 11-15 (XSD)(Constraint):** No default or fixed value || An element declaration MUST NOT have an attribute {}default or {}fixed. (N5R 9-45,9-46,9-57,9-58)

**Rule 11-16 (XSD)(Constraint):** Sequence has minimum and maximun cardinality 1 || An element `xs:sequence` MUST have a `minOccurs` and `maxOccurs` of 1. (N5R 9-66,9-67)

**Rule 11-17 (XSD)(Constraint):** `xs:choice` must be child of `xs:sequence` || An element `xs:choice` MUST be a child of `xs:sequence`. (N5R 9-65)

**Rule 11-18 (XSD)(Constraint):** Choice has minimum and maximum cardinality 1 || An element `xs:choice` MUST have a `minOccurs` and `maxOccurs` of 1. (N5R 9-68,9-69)

**Rule 11-19 (XSD)(Constraint):** Comment is not recommended || An XML comment SHOULD NOT appear in the schema. (N5R 9-77)

Since XML comments are not associated with any specific XML Schema construct, there is no standard way to interpret comments. XML Schema annotations should be preferred for meaningful information about components. NIEM specifically defines how information should be encapsulated in NIEM-conformant schemas via xs:annotation elements. Comments do not correspond to any metamodel object.

**Rule 11-20 (XSD)(Constraint):** Documentation element has no element children || A child of element `xs:documentation` MUST be text or an XML comment. (N5R 9-78)

> NOTE: move the next 3 rules to an appinfo section

**Rule 11-21 (XSD)(Constraint):** `xs:appinfo` children are comments, elements, or whitespace || A child of element `xs:appinfo` MUST be an element, a comment, or whitespace text. (N5R 9-79)

**Rule 11-22 (XSD)(Constraint):** Appinfo child elements have namespaces || An element that is a child of `xs:appinfo` MUST have a namespace name. (N5R 9-80)

**Rule 11-23 (XSD)(Constraint):** Appinfo descendants are not XML Schema elements || An element that is a descendent of `xs:appinfo` MUST NOT have the XML Schema namespace. (N5R 9-81)

## 11.2 Rules for type definitions

**Rule 11-24 (REF)(Constraint):** `xs:sequence` must be child of `xs:extension` || An element `xs:sequence` MUST be a child of `xs:extension`. (N5R 9-62)

**Rule 11-25 (EXT,SUB)(Constraint):** `xs:sequence` must be child of `xs:extension` or `xs:restriction` || An element `xs:sequence` MUST be a child of `xs:extension` or `xs:restriction`. (N5R 9-63)

Restriction is allowed in an extension schema document, but not in reference schema document.

**Rule 11-26 (XSD)(Constraint):** Type definition is top-level || A type definition MUST be top-level. (N5R 9-10,9-25)

All XML Schema top-level types (children of the document element) are required by XML Schema to be named. By requiring these components to be top level, they are forced to be named and are globally reusable.  This rule does not apply to message schema documents, which are not intended for reuse.

**Rule 11-27 (XSD)(Constraint):** Complex type has a category || A complex type definition must be an object type, an association type, an adapter type, or an augmentation type. (N5R 10-1)

The rules in this document use the name of a type as the key indicator of the type’s category. This makes the rules much simpler than doing a deep examination of each type (and its base types) to identify its category. For complex types, the names follow a pattern:

* Name ends with AdapterType → type represents an [adapter class](#def). (see [Rule 7-3](#rule-7-3))
* Name ends with AssociationType → type represents an [association class](#def). (see [Rule 7-4](#rule-7-4))
* Name ends with AugmentationType → type is an [augmentation type](#def).
* Otherwise → type is the XSD representation of an [object class](#def).

**Rule 11-28 (XSD)(Constraint):** Object type with complex content is derived from `structures:ObjectType` || A type with complex content that does not represent an [adapter class](#def), an [association class](#def), or an [augmentation type](#def) MUST be derived from structures:ObjectType or from another object type. (N5R 10-2)

**Rule 11-29 (XSD)(Constraint):** Adapter type derived from `structures:AdapterType` || A type definition that represents an [adapter class](#def) MUST be derived from `structures:AdapterType`. (NEW)

**Rule 11-30 (XSD)(Constraint):** Association type derived from `structures:AssociationType` || A type definition that represents an [association class](#def) MUST be derinved from `structures:AssociationType`. (N5R 10-21)

**Rule 11-31 (XSD)(Constraint):** Augmentation type derived from `structures:AugmentationType` || A type definition that is an [augmentation type](#def) MUST be derived from `structures:AugmentationType`. (N5R 10-35)

**Rule 11-32 (XSD)(Constraint):** Complex type with simple content has `structures:SimpleObjectAttributeGroup` || A complex type definition with simple content MUST include `structures:SimpleObjectAttributeGroup`. (N5R 11-11)

**Rule 11-33 (XSD)(Constraint):** Base type definition defined by conformant schema || The base type definition of a type definition MUST have the target namespace or the XML Schema namespace or a conforming namespace that is imported. (N5R 11-3)

**Rule 11-34 (XSD)(Constraint):** Component reference defined by conformant schema || An attribute or element reference MUST have the target namespace or a namespace that is imported as conformant. (N5R 11-21,11-22)

**Rule 11-35 (XSD)(Constraint):** Schema uses only known attribute groups || An attribute group reference MUST be `structures:SimpleObjectAttributeGroup`. (N5R 11-23)

In conformant schemas, use of attribute groups is restricted. The only attribute group defined by NIEM for use in conformant schemas is structures:SimpleObjectAttributeGroup. This attribute group provides the attributes necessary for identifiers and references.

**Rule 11-36 (XSD)(Constraint):** Augmentation elements are not used directly || A complex type definition MUST NOT have an element use of an augmentation element declaration, or an element declaration that is in the substitition group of an augmentation point element declaration. (N5R 10-37)

Augmentation elements do not correspond to a model component, and must not be used as a property in any class.

**Rule 11-37 (XSD)(Constraint):** List item type defined by conformant schemas || The item type of a list simple type definition MUST have a target namespace equal to the target namespace of the XML Schema document within which it is defined, or a namespace that is imported as conformant by the schema document within which it is defined. (N5R 11-6)

**Rule 11-38 (XSD)(Constraint):** Union member types defined by conformant schemas || Every member type of a union simple type definition MUST have a target namespace that is equal to either the target namespace of the XML Schema document within which it is defined or a namespace that is imported as conformant by the schema document within which it is defined. (N5R 11-7)

## 11.3 Rules for attribute and element declarations

**Rule 11-39 (XSD)(Constraint):** Declarations are top-level || An attribute declaration or element declaration MUST be top-level. (N5R 9-36,9-48)

**Rule 11-40 (XSD)(Constraint):** Element type is not simple type || An element declaration MUST NOT have a simple type. (N5R 9-42,11-12)

**Rule 11-41 (XSD)(Constraint):** Attribute and element type is from conformant namespace || The type definition of an attribute or element declaration MUST have a target namespace that is the target namespace, or a conforming namespace that is imported. (N5R 11-13,11-18)

**Rule 11-42 (XSD)(Constraint):** Element substitution group defined by conformant schema || An element substitution group MUST have either the target namespace or a namespace that is imported as conformant. (N5R 11-17)

**Rule 11-43 (REF,EXT)(Constraint):** Element declaration is nillable || An element declaration MUST have the `{nillable}` property with a value of true. (N5R 9-47)

Properties in a reference or extension namespace are always referencable, in order to maximize reuse.  Message designers may make some properties un-referencable in a namespace subset. (See also [Rule 9-23](#rule-9-23).)

## 11.4 Rules for adapters and external components

**Rule 11-44 (XSD)(Constraint):** Import of external schema document is labeled || An `xs:import` element importing an external schema document MUST own the attribute `appinfo:externalImportIndicator` with a value of `true`. (NEW)

An [external schema document](#def) is any schema document that is not 

* a [reference schema document](#def), or
* an [extension schema document](#def), or
* a [subset schema document](#def), or
* a schema document that has the structures namespace as its target namespace.

There are a variety of commonly used standards that are represented in XML Schema. Such schemas are generally not NIEM-conformant. NIEM-conformant schemas may reference components defined by these external schema documents.

A schema component defined by an external schema document may be called an external component. A NIEM-conformant type may use external components in its definition. There are two ways to integrate external components into a NIEM-conformant schema:

* An [adapter class](#def) may be constructed from externally-defined elements and attributes. A goal of this method is to represent, as a single unit, a set of data that embodies a single concept from an external standard.

* A type that is not an external adapter type, and which is defined by an extension, subset, or message schema document, may incorporate externally-defined attribute

**Rule 11-45 (XSD)(Constraint):** Import of external namespace has data definition || An `xs:import` element importing an external schema document MUST be a documented component. (N5R 10-7)

A NIEM-conformant schema has well-known documentation points. Therefore, a schema that imports a NIEM-conformant namespace need not provide additional documentation for the imported namespace. However, when an external schema document is imported, appropriate documentation must be provided on the xs:import element. This ensures that documentation for all external schema documents will be both available and accessible in a consistent manner.

**Rule 11-46 (XSD)(Constraint):** Name of adapter type || A type definition MUST have a name ending in "AdapterType" if and only if it is an adapter type. (N5R 10-8)

An external adapter type is a NIEM-conformant type that adapts external components for use within NIEM. An external adapter type creates a new class of object that embodies a single concept composed of external components. A NIEM-conformant schema defines an external adapter type.

An external adapter type should contain the information from an external standard to express a complete concept. This expression should be composed of content entirely from an external schema document. Most likely, the external schema document will be based on an external standard with its own legacy support.

In the case of an external expression that is in the form of model groups, attribute groups, or types, additional elements and type components may be created in an external schema document, and the external adapter type may use those components.

In normal (conformant) type definition, a reference to an attribute or element is a reference to a documented component. Within an external adapter type, the references to the attributes and elements being adapted are references to undocumented components. These components must be documented to provide comprehensibility and interoperability. Since documentation made available by nonconformant schemas is undefined and variable, documentation of these components is required at their point of use, within the conformant schema.

**Rule 11-47 (XSD)(Constraint):** Structure of external adapter type definition follows pattern || An external adapter type definition MUST be a complex type definition with complex content that extends structures:ObjectType, and that uses xs:sequence as its top-level compositor. (N5R 10-9)

**Rule 11-48 (XSD)(Constraint):** AElement use from external adapter type defined by external schema documents || n element reference that appears within an external adapter type MUST have a target namespace that is imported as external. (N5R 10-10)

**Rule 11-49 (XSD)(Constraint):** External adapter type not a base type || An external adapter type definition MUST NOT be a base type definition. (N5R 10-11, 10-12)

**Rule 11-50 (REF,EXT)(Constraint):** External attribute use has data definition || An external attribute use MUST be a documented component with a non-empty data definition. (N5R 10-14)

**Rule 11-51 (XSD)(Constraint):** External attribute use not an ID || An attribute use schema component MUST NOT have an {attribute declaration} with an ID type. (N5R 10-15)

NIEM schemas use structures:id to enable references between components. Each NIEM-defined complex type in a reference or extension schema document must incorporate a definition for structures:id. [XML] Section 3.3.1, Attribute Types entails that a complex type may have no more than one ID attribute. This means that an external attribute use must not be an ID attribute.

The term "attribute use schema component" is defined by [[XML Schema Structures]](#ref) Section 3.5.1, The Attribute Use Schema Component. Attribute type ID is defined by[[XML]](#ref) Section 3.3.1, Attribute Types.

**Rule 11-52 (REF,EXT)(Constraint):** External element use has data definition || An external attribute use MUST be a documented component with a non-empty data definition. (N5R 10-16)

## 11.5 Rules for proxy types

**Rule 11-53 (XSD)(Constraint):** Proxy type has designated structure || A proxy type MUST have the designated structure. It MUST use `xs:extension`. It MUST NOT use `xs:attribute`. It MUST include exactly one `xs:attributeGroup` reference, which must be to `structures:SimpleObjectAttributeGroup`. (N5R 10-20)

A [proxy type](#def) is not a model component. It is a convenience complex type definition wrapper for a simple type in the XML Schema namespace; for example, `niem-xs:token` is a proxy type for `xs:token`.  Unlike other complex type definitions, proxy types have the same local name as the builtin simple type. This is done to make conformant schemas more understandable to people that are familiar with the names of the XML Schema namespace simple types.

## 11.6 Rules for augmentations

**Rule 11-54 (XSD)(Constraint):** Augmentable type has one augmentation point element || The type definition for an [augmentable class](#def) MUST contain exactly one element use of its corresponding augmentation point element. (N5R 10-23,10-24)

The augmentation point element for an augmentable type has the name created by replacing the final "Type" in the augmentable type name with "AugmentationPoint". For example, the augmentation point element for `nc:PersonType` is `nc:PersonAugmentationPoint`.

**Rule 11-55 (XSD)(Constraint):** Augmentation point element corresponds to its base type || A schema document containing an element declaration for an [augmentation point element](#def) MUST also contain a type definition for its augmented base type. (N5R 10-25)

For example, a schema document with an element declaration for `FooAugmentationPoint` must also contain a type definition for `FooType`.

**Rule 11-56 (XSD)(Constraint):** An augmentation point element has no type || An augmentation point element MUST have no type. (N5R 10-26)

**Rule 11-57 (XSD)(Constraint):** An augmentation point element has no substitution group || An augmentation point element MUST have no substitution group. (N5R 10-27)

**Rule 11-58 (XSD)(Constraint):** Augmentation point element is only referenced by its base type || An augmentation point element MUST only be referenced by its base type. (N5R 10-28)

For example, the `FooAugmentationPoint` element must not be included in any type other than `FooType`.

**Rule 11-59 (XSD)(Constraint):** Augmentation point element use is optional and unbounded || An augmentation point element particle MUST have attribute minOccurs equal to 0 and attribute maxOccurs set to unbounded. (N5R 10-29,10-30)

**Rule 11-60 (XSD)(Constraint):** Augmentation point element use must be last element in its base type || An augmentation point element particle MUST be the last element occurrence in the content model of its augmentable type. (N5R 10-31)

## 11.7 Rules for the appinfo namespace

NIEM defines a single namespace that holds components for use in NIEM-conformant schema application information. This namespace is referred to as the [appinfo namespace](#def).

**Rule 11-61 (XSD)(Constraint):** Component marked as deprecated is deprecated component || A schema component that has an attribute appinfo:deprecated with a value of true MUST be a deprecated component. (N5R 10-68)

**Rule 11-62 (XSD)(Constraint):** Appinfo attribute annotates schema component || An attribute in the [appinfo namespace](#def) MUST be owned by an element with a namespace name `http://www.w3.org/2001/XMLSchema` . (N5R 10-69)

**Rule 11-63 (XSD)(Constrant):** External import indicator annotates import || The attribute `appinfo:externalImportIndicator` MUST be owned by an element `xs:import`. (N5R 10-70)

**Rule 11-64 (XSD)(Constraint):** appinfo:LocalTerm annotates schema || The element `appinfo:LocalTerm` MUST be application information on an element `xs:schema`. (N5R 10-76)

## 11.8 Rules for reference schema documents

**Rule 11-65 (REF)(Constraint):** No simple type disallowed derivation || An element `xs:simpleType` MUST NOT have an attribute {}final. (N5R 9-11)

**Rule 11-66 (REF)(Constraint):** No use of fixed on simple type facets || A simple type constraining facet MUST NOT have an attribute {}fixed. (N5R 9-13)

**Rule 11-67 (REF)(Constraint):** Complex content uses extension || An element `xs:complexContent` MUST have a child `xs:extension`. (N5R 9-30)

NIEM does not support the use of complex type restriction in reference schemas. The use of restriction in a reference schema would reduce the ability for that schema to be reused. Restriction may be used in extension schemas.

**Rule 11-68 (REF)(Constraint):** Simple content uses extension || A complex type definition with simple content MUST have a derivation method of extension. (N5R 9-33)

This rule ensures that the definition of a complex type with simple content will use XML Schema extension. Under this rule, the structure of these types will be more uniform, as alternate formats are prohibited. The  use of xs:restriction is allowed in extension schemas.

**Rule 11-69 (REF)(Constraint):** No disallowed substitutions or derivation || A schema component MUST NOT have an attribute `{}block`, `{}blockDefault`, `{}final`, or `{}finalDefault`. (N5R 9-34,9-35,9-43,9-44,9-86,9-87)

**Rule 11-70 (REF)(Constraint):** No `xs:choice` || The schema MUST NOT contain the element `xs:choice`. (N5R 9-64)

**Rule 11-71 (REF)(Constraint):** External attribute use only in external adapter type || An external attribute use MUST be in an external adapter type. (N5R 10-13)

A complex type that is defined by a reference schema document is permitted to contain an attribute use schema component only if it is an external adapter type. This does not apply to a complex type defined by an extension schema document, which is permitted to use external attributes, as long as each attribute use is a documented component.

## 11.9 Rules for schema assembly

**Rule 11-72 (SET)(Constraint):** Namespace prefix is unique || There MUST be a one-to-one match between namespace prefix and namespace URI among all schema documents in the XSD representation of a model. (NEW)

XML Schema permits a schema document set to contain

* schema document A containing `xmlns:foo="http://example.com/MyFoo/"`
* schema document B containing `xmlns:bar="http://example.com/MyFoo/"`
* schema document C containing `xmlns:foo="http://example.com/MyBar/"`

This is not allowed in NIEM XSD, because there is always a one-to-one match between namespace prefix and URI in CMF.

**Rule 11-73 (XSD)(Constraint):** `xs:import` must have namespace || An element `xs:import` MUST have an attribute `{}namespace`. (N5R 9-90)

**Rule 11-74 (XSD)(Constraint):** `xs:import` must specify local resource || An `xs:import` element MUST must specify a schema document which MUST be a local resource. (NEW)

The schema document may be specified by a `{}schemaLocation` attribute in the `xs:import` element, or by XML Catalog resolution of the `{}namespace` attribute, or both. Requiring a local resource ensures that the component definitions are known and fixed.

**Rule 11-75 (SET)(Constraint):** Imports must be consistent || The schema documents in the XSD representation of a model MUST NOT contain two `xs:import` elements that have the same `{}namespace` attribute but specify different schema documents. (NEW)

XML Schema permits conflicting imports, but the result is underspecified, and often causes errors that are very hard to detect and diagnose.

**Rule 11-76 (REF)(Constraint):** Reference schema document imports reference schema document || A namespace imported as conformant from a reference schema document MUST identify a namespace defined by a reference schema document. (N5R 11-50)

**Rule 11-77 (EXT)(Constraint):** Extension schema document imports reference or extension schema document || A namespace imported as conformant from a reference schema document MUST identify a namespace defined by a reference schema document or an extension schema document. (N5R 11-51)

**Rule 11-78 (XSD)(Constraint):** Structures imported as conformant || An import of the structures namespace MUST NOT be labeled as an external import. (N5R 11-52)

**Rule 11-79 (XSD)(Constraint):** XML namespace imported as conformant || An import of the XML namespace MUST NOT be labeled as an external import. (N5R 11-53)

**Rule 11-80 (SET)(Constraint):** Each namespace may have only a single root schema in a schema set || A namespace may appear as a root schema in a schema set only once. (N5R 11-54)

**Rule 11-81 (SET)(Constraint):** Consistently marked namespace imports || All `xs:import` elements that have the same namespace MUST have the same conformance marking via `appinfo:externalImportIndicator`. (N5R 11-55)

**Rule 11-82 (SET)(Constraint):** XML Schema document set must be complete || A schema document set must be complete. (N5R 9-91)

An XML Schema document set defines an XML Schema that may be used to validate an XML document. This rule ensures that a schema document set under consideration contains definitions for everything that it references; it has everything necessary to do a complete validation of XML documents, without any unresolved references. Note that some tools may allow validation of documents using partial schemas, when components that are not present are not exercised by the XML document under validation. Such a schema does not meet qualify as a conformant schema document set.

**Rule 11-83 (XSD)(Constraint):** Referenced namespace is imported || The namespace of a type referenced by any of the following schema attributes MUST be the target namespace, the XML Schma namespace, or imported: (N5R 9-92,9-93,9-94,9-95,9-96,9-97)

* `type`
* `base`
* `itemType`
* `memberTypes`
* `ref`
* `substitutionGroup`

The XML Schema definition language requires that, when a schema document references a component in some other namespace, it must use `xs:import` to import the namespace of the referenced component. The use of `xs:import` is described by [[XML Schema Structures]](#ref) Section 4.2.3, References to schema components across namespaces.

Some tools do not enforce this constraint; one such tool carries imports from a schema document into schema documents that it imports. This has the potential to introduce incompatibility into schema documents and schema document sets that exercise this bug. To maintain compatibility across tool sets, this requirement is an explicit rule for NIEM-conformant schemas.

**Rule 11-84 (XSD)(Constraint):** Use structures consistent with specification || A schema MUST use the NIEM structures namespace consistent with how it is defined in [Appendix B, *Structures namespace*](#appendix-b--structures-namespace). (N5R 10-78)

**Rule 11-85 (SET)(Constraint):** Schema marked as reference schema document must conform || Any schema document with an effective conformance target identifier of `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ReferenceSchemaDocument` MUST be a reference schema document. (N5R 4-1)

**Rule 11-86 (SET)(Constraint):** Schema marked as extension schema document must conform || Any schema document with an effective conformance target identifier of `https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/#ExtensionSchemaDocument` MUST be an extension schema document. (N5R 4-2)

-------

# 12. Rules for NIEM messages in XML

**Rule 12-1 (XML)(Constraint):** A message in XML format MUST be schema-valid, as assessed against a conformant schema document set, composed of reference and/or extension namespace representations. (N5R 12-1)

The schemas that define the exchange must be authoritative. Each is the reference schema or extension schema for the namespace it defines. Application developers may use other schemas for various purposes, but for the purposes of determining conformance, the authoritative schemas are relevant.

This rule should not be construed to mean that XML validation must be performed on all XML instances as they are served or consumed; only that the XML instances validate if XML validation is performed. The XML Schema component definitions specify XML documents and element information items, and the instances should follow the rules given by the schemas, even when validation is not performed.)

## 12.1 The meaning of NIEM XML data

The main way that NIEM XML data represents relationships and values is via the hierarchy of XML elements in an XML document. For example, the following fragment of an XML document:

```
<nc:Person>
  <nc:PersonName>
    <nc:PersonFullName>Clark Kent</nc:PersonFullName>
  </nc:PersonName>
</nc:Person>
```
<center><i><a name="fig12-1"></a>Figure 12-1: Example of content elements</i></center><p/>

In this instance, the XML elements describe relationships between data objects:

| XML description	| The Meaning of the data |
| --------------- | ----------------------- |
| The top element occurs within some context, about which we do not know anything. | There is some object, representing whatever is outside the outer element.|
|The top element is `nc:Person`. The NIEM reference schema defines the type of the element as `nc:PersonType`. | There is a relationship, called nc:Person, between the unknown context object and an object of type `nc:PersonType`. |
| The next element is `nc:PersonName`. The schema indicates that element is of type `nc:PersonNameType`. | There is a relationship called `nc:PersonName` between the object of type `nc:PersonType` and an object of type `nc:PersonNameType`. |
| The next element is `nc:PersonFullName`. The schema shows that the element is of type `nc:PersonNameTextType`. | There is a relationship, called `nc:PersonFullName` from the object of type `nc:PersonNameType` and an object of type `nc:PersonNameTextType`. |
| Within that element is the simple value John Doe. The schema tells us the content of that element is of simple type `xs:string`. |The object of type `nc:PersonNameTextType` has a value that is the literal "Clark Kent". |

<center><i><a name="tab12-2"></a>Table 12-2: Meaning of NIEM XML</i></center>

To summarize:

1. Data objects and literal values are expressed in XML as the values of elements and attributes.

2. The names of the XML elements and attributes identify and describe the relationships between the objects and literals.

3. The names of the XML Schema complex types and simple types describe the data objects.

NIEM is designed so that NIEM XML data is a form of RDF data. The RDF equivalent of the XML in figure 13-1 is illustrated in the diagram in figure 13-3, and shown in figure 13-4.

<center>
  <figure class="image">
    <a name="fig12-3"/></a>
    <img src="images/xml-meaning.png" alt="figure" style="zoom:100%"/>
    <figcaption><i>Figure 12-3: Diagram showing the meaning of XML data</i></figcaption>
  </figure>
</center>

```
@prefix nc: <https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
_:n0 nc:Person _:n1 .
_:n1 rdf:type nc:PersonType .
_:n1 nc:PersonName _:n2 .
_:n2 rdf:type nc:PersonNameType .
_:n2 nc:PersonFullName "Clark Kent".
```
<center><i><a name="fig12-4"></a>Figure 12-4: RDF equivalent of XML data</i></center><p/>

**Rule 12-2 (XML)(Interpretation):** Within the instance, the meaning of an element with no content is that additional properties are not asserted. There MUST NOT be additional meaning interpreted for an element with no content. (N5R 12-2)

Elements without content only show a lack of asserted information. That is, all that is asserted is what is explicitly stated, through a combination of XML instance data and its schema. Data that is not present makes no claims. It may be absent due to lack of availability, lack of knowledge, or deliberate withholding of information. These cases should be modeled explicitly, if they are required.

## 12.2 Identifiers and references

Nested elements, shown above, are sufficient to represent simple data that takes the form of a tree. However, the use of nested elements has limitations; expression of all relationships via nested elements is not always possible. Situations that cause problems include:

* Cycles: some object has a relationship that, when followed, eventually circles back to itself. For example, suppose that Bob has a sister relationship to Sue, who has a brother relationship back to Bob. This is not a tree, and so needs some representation other than just nested elements.

* Reuse: multiple objects have a relationship to a common object. For example, suppose Bob and Sue both have a mother relationship to Sally. Expressed via nested elements, this would result in a duplicate representation of Sally.

NIEM provides two different ways to solve this problem: the use of local references pointing to local identifiers, and the use of uniform resource identifiers (URIs). These two methods are similar, and can interoperate, but have distinctions, as described by Section XX Differentiating reference-to-identifier links and use of URIs, below.

**Rule 12-3 (XML)(Constraint):** An element MUST NOT have more than one attribute that is `structures:id`, `structures:ref`, or `structures:uri`. (N5R 12-3)

### 12.2.1 Local identifiers and references

The XML specifications define ID and IDREF attributes, which act as references in XML data. This is supported by XML Schema, and NIEM uses ID and IDREF as one way to reference data across data objects. Under this framework:

* Within an XML document, each value of any attribute of type `xs:ID` must be unique. For example, if an element has an attribute of type `xs:ID` with the value of Bob, then there may not be any other attribute in the document that is of type `xs:ID` that also has the value Bob. NIEM provides attribute `structures:id` of type `xs:ID` to act as a standard local identifier.

* Within an XML document, the value of any attribute of type `xs:IDREF` must appear somewhere within the document as the value of some attribute of type `xs:ID`. For example, if an attribute of type `xs:IDREF` has the value Bob, then somewhere within that XML document there must be an attribute of type `xs:ID` with the value Bob. NIEM provides attribute `structures:ref` of type `xs:IDREF` as a standard local reference.

* These constraints, that IDs must be unique, and that IDREFs must refer to IDs, are XML constraints, not unique to NIEM.

* There are additional constraints placed on XML documents and XML schemas regarding the use of ID and IDREF attributes. For example, an element may not have two attributes of type ID.

In short, within a NIEM-conformant XML document, an attribute `structures:ref` refers to an attribute `structures:id`. These attributes may appear in an XML document to express that an object that is the value of an element is the same as some other object within the document. For example, in the following example, the user of the weapon (Bart) is the same person that is the subject of the arrest:

```
<j:Arrest>
  <j:ArrestInvolvedWeapon>
    <nc:WeaponUser structures:id="bart">
      <nc:PersonName>
        <nc:PersonGivenName>Bart</nc:PersonGivenName>
      </nc:PersonName>
    </nc:WeaponUser>
  </j:ArrestInvolvedWeapon>
  <j:ArrestSubject>
    <nc:EntityPerson structures:ref="bart" xsi:nil="true"/>
  </j:ArrestSubject>
</j:Arrest>
```
<center><i><a name="fig12-5"></a>Figure 12-5: Example of `structures:id` and `structures:ref`</i></center><p/>

Note that rules below establish that relationships established using `structures:id` and `structures:ref` have the exact same meaning as relationships established using nested elements. An information exchange specification may constrain them differently, or prefer one over the other, but from a NIEM perspective, they have the same meaning.

**Rule 12-4 (XML)(Constraint):** The value of an attribute `structures:ref` MUST match the value of an attribute `structures:id` of some element in the XML document. (N5R 12-4)

Although many attributes with ID and IDREF semantics are defined by many vocabularies, for consistency, within a NIEM XML document any attribute `structures:ref` must refer to an attribute `structures:id`, and not any other attribute.

**Rule 12-5 (XML)(Constraint):** Every element that has an attribute `structures:ref` MUST have a referencing element validation root that is equal to the referenced element validation root. (N5R 12-5)

The term "validation root" is defined by [[XML Schema Structures]](#ref) *Section 5.2, Assessing Schema-Validity*. It is established as a part of validity assessment of an XML document.

NIEM supports type-safe references; that is, references using `structures:ref` and `structures:id` must preserve the type constraints that would apply if nested elements were used instead of a reference. For example, an element of type `nc:PersonType` must always refer to another element of type `nc:PersonType`, or a type derived from `nc:PersonType`, when using `structures:ref` to establish the relationship.

**Rule 12-6 (XML)(Constraint):** Every element that has an attribute `structures:ref` MUST have a referenced element type definition that is validly derived from the referencing element type definition. (N5R 12-6)

The term "validly derived" is as established by [[XML Schema Structures]](#ref), subsection *Schema Component Constraint: Type Derivation OK (Complex)* within Section 3.4.6, *Constraints on Complex Type Definition Schema Components*.

This rule requires that the type of the element pointed to by a `structures:ref` attribute must be of (or derived from) the type of the reference element.

### 12.2.2 Uniform resource identifiers in NIEM XML

NIEM supports linked data through the use of uniform resource identifiers (URIs), expressed through the attribute structures:uri in XML documents . This attribute works much like `structures:ref` and `structures:id`, and overlaps somewhat. Linked data introduces key terminology:

* Anything modeled or addressed by an information system may be called a *resource*: people, vehicles, reports, documents, relationships, ideas: anything that is talked about and modeled in an information system is a resource.

* Every resource may have a name, called a uniform resource identifier (URI).

As described in Section 5.4, Unique identification of data objects, above, `structures:uri`, `structures:id`, and `structures:ref` each denote a resource identifier. Although a `structures:ref` must always refer to a `structures:id`, and a value of `structures:id` must be unique within its document, a `structures:uri` may refer to any of `structures:uri`, `structures:ref`, or `structures:id`.

**Rule 12-7 (XML)(Interpretation):** The value of an attribute `structures:uri` is a URI-reference, as defined by [[RFC 3986]](#ref), which denotes a resource identifier on the element holding the attribute, in accordance with evaluation consistent with [[RFC 3986]](#ref) and [[XML Base]](#ref). (N5R 12-7)

**Rule 12-8 (XML)(Constraint):** The value of an attribute `structures:uri` that is an *absolute URI* according to [[RFC 3986]](#ref) MUST be valid according to the rules for its scheme. (NEW)

Validating parsers do not always test whether an absolute URI follows the rules for its scheme, and so a 
A successful validation match against the type `xs:anyURI` is necessary but not sufficient.

The following example shows a reference to an absolute URI, using the URN namespace for UUIDs:

```
<example:ArrestMessage>
  <j:Arrest xsi:nil="true"
    structures:uri="urn:uuid:f81d4fae-7dec-11d0-a765-00a0c91e6bf6"/>
</example:ArrestMessage>
```
<center><i><a name="fig12-6"></a>Figure 12-6: Example of `structures:uri` holding an absolute URI</i></center><p/>

The following example shows a relative URI, using xml:base to carry the base URI for the document. The person object identified by the structures:uri attribute has the URI http://state.example/scmods/B263-1655-2187.

```
<example:ArrestMessage xml:base="http://state.example/scmods/">
  <j:Arrest>
    <j:ArrestSubject>
      <nc:EntityPerson structures:uri="B263-1655-2187"/>
    </j:ArrestSubject>
  </j:Arrest>
</example:ArrestMessage>
```
<center><i><a name="fig12-7"></a>Figure 12-7: Example of `structures:uri` holding an relative URI, with an `xml:base`</i></center><p/>

**Rule 12-9 (XML)(Interpretation):** The value of an attribute `structures:id` with a value of *val*, or an attribute `structures:ref` with a value of *val*, denotes a resource identifier on the element holding the attribute, as would be denoted by an attribute `structures:uri` with a value of *#val*. (N5R 12-8)

For example, `structures:id="hello"` and `structures:ref="hello"` each denote the same resource identifier for an element as if it held an attribute `structures:uri="#hello"`.

A set of elements that each have the same resource identifier denote the same object, which has that given identifier. This means that, in an XML representation, the properties of an object may be spread across a set of elements that share an identifier.

The following example contains four references to the same object, which has the identifier `https://state.example/98723987/results.xml#delta`.

```
<example:ArrestMessage xml:base="https://state.example/98723987/results.xml">
  <j:Arrest>
    <j:ArrestSubject>
      <nc:EntityPerson structures:id="delta"/>
    </j:ArrestSubject>
  </j:Arrest>
  <j:Arrest>
    <j:ArrestSubject>
      <nc:EntityPerson structures:ref="delta"/>
    </j:ArrestSubject>
  </j:Arrest>
  <j:Arrest>
    <j:ArrestSubject>
      <nc:EntityPerson structures:uri="#delta"/>
    </j:ArrestSubject>
  </j:Arrest>
  <j:Arrest>
    <j:ArrestSubject>
      <nc:EmtotuPerson structures:uri="https://state.example/98723987/results.xml#delta"/>
    </j:ArrestSubject>
  </j:Arrest>
</example:ArrestMessage>
```
<center><i><a name="fig12-8"></a>Figure 12-8: Example of `structures:id`, `structures:ref`, and `structures:uri` identifying the same object</i></center><p/>

### 12.2.3 Differentiating reference-to-identifier links and use of URIs

These two methods are similar, and can interoperate, but have distinctions:

* With ref-to-id links, both structures:ref and structures:id are required to be within the same document.

* With ref-to-id links, both structures:id and structures:ref are required to be validated against the same schema.

* Ref-to-id links provide and require type safety, in that the type of an object pointed to by structures:ref must be consistent with the referencing element’s type declaration.

* The value of structures:id must be unique for IDs within the document.

* The value of structures:ref must appear within the document as the value of an attribute structures:id.

* An attribute structures:uri is a URI-reference that can reference any resource, inside or outside the document.

* A structures:uri can reference any structures:id within the same document, or in another conformant document.

* A structures:uri can reference any structures:ref within the same document, or in another conformant document.

* Any structures:uri may reference any other structures:uri, within the same document, or in another conformant document.

### 12.2.4 Reference and content elements have the same meaning

An important aspect of the use of nested elements, ref-to-id references, and URI references, is that they all have the same meaning. Expressing a relationship as a nested element, versus as a ref-to-id reference is merely for convenience and ease of serialization. There is no change in meaning or semantics between relationships expressed by sub-elements versus relationships expressed by structures:ref or structures:uri.

Any claim that nested elements represent composition, while references represent aggregation is incorrect. No life cycle dependency is implied by either method. Similarly, any claim that included data is intrinsic (i.e., a property inherent to an object), while referenced data is extrinsic (i.e., a property derived from a relationship to other things), is false. A property represented as a nested element has the exact same meaning as that property represented by a reference.

**Rule 12-10 (XML)(Interpretation):** There MUST NOT be any difference in meaning between a relationship established via an element declaration instantiated by a nested element, and that element declaration instantiated via reference. (N5R 12-9)

There is no difference in meaning between relationships established by sub-elements and those established by references. They are simply two mechanisms for expressing connections between objects. Neither mechanism implies that properties are intrinsic or extrinsic; such characteristics must be explicitly stated in property definitions.

Being of type `xs:ID` and `xs:IDREF`, validating schema parsers will perform certain checks on the values of structures:id and structures:ref. Specifically, no two IDs may have the same value. This includes structures:id and other IDs that may be used within an XML document. Also, any value of `structures:ref` must also appear as the value of an ID.

By this rule, the following three XML fragments have a very similar meaning. The first example, with no reference, shows a witness that is a role of a person.

```
<j:Witness>
  <nc:RoleOfPerson>
    <nc:PersonName>
      <nc:PersonFullName>John Doe</nc:PersonFullName>
    </nc:PersonName>
  </nc:RoleOfPerson>
</j:Witness>
```
<center><i><a name="fig12-9"></a>Figure 12-9: Example with no reference</i></center><p/>

The next example, with a backward reference, also expresses a witness object that is a role of a person. It first expresses the person object, then the witness object as a role of a that person, expressed as a reference back to the person.

```
<nc:Person structures:id="c58">
  <nc:PersonName>
    <nc:PersonFullName>John Doe</nc:PersonFullName>
  </nc:PersonName>
</nc:Person>
<j:Witness>
  <nc:EntityPerson structures:ref="c58" xsi:nil="true"/>
</j:Witness>
```
<center><i><a name="fig12-10"></a>Figure 12-10: Example with a backward reference</i></center><p/>

The final example, with a forward reference shows a witness as a role of a person, with a separate person object expressed as a forward reference to the person object that is expressed later, within the definition of the witness.

```
<nc:Person structures:ref="t85" xsi:nil="true"/>
<j:Witness>
  <nc:EntityPerson structures:id="t85">
    <nc:PersonName>
      <nc:PersonFullName>John Doe</nc:PersonFullName>
    </nc:PersonName>
  </nc:RoleOfP
```
<center><i><a name="fig12-11"></a>Figure 12-11: Example with a forward reference</i></center><p/>

NIEM-conformant data instances may use either representation as needed, to represent the meaning of the fundamental data. There is no difference in meaning between reference and content data representations. The two different methods are available for ease of representation. No difference in meaning should be implied by the use of one method or the other.

-------
# 13. Rules for the NIEM profile of JSON-LD

# 14. Rules for NIEM messages in JSON

-------

# Appendix A. References

This appendix contains the normative and informative references that are used in this document. Any normative work cited in the body of the text as needed to implement the work product must be listed in the Normative References section below. Each reference to a separate document or artifact in this work must be listed here and must be identified as either a Normative or an Informative Reference. Normative references are specific (identified by date of publication and/or edition number or version number) and Informative references are either specific or non-specific.

While any hyperlinks included in this appendix were valid at the time of publication, OASIS cannot guarantee their long-term validity.

## A.1 Normative References

The following documents are referenced in such a way that some or all of their content constitutes requirements of this document.

###### [RFC2119]
Bradner, S., "Key words for use in RFCs to Indicate Requirement Levels", BCP 14, RFC 2119, DOI 10.17487/RFC2119, March 1997, http://www.rfc-editor.org/info/rfc2119.
###### [RFC8174]
Leiba, B., "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words", BCP 14, RFC 8174, DOI 10.17487/RFC8174, May 2017, http://www.rfc-editor.org/info/rfc8174.

## A.2 Informative References

###### [I18N]
Renner, S, "Internationalization scenarios for NIEM", June 2022. **Publish as a project note**

###### [RFC3552]
Rescorla, E. and B. Korver, "Guidelines for Writing RFC Text on Security Considerations", BCP 72, RFC 3552, DOI 10.17487/RFC3552, July 2003, https://www.rfc-editor.org/info/rfc3552.

-------

# Appendix B.  Structures namespace

```
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema
  targetNamespace="https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/"
  xmlns:structures="https://docs.oasis-open.org/niemopen/ns/model/structures/6.0/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="ps02"
  xml:lang="en-US">
  <xs:annotation>
    <xs:documentation>The structures namespace provides base types and other components for definition of NIEM-conformant XML schemas.</xs:documentation>
  </xs:annotation>
  <xs:attributeGroup name="SimpleObjectAttributeGroup">
    <xs:attribute ref="structures:id"/>
    <xs:attribute ref="structures:ref"/>
    <xs:attribute ref="structures:uri"/>
    <xs:anyAttribute processContents="strict" namespace="##other"/>
  </xs:attributeGroup>
  <xs:complexType name="AdapterType" abstract="true">
    <xs:annotation>
      <xs:documentation>A data type for a type that contains a single non-conformant property from an external standard for use in NIEM.</xs:documentation>
    </xs:annotation>
    <xs:sequence>
      <xs:element ref="structures:ObjectAugmentationPoint" minOccurs="0" maxOccurs="unbounded"/>
    </xs:sequence>
    <xs:attribute ref="structures:appliesToParent"/>
    <xs:attribute ref="structures:id"/>
    <xs:attribute ref="structures:ref"/>
    <xs:attribute ref="structures:uri"/>
    <xs:anyAttribute processContents="strict" namespace="##other"/>
  </xs:complexType>
  <xs:complexType name="AssociationType" abstract="true">
    <xs:annotation>
      <xs:documentation>A data type for a relationship between two or more objects, including any properties of that relationship.</xs:documentation>
    </xs:annotation>
    <xs:sequence>
      <xs:element ref="structures:AssociationAugmentationPoint" minOccurs="0" maxOccurs="unbounded"/>
    </xs:sequence>
    <xs:attribute ref="structures:appliesToParent"/>
    <xs:attribute ref="structures:id"/>
    <xs:attribute ref="structures:ref"/>
    <xs:attribute ref="structures:uri"/>
    <xs:anyAttribute processContents="strict" namespace="##other"/>
  </xs:complexType>
  <xs:complexType name="AugmentationType" abstract="true">
    <xs:annotation>
      <xs:documentation>A data type for a set of properties to be applied to a base type.</xs:documentation>
    </xs:annotation>
  </xs:complexType>
  <xs:complexType name="ObjectType" abstract="true">
    <xs:annotation>
      <xs:documentation>A data type for a thing with its own lifespan that has some existence.</xs:documentation>
    </xs:annotation>
    <xs:sequence>
      <xs:element ref="structures:ObjectAugmentationPoint" minOccurs="0" maxOccurs="unbounded"/>
    </xs:sequence>
    <xs:attribute ref="structures:appliesToParent"/>
    <xs:attribute ref="structures:id"/>
    <xs:attribute ref="structures:ref"/>
    <xs:attribute ref="structures:uri"/>
    <xs:anyAttribute processContents="strict" namespace="##other"/>
  </xs:complexType>
  <xs:element name="AssociationAugmentationPoint" abstract="true">
    <xs:annotation>
      <xs:documentation>An augmentation point for type structures:AssociationType.</xs:documentation>
    </xs:annotation>
  </xs:element>
  <xs:element name="ObjectAugmentationPoint" abstract="true">
    <xs:annotation>
      <xs:documentation>An augmentation point for type structures:ObjectType.</xs:documentation>
    </xs:annotation>
  </xs:element>
  <xs:attribute name="appliesToParent" type="xs:boolean" default="true">
    <xs:annotation>
      <xs:documentation>True if this element is a property of its parent; false if it appears only to support referencing.</xs:documentation>
    </xs:annotation>
  </xs:attribute>
  <xs:attribute name="id" type="xs:ID">
    <xs:annotation>
      <xs:documentation>A document-relative identifier for an XML element.</xs:documentation>
    </xs:annotation>
  </xs:attribute>
  <xs:attribute name="ref" type="xs:IDREF">
    <xs:annotation>
      <xs:documentation>A document-relative reference to an XML element.</xs:documentation>
    </xs:annotation>
  </xs:attribute>
  <xs:attribute name="uri" type="xs:anyURI">
    <xs:annotation>
      <xs:documentation>An internationalized resource identifier or uniform resource identifier for a node or object.</xs:documentation>
    </xs:annotation>
  </xs:attribute>
</xs:schema>
```

-------

# Appendix C. Index of rules

* [Rule 7-1: Name of Class, Datatype, and Property components (CMF,XSD)](#rule-7-1).
* [Rule 7-2: No augmentation components in CMF (CMF)](#rule-7-2).
* [Rule 7-3: Name of adapter classes (CMF,XSD)](#rule-7-3).
* [Rule 7-4: Name of association classes (CMF,XSD)](#rule-7-4).
* [Rule 7-5: Name of code list atomic classes (CMF,XSD)](#rule-7-5).
* [Rule 7-6: Names ending in "SimpleType" (CMF,XSD)](#rule-7-6).
* [Rule 7-7: Names ending in "CodeSimpleType" (CMF,XSD)](#rule-7-7).
* [Rule 7-8: Name of code list datatypes (CMF,XSD)](#rule-7-8).
* [Rule 7-9: Name of abstract properties (CMF,XSD)](#rule-7-9).
* [Rule 7-10: Name of association properties (CMF,XSD)](#rule-7-10).
* [Rule 7-11: Name of code properties (CMF,XSD)](#rule-7-11).
* [Rule 7-12: Name of literal properties in CMF (CMF)](#rule-7-12).
* [Rule 7-13: Name of representation attributes (CMF,XSD)](#rule-7-13).
* [Rule 7-14: Name of augmentation types (XSD)](#rule-7-14).
* [Rule 7-15: Name of augmentation elements (XSD)](#rule-7-15).
* [Rule 7-16: Name of augmentation point elements (XSD)](#rule-7-16).
* [Rule 7-17: No literal properties in XSD (XSD)](#rule-7-17).
* [Rule 7-18: Name of type definitions (XSD)](#rule-7-18).
* [Rule 7-19: Name of simple type definitions (XSD)](#rule-7-19).
* [Rule 7-20: Name of complex type definition (XSD)](#rule-7-20).
* [Rule 7-21: Proxy types (XSD)](#rule-7-21).
* [Rule 7-22: Component name composed of English words (REF)](#rule-7-22).
* [Rule 7-23: Component names have only specific characters (CMF,XSD)](#rule-7-23).
* [Rule 7-24: Component names use camel case (CMF,XSD)](#rule-7-24).
* [Rule 7-25: Name of attribute properties begin with lower case letter (CMF,XSD)](#rule-7-25).
* [Rule 7-26: Name of components other than attribute properties begin with upper case letter (CMF,XSD)](#rule-7-26).
* [Rule 7-27: Punctuation in component name is a separator (CMF,XSD)](#rule-7-27).
* [Rule 7-28: Singular form is preferred in name (CMF,XSD)](#rule-7-28).
* [Rule 7-29: Present tense is preferred in name (CMF,XSD)](#rule-7-29).
* [Rule 7-30: Name does not have nonessential words (CMF,XSD)](#rule-7-30).
* [Rule 7-31: Property name follows ISO 11179-5 pattern (CMF,XSD)](#rule-7-31).
* [Rule 7-32: Object-class term identifies concrete category (CMF,XSD)](#rule-7-32).
* [Rule 7-33: Property term describes characteristic or subpart (CMF,XSD)](#rule-7-33).
* [Rule 7-34: Name may have multiple qualifier terms (CMF,XSD)](#rule-7-34).
* [Rule 7-35: Name avoids unnecessary qualifier terms (CMF,XSD)](#rule-7-35).
* [Rule 7-36: Order of qualifiers is not significant (CMF,XSD)](#rule-7-36).
* [Rule 7-37: Redundant term in name is omitted (CMF,XSD)](#rule-7-37).
* [Rule 7-38: Data property uses representation term (CMF,XSD)](#rule-7-38).
* [Rule 7-39: Object property uses representation term when appropriate (CMF,XSD)](#rule-7-39).
* [Rule 7-40: Object property uses representation term only when appropriate (CMF,XSD)](#rule-7-40).
* [Rule 7-41: Names use common abbreviations (CMF,XSD)](#rule-7-41).
* [Rule 7-42: Local term has literal or definition (CMF,XSD)](#rule-7-42).
* [Rule 7-43: Local term declaration applies only to its namespace (CMF,XSD)](#rule-7-43).
* [Rule 7-44: LocalTerm appinfo applies to schema (XSD)](#rule-7-44).
* [Rule 8-1: Namespace has data definition (CMF,XSD)](#rule-8-1).
* [Rule 8-2: Model component has data definition (CMF,XSD)](#rule-8-2).
* [Rule 8-3: Facet has data definition (CMF,XSD)](#rule-8-3).
* [Rule 8-4: Subset does not alter data definition (CMF,SUB)](#rule-8-4).
* [Rule 8-5: Documentation is provided in US English (CMF,XSD)](#rule-8-5).
* [Rule 8-6: Data definition does not introduce ambiguity (CMF,XSD)](#rule-8-6).
* [Rule 8-7: Object class has only one meaning (CMF,XSD)](#rule-8-7).
* [Rule 8-8: Data definition of a part does not redefine the whole (CMF,XSD)](#rule-8-8).
* [Rule 8-9: Do not leak representation into data definition (CMF,XSD)](#rule-8-9).
* [Rule 8-10: Data definition follows 11179-4 requirements (CMF,XSD)](#rule-8-10).
* [Rule 8-11: Data definition follows 11179-4 recommendations (CMF,XSD)](#rule-8-11).
* [Rule 8-12: Standard opening phrase for abstract property data definition (CMF,XSD)](#rule-8-12).
* [Rule 8-13: Standard opening phrase for association property data definition (CMF,XSD)](#rule-8-13).
* [Rule 8-14: Standard opening phrase for date property data definition (CMF,XSD)](#rule-8-14).
* [Rule 8-15: Standard opening phrase for quantity property data definition (CMF,XSD)](#rule-8-15).
* [Rule 8-16: Standard opening phrase for picture property data definition (CMF,XSD)](#rule-8-16).
* [Rule 8-17: Standard opening phrase for indicator property data definition (CMF,XSD)](#rule-8-17).
* [Rule 8-18: Standard opening phrase for identification property data definition (CMF,XSD)](#rule-8-18).
* [Rule 8-19: Standard opening phrase for name property data definition (CMF,XSD)](#rule-8-19).
* [Rule 8-20: Standard opening phrase for property data definition (CMF,XSD)](#rule-8-20).
* [Rule 8-21: Standard opening phrase for association class data definition (CMF,XSD)](#rule-8-21).
* [Rule 8-22: Standard opening phrase for class data definition (CMF,XSD)](#rule-8-22).
* [Rule 8-23: Standard opening phrase for augmentation point element data definition (XSD)](#rule-8-23).
* [Rule 8-24: Standard opening phrase for augmentation element data definition (XSD)](#rule-8-24).
* [Rule 8-25: Standard opening phrase for augmentation type data definition (XSD)](#rule-8-25).
* [Rule 9-1: Namespace identifier is absolute URI (CMF)](#rule-9-1).
* [Rule 9-2: Namespace identifier is absolute URI (XSD)](#rule-9-2).
* [Rule 9-3: Namespace has a prefix (CMF)](#rule-9-3).
* [Rule 9-4: Namespace has a prefix (XSD)](#rule-9-4).
* [Rule 9-5: Namespace has version (CMF)](#rule-9-5).
* [Rule 9-6: Namespace has version (XSD)](#rule-9-6).
* [Rule 9-7: Namespace has language (CMF)](#rule-9-7).
* [Rule 9-8: Namespace has language (XSD)](#rule-9-8).
* [Rule 9-9: Schema is CTAS-conformant (XSD)](#rule-9-9).
* [Rule 9-10: Document element has attribute `ct:conformanceTargets` (XSD)](#rule-9-10).
* [Rule 9-11: Reference namespace has proper conformance target (CMF)](#rule-9-11).
* [Rule 9-12: Reference namespace has proper conformance target (REF)](#rule-9-12).
* [Rule 9-13: Extension namespace has proper conformance target (CMF)](#rule-9-13).
* [Rule 9-14: Extension namespace has proper conformance target (EXT)](#rule-9-14).
* [Rule 9-15: Subset namespace has proper conformance target (CMF)](#rule-9-15).
* [Rule 9-16: Subset namespace has proper conformance target (SUB)](#rule-9-16).
* [Rule 9-17: Reference namespace does not have wildcard (CMF)](#rule-9-17).
* [Rule 9-18: Reference namespace does not have wildcard (REF)](#rule-9-18).
* [Rule 9-19: Reference namespace uses reference namespace components (CMF,REF)](#rule-9-19).
* [Rule 9-20: Extension namespace uses reference or extension namespace components (CMF,EXT)](#rule-9-20).
* [Rule 9-21: Property occurs only once in a Class (CMF,XSD)](#rule-9-21).
* [Rule 9-22: Object properties in reference and extension namespace are referencable (CMF)](#rule-9-22).
* [Rule 9-23: Object properties in reference and extension namespace are referencable (REF,EXT)](#rule-9-23).
* [Rule 9-24: Subset has corresponding reference or extension namespace (CMF,SUB)](#rule-9-24).
* [Rule 9-25: Subset does not extend component range (SUB)](#rule-9-25).
* [Rule 9-26: Subset does not add components (SUB)](#rule-9-26).
* [Rule 9-27: Augmentations declare augmenting namespace (CMF)](#rule-9-27).
* [Rule 9-28: Augmentations declare augmenting namespace (SUB)](#rule-9-28).
* [Rule 11-1: Document is a schema document (XSD)](#rule-11-1).
* [Rule 11-2: Document element is `xs:schema` (XSD)](#rule-11-2).
* [Rule 11-3: Prohibited schema components (XSD)](#rule-11-3).
* [Rule 11-4: Prohibited base types (XSD)](#rule-11-4).
* [Rule 11-5: Prohibited list item types (XSD)](#rule-11-5).
* [Rule 11-6: Prohibited union item types (XSD)](#rule-11-6).
* [Rule 11-7: Prohibited attribute types (XSD)](#rule-11-7).
* [Rule 11-8: No mixed content on complex type or complex content (XSD)](#rule-11-8).
* [Rule 11-9: Complex type content is explicitly simple or complex (XSD)](#rule-11-9).
* [Rule 11-10: Base type of complex type with complex content must have complex content (XSD,SET)](#rule-11-10).
* [Rule 11-11: Untyped element is abstract (XSD)](#rule-11-11).
* [Rule 11-12: Element type not in the XML or XML Schema namespace (XSD)](#rule-11-12).
* [Rule 11-13: Element type is not simple type (XSD)](#rule-11-13).
* [Rule 11-14: Attribute declaration has type (XSD)](#rule-11-14).
* [Rule 11-15: No default or fixed value (XSD)](#rule-11-15).
* [Rule 11-16: Sequence has minimum and maximun cardinality 1 (XSD)](#rule-11-16).
* [Rule 11-17: `xs:choice` must be child of `xs:sequence` (XSD)](#rule-11-17).
* [Rule 11-18: Choice has minimum and maximum cardinality 1 (XSD)](#rule-11-18).
* [Rule 11-19: Comment is not recommended (XSD)](#rule-11-19).
* [Rule 11-20: Documentation element has no element children (XSD)](#rule-11-20).
* [Rule 11-21: `xs:appinfo` children are comments, elements, or whitespace (XSD)](#rule-11-21).
* [Rule 11-22: Appinfo child elements have namespaces (XSD)](#rule-11-22).
* [Rule 11-23: Appinfo descendants are not XML Schema elements (XSD)](#rule-11-23).
* [Rule 11-24: `xs:sequence` must be child of `xs:extension` (REF)](#rule-11-24).
* [Rule 11-25: `xs:sequence` must be child of `xs:extension` or `xs:restriction` (EXT,SUB)](#rule-11-25).
* [Rule 11-26: Type definition is top-level (XSD)](#rule-11-26).
* [Rule 11-27: Complex type has a category (XSD)](#rule-11-27).
* [Rule 11-28: Object type with complex content is derived from `structures:ObjectType` (XSD)](#rule-11-28).
* [Rule 11-29: Adapter type derived from `structures:AdapterType` (XSD)](#rule-11-29).
* [Rule 11-30: Association type derived from `structures:AssociationType` (XSD)](#rule-11-30).
* [Rule 11-31: Augmentation type derived from `structures:AugmentationType` (XSD)](#rule-11-31).
* [Rule 11-32: Complex type with simple content has `structures:SimpleObjectAttributeGroup` (XSD)](#rule-11-32).
* [Rule 11-33: Base type definition defined by conformant schema (XSD)](#rule-11-33).
* [Rule 11-34: Component reference defined by conformant schema (XSD)](#rule-11-34).
* [Rule 11-35: Schema uses only known attribute groups (XSD)](#rule-11-35).
* [Rule 11-36: Augmentation elements are not used directly (XSD)](#rule-11-36).
* [Rule 11-37: List item type defined by conformant schemas (XSD)](#rule-11-37).
* [Rule 11-38: Union member types defined by conformant schemas (XSD)](#rule-11-38).
* [Rule 11-39: Declarations are top-level (XSD)](#rule-11-39).
* [Rule 11-40: Element type is not simple type (XSD)](#rule-11-40).
* [Rule 11-41: Attribute and element type is from conformant namespace (XSD)](#rule-11-41).
* [Rule 11-42: Element substitution group defined by conformant schema (XSD)](#rule-11-42).
* [Rule 11-43: Element declaration is nillable (REF,EXT)](#rule-11-43).
* [Rule 11-44: Import of external schema document is labeled (XSD)](#rule-11-44).
* [Rule 11-45: Import of external namespace has data definition (XSD)](#rule-11-45).
* [Rule 11-46: Name of adapter type (XSD)](#rule-11-46).
* [Rule 11-47: Structure of external adapter type definition follows pattern (XSD)](#rule-11-47).
* [Rule 11-48: AElement use from external adapter type defined by external schema documents (XSD)](#rule-11-48).
* [Rule 11-49: External adapter type not a base type (XSD)](#rule-11-49).
* [Rule 11-50: External attribute use has data definition (REF,EXT)](#rule-11-50).
* [Rule 11-51: External attribute use not an ID (XSD)](#rule-11-51).
* [Rule 11-52: External element use has data definition (REF,EXT)](#rule-11-52).
* [Rule 11-53: Proxy type has designated structure (XSD)](#rule-11-53).
* [Rule 11-54: Augmentable type has one augmentation point element (XSD)](#rule-11-54).
* [Rule 11-55: Augmentation point element corresponds to its base type (XSD)](#rule-11-55).
* [Rule 11-56: An augmentation point element has no type (XSD)](#rule-11-56).
* [Rule 11-57: An augmentation point element has no substitution group (XSD)](#rule-11-57).
* [Rule 11-58: Augmentation point element is only referenced by its base type (XSD)](#rule-11-58).
* [Rule 11-59: Augmentation point element use is optional and unbounded (XSD)](#rule-11-59).
* [Rule 11-60: Augmentation point element use must be last element in its base type (XSD)](#rule-11-60).
* [Rule 11-61: Component marked as deprecated is deprecated component (XSD)](#rule-11-61).
* [Rule 11-62: Appinfo attribute annotates schema component (XSD)](#rule-11-62).
* [Rule 11-63: External import indicator annotates import (XSD)](#rule-11-63).
* [Rule 11-64: appinfo:LocalTerm annotates schema (XSD)](#rule-11-64).
* [Rule 11-65: No simple type disallowed derivation (REF)](#rule-11-65).
* [Rule 11-66: No use of fixed on simple type facets (REF)](#rule-11-66).
* [Rule 11-67: Complex content uses extension (REF)](#rule-11-67).
* [Rule 11-68: Simple content uses extension (REF)](#rule-11-68).
* [Rule 11-69: No disallowed substitutions or derivation (REF)](#rule-11-69).
* [Rule 11-70: No `xs:choice` (REF)](#rule-11-70).
* [Rule 11-71: External attribute use only in external adapter type (REF)](#rule-11-71).
* [Rule 11-72: Namespace prefix is unique (SET)](#rule-11-72).
* [Rule 11-73: `xs:import` must have namespace (XSD)](#rule-11-73).
* [Rule 11-74: `xs:import` must specify local resource (XSD)](#rule-11-74).
* [Rule 11-75: Imports must be consistent (SET)](#rule-11-75).
* [Rule 11-76: Reference schema document imports reference schema document (REF)](#rule-11-76).
* [Rule 11-77: Extension schema document imports reference or extension schema document (EXT)](#rule-11-77).
* [Rule 11-78: Structures imported as conformant (XSD)](#rule-11-78).
* [Rule 11-79: XML namespace imported as conformant (XSD)](#rule-11-79).
* [Rule 11-80: Each namespace may have only a single root schema in a schema set (SET)](#rule-11-80).
* [Rule 11-81: Consistently marked namespace imports (SET)](#rule-11-81).
* [Rule 11-82: XML Schema document set must be complete (SET)](#rule-11-82).
* [Rule 11-83: Referenced namespace is imported (XSD)](#rule-11-83).
* [Rule 11-84: Use structures consistent with specification (XSD)](#rule-11-84).
* [Rule 11-85: Schema marked as reference schema document must conform (SET)](#rule-11-85).
* [Rule 11-86: Schema marked as extension schema document must conform (SET)](#rule-11-86).
* [Rule 12-1: NO NAME YET (XML)](#rule-12-1).
* [Rule 12-2: NO NAME YET (XML)](#rule-12-2).
* [Rule 12-3: NO NAME YET (XML)](#rule-12-3).
* [Rule 12-4: NO NAME YET (XML)](#rule-12-4).
* [Rule 12-5: NO NAME YET (XML)](#rule-12-5).
* [Rule 12-6: NO NAME YET (XML)](#rule-12-6).
* [Rule 12-7: NO NAME YET (XML)](#rule-12-7).
* [Rule 12-8: NO NAME YET (XML)](#rule-12-8).
* [Rule 12-9: NO NAME YET (XML)](#rule-12-9).
* [Rule 12-10: NO NAME YET (XML)](#rule-12-10).

-------

# Appendix D.  Mapping NIEM 5 rules to NIEM 6

| NIEM 5 Rule | NIEM 6 Rules |
| :--- | :--- |
| [Rule 4-1, Schema marked as reference schema document must conform ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_4-1) | [11-85](#rule-11-85) |
| [Rule 4-2, Schema marked as extension schema document must conform ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_4-2) | [11-86](#rule-11-86) |
| [Rule 4-3, Schema is CTAS-conformant ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_4-3) | [9-9](#rule-9-9) |
| [Rule 4-4, Document element has attribute ct:conformanceTargets ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_4-4) | [9-10](#rule-9-10) |
| [Rule 4-5, Schema claims reference schema conformance target ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_4-5) | [9-11](#rule-9-11), [9-12](#rule-9-12) |
| [Rule 4-6, Schema claims extension conformance target ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_4-6) | [9-13](#rule-9-13), [9-14](#rule-9-14) |
| [Rule 5-1, structures:uri denotes resource identifier ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_5-1) | *no matching NIEM6 rule* |
| [Rule 7-1, Document is an XML document ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_7-1) | [11-1](#rule-11-1) |
| [Rule 7-2, Document uses XML namespaces properly ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_7-2) | [11-1](#rule-11-1) |
| [Rule 7-3, Document is a schema document ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_7-3) | [11-1](#rule-11-1) |
| [Rule 7-4, Document element is xs:schema ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_7-4) | [11-2](#rule-11-2) |
| [Rule 7-5, Component name follows ISO 11179 Part 5 Annex A ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_7-5) | [7-31](#rule-7-31) |
| [Rule 9-1, No base type in the XML namespace ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-1) | [11-4](#rule-11-4) |
| [Rule 9-2, No base type of xs:ID ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-2) | [11-4](#rule-11-4) |
| [Rule 9-3, No base type of xs:IDREF ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-3) | [11-4](#rule-11-4) |
| [Rule 9-4, No base type of xs:IDREFS ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-4) | [11-4](#rule-11-4) |
| [Rule 9-5, No base type of xs:anyType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-5) | [11-4](#rule-11-4) |
| [Rule 9-6, No base type of xs:anySimpleType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-6) | [11-4](#rule-11-4) |
| [Rule 9-7, No base type of xs:NOTATION ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-7) | [11-4](#rule-11-4) |
| [Rule 9-8, No base type of xs:ENTITY ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-8) | [11-4](#rule-11-4) |
| [Rule 9-9, No base type of xs:ENTITIES ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-9) | [11-4](#rule-11-4) |
| [Rule 9-10, Simple type definition is top-level ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-10) | [11-26](#rule-11-26) |
| [Rule 9-11, No simple type disallowed derivation ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-11) | [11-65](#rule-11-65) |
| [Rule 9-12, Simple type has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-12) | [8-2](#rule-8-2) |
| [Rule 9-13, No use of fixed on simple type facets ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-13) | [11-66](#rule-11-66) |
| [Rule 9-14, Enumeration has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-14) | [8-3](#rule-8-3) |
| [Rule 9-15, No list item type of xs:ID ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-15) | [11-5](#rule-11-5) |
| [Rule 9-16, No list item type of xs:IDREF ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-16) | [11-5](#rule-11-5) |
| [Rule 9-17, No list item type of xs:anySimpleType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-17) | [11-5](#rule-11-5) |
| [Rule 9-18, No list item type of xs:ENTITY ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-18) | [11-5](#rule-11-5) |
| [Rule 9-19, No union member types of xs:ID ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-19) | [11-6](#rule-11-6) |
| [Rule 9-20, No union member types of xs:IDREF ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-20) | [11-6](#rule-11-6) |
| [Rule 9-21, No union member types of xs:IDREFS ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-21) | [11-6](#rule-11-6) |
| [Rule 9-22, No union member types of xs:anySimpleType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-22) | [11-6](#rule-11-6) |
| [Rule 9-23, No union member types of xs:ENTITY ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-23) | [11-6](#rule-11-6) |
| [Rule 9-24, No union member types of xs:ENTITIES ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-24) | [11-6](#rule-11-6) |
| [Rule 9-25, Complex type definition is top-level ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-25) | [11-26](#rule-11-26) |
| [Rule 9-26, Complex type has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-26) | [8-2](#rule-8-2) |
| [Rule 9-27, No mixed content on complex type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-27) | [11-8](#rule-11-8) |
| [Rule 9-28, No mixed content on complex content ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-28) | [11-8](#rule-11-8) |
| [Rule 9-29, Complex type content is explicitly simple or complex ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-29) | [11-9](#rule-11-9) |
| [Rule 9-30, Complex content uses extension ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-30) | [11-67](#rule-11-67) |
| [Rule 9-31, Base type of complex type with complex content must have complex content ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-31) | [11-10](#rule-11-10) |
| [Rule 9-32, Base type of complex type with complex content must have complex content ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-32) | [11-10](#rule-11-10) |
| [Rule 9-33, Simple content uses extension ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-33) | [11-68](#rule-11-68) |
| [Rule 9-34, No complex type disallowed substitutions ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-34) | [11-69](#rule-11-69) |
| [Rule 9-35, No complex type disallowed derivation ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-35) | [11-69](#rule-11-69) |
| [Rule 9-36, Element declaration is top-level ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-36) | [11-39](#rule-11-39) |
| [Rule 9-37, Element declaration has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-37) | [8-2](#rule-8-2) |
| [Rule 9-38, Untyped element is abstract ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-38) | [11-11](#rule-11-11) |
| [Rule 9-39, Element of type xs:anySimpleType is abstract ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-39) | [11-11](#rule-11-11) |
| [Rule 9-40, Element type not in the XML Schema namespace ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-40) | [11-12](#rule-11-12) |
| [Rule 9-41, Element type not in the XML namespace ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-41) | [11-12](#rule-11-12) |
| [Rule 9-42, Element type is not simple type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-42) | [11-40](#rule-11-40) |
| [Rule 9-43, No element disallowed substitutions ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-43) | [11-69](#rule-11-69) |
| [Rule 9-44, No element disallowed derivation ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-44) | [11-69](#rule-11-69) |
| [Rule 9-45, No element default value ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-45) | [11-15](#rule-11-15) |
| [Rule 9-46, No element fixed value ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-46) | [11-15](#rule-11-15) |
| [Rule 9-47, Element declaration is nillable ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-47) | [11-43](#rule-11-43) |
| [Rule 9-48, Attribute declaration is top-level ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-48) | [11-39](#rule-11-39) |
| [Rule 9-49, Attribute declaration has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-49) | [8-2](#rule-8-2) |
| [Rule 9-50, Attribute declaration has type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-50) | [11-14](#rule-11-14) |
| [Rule 9-51, No attribute type of xs:ID ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-51) | [11-7](#rule-11-7) |
| [Rule 9-52, No attribute type of xs:IDREF ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-52) | [11-7](#rule-11-7) |
| [Rule 9-53, No attribute type of xs:IDREFS ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-53) | [11-7](#rule-11-7) |
| [Rule 9-54, No attribute type of xs:ENTITY ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-54) | [11-7](#rule-11-7) |
| [Rule 9-55, No attribute type of xs:ENTITIES ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-55) | [11-7](#rule-11-7) |
| [Rule 9-56, No attribute type of xs:anySimpleType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-56) | [11-7](#rule-11-7) |
| [Rule 9-57, No attribute default values ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-57) | [11-15](#rule-11-15) |
| [Rule 9-58, No fixed values for optional attributes ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-58) | [11-15](#rule-11-15) |
| [Rule 9-59, No use of element xs:notation ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-59) | [11-3](#rule-11-3) |
| [Rule 9-60, Model group does not affect meaning ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-60) | *no matching NIEM6 rule* |
| [Rule 9-61, No xs:all ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-61) | [11-3](#rule-11-3) |
| [Rule 9-62, xs:sequence must be child of xs:extension ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-62) | [11-24](#rule-11-24) |
| [Rule 9-63, xs:sequence must be child of xs:extension or xs:restriction ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-63) | [11-25](#rule-11-25) |
| [Rule 9-64, No xs:choice ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-64) | [11-70](#rule-11-70) |
| [Rule 9-65, xs:choice must be child of xs:sequence ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-65) | [11-17](#rule-11-17) |
| [Rule 9-66, Sequence has minimum cardinality 1 ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-66) | [11-16](#rule-11-16) |
| [Rule 9-67, Sequence has maximum cardinality 1 ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-67) | [11-16](#rule-11-16) |
| [Rule 9-68, Choice has minimum cardinality 1 ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-68) | [11-18](#rule-11-18) |
| [Rule 9-69, Choice has maximum cardinality 1 ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-69) | [11-18](#rule-11-18) |
| [Rule 9-70, No use of xs:any ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-70) | [9-17](#rule-9-17), [9-18](#rule-9-18) |
| [Rule 9-71, No use of xs:anyAttribute ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-71) | [9-17](#rule-9-17), [9-18](#rule-9-18) |
| [Rule 9-72, No use of xs:unique ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-72) | [11-3](#rule-11-3) |
| [Rule 9-73, No use of xs:key ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-73) | [11-3](#rule-11-3) |
| [Rule 9-74, No use of xs:keyref ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-74) | [11-3](#rule-11-3) |
| [Rule 9-75, No use of xs:group ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-75) | [11-3](#rule-11-3) |
| [Rule 9-76, No definition of attribute groups ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-76) | [11-3](#rule-11-3) |
| [Rule 9-77, Comment is not recommended ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-77) | [11-19](#rule-11-19) |
| [Rule 9-78, Documentation element has no element children ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-78) | [11-20](#rule-11-20) |
| [Rule 9-79, xs:appinfo children are comments, elements, or whitespace ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-79) | [11-21](#rule-11-21) |
| [Rule 9-80, Appinfo child elements have namespaces ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-80) | [11-22](#rule-11-22) |
| [Rule 9-81, Appinfo descendants are not XML Schema elements ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-81) | [11-23](#rule-11-23) |
| [Rule 9-82, Schema has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-82) | [8-1](#rule-8-1) |
| [Rule 9-83, Schema document defines target namespace ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-83) | [9-2](#rule-9-2) |
| [Rule 9-84, Target namespace is absolute URI ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-84) | [9-1](#rule-9-1), [9-2](#rule-9-2) |
| [Rule 9-85, Schema has version ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-85) | [9-5](#rule-9-5), [9-6](#rule-9-6) |
| [Rule 9-86, No disallowed substitutions ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-86) | [11-69](#rule-11-69) |
| [Rule 9-87, No disallowed derivations ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-87) | [11-69](#rule-11-69) |
| [Rule 9-88, No use of xs:redefine ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-88) | [11-3](#rule-11-3) |
| [Rule 9-89, No use of xs:include ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-89) | [11-3](#rule-11-3) |
| [Rule 9-90, xs:import must have namespace ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-90) | [11-73](#rule-11-73) |
| [Rule 9-91, XML Schema document set must be complete ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-91) | [11-82](#rule-11-82) |
| [Rule 9-92, Namespace referenced by attribute type is imported ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-92) | [11-83](#rule-11-83) |
| [Rule 9-93, Namespace referenced by attribute base is imported ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-93) | [11-83](#rule-11-83) |
| [Rule 9-94, Namespace referenced by attribute itemType is imported ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-94) | [11-83](#rule-11-83) |
| [Rule 9-95, Namespaces referenced by attribute memberTypes is imported ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-95) | [11-83](#rule-11-83) |
| [Rule 9-96, Namespace referenced by attribute ref is imported ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-96) | [11-83](#rule-11-83) |
| [Rule 9-97, Namespace referenced by attribute substitutionGroup is imported ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_9-97) | [11-83](#rule-11-83) |
| [Rule 10-1, Complex type has a category ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-1) | [11-27](#rule-11-27) |
| [Rule 10-2, Object type with complex content is derived from structures:ObjectType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-2) | [11-28](#rule-11-28) |
| [Rule 10-3, RoleOf element type is an object type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-3) | *no matching NIEM6 rule* |
| [Rule 10-4, Only object type has RoleOf element ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-4) | *no matching NIEM6 rule* |
| [Rule 10-5, RoleOf elements indicate the base types of a role type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-5) | *no matching NIEM6 rule* |
| [Rule 10-6, Instance of RoleOf element indicates a role object ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-6) | *no matching NIEM6 rule* |
| [Rule 10-7, Import of external namespace has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-7) | [11-45](#rule-11-45) |
| [Rule 10-8, External adapter type has indicator ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-8) | [11-46](#rule-11-46) |
| [Rule 10-9, Structure of external adapter type definition follows pattern ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-9) | [11-47](#rule-11-47) |
| [Rule 10-10, Element use from external adapter type defined by external schema documents ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-10) | [11-48](#rule-11-48) |
| [Rule 10-11, External adapter type not a base type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-11) | [11-49](#rule-11-49) |
| [Rule 10-12, External adapter type not a base type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-12) | [11-49](#rule-11-49) |
| [Rule 10-13, External attribute use only in external adapter type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-13) | [11-71](#rule-11-71) |
| [Rule 10-14, External attribute use has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-14) | [11-50](#rule-11-50) |
| [Rule 10-15, External attribute use not an ID ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-15) | [11-51](#rule-11-51) |
| [Rule 10-16, External element use has data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-16) | [11-52](#rule-11-52) |
| [Rule 10-17, Name of code type ends in CodeType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-17) | [7-5](#rule-7-5), [7-8](#rule-7-8) |
| [Rule 10-18, Code type corresponds to a code list ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-18) | [7-5](#rule-7-5), [7-8](#rule-7-8) |
| [Rule 10-19, Element of code type has code representation term ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-19) | [7-11](#rule-7-11) |
| [Rule 10-20, Proxy type has designated structure ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-20) | [7-21](#rule-7-21), [11-53](#rule-11-53) |
| [Rule 10-21, Association type derived from structures:AssociationType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-21) | [7-4](#rule-7-4), [11-30](#rule-11-30) |
| [Rule 10-22, Association element type is an association type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-22) | [7-10](#rule-7-10) |
| [Rule 10-23, Augmentable type has augmentation point element ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-23) | [11-54](#rule-11-54) |
| [Rule 10-24, Augmentable type has at most one augmentation point element ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-24) | [11-54](#rule-11-54) |
| [Rule 10-25, Augmentation point element corresponds to its base type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-25) | [11-55](#rule-11-55) |
| [Rule 10-26, An augmentation point element has no type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-26) | [11-56](#rule-11-56) |
| [Rule 10-27, An augmentation point element has no substitution group ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-27) | [11-57](#rule-11-57) |
| [Rule 10-28, Augmentation point element is only referenced by its base type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-28) | [11-58](#rule-11-58) |
| [Rule 10-29, Augmentation point element use is optional ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-29) | [11-59](#rule-11-59) |
| [Rule 10-30, Augmentation point element use is unbounded ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-30) | [11-59](#rule-11-59) |
| [Rule 10-31, Augmentation point element use must be last element in its base type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-31) | [11-60](#rule-11-60) |
| [Rule 10-32, Element within instance of augmentation type modifies base ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-32) | *no matching NIEM6 rule* |
| [Rule 10-33, Only an augmentation type name ends in AugmentationType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-33) | [7-14](#rule-7-14) |
| [Rule 10-34, Schema component with name ending in AugmentationType is an augmentation type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-34) | [7-14](#rule-7-14) |
| [Rule 10-35, Type derived from structures:AugmentationType is an augmentation type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-35) | [11-31](#rule-11-31) |
| [Rule 10-36, Augmentation element type is an augmentation type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-36) | [7-15](#rule-7-15) |
| [Rule 10-37, Augmentation elements are not used directly ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-37) | [11-36](#rule-11-36) |
| [Rule 10-38, Metadata type has data about data ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-38) | *no matching NIEM6 rule* |
| [Rule 10-39, Metadata types are derived from structures:MetadataType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-39) | *no matching NIEM6 rule* |
| [Rule 10-40, Metadata element declaration type is a metadata type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-40) | *no matching NIEM6 rule* |
| [Rule 10-41, Metadata element has applicable elements ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-41) | *no matching NIEM6 rule* |
| [Rule 10-42, Name of element that ends in Representation is abstract ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-42) | [7-9](#rule-7-9) |
| [Rule 10-43, A substitution for a representation element declaration is a value for a type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-43) | *no matching NIEM6 rule* |
| [Rule 10-44, Schema component name composed of English words ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-44) | [7-22](#rule-7-22) |
| [Rule 10-45, Schema component name has xml:lang ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-45) | [9-7](#rule-9-7), [9-8](#rule-9-8) |
| [Rule 10-46, Schema component names have only specific characters ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-46) | [7-23](#rule-7-23) |
| [Rule 10-47, Punctuation in component name is a separator ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-47) | [7-27](#rule-7-27) |
| [Rule 10-48, Names use camel case ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-48) | [7-24](#rule-7-24) |
| [Rule 10-49, Attribute name begins with lower case letter ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-49) | [7-25](#rule-7-25) |
| [Rule 10-50, Name of schema component other than attribute and proxy type begins with upper case letter ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-50) | [7-26](#rule-7-26) |
| [Rule 10-51, Names use common abbreviations ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-51) | [7-41](#rule-7-41) |
| [Rule 10-52, Local term declaration is local to its schema document ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-52) | [7-43](#rule-7-43) |
| [Rule 10-53, Local terminology interpretation ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-53) | *no matching NIEM6 rule* |
| [Rule 10-54, Singular form is preferred in name ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-54) | [7-28](#rule-7-28) |
| [Rule 10-55, Present tense is preferred in name ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-55) | [7-29](#rule-7-29) |
| [Rule 10-56, Name does not have nonessential words ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-56) | [7-30](#rule-7-30) |
| [Rule 10-57, Element or attribute name follows pattern ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-57) | [7-31](#rule-7-31) |
| [Rule 10-58, Object-class term identifies concrete category ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-58) | [7-32](#rule-7-32) |
| [Rule 10-59, Property term describes characteristic or subpart ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-59) | [7-33](#rule-7-33) |
| [Rule 10-60, Name may have multiple qualifier terms ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-60) | [7-34](#rule-7-34) |
| [Rule 10-61, Name has minimum necessary number of qualifier terms ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-61) | [7-35](#rule-7-35) |
| [Rule 10-62, Order of qualifiers is not significant ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-62) | [7-36](#rule-7-36) |
| [Rule 10-63, Redundant term in name is omitted ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-63) | [7-37](#rule-7-37) |
| [Rule 10-64, Element with simple content has representation term ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-64) | [7-38](#rule-7-38) |
| [Rule 10-65, Element with complex content has representation term when appropriate ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-65) | [7-39](#rule-7-39) |
| [Rule 10-66, Element with complex content has representation term only when appropriate ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-66) | [7-40](#rule-7-40) |
| [Rule 10-67, Machine-readable annotations are valid ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-67) | *no matching NIEM6 rule* |
| [Rule 10-68, Component marked as deprecated is deprecated component ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-68) | [11-61](#rule-11-61) |
| [Rule 10-69, Deprecated annotates schema component ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-69) | [11-62](#rule-11-62) |
| [Rule 10-70, External import indicator annotates import ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-70) | [11-63](#rule-11-63) |
| [Rule 10-71, External adapter type indicator annotates complex type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-71) | *no matching NIEM6 rule* |
| [Rule 10-72, appinfo:appliesToTypes annotates metadata element ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-72) | *no matching NIEM6 rule* |
| [Rule 10-73, appinfo:appliesToTypes references types ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-73) | *no matching NIEM6 rule* |
| [Rule 10-74, appinfo:appliesToElements annotates metadata element ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-74) | *no matching NIEM6 rule* |
| [Rule 10-75, appinfo:appliesToElements references elements ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-75) | *no matching NIEM6 rule* |
| [Rule 10-76, appinfo:LocalTerm annotates schema ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-76) | [7-44](#rule-7-44), [11-64](#rule-11-64) |
| [Rule 10-77, appinfo:LocalTerm has literal or definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-77) | [7-42](#rule-7-42) |
| [Rule 10-78, Use structures consistent with specification ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_10-78) | [11-84](#rule-11-84) |
| [Rule 11-1, Name of type ends in Type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-1) | [7-1](#rule-7-1) |
| [Rule 11-2, Only types have name ending in Type or SimpleType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-2) | [7-1](#rule-7-1), [7-18](#rule-7-18) |
| [Rule 11-3, Base type definition defined by conformant schema ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-3) | [11-33](#rule-11-33) |
| [Rule 11-4, Name of simple type ends in SimpleType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-4) | [7-19](#rule-7-19) |
| [Rule 11-5, Use lists only when data is uniform ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-5) | *no matching NIEM6 rule* |
| [Rule 11-6, List item type defined by conformant schemas ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-6) | [11-37](#rule-11-37) |
| [Rule 11-7, Union member types defined by conformant schemas ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-7) | [11-38](#rule-11-38) |
| [Rule 11-8, Name of a code simple type ends in CodeSimpleType ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-8) | [7-7](#rule-7-7) |
| [Rule 11-9, Code simple type corresponds to a code list ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-9) | [7-7](#rule-7-7) |
| [Rule 11-10, Attribute of code simple type has code representation term ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-10) | [7-11](#rule-7-11) |
| [Rule 11-11, Complex type with simple content has structures:SimpleObjectAttributeGroup ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-11) | [11-32](#rule-11-32) |
| [Rule 11-12, Element type does not have a simple type name ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-12) | [11-40](#rule-11-40) |
| [Rule 11-13, Element type is from conformant namespace ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-13) | [11-41](#rule-11-41) |
| [Rule 11-14, Name of element that ends in Abstract is abstract ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-14) | [7-9](#rule-7-9) |
| [Rule 11-15, Name of element declaration with simple content has representation term ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-15) | [7-38](#rule-7-38) |
| [Rule 11-16, Name of element declaration with simple content has representation term ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-16) | [7-38](#rule-7-38) |
| [Rule 11-17, Element substitution group defined by conformant schema ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-17) | [11-42](#rule-11-42) |
| [Rule 11-18, Attribute type defined by conformant schema ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-18) | [11-41](#rule-11-41) |
| [Rule 11-19, Attribute name uses representation term ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-19) | [7-38](#rule-7-38) |
| [Rule 11-20, Element or attribute declaration introduced only once into a type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-20) | [9-21](#rule-9-21) |
| [Rule 11-21, Element reference defined by conformant schema ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-21) | [11-34](#rule-11-34) |
| [Rule 11-22, Referenced attribute defined by conformant schemas ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-22) | [11-34](#rule-11-34) |
| [Rule 11-23, Schema uses only known attribute groups ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-23) | [11-35](#rule-11-35) |
| [Rule 11-24, Data definition does not introduce ambiguity ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-24) | [8-6](#rule-8-6) |
| [Rule 11-25, Object class has only one meaning ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-25) | [8-7](#rule-8-7) |
| [Rule 11-26, Data definition of a part does not redefine the whole ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-26) | [8-8](#rule-8-8) |
| [Rule 11-27, Do not leak representation into data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-27) | [8-9](#rule-8-9) |
| [Rule 11-28, Data definition follows 11179-4 requirements ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-28) | [8-10](#rule-8-10) |
| [Rule 11-29, Data definition follows 11179-4 recommendations ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-29) | [8-11](#rule-8-11) |
| [Rule 11-30, xs:documentation has xml:lang ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-30) | [9-7](#rule-9-7), [9-8](#rule-9-8) |
| [Rule 11-31, Standard opening phrase for augmentation point element data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-31) | [8-23](#rule-8-23) |
| [Rule 11-32, Standard opening phrase for augmentation element data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-32) | [8-24](#rule-8-24) |
| [Rule 11-33, Standard opening phrase for metadata element data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-33) | *no matching NIEM6 rule* |
| [Rule 11-34, Standard opening phrase for association element data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-34) | [8-13](#rule-8-13) |
| [Rule 11-35, Standard opening phrase for abstract element data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-35) | [8-12](#rule-8-12) |
| [Rule 11-36, Standard opening phrase for date element or attribute data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-36) | [8-14](#rule-8-14) |
| [Rule 11-37, Standard opening phrase for quantity element or attribute data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-37) | [8-15](#rule-8-15) |
| [Rule 11-38, Standard opening phrase for picture element or attribute data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-38) | [8-16](#rule-8-16) |
| [Rule 11-39, Standard opening phrase for indicator element or attribute data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-39) | [8-17](#rule-8-17) |
| [Rule 11-40, Standard opening phrase for identification element or attribute data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-40) | [8-18](#rule-8-18) |
| [Rule 11-41, Standard opening phrase for name element or attribute data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-41) | [8-19](#rule-8-19) |
| [Rule 11-42, Standard opening phrase for element or attribute data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-42) | [8-20](#rule-8-20) |
| [Rule 11-43, Standard opening phrase for association type data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-43) | [8-21](#rule-8-21) |
| [Rule 11-44, Standard opening phrase for augmentation type data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-44) | [8-25](#rule-8-25) |
| [Rule 11-45, Standard opening phrase for metadata type data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-45) | *no matching NIEM6 rule* |
| [Rule 11-46, Standard opening phrase for complex type data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-46) | [8-22](#rule-8-22) |
| [Rule 11-47, Standard opening phrase for simple type data definition ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-47) | [8-22](#rule-8-22) |
| [Rule 11-48, Same namespace means same components ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-48) | *no matching NIEM6 rule* |
| [Rule 11-49, Different version means different view ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-49) | *no matching NIEM6 rule* |
| [Rule 11-50, Reference schema document imports reference schema document ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-50) | [9-19](#rule-9-19), [11-76](#rule-11-76) |
| [Rule 11-51, Extension schema document imports reference or extension schema document ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-51) | [9-20](#rule-9-20), [11-77](#rule-11-77) |
| [Rule 11-52, Structures imported as conformant ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-52) | [11-78](#rule-11-78) |
| [Rule 11-53, XML namespace imported as conformant ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-53) | [11-79](#rule-11-79) |
| [Rule 11-54, Each namespace may have only a single root schema in a schema set ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-54) | [11-80](#rule-11-80) |
| [Rule 11-55, Consistently marked namespace imports ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_11-55) | [11-81](#rule-11-81) |
| [Rule 12-1, Instance must be schema-valid ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-1) | [12-1](#rule-12-1) |
| [Rule 12-2, Empty content has no meaning ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-2) | [12-2](#rule-12-2) |
| [Rule 12-3, Element has only one resource identifying attribute ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-3) | [12-3](#rule-12-3) |
| [Rule 12-4, Attribute structures:ref must reference structures:id ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-4) | [12-4](#rule-12-4) |
| [Rule 12-5, Linked elements have same validation root ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-5) | [12-5](#rule-12-5) |
| [Rule 12-6, Attribute structures:ref references element of correct type ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-6) | [12-6](#rule-12-6) |
| [Rule 12-7, structures:uri denotes resource identifier ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-7) | [12-7](#rule-12-7) |
| [Rule 12-8, structures:id and structures:ref denote resource identifier ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-8) | [12-9](#rule-12-9) |
| [Rule 12-9, Nested elements and references have the same meaning. ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-9) | [12-10](#rule-12-10) |
| [Rule 12-10, Order of properties is expressed via structures:sequenceID ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-10) | *no matching NIEM6 rule* |
| [Rule 12-11, Metadata applies to referring entity ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-11) | *no matching NIEM6 rule* |
| [Rule 12-12, Referent of structures:relationshipMetadata annotates relationship ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-12) | *no matching NIEM6 rule* |
| [Rule 12-13, Values of structures:metadata refer to values of structures:id ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-13) | *no matching NIEM6 rule* |
| [Rule 12-14, Values of structures:relationshipMetadata refer to values of structures:id ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-14) | *no matching NIEM6 rule* |
| [Rule 12-15, structures:metadata and structures:relationshipMetadata refer to metadata elements ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-15) | *no matching NIEM6 rule* |
| [Rule 12-16, Attribute structures:metadata references metadata element ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-16) | *no matching NIEM6 rule* |
| [Rule 12-17, Attribute structures:relationshipMetadata references metadata element ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-17) | *no matching NIEM6 rule* |
| [Rule 12-18, Metadata is applicable to element ](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/niem-ndr-5.0.html#rule_12-18) | *no matching NIEM6 rule* |

-------

# Appendix W. Safety, Security and Privacy Considerations

(Note: OASIS strongly recommends that Open Projects consider issues that might affect safety, security, privacy, and/or data protection in implementations of their specification and document them for implementers and adopters. For some purposes, you may find it required, e.g. if you apply for IANA registration.

While it may not be immediately obvious how your specification might make systems vulnerable to attack, most specifications, because they involve communications between systems, message formats, or system settings, open potential channels for exploit. For example, IETF [[RFC3552](#rfc3552)] lists “eavesdropping, replay, message insertion, deletion, modification, and man-in-the-middle” as well as potential denial of service attacks as threats that must be considered and, if appropriate, addressed in IETF RFCs.

In addition to considering and describing foreseeable risks, this section should include guidance on how implementers and adopters can protect against these risks.

We encourage editors and OP members concerned with this subject to read _Guidelines for Writing RFC Text on Security Considerations_, IETF [[RFC3552](#rfc3552)], for more information.

Remove this note before submitting for publication.)

-------

# Appendix X. Acknowledgments

`(Note: A Work Product approved by the OP should include a list of people who participated in the development of the Work Product. This is generally done by collecting the list of names in this appendix. This list should be initially compiled by the Chair, and any Member of the OP may add or remove their names from the list by request. Remove this note before submitting for publication.)`

## D.1 Special Thanks

(This is an optional subsection to call out contributions from OP members. If a OP wants to thank non-OP members then they should avoid using the term "contribution" and instead thank them for their "expertise" or "assistance".)

Substantial contributions to this document from the following individuals are gratefully acknowledged:

Participant Name, Affiliation or "Individual Member"

## D.2 Participants

(An OP can determine who they list here. It is common practice for OPs to list everyone that was part of the OP during the creation of the document, but this is ultimately an OP decision on who they want to list and not list.)

The following individuals have participated in the creation of this specification and are gratefully acknowledged:

**Project-name OP Members:**

| First Name | Last Name | Company |
| :--- | :--- | :--- |
| Aubrey | Beach | JS J6 |
| Brad | Bollinger | Ernst & Young |
| James | Cabral | Individual |
| Tom | Carlson | GTRI |
| Chuck | Chipman | GTRI |
| Mike | Douklias | JS J6 | 
| Katherine | Escobar | JS J6 |
| Lavdjola | Farrington | JS J6 |
| Dave | Hardy | JS J6 |
| Mike | Hulme | Unisys |
| Eric | Jahn | Alexandria Consulting |
| Dave | Kemp | NSA |
| Vamsi | Kondannagari | Integral Fed | 
| Shunda | Louis | JS J6 |
| Peter | Madruga | GTRI |
| Christina | Medlin | GTRI |
| Joe | Mierwa | Mission Critical Partners |
| April | Mitchell | FBI |
| Carl | Nelson | RISS |
| Scott | Renner | MITRE
| Beth | Smalley | JS J6 |
| Duncan | Sparrell | sFractal |
| Jennifer | Stathakis | NIST |
| Stephen | Sullivan | JS J6 |
| Josh | Wilson | FBI |

-------

# Appendix Y. Revision History

Revisions made since the initial stage of this numbered Version of this document may be tracked here.

If revision tracking is handled in another system like github, provide a link to it instead of using this table, if desired.

| Revision | Date | Editor | Changes Made |
| :--- | :--- | :--- | :--- |
| | 2024-02-26 | Scott Renner | Attempts to be a fairly complete outline of NDR6. |
| | 2024-04-10 | Scott Renner | Includes sections 1 and 2.  The plan now is to keep filling out this outline until enough sections are complete. Then we will remove the comment stuff and apply the OASIS template. |
| | 2024-04-15 | Scott Renner | Revised section 3 |
| | 2024-04-24 | Scott Renner | New section 4, Section 3 comments from incorporated.
| | 2024-05-04 | Scott Renner | Section 3: better description of message spec, type, format; new figure 3-3, Section 4: comments, new examples and figures; flattened outline
| | 2024-05-20 | Scott Renner | Nearly complete section 5 -- still need section on augmentations |
| | 2024-06-03 | Scott Renner | Combined section 4 and 5 into new section 4: "Data models in NIEM" -- metamodel, CMF, and XSD, Outlined section 5: "Modeling rules for NIEM XSD", Moved a lot of XSD stuff from section 3 into the new section 5, Comments  incorporated |
| | 2024-06-24 | Scott Renner | Incorporated comments, Augmentation section is complete |
| | 2024-07-01 | Scott Renner | New subsections in section 2, New text in section 3.6 (canonical representation in XSD and CMF), Lots of new stuff in section 5.1 |
| | 2024-07-08 | Scott Renner | Conformance is a major section (new section 5), Conformance targets now apply to namespaces, not schema documents, Section 6 is now "Rules for namespaces and models" |
| | 2024-07-10 | Scott Renner | Naming rules (section 6) complete |
| | 2024-07-15 | Scott Renner | Rules for documentation, extension schemas and models complete, new placeholder section 5 (data modeling patterns) |
| | 2024-07-19 | Scott Renner | All NDR 5 schema rules handled, NDR5 to NDR6 crossref appendix added, comments incorporated|

-------

# Appendix Z. Notices

(This required section should not be altered, except to modify the license information in the second paragraph if needed.)


Copyright &copy; OASIS Open 2024. All Rights Reserved.

All capitalized terms in the following text have the meanings assigned to them in the OASIS Intellectual Property Rights Policy (the "OASIS IPR Policy"). The full [Policy](https://www.oasis-open.org/policies-guidelines/ipr/) may be found at the OASIS website.

This specification is published under [Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/legalcode).
Code associated with this specification is provided under [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

All contributions made to this project have been made under the [OASIS Contributor License Agreement (CLA)](https://www.oasis-open.org/policies-guidelines/open-projects-process/#individual-cla-exhibit).

For information on whether any patents have been disclosed that may be essential to implementing this specification, and any offers of patent licensing terms, please refer to the [NIEMOpen IPR Statement](https://github.com/niemopen/oasis-open-project/blob/main/IPR-STATEMENT.md) page.

This document and translations of it may be copied and furnished to others, and derivative works that comment on or otherwise explain it or assist in its implementation may be prepared, copied, published, and distributed, in whole or in part, without restriction of any kind, provided that the above copyright notice and this section are included on all such copies and derivative works. However, this document itself may not be modified in any way, including by removing the copyright notice or references to OASIS, except as needed for the purpose of developing any document or deliverable produced by an OASIS Open Project (in which case the rules applicable to copyrights, as set forth in the OASIS IPR Policy, must be followed) or as required to translate it into languages other than English.

The limited permissions granted above are perpetual and will not be revoked by OASIS or its successors or assigns.

This document and the information contained herein is provided on an "AS IS" basis and OASIS DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF THE INFORMATION HEREIN WILL NOT INFRINGE ANY OWNERSHIP RIGHTS OR ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. OASIS AND ITS MEMBERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THIS DOCUMENT OR ANY PART THEREOF.

As stated in the OASIS IPR Policy, the following three paragraphs in brackets apply to OASIS Standards Final Deliverable documents (Project Specifications, OASIS Standards, or Approved Errata).

[OASIS requests that any OASIS Party or any other party that believes it has patent claims that would necessarily be infringed by implementations of this OASIS Standards Final Deliverable, to notify OASIS TC Administrator and provide an indication of its willingness to grant patent licenses to such patent claims in a manner consistent with the IPR Mode of the OASIS Open Project that produced this deliverable.]

[OASIS invites any party to contact the OASIS TC Administrator if it is aware of a claim of ownership of any patent claims that would necessarily be infringed by implementations of this OASIS Standards Final Deliverable by a patent holder that is not willing to provide a license to such patent claims in a manner consistent with the IPR Mode of the OASIS Open Project that produced this OASIS Standards Final Deliverable. OASIS may include such claims on its website, but disclaims any obligation to do so.]

[OASIS takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this OASIS Standards Final Deliverable or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any effort to identify any such rights. Information on OASIS' procedures with respect to rights in any document or deliverable produced by an OASIS Open Project can be found on the OASIS website. Copies of claims of rights made available for publication and any assurances of licenses to be made available, or the result of an attempt made to obtain a general license or permission for the use of such proprietary rights by implementers or users of this OASIS Standards Final Deliverable, can be obtained from the OASIS TC Administrator. OASIS makes no representation that any information or list of intellectual property rights will at any time be complete, or that any claims in such list are, in fact, Essential Claims.]

The name "OASIS" is a trademark of [OASIS](https://www.oasis-open.org/), the owner and developer of this specification, and should be used only to refer to the organization and its official outputs. OASIS welcomes reference to, and implementation and use of, specifications, while reserving the right to enforce its marks against misleading uses. Please see https://www.oasis-open.org/policies-guidelines/trademark/ for above guidance.
