
# NDR feedback

## Misc

- [ ] Upcoming commit to fix some typos and add syntax formatting for code blocks
- [ ] CSpell file and add a GitHub action to run spellcheck?

## Questions

- [x] Add TODO for things to be updated later?  Easier to find all the unfinished places vs text descriptions.  **Doing this now**
- [ ] Is Section 1.2.1 Definition of terms current? **Not even slightly current**
- [ ] Does the `Constraint` vs `Interpretation` distinction add anything meaningful to rules?  Simpler without it? **Probably remove, decide later**
- [x] Style convention: Get rid of smart quotes and dashes?  Avoid the mix of standard quotes and left/right quotes? **Working on the dashes (markdown likes "-", not "–"). Don't see any smart quotes - where are they?**
- [x] How do definitions work?  Official is from the Definitions table at the top and then repeated in the text below? **That seems to be OASIS style**
- [ ] Do we need a separate Conformance specification since the OASIS requires the NDR to have its own Conformance section? **Perhaps not. Also, *docs/template-README* suggests we may not be required to have a separate Conformance section before the appendices.**
  - No IEPD spec to conform to any more
- [ ] Add something about when to use NIEM and when it might be overkill?
  - Maybe in section 3.1 (Machine-to-machine data specifications)?
  - When you want to build multiple message specifications (leverage commonalities of an existing data model), already use NIEM or have exchange partners using NIEM, etc.
- [x] Move `@context` to the top of JSON messages to align more closely with the position of XML namespace prefixes? **Yes, TODO**
- [ ] Status of external standards in CMF?  Needs to be resolved before publishing NDR or CMF.
- [ ] Aren't CMF field names ending in "Of" missing a property or representation term? (e.g., SubPropertyOf, ListOf)

## Abstract

- [ ] Abstract needs to be updated.  Currently XML-specific.

> ...specifies XML Schema documents for use with...

Reuse line from the Introduction?

> This document specifies principles and enforceable rules for NIEM data components and schemas.

## 1. Introduction

- [ ] Include a paragraph about what is out of scope of NIEM?

  - Security
  - How to share information
  - Data marshalling
  - Programming languages
  - Database implementations
  - Most data cleansing

- [ ] Include a paragraph about what is out of scope of the NDR (not just NIEM)?

  - How to build NIEM-conformant messages
  - Normative JSON Schema
  - Harmonization

## 1.2.1 Definition of terms

- [ ] Identify RDF terminology

  - Identify terminology derived from RDF?  Like Data property, datatype, class, range?

- [ ] Identify synonyms?  Or pick one?

  - Data definition and documentation?
  - Adapter class and external adapter type?

- [ ] Adapter class

  - Thought it could only wrap a single external property, not multiple properties from a single external namespace?

- [ ] Atomic class

  - Doesn't look like we've defined atomic in previous NDRs.  I've used it internally to mean a single simple type, no attributes, not a list, not a union.
  - The definition given lines it up with NIEM simple content converted to CMF.

- [ ] Attribute property

  - "`isAttribute` is true doesn't describe what it is.

- [ ] Augmentable class

  - Expand from "...can be augmented".  "NDR allows to be augmented"?

- [ ] Augmentation

  - Add a more generic entry for a generic augmentation?

- [ ] Class

  - Not limited to messages
  - Add a more basic description

- [ ] Code list

  - Is this a code property?  A property with a code datatype?
  - Any need to distinguish from the Code Lists specification, or are those "enhanced code lists"?

- [ ] Complete model

  - Is definition overloaded?  Human readable definition vs element and type definitions / declarations?

- [ ] Data definition

  - "each component" > "a component" so it doesn't read like the full set of definitions in a model.

- [ ] Data property

  - Expand on definition
  - Data properties can exist independently
  - Is this a property with simple content?  Literal value with optional attributes?

- [ ] Document element

  - Doesn't describe that it's a root-level property for a message.

- [ ] Documentation

  - Component or namespace?
  - How does this differ from data definition?

- [ ] Facet

  - "data type" vs "datatype"?
  - "aspect" vs "literal"
  - Add some examples for clarity?

- [ ] List

  - "An object that defines a datatype"?  "with a datatype"?
  - Does the use of "atomic" here conflicts with the definition of atomic class, which can contain attributes and has a single data property?

- [ ] Message

  - In an instance of an information exchange?  To distinguish it from the set of all data that is shared?

- [ ] Model object

  - Should this just be "model"?

- [ ] Namespace

  - Add "managed by an authoritative source"? To explain how components are grouped in namespaces?

- [ ] Namespace URI

  - Explain that is used as an identifier for a specific version of a specific namespace.

- [ ] NIEM Core

  - Add something like "managed collectively by the NBAC, a governance body that includes representatives of each of the NIEM domains."

- [ ] NIEM Domain

  - Vertical?  Community of interest?

- [ ] Object class

  - "Class of objects"?

- [ ] Object property

  - ?

- [ ] Property term

  - ?
  - Part of a component name that describes...

- [ ] Proxy type

  - Add something like "which allows for the use of NIEM attributes from the `structures` namespace which support such things as IDs and referencing, metadata, linked data, attribute augmentations, and security markup.

- [ ] Qualifier term

  - Add "Part of a component name"

- [ ] Range

  - Using range from RDF but not domain?
  - Add something about it describes or defines the structure of a property.

- [ ] Reference attribute

  - Need to see how this is used.  Is this `structures:ref`?

- [ ] Reference data model

  - How is this different from other data models?

- [ ] Reference namespace

  - Not "all component in the NIEM model".  It's the full official version of a namespace as opposed to a subset instance of namespace.
  - Can an organization define their own reference namespace?  Like in an EIEM?

- [ ] Reference property

  - How is this different from the definition of "Reference attribute"?

- [ ] Representation term

  - Add "part of a component name"

- [ ] Simple content

  - Has a literal value, and optional attributes

- [ ] Subset

  - A *something* collection.  Minimal?
  - Includes the properties from NIEM to be used in a message, plus any required dependencies.
  - Reduces the size and complexity of the NIEM schemas.

- [ ] XML schema document set

  - A single aggregate XML Schema?  Or the set of all required XML Schemas?

## 3.1 Machine-to-machine data specifications

- [x] Add messages to the outline?

  - Rename the section to something like "Messages" or "Messages in NIEM" or break up the message information into its own section or subsection? **Added subsections for message and message format/type/specification; added examples**
  - Would like to have messages show up explicitly in the TOC / Outline

- [x] Add message terms to the Glossary

  - Add message, message type, message format, and message specification to the Glossary's Definition of Terms and add definition formatting / links to their usage here. **Done**

- [x] More information about message terms

  - Break message terms up into their own paragraphs, with more descriptive information.

- [x] Message type vs Message format

  - Not sure exactly what a message type is / can be:
    - UML
    - Spreadsheet
    - Requirements document
    - CMF
    - XML Schema
    - Is it conceptual? Is an artifact required?  Can you go straight to XML Schema or CMF and skip this?
  - Is Message format XML Schema vs CMF, or XML Schema vs JSON Schema?

- [x] Syntax

  - Add explicit term(s) for syntax?
  - Message type syntax?  UML, XML Schema, CMF?
  - Message format syntax?  XML Schema, JSON Schema?
  - Message syntax?  XML, JSON

- [x] Figure 3-1: Message specification, types and formats

  - Two different paths based on whether the message format syntax is XSD or CMF
    - Message format XSD -> XML syntax messages (*)
    - Message format CMF -> XSD and/or JSON Schema -> XML syntax message and/or JSON syntax messages
    - (*) Potential transformation to JSON Schema as well, but may be lossy
  - Missing Message Schema

## 3.2 Reuse of community-agreed data models

- [x] Wording

  > adding definitions that they require but have not (so far!) been found worthy of inclusion in the NIEM model.

  Rephrase as "adding components that do not yet exist in NIEM."?  Most of them come from requirements we haven't seen, not ones we've rejected.

- [x] Could also add a following sentence: "Local extensions that could be useful to others in the community beyond the scope of the original message can be submitted for potential adoption by NIEM (https://github.com/niemopen/niem-model/issues)."

## 3.3 Reuse of open standards

- [x] JSON Schema as a non-normative method to validate the content of JSON or YAML messages?
- [ ] Note about why JSON Schema is not a modeling formalism? **Maybe in section 3.5?**

## 3.4 The NIEM metamodel

- [x] Descriptions of class, datatype, properties

  - Start with a definition of property.  A concept, idea, or thing.  Appears as a field in a message and can contain subfields (for objects / object properties) or a value (for literals / data properties).
  - Properties define semantics, types define structures
    - One nc:PersonType type
      - Many different kinds of people in the model (properties) that share the same nc:PersonType structure
    - One nc:TextType type
      - Many different kinds of text elements in the model (properties) that share the same nc:TextType structure

- [ ] No conceptual Type class as the parent of Class and Datatype?

- [ ] Figure 3-3

  - Add person as a top-level object?

- [x] objects, properties, and literal values

  > A NIEM message contains objects, properties, and literal values.  These are specified by the Class, Property, and Datatype objects in a NIEM data model...

- [x] Mixing different levels of detail?  A NIEM message contains properties, which can be either objects or literal values.

## 3.5 NIEM model representations: XSD and CMF

- [x] Conformance testing...

  > A CMF model can be transformed into XSD for conformance testing of XML messages, and into JSON Schema for conformance testing of JSON messages.

  - XSD for...
    - conformance testing of XML message formats?
    - validation testing of XML messages?
  - JSON Schema for validation testing of JSON messages (no conformance testing)

- [ ] Also, add reason why no recommendation to build NIEM JSON Schemas directly:

  - No conformance testing
  - JSON Schema differences from XML Schema (Tom's reasons, not the same kind of modeling capabilities like inheritance and abstracts, lossy round-trips between XSD and JSON Schema)

## 3.7 NIEM messages in XML and JSON

- [x] Move after or under 3.1?  Exemplifies some of the message information in that section. **Different examples now appear as figure 3.2**

## 4. Data models in NIEM

- [ ] Need to describe what these things are
- [ ] Basic concepts should be described here, backed up with CMF / metamodel stuff.
  - Wouldn't the CMF spec be the source of the CMF class definitions.  NDR describes what NIEM concepts are.
- [ ] Drop shortened UML field names?
  - Easier to deal with one set of names than two
  - Shortened names goes against NIEM naming principles
  - Shortened names can be unclear (`confTarg`, `docPath`)
- [ ] Tables showing the mappings between CMF and XSD don't seem to be numbered or linked
- [ ] Use real examples instead of things like ExampleProperty and ExType
- [ ] Add XML and JSON instance examples to correspond with the CMF and XSD examples?

## 4.1 Model class

- [ ] Expand definition
- [ ] What is a partial NIEM model?
- [ ] Good place to talk about subsets
- [ ] Reference vs message model (generic and reusable vs smaller and specialized)
  - NIEM is a reference model.
  - Organizations can define their own reference model if they want to define common extensions across multiple messages
- [ ] Extensibility should be explained a little here, maybe in addition to a section following 3.6 Namespaces?
  - A message model consists of namespaces and components taken from the NIEM reference model (usually in a minimized NIEM subset consisting of the necessary components plus any required dependencies).  And extension namespaces and components, created by the message designer, to meet requirements not in NIEM.
- [ ] Missing fields in `iepd-catalog.xml` - name, description, version, point of contact, status, etc.

## 4.2 Namespace class

- [ ] Describe what a namespace is
- [ ] Describe the main kinds of namespace in NIEM, and who manages them?
  - Core
  - Domain
  - Code
  - Adapter
  - External
  - External
  - Proxy(?)
  - Utility
- [ ] Namespace versioning
  - Persistence for published versions
  - Draft strategies (same uri, different version attribute)
  - Dependencies on other namespaces
  - Authoritative source (e.g., multiple domains use `Arrest`  but defer to the Justice domain to manage it)
- [ ] Describe qualified names / namespace prefixes?
  - Can use aliases in JSON for issues with qualified names
- [ ] Describe the need for `@context`
  - Preserve namespace information for JSON
  - Without context, you don't know that `nc` represents the NIEM Core namespace and you don't know which version
- [ ] ImportDocumentationText?
  - Isn't this documentation for an external namespace?  Capture it there?
- [ ] `NIEMVersionText` - We use this for draft stages (alpha, beta, PSD01, etc.)
- [ ] `NamespaceLanguageName` - Isn't this a code?
- [ ] `NamespaceKindCode` - NIEM uses category instead of kind.
- [ ] `DocumentFilePathText` - Add a note that this is needed for XML schemas.  Not required for JSON only representations or required to maintain transformation capabilities?

## 4.3 Component class

- [ ] Keywords, example content, and usage fields?

## 4.4 Class class

- [ ] Do we have any abstract classes?
- [ ] Don't we also have an Augmentation class?  Name ends with `AugmentationType`, extends `structures:AugmentationType`, definition begins with "...", etc.
- [ ] More info and subsections for the kinds of object classes?
- [ ] Expected an atomic class to be a simple type, not a complex type with simple content.
  - `Literal class` and `datatype` instead of CSC and simple?
- [ ] Do we need `AugmentableIndicator`?
  - Is it just for subsets to flag which ones carry augmentation points and which ones don't?
- [ ] `ReferenceCode` / inline vs ref isn't explained
- [ ] Atomic class example doesn't show how you get from Class has property Example2Literal to `xs:extension base="xs:integer"`
- [ ] Can't EXT CCC types be either extensions or restrictions?  CMF doesn't capture that information.

Literal properties

- [ ] RDF-star and JSON-LD-star don't convert literals to objects in order to add metadata, they annotate the existing literal statements.
- [ ] CMF still seems to require a lot of additional information to be hardcoded rather than automatically generated.
  - More difficult for users creating CMF by hand
  - Much more error prone - user forgets to add, doesn't get the name right, later renames the class but forgets about the literal property, etc.
  - Creates a lot of properties that won't exist in the XML representation

```xml
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
<DataProperty structures:id="ex.Example2Literal">
  <Name>Example2Literal</Name>
  <Namespace structures:ref="ex" xsi:nil="true"/>
  <DocumentationText>Documentation text for Example2Literal.</DocumentationText>
  <Datatype structures:ref="xs.integer" xsi:nil="true"/>
</DataProperty>
```

vs

```xml
<Class structures:id="ex.Example2Type">
  <Name>Example2Type</Name>
  <Namespace structures:ref="ex" xsi:nil="true"/>
  <Literal structures:ref="xs.integer">
  <HasProperty>
    <DataProperty structures:ref="ex.aProperty" xsi:nil="true"/>
    <MinOccursQuantity>0</MinOccursQuantity>
    <MaxOccursQuantity>1</MaxOccursQuantity>
    <DocumentationText>A reason why a data value was not provided.</DocumentationText>
  </HasProperty>
</Class>
```

Changing this wouldn't have to mean a big rework of the CMF Tool. First step after loading the CMF objects could be to convert all Literal properties to the way it appear in CMF now - it just would be done consistently by the code instead of the users having to deal with it.  And similar for exporting CMF - convert back to Literal properties.

This is similar to what we do for change request spreadsheets and augmentation point elements.  We handle all augmentation point elements internally in code because it's so error prone and unnecessary to do the extra work by hand since it all follows the same pattern.  Write the code to deal with it once and it's easier on everyone else who uses it forever.

> [!NOTE]
>
> Dr. Scott: The proposed <Literal> tag in CMF is indeed simpler, but does not help with the problem, which is XSD weirdness imposed on JSON developers, RDF developers, and probably every other kind of developer in the future. I wrote [*Literal properties and atomic classes in NIEM 6*](https://github.com/niemopen/ntac-admin/blob/main/documents/docs/Literals-241009.md) to explain the problem and our choices.  RDF-star is about attaching properties and values to triples, which I think doesn't help us here.

## 4.5 HasProperty class

- [ ] Rename as ChildProperty?
  - Everything is a has
  - Child is used in the Glossary with Complex content
  - "child" appears 24 times in the document.  More descriptive than "has"
- [ ] Need easy terminology for both directions of the relationship
  - Type (nc:PersonType) has a child property (nc:PersonName)
  - Property (nc:PersonName) has a / belongs to a container type (nc:PersonType)?
- [ ] Wasn't CMF switching to `structures:uri` instead of `structures:ref` so we can use references like `ex:PersonMiddleName` instead of `ex.PersonMiddleName`?

> [!NOTE]
>
> Dr. Scott: CMF needs `structures:uri` to handle partial models.  But you won't see references like `structures:uri="ex:PersonMiddleName"`, because that's a QName, not a URI.  You'll see `structures:uri="http://example.com/Some/Namespace/URI/PersonMiddleName"` instead.  I think that's ugly, which is why I propsed adding a `qname` attribute to *structures.xsd*.  I believe we decided not to do that.

- [ ] Figure 4-9: HasProperty object in CMF and XSD
  - HasProperty doesn't exist independently.  Might be helpful to show the examples in context under the containing type.
  - Use nameInitialIndicator for the example attribute?
- [ ] Add an explicit note about attribute cardinalities
  - MinOccurs = 0 => `use="optional"`
  - MinOccurs = 1 => `use="required"`
  - Any MaxOccurs other than 1 (or just above 1?) is invalid
- [ ] Add a note that documentation is required here for external properties in adapter classes but doesn't typically appear otherwise since every NIEM conformant property is already required to have its own definition.

## 4.6 Property class

- [ ] Use substitution instead of subProperty for clarity?
- [ ] Putting AbstractIndicator and SubPropertyOf on Property allows for abstract or substitutable attributes in CMF, which aren't valid XML
- [ ] RelationshipPropertyIndicator is unclear.
- [ ] Add attributes of the Component class to the UML diagram to make it easy to see what Property inherits?

## 4.7 ObjectProperty class

- [ ] Would be helpful to see a list of reference code values
- [ ] Inline vs reference isn't explained much here.  Examples here or in section 5 (Data modeling patterns) would be helpful.
- [ ] Default for reference code?  If not specified, element could be inline or reference?

## 4.8 DataProperty class

- [ ] Example of `nc:PersonFullName` with range of `xs:string` is confusing since its type in NIEM is `nc:PersonNameTextType`
- [ ] CMF shouldn't expect users to flatten NIEM themselves but the CMF Tool should do it for them
- [ ] What is a data property in XML with AttributeIndicator = false?
  - Aren't elements with simple types invalid in reference / extension schemas?  (okay for flattened schemas)
- [ ] Not sure what the RefAttributeIndicator / reference property is here

## 4.9 Datatype class

- [ ] Benefit of 11 facet subclasses vs a `FacetCategoryCode` code set?
  - I think XSLT could check if values for certain kinds of facets are numeric, positive, etc.
- [ ] Seems like "atomic" is used again here to mean simple instead of simple + attributes
- [ ] Can't EXT simple types be either restrictions or extensions?
  - Would need a field to capture which one
  - Would need ot rename Restriction class to something else (ValueType?)
- [ ] Show the Component class and its attributes here to show its inherited fields?

## 4.10 List class

- [ ] Is `ListOf` named correctly?  `ListItemDataType` instead?

## 4.11 Union class

- [ ] `UnionOf` to something like `MemberDatatype` or `UnionMemberDataType`?

## 4.16 LocalTerm class

- [ ] Show the examples in context? `xs:appinfo` under `xs:schema`, as opposed to appinfo on a property or type or namespace.

## 4.17 TextType class

- [ ] Seems like a CMF thing for the CMF spec, not a NIEM thing for the NDR?

## 5. Data modeling patterns

- [ ] New way to represent roles (`structures:uri`)
- [ ] Inline vs reference?
- [ ] Associations
- [ ] Representation pattern (not sure about representation terms)
- [ ] Simple type unions to fake code set extension?

