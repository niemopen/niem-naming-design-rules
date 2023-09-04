## 2023-09-01

1. Replaced niem.org URIs with oasis-open.org URIs
2. Fixed extra blank space in many references to Appendix-A
3. Removed metadata from 10.1 (categories)
4. Rule 10-2:  removed MetadataType 
5. Removed section 10.2.2 (role types and roles), including rules 10-3 through 10-6
6. Rewrote intro to metadata section and removed the rest
7. Removed appinfo:appliesToTypes and appliesToElements
8. Removed rule 11-23 (NIEM 6 does not use attribute groups)
9. Removed section 12-4 (instance metadata) and rules 12-13 thru 12-18
10. Some section numbers added

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