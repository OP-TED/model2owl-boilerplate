# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]
### Added

### Changed


## [3.2.0-rc.2] - 2026-02-03
### Added
- Add support for generation of diff reports at the same time (TEDM2O-12).

### Changed
- Reorganize and improve transform and diff workflows to enable multi-module support (TEDM2O-12).
- Update workflow description in README to reflect the changes (TEDM2O-12).

### Fixed
- Enforce sequential execution of transform and diff workflows (TEDM2O-12).
- Update installation steps in the transformation workflow (TEDM2O-12).
- Implement selection of the correct configuration file for the generation of combined glossaries (TEDM2O-13).


## [3.2.0-rc.1] - 2025-12-09
### Added
- Add automated workflow for generation of RDF diff reports (TEDM2O-12).
- Enable generation of a new AsciiDoc glossary (TEDM2O-13).
### Changed
- Update project to use [model2owl
3.2.0](https://github.com/OP-TED/model2owl/releases/tag/3.2.0).


## [3.1.0-rc.2] - 2025-11-20
### Changed
- Enable use of imports.xml files along with the fine-grained control of import
  statements generated for ontologies in RDF artefacts (TEDM2O-21).
- Update configuration for the issued date (TEDM2O-11).


## [3.1.0-rc.1] - 2025-10-15
### Added
- Generation of the new ReSpec documentation artefact (available through the new
  `generate_jsonld_context` CI job) (TEDM2O-11).
- New subdirectories for input (`respec-resources`) and output (`respec`) data
  related to the ReSpec generation feature (TEDM2O-11).
- New resources needed to demonstrate the ReSpec documentation (TEDM2O-11).
- Dedicated `metadata.json` file describing metadata to be used in the generated
  artefacts (TEDM2O-11).
- Generation of the new JSON-LD context artefact, available through the new
  `generate_respec` CI job (TEDM2O-7).
- Publication of the ReSpec documentation via the GitHub Pages (TEDM2O-11).

### Changed
- Update project to use [model2owl
3.1.0](https://github.com/OP-TED/model2owl/releases/tag/3.1.0)


## [3.0.0] — 2025-03-26
### Changed
- Update project to use [model2owl 3.0.0](https://github.com/OP-TED/model2owl/releases/tag/3.0.0)
- Update GitHub Actions to explicitly pass a namespaces file to model2owl toolkit commands
- Update test files
- Change the versioning scheme to align with the used [model2owl](https://github.com/OP-TED/[model2owl](https://github.com/OP-TED/model2owl)) version