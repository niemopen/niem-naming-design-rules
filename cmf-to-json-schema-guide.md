# CMF to JSON Schema Guide

## Introduction

This is a guide to converting Common Model Format (CMF) to JSON Schema to allow for the validation of JOSN/JSON-LD instance documents against NIEM subsets.

It aims to enforce as much of the CMF as possible, while still being acceptable to JSON developers. It does not reference XML Schema at all.

The initial audience was GTRI internal developers for the purpose of writing CMF-to-JSON Schema transformation software.

## Replicate Properties and Classes

Properties and classes in CMF map very easily over to JSON Schema properties and definitions.

Here's an example `Property` definition for `j.Crash`. In CMF, as in XML Schema, each `Property` is a separate object. The `Class` property defines the `Property`'s class, in this case `j.CrashType`, where what the `Property` can hold is defined.

```xml

<Property structures:id="j.Crash">
	<Name>Crash</Name>
	<Namespace structures:ref="j" xsi:nil="true"/>
	<DefinitionText>A traffic accident.</DefinitionText>
	<Class structures:ref="j.CrashType" xsi:nil="true"/>
</Property>
```

In JSON Schema, each property is an object inside the `properties` object for the schema. It includes a type, for simple data types, or a reference to a definition where what the property can hold is defined. Here's the definition for `j:Crash`:

```json
"properties": {
	"j:Crash": {
		"description": "A traffic accident.",
		"$ref": "#/definitions/j:CrashType"
	}
}
```

Here's the matching `Class` definition for` j.CrashType` in CMF. It shows that `j.CrashType` extends a base type called `j.DrivingIncidentType`, thus inheriting properties from that base type. Then it adds three additional contained properties, `j.CrashVehicle`, `j.CrashPerson`, and `nc.Location`.

```xml
<Class structures:id="j.CrashType">
	<Name>CrashType</Name>
	<Namespace structures:ref="j" xsi:nil="true"/>
	<DefinitionText>A data type for a traffic accident.</DefinitionText>
	<ExtensionOfClass structures:ref="j.DrivingIncidentType" xsi:nil="true"/>
	<HasProperty structures:sequenceID="1">
		<Property structures:ref="j.CrashVehicle" xsi:nil="true"/>
		<MinOccursQuantity>1</MinOccursQuantity>
		<MaxOccursQuantity>1</MaxOccursQuantity>
	</HasProperty>
	<HasProperty structures:sequenceID="2">
		<Property structures:ref="j.CrashPerson" xsi:nil="true"/>
		<MinOccursQuantity>0</MinOccursQuantity>
		<MaxOccursQuantity>unbounded</MaxOccursQuantity>
	</HasProperty>
	<HasProperty structures:sequenceID="3">
		<Property structures:ref="nc.Location" xsi:nil="true"/>
		<MinOccursQuantity>1</MinOccursQuantity>
		<MaxOccursQuantity>1</MaxOccursQuantity>
	</HasProperty>
</Class>
```

In JSON Schema, each type is an object inside the  `definitions` object for the schema. The base type is included by referencing it in the `allOf` array. The properties added by `j:CrashType` are added in a second object in the array. It should also be noted that JSON Schema is not object oriented in the same way that XML Schema and CMF are. The `allOf` object does not create a composition of all the definitions listed. Each object in the `allOf` array is tested separately. This means that you cannot use the `"additionalProperties": false` to exclude additional arbitrary properties in the context of an `allOf` array. 

`j:CrashType` looks like this:

```json
"definitions": {
	"j:CrashType": {
		"description": "A data type for a traffic accident.",
		"allOf": [
			{"$ref": "#/definitions/j:DrivingIncidentType"},
			{
				"type": "object",
				"properties": {
					"j:CrashVehicle": {"$ref": "#/properties/j:CrashVehicle"},
					"j:CrashPerson": {"$ref": "#/properties/j:CrashPerson"},
					"nc:Location": {"$ref": "#/properties/nc:Location"}
				},
				"required": [
					"j:CrashVehicle",
					"nc:Location"
				]
			}
		]
	}
}
```

This example displays simple cardinality. More complex cardinality is discussed below.

## Replicate Cardinality

JSON Schema handles multiple instances of data differently. This is allowable XML:

```xml
<nc:PersonName>  
	<nc:PersonGivenName>Peter</nc:PersonGivenName>  
	<nc:PersonMiddleName>Death</nc:PersonMiddleName>  
	<nc:PersonMiddleName>Bredon</nc:PersonMiddleName>  
	<nc:PersonSurName>Wimsey</nc:PersonSurName>  
</nc:PersonName>
```

But duplicate sequential keys in JSON is not. If you want an element to have multiple instances of the same property, you need to define the object as containing an array of things instead of just one instance a thing. The above example looks like this in JSON:

```json
"nc:PersonName": [  
	{  
		"nc:PersonGivenName": "Peter",  
		"nc:PersonMiddleName": [  
			"Death",  
			"Bredon"  
		],  
		"nc:PersonSurName": "Wimsey"  
	}  
]
```

Cardinality in XML Schema is defined in one place, in the containing type. 

```xml
<xs:complexType name="PersonNameType">
	<xs:annotation>
		<xs:documentation>A data type for a combination of names and/or titles by which a person is known.</xs:documentation>
	</xs:annotation>
	<xs:complexContent>
		<xs:extension base="structures:ObjectType">
			<xs:sequence>
				<xs:element ref="nc:PersonGivenName" minOccurs="0" maxOccurs="1"/>
				<xs:element ref="nc:PersonMiddleName" minOccurs="0" maxOccurs="unbounded"/>
				<xs:element ref="nc:PersonSurName" minOccurs="1" maxOccurs="1"/>
			</xs:sequence>
			<xs:attribute ref="nc:personNameCommentText" use="optional"/>
		</xs:extension>
	</xs:complexContent>
</xs:complexType>
```

In JSON Schema, whether a property is required to be inside another object is defined in the containing object's type, but due to the nature of how JSON handles multiple instances of the same property, whether an object can contain just a single thing or can contain an array of things is defined on the object itself. See the difference below between `PersonMiddleName` which holds an array of values and `PersonSurName` which contains just a single instance.

```json
"nc:PersonMiddleName": {  
	"description": "A middle name of a person.",  
	"type": "array",  
	"items": {"$ref": "#/definitions/nc:PersonNameTextType"}  
},  
"nc:PersonSurName": {  
	"description": "A last name or family name of a person.",  
	"$ref": "#/definitions/nc:PersonNameTextType"  
},
```

Here's the mapping for the various combinations of cardinality, as defined via the `MinOccursQuantity` and `MaxOccursQuantity` properties in a class:

### Cardinality of 0 to 1

For cardinality of 0 to 1, we add the object to the appropriate containing type, and define the object as holding one instance of its contents.

Here we add `nc:PersonGivenName` to `nc:PersonNameType`, but do _not_ include it in the list of required properties:

```json
"nc:PersonNameType": {
	"description": "A data type for a combination of names and/or titles by which a person is known.",
	"type": "object",
	"properties": {
		"nc:PersonGivenName": {"$ref": "#/properties/nc:PersonGivenName"},
		"nc:PersonMiddleName": {"$ref": "#/properties/nc:PersonMiddleName"},
		"nc:PersonSurName": {"$ref": "#/properties/nc:PersonSurName"},
		"nc:personNameCommentText": {"$ref": "#/properties/nc:personNameCommentText"}
	},
	"required": ["nc:PersonSurName"]
}
```

Then we define `nc:PersonGivenName` itself as holding _a single instance_ of the things it's defined to hold, via the `$ref`:

```json
"nc:PersonGivenName": {
	"description": "A first name of a person.",
	"$ref": "#/definitions/nc:PersonNameTextType"
}
```

### Cardinality of 1 to 1

For cardinality of 1 to 1, we add the object to the appropriate containing type, mark it as required, and define the object as holding one instance of its contents.

Here we add `nc:PersonSurName` to `nc:PersonNameType`, and _include_ it in the list of required properties:

```json
"nc:PersonNameType": {
	"description": "A data type for a combination of names and/or titles by which a person is known.",
	"type": "object",
	"properties": {
		"nc:PersonGivenName": {"$ref": "#/properties/nc:PersonGivenName"},
		"nc:PersonMiddleName": {"$ref": "#/properties/nc:PersonMiddleName"},
		"nc:PersonSurName": {"$ref": "#/properties/nc:PersonSurName"},
		"nc:personNameCommentText": {"$ref": "#/properties/nc:personNameCommentText"}
	},
	"required": ["nc:PersonSurName"]
}
```

Then we define `nc:PersonSurName` itself as holding _a single instance_ of the things it's defined to hold, via the `$ref`:

```json
"nc:PersonSurName": {
	"description": "A last name or family name of a person.",
	"$ref": "#/definitions/nc:PersonNameTextType"
}
```

### Cardinality of 0 to unbounded

For cardinality of 0 to unbounded, we add the object to the appropriate containing type, and define the object as holding _an array_ of instances of its contents.

Here we add `nc:PersonMiddleName` to `nc:PersonNameType`, but do _not_ include it in the list of required properties:

```json
"nc:PersonNameType": {
	"description": "A data type for a combination of names and/or titles by which a person is known.",
	"type": "object",
	"properties": {
		"nc:PersonGivenName": {"$ref": "#/properties/nc:PersonGivenName"},
		"nc:PersonMiddleName": {"$ref": "#/properties/nc:PersonMiddleName"},
		"nc:PersonSurName": {"$ref": "#/properties/nc:PersonSurName"},
		"nc:personNameCommentText": {"$ref": "#/properties/nc:personNameCommentText"}
	},
	"required": ["nc:PersonSurName"]
}
```

Then we define `nc:PersonMiddleName` itself as holding _an array_ of the things it's defined to hold, via the `$ref`:

```json
"nc:PersonMiddleName": {
	"description": "A middle name of a person.",
	"type": "array",
	"items": {"$ref": "#/definitions/nc:PersonNameTextType"}
}
```

### Cardinality of 1 to unbounded

For cardinality of 1 to unbounded, we add the object to the appropriate containing type, mark it as required, and define the object as holding _an array_ of instances of its contents.

Here we add `nc:PersonName` to `nc:PersonType`, and _include_ it in the list of required properties:

```json
"nc:PersonType": {
	"description": "A data type for a human being.",
	"type": "object",
	"properties": {
		"nc:PersonBirthDate": {"$ref": "#/properties/nc:PersonBirthDate"},
		"nc:PersonName": {"$ref": "#/properties/nc:PersonName"}
	},
	"required": ["nc:PersonName"]
}
```
Then we define `nc:Person` itself as holding _an array_ of the things it's defined to hold, via the `$ref`:

```json
"nc:Person": {
	"description": "A human being.",
	"type": "array",
	"items": {"$ref": "#/definitions/nc:PersonType"}
}
```

### Arbitrary Cardinality of n to m

For cardinalities where the lower bound is greater than 1 and the upper bound is less than unbounded, we can use `minItems` and `maxItems` to define the minimum and maximum times a set of properties can occur in the array:

Here we allow for multiple `ext:PrivacyCode` values, but limit the number to 2:

```json

"ext:PrivacyCode": {
	"description": "A code representing a kind of property.",
	"type": "array",
	"items": {"$ref": "#/definitions/ext:PrivacyCodeType"},
	"maxItems": 2
}
```

We've made a design choice in not using `minItems` when the lower bound for an array is 1. It seems that JSON developers are comfortable with using an empty array, e.g. `[]`, in the same way that they use an empty string, i.e. `""` in JSON instance documents.

So if an empty value was sent for `nc:PersonMiddleName`, we allow for this:

```json
"nc:PersonMiddleName": []
```

Instead of requiring this:

```json
"nc:PersonMiddleName": [""]
```

### Combine Overlapping Cardinality

XML Schema allows for the same element to be included in multiple types, each with its own cardinality. Every context can have its own cardinality. CMF mirrors this ability.

This can be a problem in JSON Schema when the same element is in different contexts and the maximum cardinality in one of the contexts is greater than one, because the difference between a cardinality of 1 and anything greater than 1 is defined in the element itself, not the context.

To support this, we place each separate cardinality constraint in a separate block inside an `anyOf` structure. This ensures that each cardinality set can be tested, although it does not ensure that the correct constraints are enforced against the correct contexts. This is simpler to transform compared to calculating a cardinality superset, and probably a tighter constraint in most circumstances. It also covers cases in which the different sets of constraints are disjunct.

Here's an example in which `nc.PassportType` can hold 0 to 1 `nc.PersonName` objects, and `nc.PersonType` can hold 1 to unbounded `nc.PersonName` objects.

```xml
<Class structures:id="nc.PassportType">
	<Name>PassportType</Name>
	<Namespace structures:ref="nc" xsi:nil="true"/>
	<DefinitionText>A data type for a human being.</DefinitionText>
	<ExtensionOfClass structures:ref="nc.DocumentType" xsi:nil="true"/>
	<HasProperty structures:sequenceID="1">
		<Property structures:ref="nc.PersonName" xsi:nil="true"/>
		<MinOccursQuantity>0</MinOccursQuantity>
		<MaxOccursQuantity>1</MaxOccursQuantity>
	</HasProperty>
</Class>

<Class structures:id="nc.PersonType">
	<Name>PersonType</Name>
	<Namespace structures:ref="nc" xsi:nil="true"/>
	<DefinitionText>A data type for a human being.</DefinitionText>
	<HasProperty structures:sequenceID="1">
		<Property structures:ref="nc.PersonName" xsi:nil="true"/>
		<MinOccursQuantity>1</MinOccursQuantity>
		<MaxOccursQuantity>unbounded</MaxOccursQuantity>
	</HasProperty>
</Class>
```

The resulting JSON Schema simple follows the cardinality process for each context, putting each inside the `anyOf` construct:

```json
{
	"nc:PersonName": {  
		"description": "A combination of names and/or titles by which a person is known.",  
		"anyOf" [
			{"$ref": "#/definitions/nc:PersonNameType"},
			{
				"type": "array",  
				"items": {"$ref": "#/definitions/nc:PersonNameType"}
			}
		]
	}
}
```

There's no way to map each option to the correct context. This does is allow `nc:Passport` objects to have the cardinality of `nc:Person` objects and vice-versa (beyond being "required"). This method also scales to however many contexts a particular element falls into.

If the different contexts have the same cardinality constraints, there's no particular harm in repeating the constraint, which would be the simplest process to follow.

## Collapse Substitution Groups

JSON Schema doesn't directly support substitution groups, so we collapse that level of organization.

In CMF, we replicate the XML substitution group organization with `SubPropertyOf` properties. This isn't "subordinate property", but instead is "substitution property."

In this example, the class `nc.InjuryType` contains an `nc.InjurySeverityAbstract`:

```xml
<Class structures:id="nc.InjuryType">
	<Name>InjuryType</Name>
	<Namespace structures:ref="nc" xsi:nil="true"/>
	<DefinitionText>A data type for a form of harm or damage sustained by a person.</DefinitionText>
	<HasProperty structures:sequenceID="1">
		<Property structures:ref="nc.InjuryDescriptionText" xsi:nil="true"/>
		<MinOccursQuantity>1</MinOccursQuantity>
		<MaxOccursQuantity>1</MaxOccursQuantity>
	</HasProperty>
	<HasProperty structures:sequenceID="2">
		<Property structures:ref="nc.InjurySeverityAbstract" xsi:nil="true"/>
		<MinOccursQuantity>0</MinOccursQuantity>
		<MaxOccursQuantity>1</MaxOccursQuantity>
	</HasProperty>
</Class>
```

The `nc.InjurySeverityAbstract` is a placeholder for the concept of the severity of an injury. It's marked with an `AbstractIndicator` to reflect this. In XML, this would be the head of a substitution group, to be substituted with another element. In CMF, we're just noting it with the `AbstractIndicator`:

```xml
<Property structures:id="nc.InjurySeverityAbstract">
	<Name>InjurySeverityAbstract</Name>
	<Namespace structures:ref="nc" xsi:nil="true"/>
	<DefinitionText>A data concept for a severity of an injury received by a person involved into a Traffic Accident.</DefinitionText>
	<AbstractIndicator>true</AbstractIndicator>
</Property>
```

The element to substitute for `nc.InjurySeverityAbstract` can be identified by looking for another property that has a `SubPropertyOf` element pointing to `nc.InjurySeverityAbstract`, in this case `j.InjurySeverityCode`:

```xml
<Property structures:id="j.InjurySeverityCode">  
	<Name>InjurySeverityCode</Name>  
	<Namespace structures:ref="j" xsi:nil="true"/>  
	<DefinitionText>A severity of an injury received by a person, such as in a traffic accident or crash.</DefinitionText>  
	<SubPropertyOf structures:ref="nc.InjurySeverityAbstract" xsi:nil="true"/>  
	<Datatype structures:ref="aamva_d20.AccidentSeverityCodeType" xsi:nil="true"/>  
</Property>
```

In JSON Schema, there's no concept of substitution groups, so we just do the substitution in the JSON Schema itself:

```json
"nc:InjuryType": {
	"description": "A data type for a form of harm or damage sustained by a person.",
	"type": "object",
	"properties": {
		"nc:InjuryDescriptionText": {"$ref": "#/properties/nc:InjuryDescriptionText"},
		"j:InjurySeverityCode": {"$ref": "#/properties/j:InjurySeverityCode"}
	},
	"required": ["nc:InjuryDescriptionText"]
}
```

Additionally, we apply the cardinality of `nc.InjurySeverityAbstract` directly to `j:InjurySeverityCode` in the JSON Schema,  in this case 0..1, following the rules for replicating cardinality.

The resulting XML and JSON instances are organized exactly the same, but the underlying JSON Schema is simpler.

```xml
<j:CrashPersonInjury>
	<nc:InjuryDescriptionText>Broken Arm</nc:InjuryDescriptionText>
	<j:InjurySeverityCode>3</j:InjurySeverityCode>
</j:CrashPersonInjury>
```

```json
"j:CrashPersonInjury": [
	{
		"nc:InjuryDescriptionText": "Broken Arm",
		"j:InjurySeverityCode": "3"
	}
]
```

If there are multiple elements all with the same `SubPropertyOf`, then we need to include them all inside the type. If the abstract element is _required_, then we use a `oneOf` or `anyOf` array holding a `required` array for each possible substitution. If the maximum cardinality is 1, then we use oneOf, which is an exclusive OR, allowing one or the other test to pass, but not both. If the maximum cardinality is more than 1, then we use anyOf, which ensures that at least one test passes, but allows for multiple tests to pass.

In this example, we could have included `nc.InjurySeverityText` in the CMF with the same `SubPropertyOf` of `nc.InjurySeverityAbstract`. Because the abstract element is required, the `required` statements are put in their own `oneOf` array. The resulting JSON Schema would look like this:

```json
"nc:InjuryType": {
	"description": "A data type for a form of harm or damage sustained by a person.",
	"type": "object",
	"properties": {
		"nc:InjuryDescriptionText": {"$ref": "#/properties/nc:InjuryDescriptionText"},
		"j:InjurySeverityCode": {"$ref": "#/properties/j:InjurySeverityCode"},
		"nc:InjurySeverityText": {"$ref": "#/properties/nc:InjurySeverityText"}
	},
	"oneOf": [
		{"required": ["j:InjurySeverityCode"]},
		{"required": ["nc:InjuryDescriptionText"]}
	]
}
```

If the maximum cardinality was "unbounded" instead of 1, then we use the `anyOf` in place of the `oneOf`:

```json
"nc:InjuryType": {
	"description": "A data type for a form of harm or damage sustained by a person.",
	"type": "object",
	"properties": {
		"nc:InjuryDescriptionText": {"$ref": "#/properties/nc:InjuryDescriptionText"},
		"j:InjurySeverityCode": {"$ref": "#/properties/j:InjurySeverityCode"},
		"nc:InjurySeverityText": {"$ref": "#/properties/nc:InjurySeverityText"}
	},
	"anyOf": [
		{"required": ["j:InjurySeverityCode"]},
		{"required": ["nc:InjuryDescriptionText"]}
	]
}
```

If the abstract element is _optional_, then we still include the elements inside the type. While this would allow both objects to be present, the base transformation from stock CMF doesn't constrain arbitrary added properties, so adding complexity to disallow these properties is out of place.

```json
"nc:InjuryType": {
	"description": "A data type for a form of harm or damage sustained by a person.",
	"type": "object",
	"properties": {
		"nc:InjuryDescriptionText": {"$ref": "#/properties/nc:InjuryDescriptionText"},
		"j:InjurySeverityCode": {"$ref": "#/properties/j:InjurySeverityCode"},
		"nc:InjurySeverityText": {"$ref": "#/properties/nc:InjurySeverityText"}
	}
}
```

If the abstract is required and other elements are also required, for example `nc:InjuryDescriptionText` , then the `oneOf`/`anyOf` construct is combined with additional `required` tests in an encompassing `allOf` array:

```json
"allOf": [
	{
		"oneOf": [
			{"required": ["j:InjurySeverityCode"]},
			{"required": ["nc:InjurySeverityText"]}
		]
	},
	{"required": ["nc:InjuryDescriptionText"]}
]
```

## Support References

XML supports referencing but if an element has required properties, you can only use the element solely as a reference if it's marked as being `nillable`. Then you can `nil` the element and leave it empty regardless of its required properties.

In CMF, elements that are marked as `nillable` in XML are indicated with a `ReferenceableIndicator` that is set to "true". (Elements that are not set as `nillable` simply don't have this indicator.) The indicator name is misleading. It seems to say that an element can be referenced, but it actually means the element can _reference_ another element.

JSON Schema doesn't have a means of marking an object such that you can ignore what it normally holds. Instead, we move the object's current definition inside an `anyOf` block, adding a second option that defines the object solely as a reference with an `@id` property to point to another object.

```json
"j:Charge": {
	"description": "A formal allegation that a specific person has committed a specific offense.",
	"anyOf": [
		{
			"type": "array",
			"items": {"$ref": "#/definitions/j:ChargeType"}
		},
		{
			"type": "object",
			"properties": {
				"@id": {"type": "string"}
			}
		}
	]
}
```
This let's us use `j:Charge` both as an object containing properties _or_ as a reference:

```json
"j:PersonChargeAssociation": [
	{
		"@id": "#JMD01",
		"nc:Person": {"@id": "#P01"},
		"j:Charge": {"@id": "#CH01"},
		"j:JuvenileAsAdultIndicator": false
	}
],
"j:Charge": [
	{
		"@id": "#CH01",
		"j:ChargeDescriptionText": "Furious Driving",
		"j:ChargeFelonyIndicator": false
	}
],
```

The `@id` can be added along with other properties without doing anything special. It's only when an object is being used _only_ as a reference that the need for the explicit `@id` property needs to be added.

## Attributes

XML attributes simple become additional properties in JSON Schema. In CMF, property objects that are XML attributes will have a subproperty of `AttributeIndicator` set to "true". This can be ignored in the transformation to JSON Schema.

Here's the CMF for `nc.personNameCommentText`, an attribute in the XML version of NIEM:

```xml
<Property structures:id="nc.personNameCommentText">
	<Name>personNameCommentText</Name>
	<Namespace structures:ref="nc" xsi:nil="true"/>
	<DefinitionText>A comment about a kind of name for a person.</DefinitionText>
	<Datatype structures:ref="xs.string" xsi:nil="true"/>
	<AttributeIndicator>true</AttributeIndicator>
</Property>

```

JSON Schema includes it as just another property. If the attribute's is set to "1 to 1", then it would be _included_ in the list of required properties:

```json
"nc:PersonNameType": {
	"description": "A data type for a combination of names and/or titles by which a person is known.",
	"type": "object",
	"properties": {
		"nc:PersonGivenName": {"$ref": "#/properties/nc:PersonGivenName"},
		"nc:PersonMiddleName": {"$ref": "#/properties/nc:PersonMiddleName"},
		"nc:PersonSurName": {"$ref": "#/properties/nc:PersonSurName"},
		"nc:personNameCommentText": {"$ref": "#/properties/nc:personNameCommentText"}
	},
	"required": ["nc:PersonSurName"]
}
```

The property itself is defined like any other property. Since the maximum occurrences of attributes in XML is never more than 1, properties derived from XML attributes will never need to be defined as arrays of things. They will always be very simple definitions like `nc:personNameCommentText` here:

```json
"nc:personNameCommentText": {
	"description": "A comment about a kind of name for a person.",
	"type": "string"
}
```

## Enumerations

Enumerations in CMF are directly translated to JSON Schema `enum`s inside a `oneOf` array. JSON Schema lacks a `token` datatype, so we just use `string`.

Here's the `AccidentSeverityCodeType` represented in CMF:

```xml
<Datatype structures:id="aamva_d20.AccidentSeverityCodeType">
	<Name>AccidentSeverityCodeType</Name>
	<Namespace structures:ref="aamva_d20" xsi:nil="true"/>
	<DefinitionText>A data type for severity levels of an accident.</DefinitionText>
	<RestrictionOf>
		<Datatype structures:ref="xs.token" xsi:nil="true"/>
		<Enumeration>
			<StringValue>1</StringValue>
			<DefinitionText>Fatal Accident</DefinitionText>
		</Enumeration>
		<Enumeration>
			<StringValue>2</StringValue>
			<DefinitionText>Incapacitating Injury Accident</DefinitionText>
		</Enumeration>
		<Enumeration>
			<StringValue>3</StringValue>
			<DefinitionText>Non-incapacitating Evident Injury</DefinitionText>
		</Enumeration>
		<Enumeration>
			<StringValue>4</StringValue>
			<DefinitionText>Possible Injury Accident</DefinitionText>
		</Enumeration>
		<Enumeration>
			<StringValue>5</StringValue>
			<DefinitionText>Non-injury Accident</DefinitionText>
		</Enumeration>
		<Enumeration>
			<StringValue>9</StringValue>
			<DefinitionText>Unknown</DefinitionText>
		</Enumeration>
	</RestrictionOf>
</Datatype>
```

Each enumeration is converted into a JSON Schema `enum` array that holds each value:

```json
"aamva_d20:AccidentSeverityCodeType": {
		"description": "A data type for severity levels of an accident.",
		"type": "string",
		"oneOf": [
				{
						"enum": ["1"],
						"description": "Fatal Accident"
				},
				{
						"enum": ["2"],
						"description": "Incapacitating Injury Accident"
				},
				{
						"enum": ["3"],
						"description": "Non-incapacitating Evident Injury"
				},
				{
						"enum": ["4"],
						"description": "Possible Injury Accident"
				},
				{
						"enum": ["5"],
						"description": "Non-injury Accident"
				},
				{
						"enum": ["9"],
						"description": "Unknown"
				}
		]
}
```

A cleaner alternative is to use `const` to define the allowed values:

```json
"aamva_d20:AccidentSeverityCodeType": {
		"description": "A data type for severity levels of an accident.",
		"type": "string",
 		"oneOf": [
			{
				"const": "1",
				"description": "Fatal Accident"
			},
			{
				"const": "2",
				"description": "Incapacitating Injury Accident"
			},
			{
				"const": "3",
				"description": "Non-incapacitating Evident Injury"
			},
			{
				"const": "4",
				"description": "Possible Injury Accident"
			},
			{
				"const": "5",
				"description": "Non-injury Accident"
			},
			{
				"const": "9",
				"description": "Unknown"
			}
		]
```

This format is simpler, but has less validation error support in some editors.
