## NIEM 6 XNDR

This paper is about a least-effort update of the NIEM 5 NDR to form the new NIEM 6 XML NDR (XNDR).  I do try to identify the rules that will eventually move to the metamodel NDR.  But the plan here is to first compose a complete NIEM 6 XNDR to support developing the NIEM 6 model represented in XSD.  The specifications and NDR for the metamodel and CMF can come later.

**Questions and answers**

1. Do we need a conformance target for subset schema documents?  ***YES***  
2. For message schema documents?  ***YES?*** (still tbd)
3. Do we continue to forbid `@default` and `@fixed` in all schema documents?  ***NO***
4. Do we keep RoleOf?  ***NO***
5. Do we keep the metadata mechanism?  ***NO***
6. Are documentation elements required in subset schema documents?  ***YES***

**NDR 5 rules and proposed dispositions**

Here is a list of the rules in the NIEM 5 NDR and where those rules belong in the NIEM 6 XNDR.  The possibilities are:

* Move to the metamodel specification & NDR, eventually
* Applies to all XML conformance targets
* Does not apply to message schema documents

| NDR.5 | Rule Text | applies to NIEM 6 |
| ------ | --------- | ----------- |
|        |           |             |
| 9-1 | No base type in the XML namespace (REF, EXT) | All XSD targets |
| 9-2 | No base type of xs:ID (REF, EXT) | All XSD |
| 9-3 | No base type of xs:IDREF (REF, EXT) | All XSD |
| 9-4 | No base type of xs:IDREFS (REF, EXT) | All XSD |
| 9-5 | No base type of xs:anyType (REF, EXT) | All XSD |
| 9-6 | No base type of xs:anySimpleType (REF, EXT) | All XSD |
| 9-7 | No base type of xs:NOTATION (REF, EXT) | All XSD |
| 9-8 | No base type of xs:ENTITY (REF, EXT) | All XSD |
| 9-9 | No base type of xs:ENTITIES (REF, EXT) | All XSD |
| 9-10 | Simple type definition is top-level (REF, EXT) | not MSG |
| 9-11 | No simple type disallowed derivation (REF) | REF |
| 9-12 | Simple type has data definition (REF, EXT) | All XSD |
| 9-13 | No use of fixed on simple type facets (REF) | REF |
| 9-14 | Enumeration has data definition (REF, EXT) | not SUB, MSG |
| 9-15 | No list item type of xs:ID (REF, EXT) | All XSD |
| 9-16 | No list item type of xs:IDREF (REF, EXT) | All XSD |
| 9-17 | No list item type of xs:anySimpleType (REF, EXT) | All XSD |
| 9-18 | No list item type of xs:ENTITY (REF, EXT) | All XSD |
| 9-19 | No union member types of xs:ID (REF, EXT) | All XSD |
| 9-20 | No union member types of xs:IDREF (REF, EXT) | All XSD |
| 9-21 | No union member types of xs:IDREFS (REF, EXT) | All XSD |
| 9-22 | No union member types of xs:anySimpleType (REF, EXT) | All XSD |
| 9-23 | No union member types of xs:ENTITY (REF, EXT) | All XSD |
| 9-24 | No union member types of xs:ENTITIES (REF, EXT) | All XSD |
| 9-25 | Complex type definition is top-level (REF, EXT) | not MSG |
| 9-26 | Complex type has data definition (REF, EXT) | All XSD                  |
| 9-27 | No mixed content on complex type (REF, EXT) | All XSD |
| 9-28 | No mixed content on complex content (REF, EXT) | All XSD |
| 9-29 | Complex type content is explicitly simple or complex (REF, EXT) | All XSD |
| 9-30 | Complex content uses extension (REF) | REF |
| 9-31 | Base type of complex type with complex content must have complex content (REF, EXT) | All XSD |
| 9-32 | Base type of complex type with complex content must have complex content (SET) | SET |
| 9-33 | Simple content uses extension (REF) | REF |
| 9-34 | No complex type disallowed substitutions (REF) | REF |
| 9-35 | No complex type disallowed derivation (REF) | REF |
| 9-36 | Element declaration is top-level (REF, EXT) | All XSD |
| 9-37 | Element declaration has data definition (REF, EXT) | All XSD                  |
| 9-38 | Untyped element is abstract (REF, EXT) | All XSD |
| 9-39 | Element of type xs:anySimpleType is abstract (REF, EXT) | All XSD |
| 9-40 | Element type not in the XML Schema namespace (REF, EXT) | All XSD |
| 9-41 | Element type not in the XML namespace (REF, EXT) | All XSD |
| 9-42 | Element type is not simple type (REF, EXT) | not MSG |
| 9-43 | No element disallowed substitutions (REF) | REF |
| 9-44 | No element disallowed derivation (REF) | REF |
| 9-45 | No element default value (REF, EXT) | not SUB, MSG |
| 9-46 | No element fixed value (REF, EXT) | not SUB, MSG |
| 9-47 | Element declaration is nillable (REF) | REF |
| 9-48 | Attribute declaration is top-level (REF, EXT) | All XSD                  |
| 9-49 | Attribute declaration has data definition (REF, EXT) | All XSD |
| 9-50 | Attribute declaration has type (REF, EXT) | All XSD |
| 9-51 | No attribute type of xs:ID (REF, EXT) | All XSD |
| 9-52 | No attribute type of xs:IDREF (REF, EXT) | All XSD |
| 9-53 | No attribute type of xs:IDREFS (REF, EXT) | All XSD |
| 9-54 | No attribute type of xs:ENTITY (REF, EXT) | All XSD |
| 9-55 | No attribute type of xs:ENTITIES (REF, EXT) | All XSD |
| 9-56 | No attribute type of xs:anySimpleType (REF, EXT) | All XSD |
| 9-57 | No attribute default values (REF, EXT) | not SUB, MSG |
| 9-58 | No fixed values for optional attributes (REF, EXT) | not SUB, MSG |
| 9-59 | No use of element xs:notation (REF, EXT) | All XSD |
| 9-60 | Model group does not affect meaning (EXT) | EXT, SUB, MSG            |
| 9-61 | No xs:all (REF, EXT) | All XSD |
| 9-62 | xs:sequence must be child of xs:extension (REF) | REF |
| 9-63 | xs:sequence must be child of xs:extension or xs:restriction (EXT) | EXT, SUB, MSG |
| 9-64 | No xs:choice (REF) | REF |
| 9-65 | xs:choice must be child of xs:sequence (EXT) | EXT, SUB, MSG            |
| 9-66 | Sequence has minimum cardinality 1 (REF, EXT) | All XSD |
| 9-67 | Sequence has maximum cardinality 1 (REF, EXT) | All XSD |
| 9-68 | Choice has minimum cardinality 1 (EXT) | EXT, SUB, MSG            |
| 9-69 | Choice has maximum cardinality 1 (EXT) | EXT, SUB, MSG |
| 9-70 | No use of xs:any (REF) | REF |
| 9-71 | No use of xs:anyAttribute (REF) | REF |
| 9-72 | No use of xs:unique (REF, EXT) | All XSD |
| 9-73 | No use of xs:key (REF, EXT) | All XSD |
| 9-74 | No use of xs:keyref (REF, EXT) | All XSD |
| 9-75 | No use of xs:group (REF, EXT) | All XSD |
| 9-76 | No definition of attribute groups (REF, EXT) | All XSD |
| 9-77 | Comment is not recommended (REF, EXT) | All XSD |
| 9-78 | Documentation element has no element children (REF, EXT) | All XSD |
| 9-79 | xs:appinfo children are comments, elements, or whitespace (REF, EXT) | All XSD |
| 9-80 | Appinfo child elements have namespaces (REF, EXT) | All XSD |
| 9-81 | Appinfo descendants are not XML Schema elements (REF, EXT) | All XSD |
| 9-82 | Schema has data definition (REF, EXT) | All XSD       |
| 9-83 | Schema document defines target namespace (REF, EXT) | All XSD |
| 9-84 | Target namespace is absolute URI (REF, EXT) | All XSD (plus metamodel) |
| 9-85 | Schema has version (REF, EXT) | All XSD (plus metamodel) |
| 9-86 | No disallowed substitutions (REF) | REF |
| 9-87 | No disallowed derivations (REF) | REF |
| 9-88 | No use of xs:redefine (REF, EXT) | All XSD |
| 9-89 | No use of xs:include (REF, EXT) | All XSD |
| 9-90 | xs:import must have namespace (REF, EXT) | All XSD |
| 9-91 | XML Schema document set must be complete (SET) | all schemas |
| 9-92 | Namespace referenced by attribute type is imported (REF, EXT) | All XSD |
| 9-93 | Namespace referenced by attribute base is imported (REF, EXT) | All XSD |
| 9-94 | Namespace referenced by attribute itemType is imported (REF, EXT) | All XSD |
| 9-95 | Namespaces referenced by attribute memberTypes is imported (REF, EXT) | All XSD |
| 9-96 | Namespace referenced by attribute ref is imported (REF, EXT) | All XSD |
| 9-97 | Namespace referenced by attribute substitutionGroup is imported (REF, EXT) | All XSD |
| 10-1 | Complex type has a category (REF, EXT) | All XSD (revise) |
| 10-2 | Object type with complex content is derived from structures:ObjectType (REF, EXT) | not MSG                  |
| 10-3 | RoleOf element type is an object type (REF, EXT) | All XSD (keep?) |
| 10-4 | Only object type has RoleOf element (REF, EXT) | All XSD (keep?) |
| 10-5 | RoleOf elements indicate the base types of a role type (REF, EXT, INS) | All XSD (keep?) |
| 10-6 | Instance of RoleOf element indicates a role object (INS) | All XSD (keep?) |
| 10-7 | Import of external namespace has data definition (REF, EXT) | All XSD |
| 10-8 | External adapter type has indicator (REF, EXT) | All XSD |
| 10-9 | Structure of external adapter type definition follows pattern (REF, EXT) | All XSD |
| 10-10 | Element use from external adapter type defined by external schema documents (REF, EXT) | All XSD |
| 10-11 | External adapter type not a base type (REF, EXT) | All XSD |
| 10-12 | External adapter type not a base type (SET) | All XSD |
| 10-13 | External attribute use only in external adapter type (REF) | REF |
| 10-14 | External attribute use has data definition (REF, EXT) | All XSD |
| 10-15 | External attribute use not an ID (SET) | SET, MSET                |
| 10-16 | External element use has data definition (REF, EXT) | All XSD |
| 10-17 | Name of code type ends in CodeType (REF, EXT) | All XSD |
| 10-18 | Code type corresponds to a code list (REF, EXT) | All XSD |
| 10-19 | Element of code type has code representation term (REF, EXT) | All XSD |
| 10-20 | Proxy type has designated structure (REF, EXT) | not MSG |
| 10-21 | Association type derived from structures:AssociationType (REF, EXT) | not MSG                  |
| 10-22 | Association element type is an association type (REF, EXT) | not MSG |
| 10-23 | Augmentable type has augmentation point element (REF) | REF |
| 10-24 | Augmentable type has at most one augmentation point element (REF, EXT) | all XSD |
| 10-25 | Augmentation point element corresponds to its base type (REF, EXT) | all XSD |
| 10-26 | An augmentation point element has no type (REF, EXT) | all XSD |
| 10-27 | An augmentation point element has no substitution group (REF, EXT) | all XSD |
| 10-28 | Augmentation point element is only referenced by its base type (REF, EXT) | all XSD |
| 10-29 | Augmentation point element use is optional (REF) | REF |
| 10-30 | Augmentation point element use is unbounded (REF) | REF |
| 10-31 | Augmentation point element use must be last element in its base type (REF, EXT) | all XSD |
| 10-32 | Element within instance of augmentation type modifies base (INS) | INS |
| 10-33 | Only an augmentation type name ends in AugmentationType (REF, EXT) | all XSD |
| 10-34 | Schema component with name ending in AugmentationType is an augmentation type (REF, EXT) | all XSD |
| 10-35 | Type derived from structures:AugmentationType is an augmentation type (REF, EXT) | all XSD |
| 10-36 | Augmentation element type is an augmentation type (REF, EXT) | all XSD |
| 10-37 | Augmentation elements are not used directly (REF, SET) | all XSD (incl EXT) |
| 10-38 | Metadata type has data about data (REF, EXT) | all XSD (delete?) |
| 10-39 | Metadata types are derived from structures:MetadataType (REF, EXT) | all XSD (delete?) |
| 10-40 | Metadata element declaration type is a metadata type (REF, EXT) | all XSD (delete?) |
| 10-41 | Metadata element has applicable elements (REF, EXT, SET) | all XSD (delete?) |
| 10-42 | Name of element that ends in Representation is abstract (REF, EXT) | all XSD |
| 10-43 | A substitution for a representation element declaration is a value for a type (REF, EXT) | all XSD |
| 10-44 | Schema component name composed of English words (REF, EXT) | metamodel |
| 10-45 | Schema component name has xml:lang (REF, EXT) | metamodel |
| 10-46 | Schema component names have only specific characters (REF, EXT) | metamodel |
| 10-47 | Punctuation in component name is a separator (REF, EXT) | metamodel |
| 10-48 | Names use camel case (REF, EXT) | metamodel |
| 10-49 | Attribute name begins with lower case letter (REF, EXT) | metamodel |
| 10-50 | Name of schema component other than attribute and proxy type begins with upper case letter (REF, EXT) | metamodel |
| 10-51 | Names use common abbreviations (REF, EXT) | metamodel |
| 10-52 | Local term declaration is local to its schema document (REF, EXT) | metamodel |
| 10-53 | Local terminology interpretation (REF, EXT) | metamodel |
| 10-54 | Singular form is preferred in name (REF, EXT) | metamodel |
| 10-55 | Present tense is preferred in name (REF, EXT) | metamodel |
| 10-56 | Name does not have nonessential words (REF, EXT) | metamodel |
| 10-57 | Element or attribute name follows pattern (REF, EXT) | metamodel |
| 10-58 | Object-class term identifies concrete category (REF, EXT) | metamodel |
| 10-59 | Property term describes characteristic or subpart (REF, EXT) | metamodel |
| 10-60 | Name may have multiple qualifier terms (REF, EXT) | metamodel |
| 10-61 | Name has minimum necessary number of qualifier terms (REF, EXT) | metamodel |
| 10-62 | Order of qualifiers is not significant (REF, EXT) | metamodel |
| 10-63 | Redundant term in name is omitted (REF, EXT) | metamodel |
| 10-64 | Element with simple content has representation term (REF, EXT) | metamodel |
| 10-65 | Element with complex content has representation term when appropriate (REF, EXT) | metamodel |
| 10-66 | Element with complex content has representation term only when appropriate (REF, EXT) | metamodel |
| 10-67 | Machine-readable annotations are valid (REF, EXT) | all XSD |
| 10-68 | Component marked as deprecated is deprecated component (REF, EXT) | all XSD                  |
| 10-69 | Deprecated annotates schema component (REF, EXT) | all XSD |
| 10-70 | External import indicator annotates import (REF, EXT) | all XSD |
| 10-71 | External adapter type indicator annotates complex type (REF, EXT) | all XSD |
| 10-72 | appinfo:appliesToTypes annotates metadata element (REF, EXT) | remove? |
| 10-73 | appinfo:appliesToTypes references types (SET) | remove? |
| 10-74 | appinfo:appliesToElements annotates metadata element (REF, EXT) | remove? |
| 10-75 | appinfo:appliesToElements references elements (SET) | remove? |
| 10-76 | appinfo:LocalTerm annotates schema (REF, EXT) | all XSD |
| 10-77 | appinfo:LocalTerm has literal or definition (REF, EXT) | all XSD |
| 10-78 | Use structures consistent with specification (REF, EXT, INS, SET) | MSG is special |
| 11-1 | Name of type ends in Type (REF, EXT) | metamodel |
| 11-2 | Only types have name ending in Type or SimpleType (REF, EXT) | metamodel |
| 11-3 | Base type definition defined by conformant schema (REF, EXT) | all XSD |
| 11-4 | Name of simple type ends in SimpleType (REF, EXT) | metamodel |
| 11-5 | Use lists only when data is uniform (REF, EXT) | all XSD |
| 11-6 | List item type defined by conformant schemas (REF, EXT) | all XSD |
| 11-7 | Union member types defined by conformant schemas (REF, EXT) | all XSD |
| 11-8 | Name of a code simple type ends in CodeSimpleType (REF, EXT) | not MSG |
| 11-9 | Code simple type corresponds to a code list (REF, EXT) | all XSD |
| 11-10 | Attribute of code simple type has code representation term (REF, EXT) | all XSD |
| 11-11 | Complex type with simple content has structures:SimpleObjectAttributeGroup (REF, EXT) | not MSG |
| 11-12 | Element type does not have a simple type name (REF, EXT) | all XSD |
| 11-13 | Element type is from conformant namespace (REF, EXT) | all XSD |
| 11-14 | Name of element that ends in Abstract is abstract (REF, EXT) | metamodel |
| 11-15 | Name of element declaration with simple content has representation term (REF, EXT) | metamodel |
| 11-16 | Name of element declaration with simple content has representation term (SET) | metamodel |
| 11-17 | Element substitution group defined by conformant schema (REF, EXT) | all XSD |
| 11-18 | Attribute type defined by conformant schema (REF, EXT) | all XSD |
| 11-19 | Attribute name uses representation term (REF, EXT) | metamodel |
| 11-20 | Element or attribute declaration introduced only once into a type (REF, EXT) | metamodel |
| 11-21 | Element reference defined by conformant schema (REF, EXT) | all XSD |
| 11-22 | Referenced attribute defined by conformant schemas (REF, EXT) | all XSD |
| 11-23 | Schema uses only known attribute groups (REF, EXT) | delete |
| 11-24 | Data definition does not introduce ambiguity (REF, EXT) | Some s |
| 11-25 | Object class has only one meaning (REF, EXT) | metamodel |
| 11-26 | Data definition of a part does not redefine the whole (REF, EXT) | metamodel |
| 11-27 | Do not leak representation into data definition (REF, EXT) | metamodel |
| 11-28 | Data definition follows 11179-4 requirements (REF, EXT) | metamodel |
| 11-29 | Data definition follows 11179-4 recommendations (REF, EXT) | metamodel |
| 11-30 | xs:documentation has xml:lang (REF, EXT) | all XSD |
| 11-31 | Standard opening phrase for augmentation point element data definition (REF, EXT) | metamodel |
| 11-32 | Standard opening phrase for augmentation element data definition (REF, EXT) | metamodel |
| 11-33 | Standard opening phrase for metadata element data definition (REF, EXT) | metamodel |
| 11-34 | Standard opening phrase for association element data definition (REF, EXT) | metamodel |
| 11-35 | Standard opening phrase for abstract element data definition (REF, EXT) | metamodel |
| 11-36 | Standard opening phrase for date element or attribute data definition (REF, EXT) | metamodel |
| 11-37 | Standard opening phrase for quantity element or attribute data definition (REF, EXT) | metamodel |
| 11-38 | Standard opening phrase for picture element or attribute data definition (REF, EXT) | metamodel |
| 11-39 | Standard opening phrase for indicator element or attribute data definition (REF, EXT) | metamodel |
| 11-40 | Standard opening phrase for identification element or attribute data definition (REF, EXT) | metamodel |
| 11-41 | Standard opening phrase for name element or attribute data definition (REF, EXT) | metamodel |
| 11-42 | Standard opening phrase for element or attribute data definition (REF, EXT) | metamodel |
| 11-43 | Standard opening phrase for association type data definition (REF, EXT) | metamodel |
| 11-44 | Standard opening phrase for augmentation type data definition (REF, EXT) | metamodel |
| 11-45 | Standard opening phrase for metadata type data definition (REF, EXT) | metamodel |
| 11-46 | Standard opening phrase for complex type data definition (REF, EXT) | metamodel |
| 11-47 | Standard opening phrase for simple type data definition (REF, EXT) | metamodel |
| 11-48 | Same namespace means same components (REF, EXT) | metamodel |
| 11-49 | Different version means different view (REF, EXT) | all XSD (extend) |
| 11-50 | Reference schema document imports reference schema document (SET) | all XSD |
| 11-51 | Extension schema document imports reference or extension schema document (SET) | all XSD |
| 11-52 | Structures imported as conformant (REF, EXT) | all XSD |
| 11-53 | XML namespace imported as conformant (REF, EXT) | all XSD |
| 11-54 | Each namespace may have only a single root schema in a schema set (SET) | all XSD |
| 11-55 | Consistently marked namespace imports (REF, EXT) | all XSD |
| 12-1 | Instance must be schema-valid (INS) | INS |
| 12-2 | Empty content has no meaning (INS) | INS |
| 12-3 | Element has only one resource identifying attribute (INS) | INS |
| 12-4 | Attribute structures:ref must reference structures:id (INS) | INS (relax?) |
| 12-5 | Linked elements have same validation root (INS) | INS |
| 12-6 | Attribute structures:ref references element of correct type (INS) | INS |
| 12-7 | structures:uri denotes resource identifier (INS) | INS |
| 12-8 | structures:id and structures:ref denote resource identifier (INS) | INS |
| 12-9 | Nested elements and references have the same meaning. (INS) | INS |
| 12-10 | Order of properties is expressed via structures:sequenceID (INS) | rewrite |
| 12-11 | Metadata applies to referring entity (INS) | INS (delete?) |
| 12-12 | Referent of structures:relationshipMetadata annotates relationship (INS) | INS (rewrite) |
| 12-13 | Values of structures:metadata refer to values of structures:id (INS) | INS (delete?) |
| 12-14 | Values of structures:relationshipMetadata refer to values of structures:id (INS) | INS (delete?) |
| 12-15 | structures:metadata and structures:relationshipMetadata refer to metadata elements (INS) | INS (delete?) |
| 12-16 | Attribute structures:metadata references metadata element (INS) | INS (delete?) |
| 12-17 | Attribute structures:relationshipMetadata references metadata element (INS) | INS (delete?) |
| 12-18 | Metadata is applicable to element (INS) | INS (delete?) |



Author:  Scott Renner
Date:  2023-07-27
