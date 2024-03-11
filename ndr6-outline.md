> 2024-02-26 draft
>
> Attempts to be a fairly complete outline of NDR6. Includes everything I can remember from the 2024-02-22 NDR-outline telcon.  
>
> I tried to include all of the essential goals and principles from NDR 5.  I tried to mash up everything important from the technical architecture PN, the architecture change PN, the data modeling paper, the NTAC discussions, and the NDR discussions and issues.
>
> I did not pay any attention to the OASIS template.  I did not try to fit into the [niem-ndr.md](https://github.com/niemopen/niem-naming-design-rules/blob/dev/niem-ndr.md) document that is posted in the NDR dev branch.

**Outline**

> Last Thursday we figured out:  We aren't going to introduce any new *modeling formalisms*, so we don't need to put CMF and XSD into separate documents.  We aren't going to introduce new *message serializations* soon, so we don't really need to put NIEM XML and NIEM JSON into separate documents, either.  When we support a new serialization, that will go into a separate document (at least until we suck it into NDR 7).

[TOC]

## 1. Introduction

* NIEM and NIEMOpen
  * NIEM refers to the model and technical architecture. This document is part of the specification of the technical architecture.
  * NIEMOpen is the OASIS Open Project
* other intro stuff tbd – doc conventions, typography, etc.

## 2. How To Read This Document

This document provides normative specifications for NIEM data models. It also describes the goals and principles behind those specifications. It includes examples and explanations to help people understand the goals, principles, and specifications. Different people will have the greatest interest in different sections.

* *Business analysts and subject matter experts* – <<who are they, what sections should they read>>
* *Message designers* – <<etc.>>
* *Message developers*
* *Software tool developers*

The relationships between these roles and NIEM are illustrated in figures [3-1](#fig3-1) and [3-2](#fig3-2), which appear in the next section: an overview of the NIEM technical architecture. This section is recommended to all readers.

## 3. Overview of the NIEM Technical Architecture

This overview describes NIEM's design goals and principles. It introduces key features of the architecture that will be defined in more detail later in the document.

### 3.1 Machine-to-machine data specifications

> 

NIEM is a framework for developer-level specifications of data. A NIEM-based data specification – which is built *using* NIEM and in *conformance* to NIEM, but is not itself a *part* of NIEM – describes data to the developers of producing and consuming systems. This data may be shared via:

* a message passed between applications
* an information resource published on the web
* an API for a system or service

NIEM is potentially useful for any mechanism that transfers a package of data across a system or organization boundary. (In a large system, NIEM may be useful when data passes from one developer team to another.)

The primary purpose of a NIEM-based data specification is to establish a common understanding among developers, so that they can write software that correctly handles the shared data, hence "machine-to-machine". (The content of a NIEM message may also be directly presented to human consumers, but that is not the main purpose of NIEM.)

In NIEM terms, the package of data shared at runtime is a *message*. A *message format* specifies the syntax and semantics of a class of messages; it defines the mandatory and optional content of a message and the meaning of that content. A *message type* specifies the information content of a class of messages without prescribing a serialization. Both of these specifications are expressed in terms of a machine-readable *data model*, using either of NIEM's two *modeling formats.* A collection of related message formats and types is a *message specification.*

> A NIEM message was originally known as an *information exchange package (IEP)*, a term derived from the Federal Enterprise Architecture (2005).  A message specification was originally known as an *information exchange package documentation (IEPD).*  These terms are still in widespread use within the NIEM community today, and will not go away soon (if ever). 

A *message designer* creates a message format from an information requirement, so that a message at runtime will contain all the facts that need to be conveyed. Then any number of *message developers* write software to implement the specification, producing or processing messages that follow the message format. Message designers need some understanding of NIEM, but the message developers do not. (Sometimes the message developers do not even know that NIEM exists.)

<center>
  <a name="fig3-1"/></a>
  <figure>
    <img src="images/fig3-1.png" alt="figure" style="zoom: 50%;" />
    <figcaption><i>Figure 3-1: NIEM-based machine-to-machine data exchange</i>
  </figure>
</center>

NIEM supports serialization in XML and JSON-LD; support for others (YAML, Protobuf, etc.) may be added in the future. One feature of NIEM is that messages of the same type are convertable across serializations; for example, NIEM XML can be converted to NIEM JSON, and vice versa, with no bespoke programming required. 

### 3.2 Reuse of community-agreed data models

NIEM is also a framework for communities to create data models for concepts that are useful in many data specifications. These community models are typically not *complete* for any particular specification. Instead, they reflect the community's judgement on which defintions are *worth the trouble of agreement*. The NIEM core model contains definitions found useful by the NIEM community as a whole. NIEM domain models reuse the core, extending it with defintions found useful by the domain community. The core model plus the domain models comprise the "NIEM model". Data specification designers reuse definitions from the core and domain models, adding definitions that they require but have not (so far!) been found worthy of inclusion in the NIEM model.

<center>
<figure class="image">
    <a name="fig3-2"/></a>
  <img src="images/fig3-2.png" style="zoom:50%"/>
  <figcaption><i>Figure 3-2: NIEM communities and data models</i></figcaption>
</figure>
</center>

This reuse is especially useful in a large enterprise. Its value grows with the number of developer teams, and with the degree of commonality in the shared data. NIEM was originally designed for data sharing among federal, state, and local governments – where commonality and number of developer teams is large indeed.

### 3.3 Reuse of open standards

NIEM is built on a foundation of open standards, primarily:

* XML and XSD – message serialization and validation; also a modeling formalism
* JSON and JSON-LD – message serialization and linked data
* RDF, RDFS, and OWL – formal semantics
* ISO 11179 – data element naming conventions

A NIEM principle is to reuse well-known information technology standards when these are supported by free and open-source software. NIEM avoids reuse of standards that effectively depend on expensive COTS development or runtime software. When the NIEMOpen project defines a standard of its own, it also provides free and open-source software to support it.

### 3.4 Namespaces

The components of a NIEM model are partitioned into *namespaces.* This prevents name clashes among communities or domains that have different business perspectives and may choose identical data names to represent different data concepts.

Each namespace has an author: a person or organization that is the authoritative source for the namespace definitions. A namespace is the collection of model components for concepts of interest to the namespace author. Namespace cohesion is important; a namespace should be designed so that its components are consistent, may be used together, and may be updated at the same time.

> ISO 11179 rules and local terminology could go here?

### 3.5 Models

* Two main kinds of data model, plus a third for convenience
  * Community agreement
  * Message
  * Subset
* The information requirement for these NIEM data models can itself be modeled
  * Required: semantics and syntax
  * Abstract model of information requirement – the metamodel
  * Main model components:  Class, Property, Datatype
  * [insert UML diagram showing only Model, Namespace, Component, Class, Property, Datatype, w/o properties]
* NIEM supports two concrete modeling formats for the metamodel: XSD and CMF, described below.

### 3.6 NIEM models in XSD

XML Schema is a modeling formalism for all existing versions of NIEM.  The naming and design rules for XSD [link] amplify and constrain this use of XML Schema, for three reasons:

  1. For reuse:  To permit XML schema documents created by independent communities to be composed into a single data exchange specification, and to forbid schema constructs that needlessly limit such reuse. 
  2. For semantics:  To impose meaning on the definitions and declarations in a NIEM XML schema document, and on the elements and attributes in a NIEM XML message. 
  3. For developer convenience:  To forbid, where consistent with #1 and #2, constructs in XSD that cause difficulties with COTS XML tooling.

> There is an XSD example in the data modeling paper; do we want it here?

### 3.7 NIEM models in CMF

XSD as a modeling format supports conformance testing of NIEM XML messages through schema validation. But this is of no use to JSON developers working with JSON messages, who have no interest in reading XSD to understand a NIEM message format. Nor do developers working with any other serialization. In addition, software to read model information from an XML schema document pile is hard to write, which means working with NIEM XSD is a serious obstacle to NIEM tool developers. 

CMF is NIEM's answer to those difficulties – an alternative modeling format to support non-XML message developers and NIEM tool developers. CMF is a NIEM-based data specification like any other. A NIEM data model expressed in CMF is a NIEM message, and like any NIEM message, can be converted between XML, JSON, and any other supported serialization.

> Insert CMF example (equivalent to XSD above)?

### 3.8 The NIEM conceptual model

NIEM models in XSD and CMF define the detailed meaning of messages in a particular message format.  But there is another model, the *NIEM conceptual model*, that supplies the meaning of NIEM data *in general*. According to this conceptual model, the data in any NIEM message is a collection of statements about the world; for example, that a person has a name, a residence location, a spouse, etc. The assertion of one set of facts does not necessarily rule out other statements: A person could have multiple names, could have moved, or could be divorced. Each statement is a claim asserted to be true by the author of the message.

This conceptual model is based on a set of W3C Recommendations, the Resource Description Framework (RDF). NIEM models and messages have an equivalent representation in RDF. This provides numerous advantages:

* NIEM’s conceptual model is defined by a recognized standard.
* NIEM’s conceptual model is very well defined.
* NIEM’s use of the RDF model defines what a set of NIEM data means. The RDF specification provides a detailed description of what a statement means. This meaning is leveraged by NIEM.
* NIEM’s use of the RDF model provides a basis for inferring and reasoning about XML data that uses NIEM. That is, using the rules defined for the RDF model, programs can determine implications of relationships between NIEM-defined objects.

NIEM message designers and developers do not need to understand RDF. The concepts in this document are explained in terms of the NIEM metamodel, XSD, and CMF. The relationships between NIEM models and messages are confined to [the RDF section].

### 3.9 Conformance

* Architecture conformance: follow the rules in this document
* Model conformance:  Do not needlessly duplicate components in the NIEM model; reuse any component that satisfies the business need
* Conformance is only defined for models and messages
  * Models conform to the rules in this document
  * Messages conform to their message format, and rules in this document
* Conformance is not defined for applications, systems, tools
  * But these may claim that they generate conforming models or messages
* Not compliance

### 3.10 Message validation

* Goal:  automated validation of NIEM messages, testing conformance to the message format
* NIEM XSD messages validated by NIEM model in XSD
* Automated validation of other serializations also supported; for example, JSON Schema generated from CMF

### 3.11 Versioning and independent change

* Namespaces are the basic unit of versioning and configuration management in NIEM.
* Once published, no change
* Independent change – everyone changes when ready, no one forced by another change

### 3.12 Augmentation

The components in a community agreement model are those the community thought worth the trouble of an agreed definition. For example, the PersonType class in the NIEM Core model  (depicted in figure 1-2) has 83 properties. These, of course, are not the only possible properties of a person. For example, the members of the NIEM Justice domain have agreed that the PersonType class could usefully include the property of whether a person has a college degree. However, NIEM does not permit the Justice domain to simply add that property to the NIEM Core namespace – they are not the namespace author, and that namespace, once published, may not be changed.

Instead, the Justice domain expressed their opinon by using augmentation. Augmentation is the mechanism through which the author of one namespace adds properties to a class defined in another namespace. Further described in [links].

> A few other topics that might fit into this overview section?
>
> * devs have the specification
> * self-describing data
> * kinds of schema document
> * relationship properties

## 4. Metamodel and metamodel rules

## 5. CMF and CMF rules

## 6. XSD and XSD rules

- Message schemas!
- many many XSD rules – say something about schematron, point to files

## 7. CMF and XSD equivalence

## 8. Messages

### 8.1 NIEM XML instances

This specification attempts to restrict XML instance data as little as possible while still maintaining interoperability.

NIEM does not require a specific encoding or specific requirements for the XML prologue, except as specified by [XML].

**Instance must be schema-valid**

The XML document MUST be valid against a set of authoritative schema documents for the relevant namespaces. This does not mean that XML validation must be performed on all XML instances as they are served or consumed; only that the XML instances validate if XML validation is performed. 

NIEM embraces the use of XML Schema instance attributes, including xsi:type, xsi:nil, and xsi:schemaLocatiom, as specified by [XML Schema Structures].

#### 8.1.1 The meaning of NIEM data

NIEM XML instances represents relationships and data primarily via a hierarchy of XML elements in an XML document. For example, consider the following fragment of an XML document:

Figure XX: Example of content elements
<nc:Person>
  <nc:PersonName>
    <nc:PersonFullName>John Doe</nc:PersonFullName>
  </nc:PersonName>
</nc:Person>
In this instance, the XML elements describe a hierarchy of data objects as follows:

Table XX: Meaning of NIEM XML
| XML element/value	| The Meaning of the data                                                             |
| ----------------- | ----------------------------------------------------------------------------------- |
| nc:Person	        | The object nc:Person of type nc:PersonType exists within some unknown context.      |
| nc:PersonName	    | The object nc:PersonName of type nc:PersonNameType exists within nc:Person.         |
| nc:PersonFullName | The object nc:PersonFullName of type nc:PersonNameType exists within nc:PersonName. |
| John Doe         	| The object of type nc:PersonNameTextType has a value that is the literal John Doe.  |

Note, that the types of each element are defined in the NIEM reference model and are not present in the XML instance.

**Empty content has no meaning**

Within the instance, an element with no content has no additional meaning.

#### 8.1.2 Identifiers and references

Nested elements, shown above, can represent simple, hierarchical ("tree-like") data. However, some data is not "tree-like" and therefore does not lend itself to nested objects.  For instance:

*Cycles*: an object has a relationship that, when followed, eventually circles back to itself. For example, suppose that Bob has a sister relationship to Sue, who has a brother relationship back to Bob.

*Reuse*: multiple objects have a relationship to a common object. For example, suppose Bob and Sue both have a mother relationship to Sally. Expressed via nested elements, this would result in a duplicate representation of Sally.

NIEM provides two different ways to solve this problem: 

* The use of local references pointing to local identifiers, and 
* The use of uniform resource identifiers (URIs). 

These two methods are similar, and can interoperate, but have distinctions.

**Element has only one resource identifying attribute** 

An element MUST NOT have more than one attribute that is structures:id, structures:ref, or structures:uri.

##### 8.1.2.1 Local identifiers and references
The XML specifications define ID and IDREF attributes, which act as references in XML data. This is supported by XML Schema, and NIEM uses ID and IDREF as one way to reference data across data objects. Within a NIEM-conformant XML document, an attribute structures:ref refers to an attribute structures:id. These attributes may appear in an XML document to express that an object that is the value of an element is the same as some other object within the document. For example, in the following example, the user of the weapon (Bart) is the same person that is the subject of the arrest:

Figure XX: Example of structures:id and structures:ref
<j:Arrest>
  <j:ArrestInvolvedWeapon>
    <nc:WeaponUser structures:id="bart">
      <nc:PersonName>
        <nc:PersonGivenName>Bart</nc:PersonGivenName>
      </nc:PersonName>
    </nc:WeaponUser>
  </j:ArrestInvolvedWeapon>
  <j:ArrestSubject>
    <nc:RoleOfPerson structures:ref="bart" xsi:nil="true"/>
  </j:ArrestSubject>
</j:Arrest>
Note that rules below establish that relationships established using structures:id and structures:ref have the exact same meaning as relationships established using nested elements. An information exchange specification may constrain them differently, or prefer one over the other, but from a NIEM perspective, they have the same meaning.

**Attribute structures:ref must reference structures**

Within a NIEM XML document, any attribute structures:ref MUST refer to an attribute structures:id with the same value.

**Referenced objects must be of the same or derived types**

References using structures:ref and structures:id MUST preserve the type constraints that would apply if nested elements were used instead of a reference. That is, the type of the element pointed to by a structures:ref attribute must be of (or derived from) the type of the reference element. 

For example, an element of type nc:PersonType MUST always refer to another element of type nc:PersonType, or a type derived from nc:PersonType, when using structures:ref to establish the relationship.

#### 8.1.2.2 Uniform resource identifiers
In linked data, anything may be called a resource: people, vehicles, reports, documents, relationships, ideas. Every resource may have a name, called a uniform resource identifier (URI). NIEM supports linked data through the use of uniform resource identifiers (URIs), expressed through the attribute structures:uri in XML documents. 

As described above, structures:uri, structures:id, and structures:ref each denote a resource identifier. Although a structures:ref must always refer to a structures:id, and a value of structures:id must be unique within its document, a structures:uri may refer to any of structures:uri, structures:ref, or structures:id.

**structures:uri denotes resource identifier**
The value of an attribute structures:uri is a URI-reference, as defined by [RFC 3986], which denotes a resource identifier on the element holding the attribute, in accordance with evaluation consistent with [RFC 3986] and [XML Base].

The following example shows a reference to an absolute URI:

Figure XX: Example of structures:uri holding an absolute URI
<example:ArrestMessage>
  <j:Arrest xsi:nil="true"
    structures:uri="urn:uuid:f81d4fae-7dec-11d0-a765-00a0c91e6bf6"/>
</example:ArrestMessage>

The following example shows a relative URI, using xml:base to carry the base URI for the document: 

Figure XX: Example of structures:uri holding a relative URI, with an xml:base
<example:ArrestMessage xml:base="http://state.example/scmods/">
  <j:Arrest>
    <j:ArrestSubject>
      <nc:RoleOfPerson structures:uri="B263-1655-2187"/>
    </j:ArrestSubject>
  </j:Arrest>
</example:ArrestMessage>

The person object identified by the structures:uri attribute has the URI http://state.example/scmods/B263-1655-2187.

The attributes structures:id and structures:ref each have a mapping to equivalent values of structures:uri.

**structures:id and structures:ref denote resource identifier**

The attributes structures:id and structures:ref are equivalent to the attribute structures:uri with the same value.

For example, structures:id="hello" and structures:ref="hello" each denote the same resource identifier for an element as if it held an attribute structures:uri="#hello".

**structures:uri can reference resources in other documents**

Unlike structures:id and structures:ref, an attribute structures:uri can reference any resource, inside or outside the document, including structures:uri, structures:id or structures:ref in another document.

#### 8.1.2.3 Reference and content elements have same meaning

An important aspect of the use of nested elements, ref-to-id references, and URI references, is that they all have the same meaning. Expressing a relationship as a nested element, versus as a ref-to-id reference is merely for convenience and ease of serialization.

**Nested elements and references have the same meaning**

There MUST NOT be any difference in meaning between a relationship established via an element declaration instantiated by a nested element, and that element declaration instantiated via reference.

For example, the following XML fragments have similar meaning. 

**TODO: Update these examples to NIEM 6**

Figure 12-8: Example with no reference
<j:Witness>
  <nc:RoleOfPerson>
    <nc:PersonName>
      <nc:PersonFullName>John Doe</nc:PersonFullName>
    </nc:PersonName>
  </nc:RoleOfPerson>
</j:Witness>

Figure 12-9: Example with a backward reference
<nc:Person structures:id="c58">
  <nc:PersonName>
    <nc:PersonFullName>John Doe</nc:PersonFullName>
  </nc:PersonName>
</nc:Person>
<j:Witness>
  <nc:RoleOfPerson structures:ref="c58" xsi:nil="true"/>
</j:Witness>

Figure 12-10: Example with a forward reference
<nc:Person structures:ref="t85" xsi:nil="true"/>
<j:Witness>
  <nc:RoleOfPerson structures:id="t85">
    <nc:PersonName>
      <nc:PersonFullName>John Doe</nc:PersonFullName>
    </nc:PersonName>
  </nc:RoleOfPerson>
</j:Witness>

##### 8.1.3 Order of child elements has no meaning

A NIEM data object instance has a set of properties; these properties will appear in an XML instance as child elements of one or more parent elements. Order of child elements within each parent element is defined by the schema, which can specify exact element order, or can have flexible ordering (for example, elements provided via a substitution group may appear in any order). The order of parent and child elements in a document does not dictate the order of properties of an object.

#### Legacy rules (to be removed)
* Instance of RoleOf element indicates a role object 
* Metadata applies to referring entity 
* Referent of structures:relationshipMetadata annotates relationship 
* Values of structures:metadata refer to values of structures:is
* Values of structures:relationshipMetadata refer to values of structures:is
* structures:metadata and structures:relationshipMetadata refer to metadata elements
* Attribute structures:metadata references metadata element 
* Attribute structures:relationshipMetadata references metadata element 
* Metadata is applicable to element 
* Element within instance of augmentation type modifies base (Covered in Augmentation section?)

### 8.2 NIEM JSON

## 9. RDF stuff at the end, or elsewhere

*Normative:*

* all covered!

*Non-normative:*

* Appendix: some of the Modeling guidance (from NDR 5 principles)
* Appendix: Terminology (NDR 5 section 3)
* Appendex: References
* Appendex: Index: definitions, rules, general

*What should be separate?*

* schematron rules in separate files!
* new message serializations (protobuf, YAML) go in separate documents, at least until NIEM 8