# NIEM JSON Specification
- Version 5.0
- May 7, 2021
- NIEM Technical Architecture Committee (NTAC)

# Abstract

The NIEM JSON Specification establishes the technical basis for using JavaScript Object Notation (JSON) as a data format for exchange of information consistent with NIEM-conformant schemas and message specifications.

NIEM-conformance of JSON data is primarily focused on the relationship between the data in a JSON document and definitions established by a NIEM-conformant schema, such as the schema defined by a NIEM message specification. There are two forms of conformance of a NIEM JSON document to a NIEM-conformant schema:

- **Strict conformance** establishes that the JSON instance follows all rules of the schema or message specification. An instance that strictly conforms to a message specification will contain all content that is required by the message specification, will contain only content allowed by the message specification, and will reflect the parent-child structure and cardinality constraints defined by the message specification. This enables NIEM JSON to satisfy exchange requirements similar to traditional NIEM XML use cases.
- **Lax conformance** enables the use of vocabularies that are defined by NIEM schemas or message specifications via _linked data_ and _linked open data_ methods. It establishes that exchanges with NIEM-conformant vocabularies use those vocabularies properly; this allows data to be more flexible, and to combine terms from NIEM-conformant vocabularies with terms from other vocabularies.

# Authors

NTAC

# Document status

This specification is a product of the NIEM Technical Architecture Committee (NTAC).

Updates, revisions, and errata for this specification are posted to <a class="url" target="_blank" href="https://github.com/NIEM/NIEM-JSON-Spec">https://github.com/NIEM/NIEM-JSON-Spec</a>. Please submit comments on this specification as issues at <a class="url" target="_blank" href="https://github.com/NIEM/NIEM-JSON-Spec/issues">https://github.com/NIEM/NIEM-JSON-Spec/issues</a>.

# Table of contents

- [1. Introduction](#introduction)

	- [1.1. Audience](#audience)

- [2. Document conventions and normative content](#document-conventions-and-normative-content)

	- [2.1. Document references](#document-references)
	- [2.2. Normative and informative content](#normative-and-informative-content)

		- [2.2.1. Rules](#rules)

	- [2.3. Additional formatting](#additional-formatting)

- [3. External terminology](#external-terminology)

	- [3.1. IETF Best Current Practice 14 terminology](#ietf-best-current-practice-14-terminology)
	- [3.2. Conformance Targets Attribute Specification](#conformance-targets-attribute-specification)
	- [3.3. NIEM Naming and Design Rules](#niem-naming-and-design-rules)
	- [3.4. Model Package Description Specification](#model-package-description-specification)
	- [3.5. JSON](#json)
	- [3.6. JSON-LD](#json-ld)
	- [3.7. RDF and RDF Schema](#rdf-and-rdf-schema)

- [4. Conformance targets](#conformance-targets)

	- [4.1. NIEM JSON document strictly conformant to a schema](#niem-json-document-strictly-conformant-to-a-schema)
	- [4.2. NIEM JSON document laxly conformant to a schema](#niem-json-document-laxly-conformant-to-a-schema)

- [5. Rules](#rules)

	- [5.1. Literal-to-object conversion](#literal-to-object-conversion)

		- [5.1.1. Example of literal-to-object conversion](#example-of-literal-to-object-conversion)

	- [5.2. NIEM JSON Normalization](#niem-json-normalization)

		- [5.2.1. Example of NIEM JSON Normalization](#example-of-niem-json-normalization)

	- [5.3. External content omission](#external-content-omission)

- [Appendix A. References](#appendix-a-references)
- [Appendix B. Index of definitions](#appendix-b-index-of-definitions)
- [Appendix C. Index of rules](#appendix-c-index-of-rules)

# Introduction

The NIEM JSON Specification establishes the technical basis for using JavaScript Object Notation (JSON) as a data format for exchange of information consistent with NIEM-conformant schemas and message specifications.

NIEM-conformance of JSON data is primarily focused on the relationship between the data in a JSON document and definitions established by a NIEM-conformant schema, such as the schema defined by a NIEM message specification. There are two forms of conformance of a NIEM JSON document to a NIEM-conformant schema:

- **Strict conformance** establishes that the JSON instance follows all rules of the schema or message specification. An instance that strictly conforms to a message specification will contain all content that is required by the message specification, will contain only content allowed by the message specification, and will reflect the parent-child structure and cardinality constraints defined by the message specification. This enables NIEM JSON to satisfy exchange requirements similar to traditional NIEM XML use cases.
- **Lax conformance** enables the use of vocabularies that are defined by NIEM schemas or message specifications via _linked data_ and _linked open data_ methods. It establishes that exchanges with NIEM-conformant vocabularies use those vocabularies properly; this allows data to be more flexible, and to combine terms from NIEM-conformant vocabularies with terms from other vocabularies.

## Audience

This document was developed as a technical specification and is intended to be neither a user guide nor an introduction to the use of JSON for NIEM. Its intended audience is developers of tools that work with NIEM and NIEM JSON, or other individuals who require an understanding of the details of the alignment between NIEM JSON and other representations of NIEM data.

Developers of NIEM message formats with a JSON representation may prefer to read the NIEM JSON documentation at <a class="url" target="_blank" href="https://niem.github.io/json/">https://niem.github.io/json/</a>, specifically the _[NIEM JSON Tutorial](https://niem.github.io/json/tutorial/)_, which proceeds step-by-step from data requirements to a conforming JSON representation. Developers of systems that read and write NIEM JSON messages should conform to the relevant message descriptions.

# Document conventions and normative content

This document uses formatting and syntactic conventions to clarify meaning and avoid ambiguity.

## Document references

This document relies on references to many outside documents. Such references are noted by bold, bracketed inline terms. For example, a reference to RFC 2119 is shown as [RFC 2119](#Appendix-A-References). All reference documents are recorded in [Appendix A, _References_, below](#appendix-a-references).

## Normative and informative content

This document includes a variety of content. Some content of this document is _normative_, while other content is _informative_. In general, the informative material appears as supporting text, description, and rationales for the normative material.

> **[Definition: normative]**
> The term "normative" is as defined by [ConfReq](#Appendix-A-References) Section 7.2, _Conformance by key words_, which states:
>
>> NORMATIVE — statements provided for the prescriptive parts of the specification, providing that which is necessary in order to be able to claim conformance to the specification.

> **[Definition: informative]**
> The term "informative" is as defined by [ConfReq](#Appendix-A-References) Section 7.2, _Conformance by key words_, which states:
>
>> INFORMATIVE (NON-NORMATIVE) — statements provided for informational purposes, intended to assist the understanding or use of the specification and shall not contain provisions that are required for conformance.

Definitions within this document are _normative_, and are given special formatting.

> **[Definition: &lt;term&gt;]**
> A formal definition of a word or phrase.

Uses of these terms are given special formatting, using raised dots to identify the term. For example the use of the term _conformance target_ has special formatting.

### Rules

A rule states a specific requirement on a _conformance target_ or on the interpretation of a _conformance target_. The classes of _conformance target_ are enumerated in [Section 4, _Conformance targets_, below](#conformance-targets). Rules are normative. Human-readable text in rules uses [BCP 14](#Appendix-A-References) terminology as described in [Section 3.1, _IETF Best Current Practice 14 terminology_, below,](#ietf-best-current-practice-14-terminology) for normative requirements and recommendations.

> **[Rule &lt;section&gt;-&lt;number&gt;] (&lt;applicability&gt;) (&lt;classification&gt;)**
> An enforceable rule.

Each rule has a _classification_, which is either "Constraint" or "Interpretation". If the classification is "Constraint", then the rule is a _constraint rule_. If the classification is "Interpretation", then the rule is an _interpretation rule_.

> **[Definition: constraint rule]**
> A **constraint rule** is a rule that sets a requirement on an artifact with respect to its conformance to a _conformance target_.

> **[Definition: interpretation rule]**
> An **interpretation rule** is a rule that sets the methodology, pattern, or procedure for understanding some aspect of an instance of a conformance target.

Each rule identifies its _applicability_. This identifies the conformance targets to which the rule applies. Each entry in the list is a code from _Table 4-1, _Codes representing conformance targets_, below_. If a code appears in the applicability list for a rule, then the rule applies to the corresponding conformance target. For example, a rule with applicability "(STRICT)" is applicable to _NIEM JSON document strictly conformant to a schema_.

Rules are numbered according to the section in which they appear and the order in which they appear within that section. For example, the second rule in Section 4 is Rule 4-2.

## Additional formatting

In addition to the special formatting above, this document uses additional formatting conventions.

`Courier`: All words appearing in `Courier` font are values, objects, keywords, or literal XML text.

_Italics_: A phrase appearing in _italics_ is one of:

- a title of a section of document or a rule,
- a locally-defined term, often one that is not normatively defined, or
- is emphasized for importance or prominence.

**Bold**: A phrase appearing in **bold** is one of:

- a term being defined within a definition,
- a term that was bold in the original source text for a quote
- a heading, such as for a section, figure, definition, or rule, or
- a cross-reference within the document or to a reference to an outside document.

Throughout the document, fragments of code appear, including XML, RDF, and JSON-LD. These fragments are specially formatted in `Courier` font and appear in text boxes. An example of such a fragment follows:

## Figure 2-1: Example of an XML fragment

```xml
<xs:complexType name="PersonType">
 ...
</xs:complexType>
```

# External terminology

This document uses terminology from other documents. This section identifies sources and definitions of externally-defined terminology.

## IETF Best Current Practice 14 terminology

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [BCP 14](#Appendix-A-References)      [RFC 2119](#Appendix-A-References)      [RFC 8174](#Appendix-A-References) when, and only when, they appear in all capitals, as shown here.

## Conformance Targets Attribute Specification

[CTAS](#Appendix-A-References) defines several terms used normatively within this specification.

The term conformance target is defined by [CTAS](#Appendix-A-References)      [Section 3.1, _Conformance Target Defined_](https://reference.niem.gov/niem/specification/conformance-targets-attribute/3.0/#definition_conformance_target) which states:

> A _conformance target_ is a class of artifact, such as an interface, protocol, document, platform, process or service, that is the subject of conformance clauses and normative statements. There may be several conformance targets defined within a specification, and these targets may be diverse so as to reflect different aspects of a specification. For example, a protocol message and a protocol engine may be different conformance targets.

The term conformance target identifier is defined by [CTAS](#Appendix-A-References)      [Section 3.1, _Conformance Target Defined_](https://reference.niem.gov/niem/specification/conformance-targets-attribute/3.0/#definition_conformance_target_identifier), which states:

> A _conformance target identifier_ is an internationalized resource identifier that uniquely identifies a conformance target.

The term effective conformance target identifier is defined by [CTAS](#Appendix-A-References)      [Section 4, _Semantics and Use_](https://reference.niem.gov/niem/specification/conformance-targets-attribute/3.0/#definition_effective_conformance_target_identifier), which states:

> An _effective conformance target identifier_ of a conformant document is an internationalized resource identifier reference that occurs in the document’s effective conformance targets attribute.

## NIEM Naming and Design Rules

The term conformant schema document set is a _conformance target_ defined by the [NIEM NDR](#Appendix-A-References)      [Section 4.1.3, _Schema document set_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#definition_conformant_schema_document_set), which states: 

> A **conformant schema document set** is a collection of schema documents that together are capable of validating a conformant instance XML document.

Note that the principal component of a NIEM message specification is a conformant schema document set.

The term conformant instance XML document is a _conformance target_ defined by the [NIEM NDR](#Appendix-A-References)      [Section 4.1.4, _Instance documents and elements_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#definition_conformant_instance_XML_document), which states: 

> A **conformant instance XML document** is an XML document that is [an] instance document valid to a conformant schema document set.

Although the above definitions for the _conformance targets_      _conformant schema document set_ and _conformant instance XML document_ reference each other, each conformance target is supported by a set of rules. Each artifact (i.e., document set or XML document) must conform to all rules for its conformance target in order to conform to the conformance target.

The term reference schema document is a _conformance target_ defined by the [NIEM NDR](#Appendix-A-References)      [Section 4.1.1, _Reference schema document_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#definition_reference_schema_document), which states: 

> A **reference schema document** is a schema document that is intended to provide the authoritative definitions of broadly reusable schema components.

The term extension schema document is a _conformance target_ defined by the [NIEM NDR](#Appendix-A-References)      [Section 4.1.2, _Extension schema document_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#definition_extension_schema_document), which states: 

> An **extension schema document** is a schema document that is intended to provide definitions of schema components that are intended for reuse within a more narrow scope than those defined by a reference schema document.

The term external schema document is defined by the [NIEM NDR](#Appendix-A-References)      [Section 10.2.3, _External adapter types and external components_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#definition_external_schema_document), which states: 

> An **external schema document** is any schema document that is not one of

- a reference schema document,
- an extension schema document, or
- a schema document that has the structures namespace as its target namespace.

## Model Package Description Specification

The term IEP conformance target is defined by [IEPD](#Appendix-A-References)      [Section 5.6, _Defining Information Exchange Packages_](https://reference.niem.gov/niem/specification/model-package-description/5.0/#definition_IEP_conformance_target). An IEP conformance target defines a set of conformance criteria for a class of _information exchange package (IEP)_.

The term information exchange package is defined by [IEPD](#Appendix-A-References)      [Section 3.2.3, _IEP Conformance Targets_](https://reference.niem.gov/niem/specification/model-package-description/5.0/#definition_information_exchange_package). An information exchange package (IEP) is an XML document that conforms to the criteria defined for an _IEP conformance target_.

This document refers to an artifact that specifies NIEM-conformant information exchanges as a _message specification_. An information exchange package documentation (IEPD), as defined by [IEPD](#Appendix-A-References), is a form of message specification.

## JSON

The term JSON text is defined by [RFC8259](#Appendix-A-References)      [Section 2, _JSON Grammar_](https://tools.ietf.org/html/rfc8259#section-2), which defines it as a single serialized JSON value.

The term JSON document, when used within this document, is synonymous with _JSON text_.

## JSON-LD

[JSON-LD](#Appendix-A-References) defines JSON-LD, a JSON-based format to serialize linked data. [JSON-LD](#Appendix-A-References) defines the term JSON-LD document. [JSON-LD](#Appendix-A-References)      [Section 7, _Data Model_](https://www.w3.org/TR/2014/REC-json-ld-20140116/#dfn-json-ld-document) provides a summary of what constitutes a JSON-LD document. [JSON-LD](#Appendix-A-References)      [Section 8, _JSON-LD Grammar_](https://www.w3.org/TR/2014/REC-json-ld-20140116/#json-ld-grammar) states:

> A JSON-LD document MUST be a valid JSON document as described in [RFC4627](#Appendix-A-References).

[JSON-LD](#Appendix-A-References) leverages [RFC4627](#Appendix-A-References) as a normative definition of JSON. That specification has been superseded by [RFC8259](#Appendix-A-References). Consequently, this specification uses [RFC8259](#Appendix-A-References) as its normative definition of JSON.

[JSON-LD](#Appendix-A-References) normatively references the term _JSON document_ in [RFC4627](#Appendix-A-References), which does not define that term. We interpret this to be a reference to _JSON text_ as defined by [RFC8259](#Appendix-A-References).

The evaluation of a JSON-LD document as Resource Description Framework (RDF) is specified by [JSON-LD-API](#Appendix-A-References).

## RDF and RDF Schema

[RDF-Concepts](#Appendix-A-References)      [Section 3, _RDF Graphs_](https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/#dfn-rdf-graph) defines the term RDF graph:

> An RDF graph is a set of RDF triples.

[RDF-Concepts](#Appendix-A-References)      [Section 1.7, _Equivalence, Entailment and Inconsistency_](https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/#dfn-equivalence) defines the term equivalent:

> Two RDF graphs A and B are equivalent if they make the same claim about the world. A is equivalent to B if and only if A entails B and B entails A.

[RDF-Schema](#Appendix-A-References) describes RDF Schema (RDFS), which provides a data-modeling vocabulary for RDF data. [NIEM NDR](#Appendix-A-References) defines components of NIEM-conformant schema document sets in terms of RDF Schema.

Property `rdf:value` is defined by [RDF-Schema](#Appendix-A-References)      [Section 5.4.3, _rdf:value_](https://www.w3.org/TR/rdf-schema/#ch_value). This property is used within an object to carry a simple value with no additional meaning.

# Conformance targets

This document defines multiple _conformance targets_. Each conformance target is defined normatively by this specification. Each conformance target has an associated abbreviation, which appears in rules to identify to which conformance targets a rule applies.

## Table 4-1: Codes representing conformance targets

| Code   | Conformance target                                                                                                                                                                 |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| STRICT | [NIEM JSON document strictly conformant to a schema](https://niem.github.io/NIEM-JSON-Spec/v5.0/niem-json-spec.html#definition_NIEM_JSON_document_strictly_conformant_to_a_schema) |
| LAX    | [NIEM JSON document laxly conformant to a schema](https://niem.github.io/NIEM-JSON-Spec/v5.0/niem-json-spec.html#definition_NIEM_JSON_document_laxly_conformant_to_a_schema)       |

## NIEM JSON document strictly conformant to a schema

> **[Definition: NIEM JSON document strictly conformant to a schema]**
> A **NIEM JSON document strictly conformant to a schema** is a _JSON-LD document_ that may be assigned a one-to-one correspondence to a _conformant instance XML document_ valid against a _conformant schema document set_. It is a _conformance target_ of this specification. A NIEM JSON document strictly conformant to a schema MUST conform to all rules of this specification that apply to this conformance target. The _conformance target identifier_ for this conformance target is `http://reference.niem.gov/niem/specification/niem-json-spec/5.0/#Strict`.

## NIEM JSON document laxly conformant to a schema

> **[Definition: NIEM JSON document laxly conformant to a schema]**
> A **NIEM JSON document laxly conformant to a schema** is a _JSON-LD document_ that may be interpreted using the RDF vocabulary defined by a _conformant schema document set_. It is a _conformance target_ of this specification. A NIEM JSON document laxly conformant to a schema MUST conform to all rules of this specification that apply to this conformance target. The _conformance target identifier_ for this conformance target is `http://reference.niem.gov/niem/specification/niem-json-spec/5.0/#Lax`.

# Rules

## Rule 5-1. File must be a JSON-LD file

> **[Rule 5-1] (<a href="#conformance_target_STRICT">STRICT</a>, <a href="#conformance_target_LAX">LAX</a>) (Constraint)**
> A _NIEM JSON document strictly conformant to a schema_ or _NIEM JSON document laxly conformant to a schema_ MUST be a _JSON-LD document_.

## Rule 5-2. Strictly conformant JSON corresponds to valid XML

> **[Rule 5-2] (<a href="#conformance_target_STRICT">STRICT</a>) (Constraint)**
> The _RDF graph_ entailed by a _NIEM JSON document strictly conformant to a schema_ MUST be _equivalent_ to the _RDF graph_ entailed by a corresponding _conformant instance XML document_ instance of the schema, accounting for _NIEM JSON normalization_ and the omission of external content.

Within this rule, the _schema_ includes a _conformant schema document set_, as well as all other constraints of an _IEP conformance target_ defined by an IEPD.

The _RDF graph_ entailed by a candidate JSON document is described by [JSON-LD-API](#Appendix-A-References). The _RDF graph_ entailed by an XML document is described by [NIEM NDR](#Appendix-A-References). This rule does not provide or require a translation of JSON to XML, although such a translation may be helpful in validating this rule.

## Rule 5-3. JSON is satisfiable with schema

> **[Rule 5-3] (<a href="#conformance_target_STRICT">STRICT</a>, <a href="#conformance_target_LAX">LAX</a>) (Constraint)**
> The _RDF graph_ consisting of the union of:
> 
> 1.  the [RDF graph](https://niem.github.io/NIEM-JSON-Spec/v5.0/niem-json-spec.html#definition_RDF_graph) entailed by the [JSON document](https://niem.github.io/NIEM-JSON-Spec/v5.0/niem-json-spec.html#definition_JSON_document) and
> 2.  the [RDF graph](https://niem.github.io/NIEM-JSON-Spec/v5.0/niem-json-spec.html#definition_RDF_graph) entailed by the schema
> 
> MUST be RDFS satisfiable, accounting for _literal-to-object conversion_ and the omission of external content.

Within this rule, a schema is a _conformant schema document set_. The RDF entailed by a JSON-LD document is defined by [JSON-LD-API](#Appendix-A-References). The RDF entailed by a schema is defined by [NIEM NDR](#Appendix-A-References). The term _RDFS satisfiable_ is defined by [RDF-Semantics](#Appendix-A-References).

## Rule 5-4. JSON interpreted based on schema

> **[Rule 5-4] (<a href="#conformance_target_STRICT">STRICT</a>, <a href="#conformance_target_LAX">LAX</a>) (Interpretation)**
> A _NIEM JSON document strictly conformant to a schema_ or _NIEM JSON document laxly conformant to a schema_ MUST be interpreted as an RDFS interpretation of the RDF graph composed of the RDF entailed by the JSON document together with the RDF entailed by the schema.

Within this rule, a schema is a _conformant schema document set_. The RDF entailed by a JSON-LD document is defined by [JSON-LD-API](#Appendix-A-References). The RDF entailed by a schema is defined by [NIEM NDR](#Appendix-A-References). The term _RDFS interpretation_ is defined by [RDF-Semantics](#Appendix-A-References).

## Literal-to-object conversion

Although all NIEM elements have values that are complex types, which by [NIEM NDR](#Appendix-A-References)      [Section 5.6.3.2, _Element instance_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#section_5.6.3.2) entail an RDF object (rather than a literal value), JSON syntax for objects with simple values is cumbersome. For this reason, NIEM JSON instances may use a shorthand syntax, in which any element with only a simple value may be represented as a literal, rather than as an object with a value carried by `rdf:value`. To accommodate these cases, conformant JSON documents are evaluated based on the results of _literal-to-object conversion_, a process that yields a JSON object in which literal values are converted to idiomatic objects when appropriate.

> **[Definition: literal-to-object conversion]**
> Within this document, **literal-to-object conversion** is a process by which a JSON value is transformed from a value of false, null, true, number, or string, into an object containing only the property `rdf:value`. Evaluation of conformance of a _JSON document_ is conducted on the results of literal-to-object conversion of that document.

### Example of literal-to-object conversion

This section provides an example of literal-to-object conversion. It shows the conversion of a simple XML instance document to a corresponding simple JSON-LD object. The following is a simple XML instance document:

### Figure 5-1: XML representation of simple example

```xml
<nc:PersonFullName xmlns:nc="http://release.niem.gov/niem/niem-core/5.0/">
   Sherlock Holmes
</nc:PersonFullName>
```

[NIEM NDR](#Appendix-A-References)       [Section 5.6.3.2, _Element instance_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#section_5.6.3.2) specifies that each element that is defined by a NIEM-conformant schema carries an object value, not a literal value. The value of the above element `nc:PersonName` is an object with a single simple value of type string, which is reflected by the following RDF, in Turtle format (defined by [RDF-Turtle](#Appendix-A-References)):

### Figure 5-2: RDF representation of simple example

```rdf
@prefix nc:  <http://release.niem.gov/niem/niem-core/5.0/> .
@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
_:b0    nc:PersonFullName  _:b1 .
_:b1    rdf:value  "Sherlock Holmes" .
```

The JSON-LD versions of the example use the following JSON-LD context:

### Figure 5-3: JSON-LD context for simple example

```json
{
   "nc" : "http://release.niem.gov/niem/niem-core/5.0/",
   "rdf" : "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
   "xs" : "http://www.w3.org/2001/XMLSchema"
}
```

The JSON-LD version of the above instance includes the object, with the literal name as an `rdf:value` property. The type for the literal is the nearest base type that appears within the list of RDF-compatible XSD types provided by [RDF-Types](#Appendix-A-References)       [Section 5.1, _The XML Schema Built-in Datatypes_](https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/#xsd-datatypes).

### Figure 5-4: JSON-LD representation of simple example

```json
{
 "nc:PersonFullName" : {
   "rdf:value": {
     "@value": "Sherlock Holmes",
     "@type": "xs:string"
   }
 }
}
```

Users of NIEM JSON have expressed a preference for a representation of data that is less verbose than the above. By converting from an object to a literal, the JSON-LD may be simplified:

### Figure 5-5: JSON-LD example using literals

```json
{
 "nc:PersonFullName" : "Sherlock Holmes"
}
```

_Literal-to-object conversion_ is the transformation from _Figure 5-5, _JSON-LD example using literals_, above,_ to _Figure 5-4, _JSON-LD representation of simple example_, above_. Following the _literal-to-object conversion_ process ensures that the resulting JSON can be mapped to the same RDF as for the XML version.

Users may express NIEM data using a brief format, with the knowledge that it represents the more verbose use of objects instead of bare literals through the _NIEM JSON Normalization_ process.

## NIEM JSON Normalization

The literal-to-object conversion process forms the core of NIEM JSON Normalization, a process allowing for even briefer JSON expressions of NIEM data while maintaining a deterministic transformation to NIEM JSON-LD. The process consists of two steps:

1. Apply a context to map simple JSON names to fully qualified NIEM names
1. Iteratively convert each literal to an object

> **[Definition: NIEM JSON normalization]**
> Within this document, **NIEM JSON normalization** is a process by which a _JSON document_ is transformed into a NIEM conformant document via the application of a context and an iterative application of _literal-to-object conversions_, transforming simple JSON name/value pairs from simple names with values of false, null, true, number, or string, into NIEM conformant objects containing only the property `rdf:value`.
>
> Evaluation of conformance of a _JSON document_ is conducted on the results of NIEM JSON normalization of that document.

### Example of NIEM JSON Normalization

This section provides an example of _NIEM JSON normalization_. It shows the conversion of a simple JSON document to a corresponding Normalized JSON-LD object. The following is a simple plain NIEM JSON document:

### Figure 5-6: Plain NIEM JSON

```json
{
 "birth": {
   "date": "1978-01-01"
 }
}
```

A JSON-LD context maps the simple JSON names to the corresponding NIEM names:

### Figure 5-7: JSON-LD Context

```json
{
 "nc": "http://release.niem.gov/niem/niem-core/5.0/",
 "birth": "nc:PersonBirthDate",
 "date": "nc:Date"
}
```

Applying that JSON-LD context to the simple plain NIEM JSON document produces this plain NIEM JSON plus context document:

### Figure 5-8: Plain NIEM JSON + Context

```json
{
 "@context": {
   "nc": "http://release.niem.gov/niem/niem-core/5.0/"
 },
 "nc:PersonBirthDate": {
   "nc:Date": "1978-01-01"
 }
}
```

Using the techniques in [Section 5.1, _Literal-to-object conversion_, above,](#literal-to-object-conversion) to replace the literal string, we get the following normalized NIEM JSON-LD:

### Figure 5-9: Normalized NIEM JSON-LD

```json
{
 "@context": {
   "nc": "http://release.niem.gov/niem/niem-core/5.0/",
   "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
   "xs": "http://www.w3.org/2001/XMLSchema"
 },
 "nc:PersonBirthDate": {
   "nc:Date": {
     "rdf:value": {
       "@value": "1978-01-01",
       "@type": "xs:date"
     }
   }
 }
}
```

The RDF graph entailed by _Figure 5-9, _Normalized NIEM JSON-LD_, above,_ is equivalent to the RDF graph entailed by the conformant instance XML document shown in _Figure 5-10, _NIEM XML_, below_. This demonstrates conformance of the JSON-LD in _Figure 5-9, _Normalized NIEM JSON-LD_, above_. The plain NIEM JSON in _Figure 5-6, _Plain NIEM JSON_, above,_ is therefore also conforming.

The advantage of normalization is that it allows the runtime exchange of plain NIEM JSON like that shown in _Figure 5-6, _Plain NIEM JSON_, above_, while also allowing the evaluation of that data for conformance when necessary.

### Figure 5-10: NIEM XML

```xml
<nc:PersonBirthDate xmlns:nc="http://release.niem.gov/niem/niem-core/5.0/">
 <nc:Date>1978-01-01</nc:Date>
</nc:PersonBirthDate>
```

## External content omission

NIEM provides a mechanism for data that is not NIEM-conformant to be included within NIEM data. Such data is called external content (see [NIEM NDR](#Appendix-A-References)      [Section 10.2.3, _External adapter types and external components_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#section_10.2.3)). External content includes any content with a namespace defined by an _external schema document_, or with any namespace not defined by a _reference schema document_ or _extension schema document_.

NIEM provides a mapping from NIEM-conformant XML content and XML Schemas to RDF (see [NIEM NDR](#Appendix-A-References)      [Section 5, _The NIEM conceptual model_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#section_5)). The NDR rules do not provide a mapping from external content to RDF.

An object carried by an external element (i.e., an instance of an element that is in a namespace not defined by NIEM-conformant schema documents) may be part of a subgraph of resources and properties that are not described by NIEM-conformant schemas. Such an object may be mapped to a resource that is assigned an IRI that is a blank node (described by [NIEM NDR](#Appendix-A-References)      [Section 5.4, _Unique identification of data objects_](https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/#section_5.4)), or may be given a more meaningful resource identifier.

Since the structure and content of such a subgraph is not described by NIEM-conformant schemas, its structure and content are not material to the conformance of a JSON document by this specification. Such content may effectively be omitted from consideration of its validity against a schema, as regards conformance to this specification. Other specifications may introduce introduce additional rules, but that is outside the scope of this specification.

# Appendix A. References

<p class="hang">[BCP 14]: Internet Engineering Task Force Best Current Practice 14. Available from <a class="url" target="_blank" href="https://www.ietf.org/rfc/bcp/bcp14.txt">https://www.ietf.org/rfc/bcp/bcp14.txt</a>. BCP 14 is composed of:

> [RFC 2119]: Bradner, S., Key words for use in RFCs to Indicate Requirement Levels, BCP 14, RFC 2119, March 1997. Available from [http://www.ietf.org/rfc/rfc2119.txt](http://www.ietf.org/rfc/rfc2119.txt).
>
> [RFC 8174]: Leiba, B., Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words, BCP 14, RFC 8174, May 2017. Available from [https://www.ietf.org/rfc/rfc8174.txt](https://www.ietf.org/rfc/rfc8174.txt).

<p class="hang">[ConfReq]: Lynne Rosenthal, and Mark Skall, eds. "Conformance Requirements for Specifications v1.0." The Organization for the Advancement of Structured Information Standards (OASIS), March 15, 2002. Available from <a class="url" target="_blank" href="https://www.oasis-open.org/committees/download.php/305/conformance_requirements-v1.pdf">https://www.oasis-open.org/committees/download.php/305/conformance_requirements-v1.pdf</a>.

<p class="hang">[CTAS]: Roberts, Webb. "NIEM Conformance Targets Attribute Specification, Version 3.0." NIEM Technical Architecture Committee. Available from <a class="url" target="_blank" href="https://reference.niem.gov/niem/specification/conformance-targets-attribute/3.0/">https://reference.niem.gov/niem/specification/conformance-targets-attribute/3.0/</a>.

<p class="hang">[JSON-LD]: Manu Sporny, Dave Longley, Gregg Kellogg, Markus Lanthaler, and Niklas Lindström. "JSON-LD 1.0, A JSON-Based Serialization for Linked Data, W3C Recommendation." Edited by Manu Sporny, Gregg Kellogg, and Markus Lanthaler. W3C, January 16, 2014. Available from <a class="url" target="_blank" href="https://www.w3.org/TR/2014/REC-json-ld-20140116/">https://www.w3.org/TR/2014/REC-json-ld-20140116/</a>.

<p class="hang">[JSON-LD-API]: Dave Longley, Gregg Kellogg, Markus Lanthaler, and Manu Sporny. "JSON-LD 1.0 Processing Algorithms and API." Edited by Markus Lanthaler, Gregg Kellogg, and Manu Sporny. W3C, January 16, 2014. Available from <a class="url" target="_blank" href="https://www.w3.org/TR/2014/REC-json-ld-api-20140116/">https://www.w3.org/TR/2014/REC-json-ld-api-20140116/</a>.

<p class="hang">[IEPD]: NIEM Technical Architecture Committee. "National Information Exchange Package Description (IEPD) Specification, Version 5.0". Available from <a class="url" target="_blank" href="https://reference.niem.gov/niem/specification/model-package-description/5.0/">https://reference.niem.gov/niem/specification/model-package-description/5.0/</a>.

<p class="hang">[NIEM NDR]: Roberts, Webb. "National Information Exchange Model Naming and Design Rules, Version 5.0." NIEM Technical Architecture Committee. Available from <a class="url" target="_blank" href="https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/">https://reference.niem.gov/niem/specification/naming-and-design-rules/5.0/</a>.

<p class="hang">[RDF-Concepts]: Richard Cyganiak, David Wood, and Markus Lanthaler, eds. "RDF 1.1 Concepts and Abstract Syntax." W3C Recommendation. The World Wide Web Consortium (W3C), February 25, 2014. Available from <a class="url" target="_blank" href="https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/">https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/</a>.

<p class="hang">[RDF-Schema]: Dan Brickley, and R.V. Guha, eds. "RDF Schema 1.1." The World Wide Web Consortium (W3C), February 25, 2014. Available from <a class="url" target="_blank" href="http://www.w3.org/TR/2014/REC-rdf-schema-20140225/">http://www.w3.org/TR/2014/REC-rdf-schema-20140225/</a>.

<p class="hang">[RDF-Semantics]: Patrick J. Hayes, and Peter F. Patel-Schneider, eds. "RDF 1.1 Semantics." The World Wide Web Consortium (W3C), February 25, 2014. Available from <a class="url" target="_blank" href="https://www.w3.org/TR/2014/REC-rdf11-mt-20140225/">https://www.w3.org/TR/2014/REC-rdf11-mt-20140225/</a>.

<p class="hang">[RDF-Turtle]: "RDF 1.1 Turtle, Terse RDF Triple Language," W3C Recommendation 25 February 2014. Available from <a class="url" target="_blank" href="https://www.w3.org/TR/2014/REC-turtle-20140225/">https://www.w3.org/TR/2014/REC-turtle-20140225/</a>.

<p class="hang">[RDF-Types]: "RDF 1.1 Concepts and Abstract Syntax," W3C Recommendation 25 February 2014. Available from <a class="url" target="_blank" href="https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/">https://www.w3.org/TR/2014/REC-rdf11-concepts-20140225/</a>.

<p class="hang">[RFC4627]: D. Crockford. "The application/json Media Type for JavaScript Object Notation (JSON) (RFC 4627)." July 2006. RFC. Available from <a class="url" target="_blank" href="http://www.ietf.org/rfc/rfc4627.txt">http://www.ietf.org/rfc/rfc4627.txt</a>

<p class="hang">[RFC8259]: Bray, T., Ed., "The JavaScript Object Notation (JSON) Data Interchange Format," STD 90, RFC 8259, DOI 10.17487/RFC8259, December 2017, Available from <a class="url" target="_blank" href="https://www.ietf.org/rfc/rfc8259.txt">https://www.ietf.org/rfc/rfc8259.txt</a>.

# Appendix B. Index of definitions

- _conformance target_: [Section 3.2, _Conformance Targets Attribute Specification_](#conformance-targets-attribute-specification)
- _conformance target identifier_: [Section 3.2, _Conformance Targets Attribute Specification_](#conformance-targets-attribute-specification)
- _conformant instance XML document_: [Section 3.3, _NIEM Naming and Design Rules_](#niem-naming-and-design-rules)
- _conformant schema document set_: [Section 3.3, _NIEM Naming and Design Rules_](#niem-naming-and-design-rules)
- _constraint rule_: [Section 2.2.1, _Rules_](#rules)
- _effective conformance target identifier_: [Section 3.2, _Conformance Targets Attribute Specification_](#conformance-targets-attribute-specification)
- _equivalent_: [Section 3.7, _RDF and RDF Schema_](#rdf-and-rdf-schema)
- _extension schema document_: [Section 3.3, _NIEM Naming and Design Rules_](#niem-naming-and-design-rules)
- _external schema document_: [Section 3.3, _NIEM Naming and Design Rules_](#niem-naming-and-design-rules)
- _IEP_: [Section 3.4, _Model Package Description Specification_](#model-package-description-specification)
- _IEP conformance target_: [Section 3.4, _Model Package Description Specification_](#model-package-description-specification)
- _information exchange package_: [Section 3.4, _Model Package Description Specification_](#model-package-description-specification)
- _informative_: [Section 2.2, _Normative and informative content_](#normative-and-informative-content)
- _interpretation rule_: [Section 2.2.1, _Rules_](#rules)
- _JSON document_: [Section 3.5, _JSON_](#json)
- _JSON text_: [Section 3.5, _JSON_](#json)
- _JSON-LD document_: [Section 3.6, _JSON-LD_](#json-ld)
- _literal-to-object conversion_: [Section 5.1, _Literal-to-object conversion_](#literal-to-object-conversion)
- _NIEM JSON document laxly conformant to a schema_: [Section 4.2, _NIEM JSON document laxly conformant to a schema_](#niem-json-document-laxly-conformant-to-a-schema)
- _NIEM JSON document strictly conformant to a schema_: [Section 4.1, _NIEM JSON document strictly conformant to a schema_](#niem-json-document-strictly-conformant-to-a-schema)
- _NIEM JSON normalization_: [Section 5.2, _NIEM JSON Normalization_](#niem-json-normalization)
- _normative_: [Section 2.2, _Normative and informative content_](#normative-and-informative-content)
- _RDF graph_: [Section 3.7, _RDF and RDF Schema_](#rdf-and-rdf-schema)
- _reference schema document_: [Section 3.3, _NIEM Naming and Design Rules_](#niem-naming-and-design-rules)

# Appendix C. Index of rules

- [Rule 5-1, _File must be a JSON-LD file_ (STRICT, LAX)](#rule-5-1-file-must-be-a-json-ld-file): [Section 5, _Rules_](#rules)
- [Rule 5-2, _Strictly conformant JSON corresponds to valid XML_ (STRICT)](#rule-5-2-strictly-conformant-json-corresponds-to-valid-xml): [Section 5, _Rules_](#rules)
- [Rule 5-3, _JSON is satisfiable with schema_ (STRICT, LAX)](#rule-5-3-json-is-satisfiable-with-schema): [Section 5, _Rules_](#rules)
- [Rule 5-4, _JSON interpreted based on schema_ (STRICT, LAX)](#rule-5-4-json-interpreted-based-on-schema): [Section 5, _Rules_](#rules)

