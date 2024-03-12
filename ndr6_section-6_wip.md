# NDR Section 6

## Sources

https://niem.github.io/reference/concepts/


## Topic Outline

### NIEM model fundamentals

#### Models

- General info about the model (IEPD catalog basic info section, auth source, etc.)
- Conformance Targets / Reference models vs message models
- Model versioning

A model version is a collection of schemas representing
It's possible, but ill-advised to combine schemas from different versions.

#### Namespaces

##### General info about the namespace (prefix, definition, auth source)

Namespaces act like collections that contextually group related properties and types. Namespaces represent content from an authoritative source or standard, such as a domain or the NIEM Business Architecture Committee (NBAC), which collaboratively manages the Core namespace. They also have additional characteristics, like a target namespace URI (a unique ID) and a namespace prefix (used as shorthand for the URI)

Each NIEM namespace is defined in one and only one schema document. The URI for a namespace is defined by the `targetNamespace` attribute on the top-level `xs:schema` property. In this example, the NIEM Core namespace is assigned the URI `https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/`.

```xml
targetNamespace="https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/"
```
The URI and prefix are both defined with the `xmlns` attribute on the top-level `xs:schema` property.

In this example for the NIEM Core namespace, the `xmlns` definess a URI for the namespace itself, `https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/`, and a prefix for properties from that namespace, `nc`.

```xml
xmlns:nc="https://docs.oasis-open.org/niemopen/ns/model/niem-core/6.0/"
```

##### Namespace versioning

NIEM release namespaces are persistent. Once a release is published, its schemas will not be overwritten with future changes. Changes go into new schemas. This ensures that existing exchanges do not break when NIEM publishes a new release and allows existing work to use older schemas.

Version numbers are embedded in the URI for each namespace. In this examples, this is version 6.0 of the schema defining the Human Services domain.

```xml
xmlns:hs="https://docs.oasis-open.org/niemopen/ns/model/domains/humanServices/6.0/"
```

##### Local terminology

Each namespace can optionally include terminology local to that community. This information is for convenience in understanding properties and definitions in that namespace. Local terminology is defined by `appinfo:LocalTerm` properties, one per term. The `term` and `literal` attributes link terms and their definitions.

```xml
<appinfo:LocalTerm term="AFIS" literal="Automated Fingerprint Identification System"/>
```



### Properties

- Object properties
- Literal properties
- Abstract properties
- Attributes


Properties
A property represents a concept, idea, or thing. Properties can represent complex objects containing other properties, simple data values, or simply a concept with no defined representation. Different kinds of properties are represented by different XML elements.

Elements
Properties are typically represented in XML by XML elements, occasionally by attributes. In an XML instance document, the element acts as a container that may carry either a simple value or an object, and optionally attributes.

Abstract Elements
An abstract element is an element defined as a placeholder for a concept. Prime examples in NIEM are the different formats possible for dates. NIEM has a conceptual placeholder, `nc:DateRepresentation`, that can be replaced with various date formats, e.g. a timestamp, a full date, etc. In a schema, the placeholder element is a substitution group head that must be replaced with an appropriate substitution group member in an XML instance.

```xml
  <xs:element name="DateRepresentation" abstract="true">
    <xs:annotation>
      <xs:documentation>A data concept for a representation of a date.</xs:documentation>
    </xs:annotation>
  </xs:element>
```
Substitutable Elements
A substitutable element is one that can replace another element in an instance. They generally provide different ways of representing a concept. In XML, they are substitution group members that specify a substitution group head that represents a concept. For example, `nc:Date` can replace the concept of a `nc:DateRepresentation` in an XML instance document.

```xml
  <xs:element name="Date" type="niem-xs:date" substitutionGroup="nc:DateRepresentation" nillable="true">
    <xs:annotation>
      <xs:documentation>A full date.</xs:documentation>
    </xs:annotation>
  </xs:element>
```

Attributes
An XML attribute is a property that may carry a simple value only. NIEM tends to limit attributes to metadata, but that is not a requirement. In this example, the `nc:valueEmptyReasonText` attribute would be applied to some element lacking a value and would provide an explanation.

```xml
  <xs:attribute name="valueEmptyReasonText" type="xs:string">
    <xs:annotation>
      <xs:documentation>A reason why a data value was not provided.</xs:documentation>
    </xs:annotation>
  </xs:attribute>
```

#### Classes

Classes define how concepts are structured. Properties are then defined to be of certain classes, thereby defining what those properties can hold. Classes are usually more generic than properties. Different properties might have different semantic meanings, but have the same structure. A single class defining that structure

Classes are represented in XML by XML Schema's type system. Each class is an XML Schema type. Types can hold other objects, or can hold simple data. In either case, types can also include attributes.

- Classes / object types
	- Subclasses
- Literal types
- Simple types
	- Simple types with facets
	- Simple list types
	- Simple union types

### NIEM modeling patterns / advanced constructs

#### Adapters and external standards

#### Associations

#### Augmentations

#### Linked data

#### Metadata

#### References

#### Representation pattern

#### Roles
