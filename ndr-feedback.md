
# NDR feedback

## Misc

- [ ] Splitting examples that combine (CMF and XSD) or (XSD and JSON Schema) or (XML and JSON) into separate examples would allow us to use syntax highlighting on the code blocks.  Side-by-side examples might be worth keeping as is to make comparisons easier, but top-bottom combos could be split pretty easily. **Do we want syntax highlighting? It doesn't show up in PDF. I'm thinking "no".**
- [ ] CSpell file and add a GitHub action to run spellcheck? **Sure, why not?**
- [ ] Some CMF definitions are going to throw warnings when checked against the Schematron rules.

## Questions

- [x] Add TODO for things to be updated later?  Easier to find all the unfinished places vs text descriptions.  **Doing this now**
- [ ] Is Section 1.2.1 Definition of terms current? **Not even slightly current**
- [x] Does the `Constraint` vs `Interpretation` distinction add anything meaningful to rules?  Simpler without it? **Removed in 30 October draft **
- [x] Style convention: Get rid of smart quotes and dashes?  Avoid the mix of standard quotes and left/right quotes? **Working on the dashes (markdown likes "-", not "–"). Don't see any smart quotes - where are they?**
- [x] How do definitions work?  Official is from the Definitions table at the top and then repeated in the text below? **That seems to be OASIS style**
- [ ] Do we need a separate Conformance specification since the OASIS requires the NDR to have its own Conformance section? **Perhaps not. Also, *docs/template-README* suggests we may not be required to have a separate Conformance section before the appendices.**
  - No IEPD spec to conform to any more - just guidance?  **Perhaps write the "MPD specification" next.**
- [ ] Add something about when to use NIEM and when it might be overkill?
  - Maybe in section 3.1 (Machine-to-machine data specifications)?
  - When you want to build multiple message specifications (leverage commonalities of an existing data model), already use NIEM or have exchange partners using NIEM, etc.
- [x] Move `@context` to the top of JSON messages to align more closely with the position of XML namespace prefixes? **Yes, TODO**
- [ ] Status of external standards in CMF?  Needs to be resolved before publishing NDR or CMF.
  - [ ] Example with [GeoJSON](https://geojson.org/)?
  - [ ] GML with `rdf:XMLLiteral` (how to do in JSON-LD)?
  - [ ] Hold for PS02 or just an example on niem.github.io?
- [x] Aren't CMF field names ending in "Of" missing a property or representation term? (e.g., SubPropertyOf, ListOf) **Those are object properties, which don't require a representation term**
- [ ] "Figure #" seems like the wrong label for code examples. Use "Figure" for images and "Example" for code? **Fix this at the very end, if we decide to. It means a separate index of figures and index of examples. It means bin/reindex needs revising, and I already spent too much time on that :-) **
- [ ] Section 4 tables that document classes and attributes and tables that relate CMF to XSD don't have identifiers.  Use "Table #"? **And now an index of tables? Not sure we need a caption for somthing that is never referenced.**

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

- [x] Identify synonyms?  Or pick one?

  - Data definition and documentation? **data def**
  - Adapter class and external adapter type? **adapter class**

- [x] Adapter class

  - Thought it could only wrap a single external property, not multiple properties from a single external namespace? **I don't see a rule for that. The text in NDR 5 rule 10-12 is plural; says "built from components…" 

- [x] Atomic class  **Renamed "literal class"**

- [x] Attribute property  **fixed**

  - "`isAttribute` is true doesn't describe what it is.

- [x] Augmentable class **Removed; all classes now augmentable**

  - Expand from "...can be augmented".  "NDR allows to be augmented"?

- [x] Augmentation

  - Add a more generic entry for a generic augmentation? **Done**

- [x] Class

  - Not limited to messages
  - Add a more basic description **Done**

- [x] Code list

  - Is this a code property?  A property with a code datatype? **It's the set of valid code values**
  - Any need to distinguish from the Code Lists specification, or are those "enhanced code lists"? **We may want to rewrite that spec**

- [x] Complete model

  - Is definition overloaded?  Human readable definition vs element and type definitions / declarations? **Removed the term **

- [x] Data definition

  - "each component" > "a component" so it doesn't read like the full set of definitions in a model. **Done**

- [ ] Data property

  - Expand on definition
  - Data properties can exist independently
  - Is this a property with simple content?  Literal value with optional attributes?

- [x] Document element

  - Doesn't describe that it's a root-level property for a message. **Done**

- [x] Documentation  **Removed term**

  - Component or namespace?
  - How does this differ from data definition?

- [x] Facet **Removed term**

  - "data type" vs "datatype"?
  - "aspect" vs "literal"
  - Add some examples for clarity?

- [x] List **Removed term**

  - "An object that defines a datatype"?  "with a datatype"?
  - Does the use of "atomic" here conflicts with the definition of atomic class, which can contain attributes and has a single data property?

- [x] Message

  - In an instance of an information exchange?  To distinguish it from the set of all data that is shared?  **added instance of message type**

- [x] Model object  **removed term**

  - Should this just be "model"?

- [x] Namespace

  - Add "managed by an authoritative source"? To explain how components are grouped in namespaces? **done**

- [x] Namespace URI **removed term**

  - Explain that is used as an identifier for a specific version of a specific namespace.

- [x] NIEM Core **removed term**

  - Add something like "managed collectively by the NBAC, a governance body that includes representatives of each of the NIEM domains."

- [x] NIEM Domain **removed term**

  - Vertical?  Community of interest?

- [ ] Object class **Need something for a class that is not an adapter, association, or literal class – NTAC decide**

  - "Class of objects"?

- [x] Object property **removed**

  - ?

- [x] Property term **removed**

  - ?
  - Part of a component name that describes...

- [x] Proxy type **changed to match section 9.5**

  - Add something like "which allows for the use of NIEM attributes from the `structures` namespace which support such things as IDs and referencing, metadata, linked data, attribute augmentations, and security markup.

- [x] Qualifier term **removed**

  - Add "Part of a component name"

- [x] Range **removed**

  - Using range from RDF but not domain? **yes. rdfs:domain doesn't do what you think it does**
  - Add something about it describes or defines the structure of a property.

- [ ] Reference attribute

  - Need to see how this is used.  Is this `structures:ref`?

- [x] Reference data model **removed**

  - How is this different from other data models?

- [x] Reference namespace  **changed to match section 3.6**

  - Not "all component in the NIEM model".  It's the full official version of a namespace as opposed to a subset instance of namespace.
  - Can an organization define their own reference namespace?  Like in an EIEM? **anyone can define a reference namespace**

- [x] Reference property **removed**

  - How is this different from the definition of "Reference attribute"?

- [x] Representation term **removed**

  - Add "part of a component name"

- [x] Simple content **removed**

  - Has a literal value, and optional attributes

- [x] Subset **removed**

  - A *something* collection.  Minimal?
  - Includes the properties from NIEM to be used in a message, plus any required dependencies.
  - Reduces the size and complexity of the NIEM schemas.

- [x] XML schema document set **now just schema document set**

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

- [x] Figure 3-4: The CMF element DataProperty has two opening brackets (`<<DataProperty`) and the `ObjectProperty` element beneath it isn't indented consistently.  **FIXED**

## 3.2 Reuse of community-agreed data models

- [x] Wording

  > adding definitions that they require but have not (so far!) been found worthy of inclusion in the NIEM model.

  Rephrase as "adding components that do not yet exist in NIEM."?  Most of them come from requirements we haven't seen, not ones we've rejected.

- [x] Could also add a following sentence: "Local extensions that could be useful to others in the community beyond the scope of the original message can be submitted for potential adoption by NIEM (https://github.com/niemopen/niem-model/issues)."

- [ ] "reuse model" - We've always used the term "reference model".  Consistent with "reference namespace".  Could also mention this includes EIEMs and enterprise models that extend NIEM.  **OTOH we use "reference" for reference namespace and reference schema document; "reference model" isn't consistent with those meanings. Confusing? Let's vote.**

## 3.3 Reuse of open standards

- [x] JSON Schema as a non-normative method to validate the content of JSON or YAML messages?
- [x] Note about why JSON Schema is not a modeling formalism? **Maybe in section 3.5? Yes.**

## 3.4 The NIEM metamodel

- [x] Descriptions of class, datatype, properties

  - Start with a definition of property.  A concept, idea, or thing.  Appears as a field in a message and can contain subfields (for objects / object properties) or a value (for literals / data properties).
  - Properties define semantics, types define structures **Needs more explanation. Seems XML-specific, perhaps**
    - One nc:PersonType type
      - Many different kinds of people in the model (properties) that share the same nc:PersonType structure
    - One nc:TextType type
      - Many different kinds of text elements in the model (properties) that share the same nc:TextType structure

- [x] No conceptual Type class as the parent of Class and Datatype? **Added here but not in the detailed diagram**

- [x] Figure 3-3

  - Add person as a top-level object? **Changed to Request message example**

- [x] objects, properties, and literal values

  > A NIEM message contains objects, properties, and literal values.  These are specified by the Class, Property, and Datatype objects in a NIEM data model...

- [x] Mixing different levels of detail?  A NIEM message contains properties, which can be either objects or literal values.

- [x] Figure 3-7

Should the line be there between Property and Class?  ObjectProperty has a class; DataProperty has a Datatype.  But Property also has a Class, so DataProperty inherits its class?

## 3.5 NIEM model representations: XSD and CMF

- [x] Conformance testing...

  > A CMF model can be transformed into XSD for conformance testing of XML messages, and into JSON Schema for conformance testing of JSON messages.

  - XSD for...
    - conformance testing of XML message formats?
    - validation testing of XML messages?
  - JSON Schema for validation testing of JSON messages (no conformance testing)

- [x] Also, add reason why no recommendation to build NIEM JSON Schemas directly:

  - No conformance testing
  - JSON Schema differences from XML Schema (Tom's reasons, not the same kind of modeling capabilities like inheritance and abstracts, lossy round-trips between XSD and JSON Schema)

## 3.6 Namespaces

- [ ] "Namespace are the units of model configuration management."

Seems like there are two parts.  Yes, each namespace has its own version.  But they also get released together as a major, minor, or patch version of a model for consistency.

If a domain put out its own update independently without the other namespaces in NIEM, and it made a bunch of breaking changes that created errors in other namespaces that depend on it, then there could be issues using that new content in messages.

Seems more like versions are the units of model configuration management, and as part of that, each namespace is versioned independently.

- [x] "Once published, the components...may not be removed...As a result of this rule, a change by author of namespace X does not force a change by the author of any other namespace Y...."

This is an important point and explains a question we get asked a lot. Not sure it stands out enough though and I'm not sure it's inclusive enough.  We want to make sure it's clear that implementers can keep using their exchanges based on old version of NIEM, not just message designers.

Maybe something like...  **used this text**

> As a result of this rule, once a specific version of a namespace is published, it can no longer be modified.  Updates must go into a new version of the namespace.  All published versions of a namespace should remain available to support older exchanges.
>
> In addition, note that messages specifications contain their own copy of the schemas that they depend upon.  New versions of a model or a namespace do not affect existing exchanges.  Exchange partners may decide to upgrade to a new version of NIEM if they decide it suits their needs, but only if they choose to do so, and only on their own timeline.  The NIEM release schedule does not force adopters to keep in sync.

- [ ] "Augment a reference namespace or extension namespace with an attribute property."  I'd recommend mentioning this is a subset operation because of attribute wildcards.  Attribute wildcards allow almost any declared attribute to be used in NIEM schemas.  This is replacing the wildcard with specific attributes, which limits the range of possibilities to a pre-defined set.

- [ ] "External namespace" - This part doesn't really describe what it is or what it's for.  Something like...

> External namespace are namespace that do not follow NDR rules.  They exist to support the use of external standards, like GML, when it's better for interoperability to bring in and use other standards exactly as they are rather than to try to replicate their contents in NIEM conformant schemas.

## 3.7 NIEM messages in XML and JSON

- [x] Move after or under 3.1?  Exemplifies some of the message information in that section. **Different examples now appear as figure 3.2**

## 4. Data models in NIEM

- [ ] Need to describe what these things are
- [ ] Basic concepts should be described here, backed up with CMF / metamodel stuff.
  - Wouldn't the CMF spec be the source of the CMF class definitions.  NDR describes what NIEM concepts are.
- [x] Drop shortened UML field names?  **Done, only CMF names appear now**
  - Easier to deal with one set of names than two
  - Shortened names goes against NIEM naming principles
  - Shortened names can be unclear (`confTarg`, `docPath`)
- [ ] Tables showing the mappings between CMF and XSD don't seem to be numbered or linked
- [ ] Use real examples instead of things like ExampleProperty and ExType **Examples are now more real… but completely real examples often require a lot of stuff that obscures the point. For example, I'd love to use the real WeightMeasureType in figure 4-9, but then I'd have to explain the abstract elements and substitution.)**
- [ ] Add XML and JSON instance examples to correspond with the CMF and XSD examples? **Perhaps? I did for section 4.4, which is as far as I've gone.**

- [ ] Subsections headers - Some headers use spaces (the concept) and some headers use camel casing (the CMF class) to separate terms.  I'd vote for spaces (the concept).  For example, "4.7 Object Property" instead of "4.7 ObjectProperty".

## 4.1 Model class

- [ ] Expand definition
- [ ] What is a partial NIEM model?
- [ ] Good place to talk about subsets  **That's in 6.1.3 at present**
- [ ] Reference vs message model (generic and reusable vs smaller and specialized)
  - NIEM is a reference model.
  - Organizations can define their own reference model if they want to define common extensions across multiple messages
- [ ] Extensibility should be explained a little here, maybe in addition to a section following 3.6 Namespaces?
  - A message model consists of namespaces and components taken from the NIEM reference model (usually in a minimized NIEM subset consisting of the necessary components plus any required dependencies).  And extension namespaces and components, created by the message designer, to meet requirements not in NIEM.
- [ ] Missing fields in `iepd-catalog.xml` - name, description, version, point of contact, status, etc.

- [ ] "A model object represents a complete or partial NIEM model." - We talk about *the* NIEM model a lot.  This mentions *a* NIEM model.  Maybe better to phrase it as "a complete or partial model based on NIEM"?

- [ ] Skips the idea of versions of a model.  We talk about models like NIEM is a model, and like NIEM 6.0 is a model.  I think it's the first.  I think NIEM is one model with 13 versions, not a collection of 13 different models.  Even if it's just a note that explains wording like "the NIEM 6.0 model" is shorthand for "the 6.0 version of the NIEM model", and that the CMF model object represents a single version of the model.

## 4.2 Namespace class

- [ ] Describe what a namespace is  **That's in section 3.6**

Drop section 3.6 and move the contents to the top of this section.  I think it makes more sense for there to be one namespace section, and if I was looking to see what a namespace is, I'd jump here.

- [ ] Describe the main kinds of namespace in NIEM, and who manages them? **Maybe someplace else?**
  - Core
  - Domain
  - Code
  - Adapter
  - External
  - External
  - Proxy(?)
  - Utility

- [ ] Namespace versioning **Add anything missing to section 3.6**?
  - Persistence for published versions
  - Draft strategies (same uri, different version attribute)
  - Dependencies on other namespaces
  - Authoritative source (e.g., multiple domains use `Arrest`  but defer to the Justice domain to manage it)

- [ ] Describe qualified names / namespace prefixes? **Maybe? Could be a paragraph right after figure 4-4?**
  - Can use aliases in JSON for issues with qualified names

- [x] Describe the need for `@context` **In rules for JSON messages**
  - Preserve namespace information for JSON
  - Without context, you don't know that `nc` represents the NIEM Core namespace and you don't know which version

- [x] ImportDocumentationText?
  - Isn't this documentation for an external namespace?  Capture it there? **In CMF it is recorded in the Namespace object for the external namespace.  In XSD the documentation string is actually in the importing schema document.**

    ```
      <xs:import
        namespace="http://www.opengis.net/gml/3.2"
        schemaLocation="../external/ogc/gml/3.2.1/gml.xsd"
        appinfo:externalImportIndicator="true">
        <xs:annotation>
          <xs:documentation>Geography Markup Language (GML) version 3.2.1 schemas.  See http://www.opengeospatial.org OGC document 07-036 for documentation: "The Geography Markup Language (GML) was originally developed within the Open Geospatial Consortium, Inc. (OGC). ISO 19136 was prepared by ISO/TC 211 jointly with the OGC."  See http://schemas.opengis.net/gml/ for schemas.</xs:documentation>
        </xs:annotation>
      </xs:import>
    ```

    **If your schema pile has two <imports> for the same external namespace with two different comments, so sad too bad. **

  CDM: Still don't understand this field.  I would assume CMF would look like...

```xml
<Model>
  <Namespace>
    <NamespacePrefixText>Core</NamespacePrefixText>
    <DocumentationText>NIEM Core</DocumentationText>
    <NamespaceCategoryCode>CORE</NamespaceCategoryCode>
  </Namespace>
  <Namespace>
    <NamespacePrefixText>gml</NamespacePrefixText>
    <DocumentationText>Geography Markup Language (GML) version ...</DocumentationText>
    <NamespaceCategoryCode>EXTERNAL</NamespaceCategoryCode>
  </Namespace>
</Model>
```

**Nope. *gml.xsd* has schema-level documentation and it's not the same as the documentation within the xs:import in *adapters/niem-gml.xsd*.  The CMF looks like this:**

```
<Namespace structures:id="gml">
  <NamespaceURI>http://www.opengis.net/gml/3.2</NamespaceURI>
  <NamespacePrefixText>gml</NamespacePrefixText>
  <DocumentationText>GML Subset schema for gml:AngleType,gml:Curve,gml:Envelope,gml:AbstractFeature,gml:AbstractGeometricPrimitiveType,gml:AbstractGeoemetry,gml:LengthType,gml:LineString,gml:MultiCurve,gml:MultiGeometry,gml:MultiPoint,gml:MultiSurface,gml:Point,gml:Polygon,gml:Surface, written by
                    gmlSubset.xslt. </DocumentationText>
  <NamespaceKindCode>EXTERNAL</NamespaceKindCode>
  <DocumentFilePathText>external/ogc/gml/3.2.1/gml.xsd</DocumentFilePathText>
  <NIEMVersionText/>
  <NamespaceVersionText>3.2.1 2010-01-28</NamespaceVersionText>
  <ImportDocumentationText>A profile of OpenGeospatialConsortium (OpenGIS, OGC) OpenLS (Location Services) version 1.1 schemas. A profile of OpenGeospatialConsortium (OpenGIS, OGC) OpenLS (Location Services) version 1.1 schemas that have been edited to use GML version 3.2.1 schemas instead of the GML version 3.0 schemas that were current when OpenLS version 1.1 was promulgated.  See http://www.opengeospatial.org for documentation, http://schemas.opengis.net/ols/ for schemas.</ImportDocumentationText>
</Namespace>
```

Also, if you imported two external namespaces in the same namespace, you wouldn't be able to assign or separate the documentation for each of the namespaces in one ImportDocumentationText field.

**ImportDocumentationText goes with the imported namespace, so two external imports of different namespaces in one schema document is not a problem.**

- [ ] `NIEMVersionText` - We use this for draft stages (alpha, beta, PSD01, etc.) **You are thinking of `NamespaceVersionText`.  This property is the version of the structures namespace in the XSD representation. For example, in the CMF representation of the core namespace in NIEM 5.2, this has the value `5`.**

- Sounds more like the NDR version number, which could be pulled from the conformance target URI? **I'm not sure these have to be the same.**

- Better to use the full version number ("5.0", "6.0")?

- Should the rep term be "ID" instead of text.

- I think there several things we track for namespaces related to version numbers:

  - Namespace version.  The full identifier is in `NamespaceURI`; the version number itself is embedded in the uri at the end. **well, it's embedded in our URIs, but that's not required by any NDR. Want to add that rule to NDR6?**

  - Draft version.  For example, "alpha2" or "ps01".  This is the `NamespaceVersionText` field? **yes**

  - NDR conformance target (`ConformanceTargetURI`).  This gives us the version of the NDR and structures (also in `NIEMVersionText`) and REF vs EXT.

- Can you have multiple namespaces in one model that use different versions of structures? Or Core?  Do you want to support that in CMF even you can hack it?  **It's always been possible in NIEM, and CMFTool can cope with it.**

  - Could move `NIEMVersionText` out of Namespace to the Model instead to describe which version of NIEM a message model extends (e.g., "5.1" or "6.0").

- [x] `NamespaceLanguageName` - Isn't this a code? **You would think so, but when you look at RFC 4646 I believe you'll see there can't really be a code list for all the valid values**

- [x] `NamespaceKindCode` - NIEM uses category instead of kind. **OK, changed in my working CMF spec**

- [ ] `DocumentFilePathText` - Add a note that this is needed for XML schemas.  Not required for JSON only representations or required to maintain transformation capabilities? **It's just a way  to specify a schema document pile layout in a CMF file**

Agree that the field is needed, just think JSON people who get all namespaces combined in one schema might not immediately understand it's needed if you want to be able to generate the XSD transformation, since each XSD namespace goes to it's own schema and they don't all go into the same directory.

## 4.3 Component class

- [ ] Keywords, example content, and usage fields?

- [ ] Should `DeprecatedIndicator` somehow have a default value of false, even though we don't allow defaults?
  - [ ] We use `xs:token` so literal values get modified by a validating parser anyway and not modified by some other parsers, so we break our own rule / reason for not allowing defaults here.
  - [ ] We might not have default values (NDR prohibits these) but we have default assumptions.  If deprecatedIndicator doesn't appear, we'll assume it to be false.  If augmentableIndicator doesn't appear, we'll assume it to be true?  False?  Is it better to make these explicit?

- [ ] Drop Figure 4-6?  There is no CMF or XSD representation of a Component, so this might be confusing.

- [ ] CMF to XSD table - Only mentions mappings to element or attribute declarations, not complex or simple types.

## 4.4 Class class

- [ ] Do we have any abstract classes? **The NIEM model does not. CMF does, though**

Does the NDR allow abstract classes?

- [ ] Don't we also have an Augmentation class?  Name ends with `AugmentationType`, extends `structures:AugmentationType`, definition begins with "...", etc. **Augmentation CCCs do not have corresponding model objects**

- [x] More info and subsections for the kinds of object classes? **Now have subsections for ordinary and literal classes**

- [x] Expected an atomic class to be a simple type, not a complex type with simple content.
  - `Literal class` and `datatype` instead of CSC and simple? **We could call this a "literal class" if that name seems better.**

- [ ] Do we need `AugmentableIndicator`?
  - Is it just for subsets to flag which ones carry augmentation points and which ones don't? **No, it's for extension namespaces.  Augmentation points are not required in extension schema documents.  If we change that, we can get rid of this property. The new rule in section 11.6 needs work either way.**

- [ ] `ReferenceCode` / inline vs ref isn't explained **Done?**

- [ ] Shouldn't `ReferenceCode` be under `ChildPropertyAssociation` instead?  Each child object (but not attribute) should be able to set this independently.

- [ ] Maybe rename `ReferenceCode` as `UsageCode` instead and change code "NONE" to "INLINE"?

- [ ] Shouldn't "ANY" include the ability to appear inline?

- [ ] Also, another case of an assumed default value?  If not specified, then "ANY"? "NONE"?

- [ ] Atomic class example doesn't show how you get from Class has property Example2Literal to `xs:extension base="xs:integer"`

- [ ] Can't EXT CCC types be either extensions or restrictions?  CMF doesn't capture that information.  **NDR5 permits restriction in EXT.  I had thought I could recognize a restriction from the child elements. But that won't work if the restriction removes *all* of the inherited elements.  So I think I'll do this in CMF:**

  ```
    <xs:element name="SubClassOf" type="cmf:ClassType" nillable="true">
      <xs:annotation>
        <xs:documentation>A base class of a subclass.</xs:documentation>
      </xs:annotation>
    </xs:element>
    <xs:element name="RestrictionSubClassOf" type="cmf:ClassType" nillable="true" substitutionGroup="cmf:SubClassOf">
      <xs:annotation>
        <xs:documentation>A base class of a subclass that may exclude optional properties from the base.</xs:documentation>
      </xs:annotation>
    </xs:element>
  ```

  **That's a lot of coding for something that may never be used in the history of the world, but oh well.**

- [ ] Reorganization suggestion:

- Drop "Ordinary class" and move its contents under "Class".
- Add subsections under "Class" for "Adapter class" and "Association class", and show examples for each (even if they come in the next draft).
- Merge "Atomic class" with "Datatype" down in section 4.9.  These both carry values

- [ ] Figure 4-7 seems smaller and the text is harder to read than the other diagrams.  Possible to make it a little bigger?

## 4.4.1 Ordinary class

- [ ] The first paragraph relates most classes (CMF lingo) to elements with complex content (XSD lingo) but is missing the tie in to Object Property (CMF lingo).

- [ ] "For example, figure 4-8 shows an XML element with complex content, and also the equivalent JSON message".  Should be "JSON property"?  It's not the full message and don't want to confuse it with section 3 stuff.

- [ ] The first example under "Ordinary class" is not a class but an object property.  Calling this an *instance* of an ordinary class can also sound like an *example* of an ordinary class, which might confuse some readers.

Should there be a little bit of text describing that this is an example of an object property as it appears in an XML or JSON message and the structure of it is defined by its class, WeightMeasureType, defined in the schema for that message and described below?

- [ ] An opening and closing tag pair in Figure 4-8 doesn't match (`ex:MassUnitCode` / `unece:MassUnitCode`).

## 4.4.2 Atomic class

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

- [ ] Figure 4-10: Should the `PropertyAssociation` be `ChildPropertyAssociation`?  Appears in other examples too.

- [ ] "An atomic class always has at least one [attribute property(#def)" - Attribute isn't hyperlinked correctly.

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

We can add qname to structures if `structures:uri` doesn't already support qnames.  Maybe it does?  Doesn't `structures:uri` get translated to having type `@id` in JSON-LD?  If so, qnames will expand.

From the JSON-LD Playground...

Input:

```json
{
  "@context": {
    "ex": "http://www.example.com/",
    "xsd": "http://www.w3.org/2001/XMLSchema#",
    "nc": "http://release.niem.gov/niem/niem-core/5.0/",
    "ex:qnameAsId": {
      "@type": "@id"
    },
    "ex:qnameAsURI": {
      "@type": "xsd:anyURI"
    }
  },
  "ex:qnameAsId": "nc:Person",
  "ex:qnameAsURI": "nc:Person"
}
```

Expanded output:

```json
[
  {
    "http://www.example.com/qnameAsId": [
      {
        "@id": "http://release.niem.gov/niem/niem-core/5.0/Person"
      }
    ],
    "http://www.example.com/qnameAsURI": [
      {
        "@type": "http://www.w3.org/2001/XMLSchema#anyURI",
        "@value": "nc:Person"
      }
    ]
  }
]
```

QName value with type `@id` expanded; qname value with type `xsd:anyURI` did not expand.

Oxygen seemed to accept any value for a property with type `xs:anyURI`, including qnames, numbers, and "cow".  Changing the type to `xs:QName` did make Oxygen check for a declared namespace prefix.

- [ ] Figure 4-9: HasProperty object in CMF and XSD
  - HasProperty doesn't exist independently.  Might be helpful to show the examples in context under the containing type.  Kind of like figure 4-10.
  - Use nameInitialIndicator for the example attribute?
- [ ] Add an explicit note about attribute cardinalities
  - MinOccurs = 0 => `use="optional"`
  - MinOccurs = 1 => `use="required"`
  - Any MaxOccurs other than 1 (or just above 1?) is invalid
- [ ] Add a note that documentation is required here for external properties in adapter classes but doesn't typically appear otherwise since every NIEM conformant property is already required to have its own definition.

- [ ] Is there a way to support EXT choices optionally appearing under the sequence?  Add a field for choice group number or name and then generate choice blocks for matching properties?

nc:PersonType

- *property* (*optional choice group number*)
- nc:PersonName
- nc:PersonEyeColorCode (1)
- nc:PersonEyeColorText (1)
- nc:PersonDescriptionText
- nc:PersonHairColorCode (2)
- nc:PersonHairColorText (2)

Would turn into (abbreviated)

```xml
<xs:complexType>
  <xs:sequence>
    <xs:element ref="nc:PersonName"/>
    <xs:choice>
      <xs:element ref="nc:PersonEyeColorCode"/>
      <xs:element ref="nc:PersonEyeColorText"/>
    </xs:choice>
    <xs:element ref="nc:PersonDescriptionText"/>
    <xs:choice>
      <xs:element ref="nc:PersonHairColorCode"/>
      <xs:element ref="nc:PersonHairColorText"/>
    </xs:choice>
  </xs:sequence>
</xs:complexType>
```

or change the numbers to strings.

- [ ] Association doesn't seem like quite the right name for this?

I would think of this being an association if it contained both the type and the property.  Associations in NIEM usually contain the objects being related, not contain one object and be contained by the other.

- [ ] Add a note about `AugmentingNamespace` being described in section 4.15?

- [ ] Figure 4-12 - `xs:element/@appinfo:augmentingNamespace` doesn't show up in the XSD now.  We do it via augmentation types and substitution groups.  You wouldn't need this until we possibly convert to wildcards instead of augmentation points in NIEM 7.0, in which case the appinfo could be added then.

- [ ] Property vs ObjectProperty and DataProperty

- Figure 4-7 under Section 4.4 (Class) shows a ChildProperty Association pointing to a *Property*.

- The 4.5 ChildPropertyAssociation class and attribute table contains a row for *Property*.

- The CMF example in Figure 4-12 contains *ObjectProperty* and *DataProperty* in the two Property Associations.

That seems like a little bit of a leap at this point.  Maybe update the description of Property in the 5.2 table to "An object property or a data property that occurs in the class." to create a tie in?

- [ ] Add a note about attribute cardinality? Only possible values for min occurs is 0 or 1, corresponding to attribute use `optional` or `required`.

## 4.6 Property class

- [ ] RelationshipPropertyIndicator is unclear.

- [x] Add attributes of the Component class to the UML diagram to make it easy to see what Property inherits?

- [ ] Figure 4-13 and corresponding table - Does this need to contain "nillable" if EXT properties can set the value to false?

- [ ] Make sections 4.7 (Object Property) and 4.8 (DataProperty) subsections of this one, like section 4.4 (Class) has subsections.

- [ ] Maybe move section 4.5 (Child Property Association) after the property sections so readers can understand both parts of the association before getting to the association itself?  Or instead, maybe better to move the Property section before Class?

## 4.7 ObjectProperty class

- [ ] Would be helpful to see a list of reference code values, or link back to the values that appear above.

- [ ] `ReferenceCode` - If the ReferenceCode currently on `Class` gets moved to `ChildPropertyAssociation`, should this be here at all?  Or if so, derived rather than explicit?

  - Seems to only apply to message format schemas (should nc:Person contains `structures:id`, `structures:ref` and `structures:uri`, or some subset of them, or none?).  CMF describes models, not ways to restrict content in message format schemas.  (We want to make that possible, but I think that's outside the scope of the NDR.)  Otherwise...

  - If all child property associations that contain property `Person` use reference code "NONE" (inline), then property `Person` doesn't need the stuff from `structures`.  If it's code "REF" in one place and "URI" in another, then `Person` needs all `id`, `ref`, and `uri`.  And so on.

  - Making it explicit on the property can lead to conflicts if it doesn't match up with what is defined on the child property associations.  And there is no point in allowing for additional flexibility on the property than what appears in the child property association if this only matters in the message format schemas.

- [ ] Inline vs reference isn't explained much here.  Examples here or in section 5 (Data modeling patterns) would be helpful.

- [ ] Default for reference code?  If not specified, element could be inline or reference?

- [ ] The CMF to XSD table has several `xs:complexType` paths instead of `xs:element` paths.

## 4.8 DataProperty class

- [ ] Example of `nc:PersonFullName` with range of `xs:string` is confusing since its type in NIEM is `nc:PersonNameTextType`

- [ ] CMF shouldn't expect users to flatten NIEM themselves but the CMF Tool should do it for them

- [ ] What is a data property in XML with AttributeIndicator = false?

  - Aren't elements with simple types invalid in reference / extension schemas?  (okay for flattened schemas)

- [ ] Not sure what the RefAttributeIndicator / reference property is here.  Is this attribute augmentation?  Described in section 4.15.6?

- [ ] The CMF to XSD table contains several paths for `xs:complexType` instead of `xs:element` or `xs:attribute`.

- [ ] I'd recommend adding an explicit Attribute class.

  - The rules are different enough for them to be separate things.  Name camel casing, cardinality ranges, data type (only from the xs namespace or a type with a name that ends with "SimpleType").  Can't be abstract.  Can't be in a substitution group.
  - If datatypes are allowed to contain attributes, then we'd want the child property association to only be able to reference attributes, not any data property.

## 4.9 Datatype class

- [ ] Benefit of 11 facet subclasses vs a `FacetCategoryCode` code set?

  - I think XSLT could check if values for certain kinds of facets are numeric, positive, etc.

- [ ] Seems like "atomic" is used again here to mean simple instead of simple + attributes

- [ ] Can't EXT simple types be either restrictions or extensions?

  - Would need a field to capture which one
  - Would need ot rename Restriction class to something else (ValueType?)

- [ ] Show the Component class and its attributes here to show its inherited fields?

- [ ] List itemType is a singleton, not a list. Looks like multiple item datatypes are allowed in the UML diagram.

- [ ] What is the "0..*" cardinality on `Restriction` going to `Datatype`?  There isn't a cardinality going out of List or Union to Datatype.

## 4.10 List class

- [ ] Is `ListOf` named correctly?  `ListItemDataType` instead?

## 4.11 Union class

- [ ] `UnionOf` to something like `MemberDatatype` or `UnionMemberDataType`?

- [ ] Figure 4-19 - XSD `<xs:simpleContent>` should be on its own line.

## 4.12 Restriction

- [ ] Recommend naming this Atomic Datatype instead of Restriction

  - Lines up with XML schema kinds of datatypes: atomic, list, union
  - Complex types can use restriction as well, so "Restriction" by itself doesn't uniquely identify this class as only a simple type restriction.

- [ ] CMF to XSD table has `xs:complexType` paths but no `xs:simpleType` paths.

## 4.13 Facet

- [ ] Add a note that DocumentationText is required for enumerations and patterns?

## 4.15 Augmentation class

- [ ] What is the cardinality on the UML diagram - an augmentation can have 0..1 classes?  What's an augmentation without the class?

- [ ] Single backtick code formatting is off for "There is no method for a message designer...and im:PersonType`." at the end of the sentence.

- [ ] The class and attribute table has column names that are off, still has the original UML short attribute names, the "Card" column (should be "Description") is aligned center, and the range values are missing.

- [ ] Could augmentation records themselves be ordered so that the augmentation index isn't required?

- [ ] What is `AugmentedGlobalComponentID`?

- [ ] Augmentation information seems duplicated.

  - Doesn't this duplicate all of the augmentation info?
  - It appears one time as an augmentation record in the Namespace object.
  - And it appears a second time as a child property association in the augmented class.
  - Is there really a need for both?  Couldn't the AugmentationRecord just be dropped?  The information could be derived.

- [ ] `AugmentationRecord` and `ChildPropertyAssociation` are almost the same thing.  Biggest difference is that child property associations are nested under classes, and they are ordered (no explicit index required).

## 4.15.1 Augmentations in NIEM XSD

- [ ] "a type with an atomic value...CSC type" - Better to use "a type with a simple value".  CSC types can also carry lists and unions.

- [ ] "The four combinations iare" - typo "iare".

- [ ] Didn't see a corresponding section or a mention in 4.15 "Augmentation class" about how augmentations are handled in JSON.  May need a note saying that the JSON representation for individual augmentation patterns are included in each subsection.

- [ ] Would it be clearer to give the patterns for 4.15.2 and 4.15.3 names, like "Augmentations with container substitution" and "Augmentations with direct substitution"?

## 4.15.2 Augmenting a CCC type with an augmentation element and type

- [ ] "Every CCC type in a reference or extension schema contains an augmentation point element" - except for adapter types.

- [ ] The lead in for Figure 4-29 explains that the augmentation element does not appear in a NIEM JSON message.  Should also mention explicitly that the contents of the augmentation type do appear in the JSON message.

## 4.15.3 Augmenting a CCC type with an ordinary element

- [ ] Mention the trade-offs?

- Simpler not to create an augmentation element and augmentation type
- You can only place an element in a single substitution group, so you couldn't use this method to add the same property to multiple augmentations.
- You can only place an element in a substitution group if it is in a namespace you own.  You can't changed the substitution group of an element from Core or a domain, for example, if you are creating an IEPD.

## 4.15.4 Augmenting a CCC type with an attribute

- [ ] I'm not sure this is clear why it's a subset operation.  Would be helpful to explain that removing the attribute wildcard from structures and replacing it with only the allowable attributes in a message constrains what can be sent.  Similar to constraining cardinality from 0 to unbounded to exactly the number of occurrences you want to appear, or removing properties and types you don't need from the subset.

- [ ] Refactor to have one heading for "Augmenting a complex type with an attribute" with the generic description about removing wildcards in subset schemas and then put the CCC example and the CSC example into two subsections?

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

## 6.2 Conformance target assertions

- [ ] Should the base target namespace for this document be "https://docs.oasis-open.org/niemopen/ns/specification/XNDR/6.0/"?  We didn't go with the idea of splitting CMF and XSD versions into different documents.  Would require a change to the 6.0 schemas as well.

## Rules

- [ ] Better to break up compound rules?  e.g., Rule 7-1: "Name of Class, Datatype, and Property components || Class and Datatype components MUST have a name ending in "Type"; Property components MUST NOT."  Keep one rule for class and datatype names must end with "Type" and another rule for property names must not end with "Type"?

- [ ] Note: Haven't done a real review of rules but have skimmed it to look at the organization.

- [ ] Suggested rules outline:

- Rules for components
  - (general rules about name terms, camel casing, etc.)
  - (general rules about data definitions)
- Rules for properties
- Rules for classes
- Rules for datatypes
- Rules for namespaces
- Rules for models
- Rules for message specifications
- Rules for messages
- Rules for NIEM XSD
- Rules for NIEM JSON-LD

## 7. Rules for namespaces

- [ ] Recommend creating separate sections for components, or for properties and types, instead of embedding them into namespaces.

Current:

- 7. Namespaces
  - 7.1 Component names
  - 7.2 Component definitions
  - 7.3 Namespace properties (e.g., prefix, version, uri)
  - 7.4 REF namespaces
  - 7.5 EXT namespaces
  - 7.6 SUBSET namespaces

Suggested:

- 7. Components
  - 7.1 Component names
  - 7.2 Component documentation
- 8. Namespaces
  - 8.1 Namespace properties
  - 8.2 REF namespaces
  - 8.3 EXT namespaces
  - 8.4 SUBSET namespaces

## 8. Rules for schema documents

- [ ] Isn't this similar to 13. "Rules for the NIEM profile of JSON-LD"?

- Should this be moved to just in front of the JSON-LD section?
- Should this be renamed "Rules for the NIEM profile of XSD"?  We have schemas for JSON too, but that's not what we are talking about here.
- Section 8.1 has this name, but other subsections also contain rules for the NIEM profile of XSD, just grouped with related things together.

## 8.2 Rules for type definitions

- [ ] Rules 8-25 and 8-26 (complex and simple type names) correspond with rules 7-1 and 7-6 (class and datatype names end with "Type"; datatype names end with "SimpleType").  I don't think we need two extra rules.

- Same for rule 8-31 (names of adapter types, association types, etc.)

- [ ] Unless some is pretty familiar with the XML Schema specification, they are likely going to think "Rules for type definitions" is going to talk about type documentation / data definitions, e.g., standard opening phrases.  Recommend just calling this "Rules for types".  And to be consistent, just call "Rules for attribute and element declarations" "Rules for attributes and elements".

## 9 Rules for models

- [ ] Rule 9-1 excludes other utility namespaces besides structures

## 12 ?

- [ ] No high-level section 12.  Goes from 11.2 straight to 12.2.

- [ ] Wouldn't info like `structures:id`, `structures:ref`, and `structures:uri` be grouped with 11.1 "Rules for XML messages"?

## 14. Rules for NIEM messages in JSON

- [ ] How is this different from 11.2 "Rules for JSON messages"?
