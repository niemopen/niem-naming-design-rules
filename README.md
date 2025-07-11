<img src="https://github.com/niemopen/oasis-open-project/blob/main/artwork/NIEM-NO-Logo-v5.png" width="200">

# Naming and Design Rules

This repository is part of the NIEM Open Project.

For more information on NIEMOpen, see the project's website at [www.niemopen.org](www.niemopen.org).

General questions about OASIS Open Projects may be directed to OASIS staff at project-admin@lists.oasis-open-projects.org

## Status

NDR 6.0 is a complete rewrite of the previous NDR 5.0.  The current draft is proposed as Project Specification 01.

* HTML:  [ndr-v6.0-ps01.html](https://niemopen.github.io/niem-naming-design-rules/ndr-v6.0-ps01.html)
* PDF:  [ndr-v6.0-ps01.pdf](ndr-v6.0-ps01.pdf)

Please post comments on NDR 6.0 PS01 on the [issues page](https://github.com/niemopen/niem-naming-design-rules/issues).

## Generating NDR6

* NDR 6.0 is written in Markdown.  The source file edited by people is [ndr6src.md](ndr6src.md).
* The markdown version of NDR6 is generated via Perl scripts, which
  * Transforms defined terms in the text into dot-links (*for example,* <a class="termRef" href="">·message type·</a>) pointing to definitions in the Glossary
  * Transforms references into links to Appendix A (References)
  * Generates an index of figures and rules
  * Generates a cross reference of NDR5 rules to NDR6 rules
* HTML is generated from the intermediate Markdown with [**pandoc 3.0**](https://pandoc.org)
* PDF is generated from the HTML with wkhtmltopdf
* Build automation is controlled by a [Makefile](Makefile).

## What's in this directory

* [bin](bin) – scripts to generate files in this directory
  * [genruleMatrix](genruleMatrix) – Perl script to create [ruleMatrix.md](ruleMatrix.md)  from [NDR5+](niem-ndr.md)
  * [fixmd](bin/fixmd) – Perl script to generate intermediate Markdown with definition links from the source
  * [makesch](bin/makesch) – Perl script to create schematron files from [NDR5+](niem-ndr.md)
  * [reindex](bin/reindex) – Perl script to update rule numbers in the Markdown source
* [doc](doc) – background documentation
  * [cmf-to-JsonSchema](doc/cmf-to-json-schema-guide.md) – converting a CMF model into JSON Schema to validate NIEM JSON messages
  * [confTargets](doc/confTargets.md) – *Conformance Targets in NIEM 6.0* –  summary of differences between reference, extension, subset, and message schema documents
  * [NIEM6-XNDR](doc/NIEM6-XNDR.md) – list of NDR 5 XSD rules in order; state applicable NIEM 6 XSD conformance targets
  * [ruleMatrix](doc/ruleMatrix.md) – list NDR 5 XSD rules, grouped by applicable NIEM 6 XSD conformance targets

* [examples](examples) – the [crash-driver](examples/crash-driver) message specification
* [images](images) – directory of PNG files used as images in NDR6
* [old](old) – NDR5 stuff
* [niem5ndr.md](niem5ndr.md) – NDR 5 converted to markdown, with edits to XSD rules
* [pptx](pptx) – originals of images created with Powerpoint
* [sch](sch) – Schematron for XSD rules in NDR 6
  * [ndr-ct-ext.sch](ndr-ct-ext.sch) – Schematron for extension schema documents
  * [ndr-ct-msg.sch](ndr-ct-msg.sch) – Schematron for message schema documents
  * [ndr-ct-sub.sch](ndr-ct-sub.sch) – Schematron for subset schema documents
  * [ndr-ct-ref.sch](ndr-ct-ref.sch) – Schematron for reference schema documents
* [styles](styles) – CSS files used to generate OASIS HTML from Markdown
* [uxf](uxf) – originals of UML diagrams in NDR6

# Other assets

In addition to this GitHub organization, this project also makes use of other assets. 

- The NIEMOpen website is at www.niemopen.org. The website contains news, announcements, and other information of interest about the project. 

- The [General purpose mailing list](https://lists.oasis-open-projects.org/g/niemopen). To subscribe, send an empty email message to niemopen+subscribe@lists.oasis-open-projects.org. Anyone interested is welcome to subscribe and send email to the list. The list maintains an [archive](https://lists.oasis-open-projects.org/g/niemopen/messages).

- The [Project Governing Board mailing list](https://lists.oasis-open-projects.org/g/niemopen-pgb). This is the discussion list for use by the members of the PGB. To subscribe, send an empty email message to niemopen-pgb+subscribe@lists.oasis-open-projects.org. Anyone interested is welcome to subscribe read-only. Only PGB members can post. The list maintains an [archive](https://lists.oasis-open-projects.org/g/niemopen-pgb/messages).

- [NBAC Technical Steering Committee mailing list](https://lists.oasis-open-projects.org/g/niemopen-nbactsc). This is the discussion list for use by the members of the NIEM Business Architecture Committee TSC. To subscribe, send an empty email message to niemopen-nbactsc+subscribe@lists.oasis-open-projects.org. Anyone interested is welcome to subscribe read-only. The list maintains an [archive](https://lists.oasis-open-projects.org/g/niemopen-nbactsc/messages).

- [NTAC Technical Steering Committee mailing list](https://lists.oasis-open-projects.org/g/niemopen-ntactsc). This is the discussion list for use by the members of the NIEM Technical Architecture Committee TSC. To subscribe, send an empty email message to niemopen-ntactsc+subscribe@lists.oasis-open-projects.org. Anyone interested is welcome to subscribe read-only. The list maintains an [archive](https://lists.oasis-open-projects.org/g/niemopen-ntactsc/messages).

# Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details how to join the project, contribute changes to our repositories and communicate with the rest of the project contributors. Please become familiar with and follow the [code of conduct](CODE-OF-CONDUCT.md).

# Governance

NIEM Open operates under the terms of the [Open Project Rules](https://www.oasis-open.org/policies-guidelines/open-projects-process) and the applicable license(s) specified in [LICENSE.md](LICENSE.md). Further details can be found in [GOVERNANCE.md](GOVERNANCE.md), [GOVERNANCE-NBAC.md](GOVERNANCE-NBAC.md), and [GOVERNANCE-NTAC.md](GOVERNANCE-NTAC.md).

# CLA & Non-assert signatures required

All technical contributions must be covered by a Contributor's License Agreement. This requirement allows our work to advance through OASIS standards development stages and potentially be submitted to de jure organizations such as ISO. You will get a prompt to sign this document when you submit your first pull request to a project repository, or you can sign [here](https://www.oasis-open.org/open-projects/cla/oasis-open-projects-individual-contributor-license-agreement-i-cla/). If you are contributing on behalf of your employer, you must also sign the ECLA [here](https://www.oasis-open.org/open-projects/cla/entity-cla-20210630/).

<style>
a.termRef { text-decoration: none; color: #000; background-color: #FFF; }
a.termRef[href]:hover { color: #000; background-color: #F9FAD4; }
</style>
