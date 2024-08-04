## Conformance targets in NIEM 6.0

> This is a working document.  It will eventually vanish, merge, or something.

A message schema document is like a subset schema document, except

* Can have local types (no rule 9-10 and 9-25)
* Can have elements with simple type (no Rule 9-42)
* Object types need not be derived from `structures:ObjectType` (no rule 10-2)
* Do not have proxy types (no rule 10-20)
* Association types need not be derived from `structures:AssociationType` (no rule 10-21)
* Elements ending in "Association" need not be an association type (no rule 10-22)

A subset schema document is like an extension schema document, except

* Can have default element value (no rule 9-45)
* Can have fixed element value (no rule 9-46)
* Can have attribute default valus (no rule 9-57)
* Can have fixed values for optional attributes (no rule 9-58)

An extension schema document is like a reference schema document, except

* Can have @final (no rule 9-11, 9-35, 9-44)
* Can have @fixed (no rule 9-13)
* Can use xs:restriction (no rule 9-30, 9-33, 9-62)
* Can have @block (no rule 9-34, 9-43)
* Elements need not be nillable (no rule 9-47)
* Can have xs:choice (no rule 9-64)
* Can have xs:any (no rule 9-70)
* Can have xs:anyAttribute (no rule 9-71)
* Can have @blockDefault (no rule 9-86)
* Can have @finalDefault (no rule 9-87)
* Can use external attribute without adapter (no rule 10-13)
* Augmentable types need not have augmentation points (no rule 10-23, 10-29, 10-30, 10-37)