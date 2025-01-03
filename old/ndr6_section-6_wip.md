# NDR Section 6

## Sources

https://niem.github.io/reference/concepts/


# NIEM model fundamentals

## Models

- General info about the model (IEPD catalog basic info section, auth source, etc.)
- Conformance Targets / Reference models vs message models
- Model versioning

A model version is a collection of schemas representing
It's possible, but ill-advised to combine schemas from different versions.

## Namespaces

### General info about the namespace (prefix, definition, auth source)

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

### Namespace versioning

NIEM release namespaces are persistent. Once a release is published, its schemas will not be overwritten with future changes. Changes go into new schemas. This ensures that existing exchanges do not break when NIEM publishes a new release and allows existing work to use older schemas.

Version numbers are embedded in the URI for each namespace. In this examples, this is version 6.0 of the schema defining the Human Services domain.

```xml
xmlns:hs="https://docs.oasis-open.org/niemopen/ns/model/domains/humanServices/6.0/"
```

### Local terminology

Each namespace can optionally include terminology local to that community. This information is for convenience in understanding properties and definitions in that namespace. Local terminology is defined by `appinfo:LocalTerm` properties, one per term. The `term` and `literal` attributes link terms and their definitions.

```xml
<appinfo:LocalTerm term="AFIS" literal="Automated Fingerprint Identification System"/>
```

## Properties

### Properties

A property represents a concept, idea, or thing. Properties can represent complex objects containing other properties, simple data values, or simply a concept with no defined representation. Different kinds of properties are represented by different XML elements.

### Elements

Properties are typically represented in XML by XML elements, occasionally by attributes. In an XML instance document, the element acts as a container that may carry either a simple value or an object, and optionally attributes.

### Abstract Elements

An abstract element is an element defined as a placeholder for a concept. Prime examples in NIEM are the different formats possible for dates. NIEM has a conceptual placeholder, `nc:DateRepresentation`, that can be replaced with various date formats, e.g. a timestamp, a full date, etc. In a schema, the placeholder element is a substitution group head that must be replaced with an appropriate substitution group member in an XML instance.

```xml
  <xs:element name="DateRepresentation" abstract="true">
    <xs:annotation>
      <xs:documentation>A data concept for a representation of a date.</xs:documentation>
    </xs:annotation>
  </xs:element>
```

### Substitutable Elements

A substitutable element is one that can replace another element in an instance. They generally provide different ways of representing a concept. In XML, they are substitution group members that specify a substitution group head that represents a concept. For example, `nc:Date` can replace the concept of a `nc:DateRepresentation` in an XML instance document.

```xml
  <xs:element name="Date" type="niem-xs:date" substitutionGroup="nc:DateRepresentation" nillable="true">
    <xs:annotation>
      <xs:documentation>A full date.</xs:documentation>
    </xs:annotation>
  </xs:element>
```

### Attributes

An XML attribute is a property that may carry a simple value only. NIEM tends to limit attributes to metadata, but that is not a requirement. In this example, the `nc:valueEmptyReasonText` attribute would be applied to some element lacking a value and would provide an explanation.

```xml
  <xs:attribute name="valueEmptyReasonText" type="xs:string">
    <xs:annotation>
      <xs:documentation>A reason why a data value was not provided.</xs:documentation>
    </xs:annotation>
  </xs:attribute>
```

## Classes

Classes define how concepts are structured. Properties are then defined to be of certain classes, thereby defining what those properties can hold. Classes are usually more generic than properties. Different properties might have different semantic meanings, but have the same structure. A single class defining that structure

Classes are represented in XML by XML Schema's type system. Each class is an XML Schema type. Types can hold other objects, or can hold simple data. Either option can also include attributes. Mixed content, in which an element can hold both other objects _and_ simple data, are not allowed in NIEM. In either case, types can also include attributes.

### Classes / Object types

Classes that are comprised of other objects are represented by XML Schema complex types with complex content. These types must end with the text "Type", e.g. `nc:PersonType`.

### Subclasses

NIEM supports subclasses, versions of classes that derive from a more generic parent class, inheriting all the properties that the parent can hold, and adding additional properties specific to the subclass.

_All_ complex types in NIEM are derived from a parent type, either some more generic version of the type, the NIEM-supplied base type `structures:ObjectType`, or one of the NIEM-supplied types for defining metadata, associations, and augmentations. 
These NIEM-supplied base types provide important attributes for all elements in NIEM.

For example, `j:MedicalPractitionerType` is derived from `nc:PersonType` while `nc:PersonType` itself is derived from `structures:ObjectType`. Properties from `structures:ObjectType` are inherited by `nc:PersonType`. Properties from _both_ `structures:ObjectType` and `nc:PersonType` are inherited by `j:MedicalPractitionerType`. Type derivation chains can be arbitrarily long. Each derived type will inherit _all_ properties from the types from which it is derived.


### Literal types

### Simple types

Simple type represent data such as strings and numbers as well as other simple value concepts made up of strings and numbers, like a boolean or date string.

Simple types can be constrained in various ways.

#### Simple Types with Facets

Simple types with facets constrain valid values to an enumerated list. In this example, the `xs:token` type, essentially a string, is constrained to a number of defined enumerations, e.g. "BLACK", "BLUE", and others.

```xml
<xs:simpleType name="PersonEyeColorCodeSimpleType">
	<xs:annotation>
		<xs:documentation>A data type for a code set identifying an eye color of a person.</xs:documentation>
	</xs:annotation>
	<xs:restriction base="xs:token">
		<xs:enumeration value="BLACK">
			<xs:annotation>
				<xs:documentation>BLACK</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="BLUE">
			<xs:annotation>
				<xs:documentation>BLUE</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="BROWN">
			<xs:annotation>
				<xs:documentation>BROWN</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="GRAY">
			<xs:annotation>
				<xs:documentation>GRAY</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="GREEN">
			<xs:annotation>
				<xs:documentation>GREEN</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="HAZEL">
			<xs:annotation>
				<xs:documentation>HAZEL</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="MAROON">
			<xs:annotation>
				<xs:documentation>MAROON</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="MULTICOLORED">
			<xs:annotation>
				<xs:documentation>MULTICOLORED</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="PINK">
			<xs:annotation>
				<xs:documentation>PINK</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
		<xs:enumeration value="UNKNOWN">
			<xs:annotation>
				<xs:documentation>UNKNOWN</xs:documentation>
			</xs:annotation>
		</xs:enumeration>
	</xs:restriction>
</xs:simpleType>
```

#### Simple Types with Lists

Simple types with lists constrain valid values to a space-delimited list of values of a specified type. In this example, elements of this type contain a space-delimited series of double-precision positive numbers.


```xml
<xs:simpleType name="PositiveDoubleListSimpleType">
	<xs:annotation>
		<xs:documentation>A data type for a list of doubles restricted to positive values.</xs:documentation>
	</xs:annotation>
	<xs:list itemType="cbrn:PositiveDoubleSimpleType"/>
</xs:simpleType>
```

#### Simple Types with Unions

Simple types with unions combine existing simple types, usually types with facets, to produce a type that includes all enumerations of the types being combined. In this example, six different biometric fingerprint codes are combined into one type.

```xml
<xs:simpleType name="ExemplarFingerPositionCodeSimpleType">
	<xs:annotation>
		<xs:documentation>
			A data type union of basic finger positions and slap captures, standardly used for tenprint exemplar capture
		</xs:documentation>
	</xs:annotation>
	<xs:union memberTypes="biom:FingerPositionCodeSimpleType biom:HypothenarPositionCodeSimpleType
		biom:MobileFingerPositionCodeSimpleType biom:SlapFingerPositionCodeSimpleType
		biom:SupplementalFingerPositionCodeSimpleType biom:UnknownPositionCodeSimpleType"/>
</xs:simpleType>

```

#### Simple Types with Patterns

Simple types with patterns constrain valid values to a defined pattern. In this example, the pattern defines a string of 64 hexadecimal digits. The regular expressions defining patterns can be very complex and are beyond the score of this specification.

```xml
<xs:simpleType name="DigitalAudioRecordHashValueSimpleType">
	<xs:annotation>
		<xs:documentation>
			A data type for a hash value computed from a binary object,
			like a digital audio record
		</xs:documentation>
	</xs:annotation>
	<xs:restriction base="xs:string">
		<xs:pattern value="([0-9a-fA-F]){64}">
			<xs:annotation>
				<xs:documentation>
					A pattern for a hash value computed from a binary object,
					like a digital audio record
				</xs:documentation>
			</xs:annotation>
		</xs:pattern>
	</xs:restriction>
</xs:simpleType>

```

#### Complex Types with Simple Content

Complex types can also hold a combination of simple data and attributes. One common example of this in NIEM are simple types wrapped in a complex type wrapper to add common NIEM referencing attributes via `structures:SimpleObjectAttributeGroup`. In this example, the `j:PersonEyeColorCodeSimpleType` simple type is extended to add attributes, resulting in `j:PersonEyeColorCodeType`, a complex type with simple content.

```xml
<xs:complexType name="PersonEyeColorCodeType">
	<xs:annotation>
		<xs:documentation>A data type for a code set identifying an eye color of a person.</xs:documentation>
	</xs:annotation>
	<xs:simpleContent>
		<xs:extension base="j:PersonEyeColorCodeSimpleType">
			<xs:attributeGroup ref="structures:SimpleObjectAttributeGroup"/>
		</xs:extension>
	</xs:simpleContent>
</xs:complexType>
```


# NIEM modeling patterns / advanced constructs

## References

## Associations

## Roles

## Augmentations

## Linked data

## Metadata

## Representation pattern

## Adapters and external standards
