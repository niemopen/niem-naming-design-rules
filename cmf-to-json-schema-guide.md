# NDR JSON Binding

## Introduction

This is a guide to converting Common Model Format (CMF) to JSON Schema to allow for the validation of JSON/JSON-LD instance documents against NIEM subsets.

It aims to enforce as much of the CMF as possible, while still being acceptable to JSON developers. It does not depend on XML Schema representations of NIEM, although it occasionally mentions them to explain some aspects of CMF.

A primary goal is to enable NIEM JSON exchanges that look like typical JSON that any JSON developer can implement instead of trying to essentially force JSON to work like XML. That does come at the cost of fairly complex JSON Schema defining those exchange instance document.

## Define Namespaces

CMF defines namespaces that divide NIEM into different groups for ease of model development and governance. In JSON, these become a `@context` object that maps prefixes to NIEM namespaces.

This is the CMF declaration of the Justice and NIEM Core namespaces:

```xml
<Namespace structures:id="j">
	<NamespaceURI>http://release.niem.gov/niem/domains/jxdm/7.0/</NamespaceURI>
	<NamespacePrefixName>j</NamespacePrefixName>
	<DefinitionText>Justice</DefinitionText>
	<NamespaceKindCode>DOMAIN</NamespaceKindCode>
</Namespace>
<Namespace structures:id="nc">
	<NamespaceURI>http://release.niem.gov/niem/niem-core/5.0/</NamespaceURI>
	<NamespacePrefixName>nc</NamespacePrefixName>
	<DefinitionText>NIEM Core.</DefinitionText>
	<NamespaceKindCode>CORE</NamespaceKindCode>
</Namespace>
```

The JSON representation pulls the prefix from `NamespacePrefixName` and the URI from `NamespaceURI` to create prefix/URI name value pairs.

```json
"@context" : {
    "j": "http://release.niem.gov/niem/domains/jxdm/7.0/",
    "nc": "http://release.niem.gov/niem/niem-core/5.0/"
  }
```

The `@context` object must exist as part of the specification, but does not need to be included in JSON instances being exchanged.

## Replicate Properties and Classes

Properties and classes in CMF map very easily over to JSON Schema properties and definitions.

Here's an example `Property` definition for `j.Crash`. In CMF each `Property` is a separate object. The `Class` property defines the `Property`'s class, in this case `j.CrashType`, where what the `Property` can hold is defined.

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

In JSON Schema, each type is an object inside the `definitions` object for the schema. The base type is included by referencing it in the `allOf` array. The properties added by `j:CrashType` are added in a second object in the array. It should also be noted that JSON Schema is not object oriented in the same way that XML Schema and CMF are. The `allOf` object does not create a composition of all the definitions listed. Each object in the `allOf` array is tested separately. This means that you cannot use the `"additionalProperties": false` to exclude additional arbitrary properties in the context of an `allOf` array. 

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

 CMF defines cardinality similarly to XML Schema, with a minimum and maximum value defining how many times an object can appear sequentially. A property being required is implied from a minimum that is greater than 0. Maximums that are greater than 1 result in sequential instances of the object. For example, this is allowable XML:

```xml
<nc:PersonName>  
	<nc:PersonGivenName>Peter</nc:PersonGivenName>  
	<nc:PersonMiddleName>Death</nc:PersonMiddleName>  
	<nc:PersonMiddleName>Bredon</nc:PersonMiddleName>  
	<nc:PersonSurName>Wimsey</nc:PersonSurName>  
</nc:PersonName>
```

JSON Schema handles cardinality differently. Required properties are identified as being `required`. An object having multiple values is defined as an array of things instead of just a single instance of a thing. The above example looks like this in JSON:

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

Due to the nature of how JSON handles multiple instances of the same property, whether an object can contain just a single thing or can contain an array of things is defined on the object itself, not the containing type. See the difference below between `PersonMiddleName` which holds an array of values and `PersonSurName` which contains just a single instance.

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

Due to this difference, mapping from `MinOccursQuantity` and `MaxOccursQuantity` properties in a class in CMF to JSON Schema style cardinality can be complex. The following sections describe JSON Schema implementations of different sets of CMF style cardinality.

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

We've made a design choice in not using `minItems` when the lower bound for an array is 1. It seems that JSON developers are comfortable with using an empty array, e.g. `[]`, in the same way that they use an empty string, i.e. `""`, in JSON instance documents.

So if an empty value was sent for `nc:PersonMiddleName`, we allow for this:

```json
"nc:PersonMiddleName": []
```

Instead of requiring this:

```json
"nc:PersonMiddleName": [""]
```

### Combine Overlapping Cardinality

CMF allows for the same property to be included in multiple classes, each with its own cardinality. Every context can have its own cardinality.

This can be a problem in JSON Schema when the same element is in different contexts and the maximum cardinality in one context is 1, but in the other context is greater than 1, because the difference between a cardinality of 1 and anything greater than 1 is defined in the property itself, not the context. A JSON property with a maximum cardinality of 1 is just a value, while one with a maximum of more than 1 is an array.

To support this, we place each separate cardinality constraint in a separate block inside an `anyOf` structure. This ensures that each cardinality set can be tested, although it does _not_ ensure that the correct constraints are enforced against the correct contexts. This is simpler to transform compared to calculating a cardinality superset, and probably a tighter constraint in most circumstances. It also covers cases in which the different sets of constraints are disjunct.

Here's an example in CMF in which `nc.PassportType` can hold 0 to 1 `nc.PersonName` objects, and `nc.PersonType` can hold 1 to unbounded `nc.PersonName` objects.

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

The resulting JSON Schema simply follows the cardinality process for each context, putting each inside the `anyOf` construct:

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

There's no way to map each option to the correct context when validating. This does allow `nc:Passport` objects to have the cardinality of `nc:Person` objects and vice-versa (beyond being "required"). This method also scales to however many contexts a particular element falls into.

If the different contexts have the same cardinality constraints, there's no particular harm in repeating the constraint, which would be the simplest process to follow.

## Collapse Substitution Groups

JSON Schema doesn't directly support substitution groups, so we collapse that level of organization.

CMF includes a concept of having a property represent a concept, with additional properties representing different forms of that concept. These are identified as `SubPropertyOf` properties. This isn't "subordinate property", but instead is a "substitution property."

In this example, the class `nc.InjuryType` contains an `nc.InjurySeverityAbstract`. The `nc.InjurySeverityAbstract` property represents the concept of the severity of an injury:

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

The `nc.InjurySeverityAbstract` is a placeholder for the concept of the severity of an injury. In its own definition, it's marked with an `AbstractIndicator` to reflect its nature:

```xml
<Property structures:id="nc.InjurySeverityAbstract">
	<Name>InjurySeverityAbstract</Name>
	<Namespace structures:ref="nc" xsi:nil="true"/>
	<DefinitionText>A data concept for a severity of an injury received by a person involved into a Traffic Accident.</DefinitionText>
	<AbstractIndicator>true</AbstractIndicator>
</Property>
```

The properties to substitute for `nc.InjurySeverityAbstract` can be identified by looking for other properties that have a `SubPropertyOf` specifying `nc.InjurySeverityAbstract`, in this case `j.InjurySeverityCode`:

```xml
<Property structures:id="j.InjurySeverityCode">  
	<Name>InjurySeverityCode</Name>  
	<Namespace structures:ref="j" xsi:nil="true"/>  
	<DefinitionText>A severity of an injury received by a person, such as in a traffic accident or crash.</DefinitionText>  
	<SubPropertyOf structures:ref="nc.InjurySeverityAbstract" xsi:nil="true"/>  
	<Datatype structures:ref="aamva_d20.AccidentSeverityCodeType" xsi:nil="true"/>  
</Property>
```

This substitution process closely matches a similar process in XML Schema. In JSON Schema, there's no concept of this sort of substitution, so we just do the substitution in the JSON Schema itself, resulting in this version of `nc:InjuryType`:

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

Additionally, we apply the cardinality of `nc.InjurySeverityAbstract` directly to `j:InjurySeverityCode` in the JSON Schema, in this case 0..1, following the rules for replicating cardinality as detailed in the cardinality sections above. The resulting JSON instance contains only the substitution, not the abstract placeholder:

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
		{"required": ["nc:InjurySeverityText"]}
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
		{"required": ["nc:InjurySeverityText"]}
	]
}
```

If the abstract property is _optional_, then we still include the properties inside the type. While this would allow both properties to be present, the base transformation from stock CMF doesn't constrain arbitrary added properties, so adding complexity to disallow these properties is out of place.

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

If the abstract is _required_ and other properties are also _required_, for example `nc:InjuryDescriptionText` , then the `oneOf`/`anyOf` construct is combined with additional `required` tests in an encompassing `allOf` array:

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

In CMF, properties can have a `ReferenceableIndicator` that is set to "true". The indicator name is a little misleading. It seems to say that an object can be referenced, but it actually means the object can _reference_ another element.

In NIEM exchanges, often an object will be used _solely_ as a reference, even if some of the properties it holds are required. To support this in JSON Schema, when a property is marked as being able to reference another object, we move the object's current definition inside an `anyOf` block, adding a second option that defines the object solely as a reference with an `@id` property to point to another object. The `@id` property comes from JSON-LD and can be used to link objects together.

Here's the definition of `j:Charge` assuming it was defined with `ReferenceableIndicator` set to "true" in CMF:

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

This lets us use `j:Charge` both as an object containing properties _or_ as a reference:

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

In the example, one `j:Charge` object contains an `@id` along with properties, while the other `j:Charge` object contains just an `@id`, with no other properties. This is allowed _even if_ some of the properties inside `j:Charge` are required.

The `@id` can be added _along with_ other properties without doing anything special. It's only when an object is being used _solely_ as a reference that the need for the explicit `@id` property needs to be added.

## Attributes

Some aspects of XML Schema are reflected in CMF to aid the transformation of CMF into XML Schema. In CMF, property objects that are XML attributes will have a subproperty of `AttributeIndicator` set to "true". This is ignored in the transformation to JSON Schema.

Here's the CMF for `nc.personNameCommentText`, an attribute in the XML transformations of NIEM:

```xml
<Property structures:id="nc.personNameCommentText">
	<Name>personNameCommentText</Name>
	<Namespace structures:ref="nc" xsi:nil="true"/>
	<DefinitionText>A comment about a kind of name for a person.</DefinitionText>
	<Datatype structures:ref="xs.string" xsi:nil="true"/>
	<AttributeIndicator>true</AttributeIndicator>
</Property>

```

JSON Schema includes it as just another property. If the attribute's cardinality is set to "1 to 1", then it would be _included_ in the list of required properties:

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

Enumerations in CMF are directly translated to JSON Schema `const` structures inside a `oneOf` array. JSON Schema lacks a `token` datatype, so we just use `string`.

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

The equivalent JSON Schema replicates those string values as `const` values, like so:

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

## Schema Documents

CMF contains a number of `SchemaDocument` objects. These are for enabling round-trip transformations between CMF and XML Schema. These are ignored for JSON Schema.


## Extensions

There are three main paths to extending JSON-based exchanges: extending in CMF, extending in JSON Schema, extending _ad hoc_ in JSON instances.

### Extend in CMF

Utilize existing CMF tools to add new objects in CMF, then transform those additions, along with a subset of NIEM, into JSON Schema. The tools essentially hide the details of CMF, letting a user add their own content not bound to any one serialization. The same objects then transformed into JSON Schema can also be transformed into XML Schema, as well as into any other serializations that the tools may support in the future. JSON instances can then be validated against the transformed JSON Schema. This is also true, if desired, of XML instances and transformed XML Schema.

### Extend in JSON Schema

Add new objects directly to the transformed JSON Schema following all the guidance above. This still allows for validation of JSON instances against JSON Schema, but would not be easily transferable to other serializations like XML Schema.

### Extend in JSON Instances

Add new objects to JSON instances without those additions being reflected in the JSON Schema. This method still allows for validation against subsets of NIEM transformed into JSON Schema, but there would be no means of validating new added objects.

Business rules applying to new objects can be documented however a designer desires.

## Additional Constraints

NIEM places some additional constraints on JSON Schema and JSON instances.

### Components are globally reusable

Covers:
- Rule 9-10, _Simple type definition is top-level_ (REF, EXT)
- Rule 9-25, _Complex type definition is top-level_ (REF, EXT)
- Rule 9-36, _Element declaration is top-level_ (REF, EXT)
- Rule 9-48, _Attribute declaration is top-level_ (REF, EXT)

Each component defined by a NIEM-conformant JSON Schema may be reused from outside the schema document. Every schema component that is defined by a NIEM-conformant JSON Schema is given an explicit name. These components are defined as neither local nor anonymous.

These components are defined within the top level `properties` and `definitions` blocks.

### Rule 9-14 Enumeration has data definition (REF, EXT)JSON Schema, require `definiton`

Enumerations MUST have `description` objects providing the full value of each enumeration, to preserve the semantics of the codes. In the example below, the code "1" has no semantic meaning on its own; "Fatal Accident" does.

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
}
```

### Rule 12-1. Instance must be schema-valid

> **Rule 12-1 (Constraint)**
> The JSON document MUST be schema-valid, as assessed against a JSON Schema document, composed of authoritative, comprehensive schema documents.

The schemas that define the exchange must be authoritative. Each is the reference schema or extension schema for the namespace it defines. Application developers may use other schemas for various purposes, but for the purposes of determining conformance, the authoritative schemas are relevant.

This rule should not be construed to mean that JSON Schema validation must be performed on all JSON instances as they are served or consumed; only that the JSON instances validate if JSON validation is performed. The JSON Schema component definitions specify JSON documents and element information items, and the instances should follow the rules given by the schemas, even when validation is not performed.

### 12-2 Empty content has no meaning (INS) 

> **Rule 12-2 (Interpretation)**
> Within the instance, the meaning of an element with no content is that additional properties are not asserted. There MUST NOT be additional meaning interpreted for an element with no content.

In this example, neither empty object has any implied meaning:

```json
SomeProperty1: "",
SomeProperty2: []
```

### Referencing

Covers:
- Rule 12-3 Element has only one resource identifying attribute (INS)
- Rule 12-7 structures:uri denotes resource identifier (INS)
- Rule 12-8 structures:id and structures:ref denote resource identifier (INS)

JSON-LD provides a means of identifying resources, both internally and externally, through the use of `@id`. Used on its own, `@id` provides a local identification string that identifies an object. All objects identified with the same string are the same object, linked to each other via the matching `@id` properties.

Combined with `"@type": "@vocab"`, an `@id` becomes an  [Internationalized Resource Identifier (IRI)](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier), linking together all object in an instance with the same IRI.


```json
"SomeLocalIdentifiedProperty": {
      "@id": "some-id-string"
    },
"SomeGlobalIdentifiedProperty": {
      "@id": "http://some-uri",
      "@type": "@vocab"
    }
```

Covers:
- Rule 12-5 Linked elements have same validation root (INS)
- Rule 12-6 Attribute structures:ref references element of correct type (INS)
- Rule 12-9 Nested elements and references have the same meaning. (INS)

JSON Schema lacks the object oriented classes of CMF or XML Schema, so the concept of type derivation doesn't strictly apply. Despite that limitation, references in JSON instances MUST link objects that are of the same "type" or "derived" from the same "type." People objects need to link to people objects.

For example, an `nc:Person` object can be linked to other objects of `nc:PersonType`, but also to objects derived from `nc:PersonType`, like a `j:MedicalPractitioner` object.

```json
"nc:Person": {
	"@id": "ABC123"
	"nc:PersonName": {
		"nc:PersonFullName": "Doctor Who"
	}
},
"j:MedicalPractitioner": {
	"@id": "ABC123"
}
```

It may be helpful to refer to the source CMF to more clearly see types and derivations.

There MUST NOT be any difference in meaning between a relationship established via an element declaration instantiated by a nested element, and that element declaration instantiated via reference. In other words, linking objects together establishes that the object are the same object, and one could be conceptually substituted for the other.

### Order of Properties

Covers:
- 12-10 Order of properties is expressed via structures:sequenceID (INS)

Because repeated properties are represented as ordered arrays of values in JSON, their order is automatically preserved. Whether this ordering is meaningful is up to the exchange developer and should be documented apart from the JSON Schema. If ordering is meaningful across different objects, for example regarding first, middle, and last names, the exchange developer must devise their own mechanism for documenting this ordering.

## Normalization

NIEM property and class names can be lengthy and some development environments can have issues with using the fully qualified names that NIEM uses, e.g. `nc:PersonGivenName`. NIEM allows mapping of these longer fully qualified names to shorter names. The mappings are put in the `@context` object along with namespace mappings.

```json
{
    "$schema": "http://json-schema.org/draft-07/schema#",
    "type": "object",
	"@context" : {
	    "nc": "http://release.niem.gov/niem/niem-core/5.0/",
		"name": "nc:PersonName",
		"first": "nc:PersonGivenName",
		"middle": "nc:PersonMiddleName",
		"last": "nc:PersonSurName",
		"nametype": "nc:PersonNameType",
		"nametexttype": "nc:PersonNameTextType",
		"propernametexttype": "nc:ProperNameTextType",
		"texttype": "nc:TextType"
	},

	"properties": {
		"name": {
			"description": "A combination of names and/or titles by which a person is known.",
			"type": "array",
			"items": {"$ref": "#/definitions/nametype"}
		},
		"first": {
			"description": "A first name of a person.",
			"$ref": "#/definitions/nametexttype"
		},
		"middle": {  
			"description": "A middle name of a person.",  
			"type": "array",  
			"items": {"$ref": "#/definitions/nametexttype"}  
		},
		"last": {  
			"description": "A last name or family name of a person.",  
			"$ref": "#/definitions/nametexttype"  
		}
	},
	"definitions": {
		"nametype": {
			"description": "A data type for a combination of names and/or titles by which a person is known.",
			"type": "object",
			"properties": {
				"first": {"$ref": "#/properties/first"},
				"middle": {"$ref": "#/properties/middle"},
				"last": {"$ref": "#/properties/last"},
			},
			"required": ["last"]
		},
		"nametexttype": {
			"description": "A data type for a name by which a person is known, referred, or addressed.",
			"$ref": "#/definitions/propernametexttype"
		},
		"propernametexttype": {
			"description": "A data type for a word or phrase by which a person or thing is known, referred, or addressed.",
			"$ref": "#/definitions/texttype"
		},
		"texttype": {
			"description": "A data type for a character string.",
			"type": "string"
		}

	}
}
```

Instance with fully qualified names:

```json
{
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
}
```

Instance with short names:

```json
{
	"@context" : {
	    "nc": "http://release.niem.gov/niem/niem-core/5.0/",
		"name": "nc:PersonName",
		"first": "nc:PersonGivenName",
		"middle": "nc:PersonMiddleName",
		"last": "nc:PersonSurName"
	},
	
	"name": [  
		{  
			"first": "Peter",  
			"middle": [  
				"Death",  
				"Bredon"  
			],  
			"last": "Wimsey"  
		}  
	]
}
```

As with namespace declarations above, the `@context` object MUST exist as part of the specification, but does not need to be included in JSON instances being exchanged. Structure, however, cannot be simplified via this mapping process.
