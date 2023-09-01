## 2023-08-29

1. Changed Table 4-1 codes representing conformance targets
   * New code SUB, MSG, and MSET
   * Changed meaning of code SET
   * Updates for the rest of this section left unti later
2. Rules 9-10, 9-25 do not apply to message schema documents – local type definitions are allowed in these.
3. Rule 9-42 does not apply to message schema documents – elements may have a simple type in these.
5. Rules 9-45, 9-46, 9-57, 9-58 do not apply to subset or message schema documents – fixed and default values are allowed in these.  Revision to Principle #18 left for later.
6. Rule 9-60 does not apply to REF only because xs:choice is not allowed in REF.
7. Rule 9-76 has a simpler description, because NIEM 6 does not use attribute groups at all