## Matrix of rules and conformance targets

> This is a working document. It wil eventually vanish, merge, or something.

**Applicable only to reference schema documents**

| Number | Rule | REF | EXT | SUB | MSG |
| --- | --- | :-: | :-: | :-: | :-: |
| 9-11 | No simple type disallowed derivation  | X|  |  |   |
| 9-13 | No use of "fixed" on simple type facets  | X|  |  |   |
| 9-30 | Complex content uses extension  | X|  |  |   |
| 9-33 | Simple content uses extension  | X|  |  |   |
| 9-34 | No complex type disallowed substitutions  | X|  |  |   |
| 9-35 | No complex type disallowed derivation  | X|  |  |   |
| 9-43 | No element disallowed substitutions  | X|  |  |   |
| 9-44 | No element disallowed derivation  | X|  |  |   |
| 9-47 | Element declaration is nillable  | X|  |  |   |
| 9-62 | `xs:sequence` must be child of `xs:extension`  | X|  |  |   |
| 9-64 | No `xs:choice`  | X|  |  |   |
| 9-70 | No use of `xs:any`  | X|  |  |   |
| 9-71 | No use of `xs:anyAttribute`  | X|  |  |   |
| 9-86 | No disallowed substitutions  | X|  |  |   |
| 9-87 | No disallowed derivations  | X|  |  |   |
| 10-13 | External attribute use only in external adapter type  | X|  |  |   |
| 10-23 | Augmentable type has augmentation point element  | X|  |  |   |
| 10-29 | Augmentation point element use is optional  | X|  |  |   |
| 10-30 | Augmentation point element use is unbounded  | X|  |  |   |
| 10-37 | Augmentation elements are not used directly  | X|  |  |   |

 **Applicable to reference and externsion schema documents**
| Number | Rule | REF | EXT | SUB | MSG |
| --- | --- | :-: | :-: | :-: | :-: |
| 9-45 | No element default value  | X | X|  |   |
| 9-46 | No element fixed value  | X | X|  |   |
| 9-57 | No attribute default values  | X | X|  |   |
| 9-58 | No fixed values for optional attributes  | X | X|  |   |

**Applicable to reference, extension, and subset schema documents**
| Number | Rule | REF | EXT | SUB | MSG |
| --- | --- | :-: | :-: | :-: | :-: |
| 9-10 | Simple type definition is top-level  | X | X | X|   |
| 9-25 | Complex type definition is top-level  | X | X | X|   |
| 9-42 | Element type is not simple type  | X | X | X|   |
| 10-2 | Object type with complex content is derived from `structures:ObjectType`  | X | X | X|   |
| 10-20 | Proxy type has designated structure  | X | X | X|   |
| 10-21 | Association type derived from `structures:AssociationType`  | X | X | X|   |
| 10-22 | Association element type is an association type  | X | X | X|   |
| 11-8 | Name of a code simple type ends in "CodeSimpleType"  | X | X | X|   |
| 11-11 | Complex type with simple content has `structures:SimpleObjectAttributeGroup`  | X | X | X|   |

**Applicable to reference, extension, subset, and message schema documents**
| Number | Rule | REF | EXT | SUB | MSG |
| --- | --- | :-: | :-: | :-: | :-: |
| 4-3 | Schema is CTAS-conformant  | X |  X | X  | X   |
| 4-4 | Document element has attribute `ct:conformanceTargets`  | X | X  | X | X  |
| 7-3 | Document is a schema document  | X | X | X  | X |
| 7-4 | Document element is `xs:schema`  | X| X | X | X |
| 9-1 | No base type in the XML namespace  | X | X | X | X |
| 9-2 | No base type of `xs:ID`  | X | X | X | X |
| 9-3 | No base type of `xs:IDREF`  | X | X | X | X |
| 9-4 | No base type of `xs:IDREFS`  | X | X | X | X |
| 9-5 | No base type of `xs:anyType`  | X | X | X | X |
| 9-6 | No base type of `xs:anySimpleType`  | X | X | X | X |
| 9-7 | No base type of `xs:NOTATION`  | X | X | X | X |
| 9-8 | No base type of `xs:ENTITY`  | X | X | X | X |
| 9-9 | No base type of `xs:ENTITIES`  | X | X | X | X |
| 9-12 | Simple type has data definition  | X | X | X | X |
| 9-14 | Enumeration has data definition  | X | X | X | X |
| 9-15 | No list item type of `xs:ID`  | X | X | X | X |
| 9-16 | No list item type of `xs:IDREF`  | X | X | X | X |
| 9-17 | No list item type of `xs:anySimpleType`  | X | X | X | X |
| 9-18 | No list item type of `xs:ENTITY`  | X | X | X | X |
| 9-19 | No union member types of `xs:ID`  | X | X | X | X |
| 9-20 | No union member types of `xs:IDREF`  | X | X | X | X |
| 9-21 | No union member types of `xs:IDREFS`  | X | X | X | X |
| 9-22 | No union member types of `xs:anySimpleType`  | X | X | X | X |
| 9-23 | No union member types of `xs:ENTITY`  | X | X | X | X |
| 9-24 | No union member types of `xs:ENTITIES`  | X | X | X | X |
| 9-26 | Complex type has data definition  | X | X | X | X |
| 9-27 | No mixed content on complex type  | X | X | X | X |
| 9-28 | No mixed content on complex content  | X | X | X | X |
| 9-29 | Complex type content is explicitly simple or complex  | X | X | X | X |
| 9-31 | Base type of complex type with complex content must have complex content  | X | X | X | X |
| 9-36 | Element declaration is top-level  | X | X | X | X |
| 9-37 | Element declaration has data definition  | X | X | X | X |
| 9-38 | Untyped element is abstract  | X | X | X | X |
| 9-39 | Element of type `xs:anySimpleType` is abstract  | X | X | X | X |
| 9-40 | Element type not in the XML Schema namespace  | X | X | X | X |
| 9-41 | Element type not in the XML namespace  | X | X | X | X |
| 9-48 | Attribute declaration is top-level  | X | X | X | X |
| 9-49 | Attribute declaration has data definition  | X | X | X | X |
| 9-50 | Attribute declaration has type  | X | X | X | X |
| 9-51 | No attribute type of `xs:ID`  | X | X | X | X |
| 9-52 | No attribute type of `xs:IDREF`  | X | X | X | X |
| 9-53 | No attribute type of `xs:IDREFS`  | X | X | X | X |
| 9-54 | No attribute type of `xs:ENTITY`  | X | X | X | X |
| 9-55 | No attribute type of `xs:ENTITIES`  | X | X | X | X |
| 9-56 | No attribute type of `xs:anySimpleType`  | X | X | X | X |
| 9-59 | No use of element `xs:notation`  | X | X | X | X |
| 9-60 | Model group does not affect meaning | * | X | X | X |
| 9-61 | No `xs:all`  | X | X | X | X |
| 9-63 | `xs:sequence` must be child of `xs:extension` or `xs:restriction` | * | X | X | X |
| 9-65 | `xs:choice` must be child of `xs:sequence` | * | X | X | X |
| 9-68 | Choice has minimum cardinality 1 | * | X | X | X |
| 9-69 | Choice has maximum cardinality 1 | * | X | X | X |
| 9-66 | Sequence has minimum cardinality 1  | X | X | X | X |
| 9-67 | Sequence has maximum cardinality 1  | X | X | X | X |
| 9-72 | No use of `xs:unique`  | X | X | X | X |
| 9-73 | No use of `xs:key`  | X | X | X | X |
| 9-74 | No use of `xs:keyref`  | X | X | X | X |
| 9-75 | No use of `xs:group`  | X | X | X | X |
| 9-76 | No definition of attribute groups  | X | X | X | X |
| 9-77 | Comment is not recommended  | X | X | X | X |
| 9-78 | Documentation element has no element children  | X | X | X | X |
| 9-79 | `xs:appinfo` children are comments, elements, or whitespace  | X | X | X | X |
| 9-80 | Appinfo child elements have namespaces  | X | X | X | X |
| 9-81 | Appinfo descendants are not XML Schema elements  | X | X | X | X |
| 9-82 | Schema has data definition  | X | X | X | X |
| 9-83 | Schema document defines target namespace  | X | X | X | X |
| 9-84 | Target namespace is absolute URI  | X | X | X | X |
| 9-85 | Schema has version  | X | X | X | X |
| 9-88 | No use of `xs:redefine`  | X | X | X | X |
| 9-89 | No use of `xs:include`  | X | X | X | X |
| 9-90 | `xs:import` must have namespace  | X | X | X | X |
| 9-92 | Namespace referenced by attribute `type` is imported  | X | X | X | X |
| 9-93 | Namespace referenced by attribute `base` is imported  | X | X | X | X |
| 9-94 | Namespace referenced by attribute `itemType` is imported  | X | X | X | X |
| 9-95 | Namespaces referenced by attribute `memberTypes` is imported  | X | X | X | X |
| 9-96 | Namespace referenced by attribute `ref` is imported  | X | X | X | X |
| 9-97 | Namespace referenced by attribute `substitutionGroup` is imported  | X | X | X | X |
| 10-1 | Complex type has a category  | X | X | X | X |
| 10-7 | Import of external namespace has data definition  | X | X | X | X |
| 10-8 | External adapter type has indicator  | X | X | X | X |
| 10-9 | Structure of external adapter type definition follows pattern  | X | X | X | X |
| 10-10 | Element use from external adapter type defined by external schema documents  | X | X | X | X |
| 10-11 | External adapter type not a base type  | X | X | X | X |
| 10-14 | External attribute use has data definition  | X | X | X | X |
| 10-16 | External element use has data definition  | X | X | X | X |
| 10-17 | Name of code type ends in "CodeType"  | X | X | X | X |
| 10-18 | Code type corresponds to a code list  | X | X | X | X |
| 10-19 | Element of code type has code representation term  | X | X | X | X |
| 10-24 | Augmentable type has at most one augmentation point element  | X | X | X | X |
| 10-25 | Augmentation point element corresponds to its base type  | X | X | X | X |
| 10-26 | An augmentation point element has no type  | X | X | X | X |
| 10-27 | An augmentation point element has no substitution group  | X | X | X | X |
| 10-28 | Augmentation point element is only referenced by its base type  | X | X | X | X |
| 10-31 | Augmentation point element use must be last element in its base type  | X | X | X | X |
| 10-33 | Only an augmentation type name ends in "AugmentationType"  | X | X | X | X |
| 10-34 | Schema component with name ending in "AugmentationType" is an augmentation type  | X | X | X | X |
| 10-35 | Type derived from `structures:AugmentationType` is an augmentation type  | X | X | X | X |
| 10-36 | Augmentation element type is an augmentation type  | X | X | X | X |
| 10-42 | Name of element that ends in "Representation" is abstract  | X | X | X | X |
| 10-43 | A substitution for a representation element declaration is a value for a type  | X | X | X | X |
| 10-44 | Schema component name composed of English words  | X | X | X | X |
| 10-45 | Schema component name has `xml:lang`  | X | X | X | X |
| 10-46 | Schema component names have only specific characters  | X | X | X | X |
| 10-47 | Punctuation in component name is a separator  | X | X | X | X |
| 10-48 | Names use camel case  | X | X | X | X |
| 10-49 | Attribute name begins with lower case letter  | X | X | X | X |
| 10-50 | Name of schema component other than attribute and proxy type begins with upper case letter  | X | X | X | X |
| 10-52 | Local term declaration is local to its schema document  | X | X | X | X |
| 10-53 | Local terminology interpretation  | X | X | X | X |
| 10-54 | Singular form is preferred in name  | X | X | X | X |
| 10-55 | Present tense is preferred in name  | X | X | X | X |
| 10-56 | Name does not have nonessential words  | X | X | X | X |
| 10-57 | Element or attribute name follows pattern  | X | X | X | X |
| 10-58 | Object-class term identifies concrete category  | X | X | X | X |
| 10-59 | Property term describes characteristic or subpart  | X | X | X | X |
| 10-60 | Name may have multiple qualifier terms  | X | X | X | X |
| 10-61 | Name has minimum necessary number of qualifier terms  | X | X | X | X |
| 10-62 | Order of qualifiers is not significant  | X | X | X | X |
| 10-63 | Redundant term in name is omitted  | X | X | X | X |
| 10-64 | Element with simple content has representation term  | X | X | X | X |
| 10-65 | Element with complex content has representation term when appropriate  | X | X | X | X |
| 10-66 | Element with complex content has representation term only when appropriate  | X | X | X | X |
| 10-67 | Machine-readable annotations are valid  | X | X | X | X |
| 10-68 | Component marked as deprecated is deprecated component  | X | X | X | X |
| 10-69 | Deprecated annotates schema component  | X | X | X | X |
| 10-70 | External import indicator annotates import  | X | X | X | X |
| 10-71 | External adapter type indicator annotates complex type  | X | X | X | X |
| 10-76 | `appinfo:LocalTerm` annotates schema  | X | X | X | X |
| 10-77 | `appinfo:LocalTerm` has literal or definition  | X | X | X | X |
| 10-78 | Use structures consistent with specification  | X | X | X | X |
| 11-1 | Name of type ends in "Type"  | X | X | X | X |
| 11-2 | Only types have name ending in "Type" or "SimpleType"  | X | X | X | X |
| 11-3 | Base type definition defined by conformant schema  | X | X | X | X |
| 11-4 | Name of simple type ends in "SimpleType"  | X | X | X | X |
| 11-5 | Use lists only when data is uniform  | X | X | X | X |
| 11-6 | List item type defined by conformant schemas  | X | X | X | X |
| 11-7 | Union member types defined by conformant schemas  | X | X | X | X |
| 11-9 | Code simple type corresponds to a code list  | X | X | X | X |
| 11-10 | Attribute of code simple type has code representation term  | X | X | X | X |
| 11-12 | Element type does not have a simple type name  | X | X | X | X |
| 11-13 | Element type is from conformant namespace  | X | X | X | X |
| 11-14 | Name of element that ends in "Abstract" is abstract  | X | X | X | X |
| 11-15 | Name of element declaration with simple content has representation term  | X | X | X | X |
| 11-17 | Element substitution group defined by conformant schema  | X | X | X | X |
| 11-18 | Attribute type defined by conformant schema  | X | X | X | X |
| 11-19 | Attribute name uses representation term  | X | X | X | X |
| 11-20 | Element or attribute declaration introduced only once into a type  | X | X | X | X |
| 11-21 | Element reference defined by conformant schema  | X | X | X | X |
| 11-22 | Referenced attribute defined by conformant schemas  | X | X | X | X |
| 11-24 | Data definition does not introduce ambiguity  | X | X | X | X |
| 11-25 | Object class has only one meaning  | X | X | X | X |
| 11-26 | Data definition of a part does not redefine the whole  | X | X | X | X |
| 11-27 | Do not leak representation into data definition  | X | X | X | X |
| 11-28 | Data definition follows 11179-4 requirements  | X | X | X | X |
| 11-29 | Data definition follows 11179-4 recommendations  | X | X | X | X |
| 11-30 | `xs:documentation` has `xml:lang`  | X | X | X | X |
| 11-31 | Standard opening phrase for augmentation point element data definition  | X | X | X | X |
| 11-32 | Standard opening phrase for augmentation element data definition  | X | X | X | X |
| 11-33 | Standard opening phrase for metadata element data definition  | X | X | X | X |
| 11-34 | Standard opening phrase for association element data definition  | X | X | X | X |
| 11-35 | Standard opening phrase for abstract element data definition  | X | X | X | X |
| 11-36 | Standard opening phrase for date element or attribute data definition  | X | X | X | X |
| 11-37 | Standard opening phrase for quantity element or attribute data definition  | X | X | X | X |
| 11-38 | Standard opening phrase for picture element or attribute data definition  | X | X | X | X |
| 11-39 | Standard opening phrase for indicator element or attribute data definition  | X | X | X | X |
| 11-40 | Standard opening phrase for identification element or attribute data definition  | X | X | X | X |
| 11-41 | Standard opening phrase for name element or attribute data definition  | X | X | X | X |
| 11-42 | Standard opening phrase for element or attribute data definition  | X | X | X | X |
| 11-43 | Standard opening phrase for association type data definition  | X | X | X | X |
| 11-44 | Standard opening phrase for augmentation type data definition  | X | X | X | X |
| 11-45 | Standard opening phrase for metadata type data definition  | X | X | X | X |
| 11-46 | Standard opening phrase for complex type data definition  | X | X | X | X |
| 11-47 | Standard opening phrase for simple type data definition  | X | X | X | X |
| 11-48 | Same namespace means same components  | X | X | X | X |
| 11-49 | Different version means different view  | X | X | X | X |
| 11-52 | Structures imported as conformant  | X | X | X | X |
| 11-53 | XML namespace imported as conformant  | X | X | X | X |
| 11-55 | Consistently marked namespace imports  | X | X | X | X |
 7-1 | Document is an XML document  | X | X | X | X |
 7-2 | Document uses XML namespaces properly  | X | X | X | X |
 7-5 | Component name follows ISO 11179 Part 5 Annex A  | X | X | X | X |
