> 2024-04-10 draft
>
> Includes Vamsi's text for sections 1 and 2.  The plan now is to keep filling out this outline until enough sections are complete. Then we will remove the comment stuff and apply the OASIS template.
>
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

NIEM, formerly known as the "National Information Exchange Model,” is a framework for exchanging information between public and private sector organizations. The framework includes a [reference data model](https://docs.oasis-open.org/niemopen/niem-model/v6.0/niem-model-v6.0.html) for objects, properties, and relationships; and a set of technical specifications for using and extending the data model in information exchanges. The NIEM framework supports developer-level specifications of data that form a contract between developers. The data being specified is called a message in NIEM. While a message is usually something passed between applications, NIEM works equally well to specify an information resource published on the web, an input or output for a web service or remote procedure, and so forth, basically, any chunk of data that crosses a system or organization boundary.

NIEM promotes scalability and reusability of messages between information systems, allowing organizations to share data and information more efficiently. It was launched in 2005 in response to the U.S. Homeland Security Presidential Directives to improve information sharing between agencies following 9/11.Until 2023, NIEM was updated and maintained in a collaboration between the U.S. federal government, state and local government agencies, private sector, and non-profit and international organizations, with new versions released around once per year. NIEM defines a set of common objects, the *NIEM Core*, and 17 sets of objects that are specific to certain government or industry verticals, the *NIEM Domains*.

In 2023, NIEM became the NIEMOpen OASIS Open Project. NIEMOpen welcomes participation by anyone irrespective of affiliation with OASIS. Substantive contributions to NIEMOpen and feedback are invited from all parties, following the OASIS rules and the usual conventions for participation in GitHub public repository projects.

NIEMOpen is the term generally used when referring to the organization such as Project Governing Board (PGB), NIEMOpen Technical Architecture Committee(NTAC), NIEMOpen Business Architecture Committee(NBAC), organization activities or processes. NIEM is the term used when directly referring to the model i.e. NIEM Domain Space, NIEM Model version.

This document specifies principles and enforceable rules for NIEM data components and schemas. Schemas and components that obey the rules set forth here are conformant to specific conformance targets. These targets are defined in order that they may be leveraged for comprehensive definitions of NIEM conformance. Such definitions may include more than the level of conformance defined by this NDR, and may include specific patterns of use, additional quality criteria, and requirements to reuse NIEM release schemas.

This document uses formatting and syntactic conventions to clarify meaning and avoid ambiguity. This document relies on references to many outside documents. Such references are noted by bold, bracketed inline terms. For example, a reference to RFC 3986 is shown as [RFC 3986](https://github.com/niemopen/niem-naming-design-rules/blob/dev/niem-ndr.md#Appendix-A-References). All reference documents are recorded in [Appendix A, References, below](https://github.com/niemopen/niem-naming-design-rules/blob/dev/niem-ndr.md#appendix-a-references).



## 2. How To Read This Document

This document provides normative specifications for NIEM data models. It also describes the goals and principles behind those specifications. It includes examples and explanations to help people understand the goals, principles, and specifications. People in different roles will have the greatest interest in different sections. Figure 2-1 illustrates the relationships between these roles and NIEM.

<center>
  <a name="fig3-1"/></a>
  <figure>
    <img src="images/fig3-1.png" alt="figure" style="zoom: 50%;" />
    <figcaption><i>Figure 2-1: NIEM-based machine-to-machine data exchange</i>
  </figure>
</center>

Figure 2-1 emphasizes the design and implementation of NIEM-based data exchange specifications. Figure 2-2 instead emphasizes the community agreement that forms the NIEM data model.

<center>
<figure class="image">
    <a name="fig2-2"/></a>
  <img src="images/fig3-2.png" style="zoom:50%"/>
  <figcaption><i>Figure 2-2: NIEM communities and data models</i></figcaption>
</figure>
</center>
>
>Now list the roles and what sections they should read first:
>
>* Managers and other echelons above reality
>
>* Business analyst and subject matter expert
>
>* Message designer
>
>* Message developer



## 3. Overview of the NIEM Technical Architecture

This overview describes NIEM's design goals and principles. It introduces key features of the architecture that will be defined in more detail later in the document.

### 3.1 Machine-to-machine data specifications

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

### 8.1 NIEM XML

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