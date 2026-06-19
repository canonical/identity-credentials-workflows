# Changelog

## [3.0.0](https://github.com/canonical/identity-credentials-workflows/compare/v2.0.6...v3.0.0) (2026-06-16)


### ⚠ BREAKING CHANGES

* introduce justfiles and actions ([#75](https://github.com/canonical/identity-credentials-workflows/issues/75))

### Features

* introduce justfiles and actions ([#75](https://github.com/canonical/identity-credentials-workflows/issues/75)) ([a5f90ca](https://github.com/canonical/identity-credentials-workflows/commit/a5f90cab93cb8cd0189c272b2b056f0371d7aad6))

## [2.0.6](https://github.com/canonical/identity-credentials-workflows/compare/v2.0.5...v2.0.6) (2026-06-10)


### Bug Fixes

* Trigger release with updated dependencies ([6b9167a](https://github.com/canonical/identity-credentials-workflows/commit/6b9167a25e7608fde44492d4d13e53c8d3f1819a))

## [2.0.5](https://github.com/canonical/identity-credentials-workflows/compare/v2.0.4...v2.0.5) (2026-06-09)


### Bug Fixes

* replace docker-run trivy with trivy-action and bump CodeQL to v4 ([#92](https://github.com/canonical/identity-credentials-workflows/issues/92)) ([fdbbedf](https://github.com/canonical/identity-credentials-workflows/commit/fdbbedfa2a94f0798ae90c695708152893823b79))

## [2.0.4](https://github.com/canonical/identity-credentials-workflows/compare/v2.0.3...v2.0.4) (2026-06-09)


### Bug Fixes

* correct Trvy/CodeQL SHA pins and drop reserved GITHUB_TOKEN input ([#90](https://github.com/canonical/identity-credentials-workflows/issues/90)) ([8312260](https://github.com/canonical/identity-credentials-workflows/commit/8312260a1a80c5eb2a61316b956d82abb14d1c10))

## [2.0.3](https://github.com/canonical/identity-credentials-workflows/compare/v2.0.2...v2.0.3) (2026-05-29)


### Bug Fixes

* Build grafana linter from source ([#88](https://github.com/canonical/identity-credentials-workflows/issues/88)) ([84eab03](https://github.com/canonical/identity-credentials-workflows/commit/84eab03a843b81fe821d8fe4fe6c27d2ef715793))

## [2.0.2](https://github.com/canonical/identity-credentials-workflows/compare/v2.0.1...v2.0.2) (2026-05-29)


### Bug Fixes

* Update SHA in grafana lint ([#86](https://github.com/canonical/identity-credentials-workflows/issues/86)) ([ddd1cc2](https://github.com/canonical/identity-credentials-workflows/commit/ddd1cc206a96a5e6027dda707b5083f2f93b95fe))

## [2.0.1](https://github.com/canonical/identity-credentials-workflows/compare/v2.0.0...v2.0.1) (2026-05-28)


### Bug Fixes

* Scan charms from charmhub ([b9e7a31](https://github.com/canonical/identity-credentials-workflows/commit/b9e7a31b9281d537703258c7f9a3d9ae42a92a25))

## [2.0.0](https://github.com/canonical/identity-credentials-workflows/compare/v1.3.1...v2.0.0) (2026-05-28)


### ⚠ BREAKING CHANGES

* Removes old fragmented workflows in favor of unified ones.

### Code Refactoring

* unify workflows with multi-arch and mono-repo support ([#79](https://github.com/canonical/identity-credentials-workflows/issues/79)) ([09abfc0](https://github.com/canonical/identity-credentials-workflows/commit/09abfc0e875513619e58dff5cdd7a06e2b869934))

## [1.3.1](https://github.com/canonical/identity-credentials-workflows/compare/v1.3.0...v1.3.1) (2026-05-26)


### Bug Fixes

* downgrade go version used by grafana ([#76](https://github.com/canonical/identity-credentials-workflows/issues/76)) ([0b39af3](https://github.com/canonical/identity-credentials-workflows/commit/0b39af37748d8529449f99e7c71f679d54d6ad9f))

## [1.3.0](https://github.com/canonical/identity-credentials-workflows/compare/v1.2.1...v1.3.0) (2026-01-30)


### Features

* Add default Renovate configuration for reuse ([#26](https://github.com/canonical/identity-credentials-workflows/issues/26)) ([dd9fb1a](https://github.com/canonical/identity-credentials-workflows/commit/dd9fb1a0f17e76d2b81c95f341c369f4a7f07066))
* add multiarch rock build and publishing ([#16](https://github.com/canonical/identity-credentials-workflows/issues/16)) ([3a30982](https://github.com/canonical/identity-credentials-workflows/commit/3a30982a2c90e9a4ae087f1f026a006152f4f3bf))
* Add option to fetch latest charm libraries in TICS workflow ([#34](https://github.com/canonical/identity-credentials-workflows/issues/34)) ([0657295](https://github.com/canonical/identity-credentials-workflows/commit/06572957bd588e670f41e666b2b8bd0ae50c407f))
* Add uv-scan workflow to scan uv dependencies ([#29](https://github.com/canonical/identity-credentials-workflows/issues/29)) ([844c890](https://github.com/canonical/identity-credentials-workflows/commit/844c8903006c2af7afb830ed680e33cdd372cefe))
* Allow giving a suffix to artifact names ([#61](https://github.com/canonical/identity-credentials-workflows/issues/61)) ([09ae283](https://github.com/canonical/identity-credentials-workflows/commit/09ae2834134096428f96d60f89fdd9b26ec321a9))
* Allow passing a path to build workflows ([#60](https://github.com/canonical/identity-credentials-workflows/issues/60)) ([511737a](https://github.com/canonical/identity-credentials-workflows/commit/511737aa39206c5b300b1778b4f26027a2200e5e))
* Allow setting git tag prefix ([#58](https://github.com/canonical/identity-credentials-workflows/issues/58)) ([4481c8a](https://github.com/canonical/identity-credentials-workflows/commit/4481c8a30d7a1901ff0b8b8d4e8299c4ac047b4d))
* Allow specifying a charm path for the publish workflow ([#62](https://github.com/canonical/identity-credentials-workflows/issues/62)) ([002a233](https://github.com/canonical/identity-credentials-workflows/commit/002a233e55b4597c84296c513498d8a90adf35ee))
* Allow uv lock file location to be configured ([#39](https://github.com/canonical/identity-credentials-workflows/issues/39)) ([e34696c](https://github.com/canonical/identity-credentials-workflows/commit/e34696c96ac68881fefb1a43295b596ac0221add))
* create jira-sync.yaml ([#12](https://github.com/canonical/identity-credentials-workflows/issues/12)) ([8fec14c](https://github.com/canonical/identity-credentials-workflows/commit/8fec14c41a4f34c21c9b38461f05519c7a719c63))
* enable GitHub tag creation in publish-charm workflow ([feefa49](https://github.com/canonical/identity-credentials-workflows/commit/feefa492b6c54499ee8706b639c68e3fbdadeea0))
* Enable using charmcraftcache ([#36](https://github.com/canonical/identity-credentials-workflows/issues/36)) ([4b6d0c6](https://github.com/canonical/identity-credentials-workflows/commit/4b6d0c67068b6fd3b10f2bc0f3c6c057bb3aeff2))
* Explicitly set name, path and artifact when building the charm ([#47](https://github.com/canonical/identity-credentials-workflows/issues/47)) ([5a654f4](https://github.com/canonical/identity-credentials-workflows/commit/5a654f4408424159696cbbe438524ed92dfc0803))
* Workflow to detect known vulnerabilities ([#21](https://github.com/canonical/identity-credentials-workflows/issues/21)) ([9401f83](https://github.com/canonical/identity-credentials-workflows/commit/9401f83e95f61df11b3024d3511e5a2eccb44b23))


### Bug Fixes

* Accept the required secrets in the workflow ([#15](https://github.com/canonical/identity-credentials-workflows/issues/15)) ([d300f0c](https://github.com/canonical/identity-credentials-workflows/commit/d300f0c6cfc765405edd110050fc6dc7da17acfc))
* Download artifact to the correct path when publishing charm ([#63](https://github.com/canonical/identity-credentials-workflows/issues/63)) ([786ed46](https://github.com/canonical/identity-credentials-workflows/commit/786ed46eac46814f2ada128607871d91d77f0f16))
* download the charm to the provided path ([#24](https://github.com/canonical/identity-credentials-workflows/issues/24)) ([fe83d06](https://github.com/canonical/identity-credentials-workflows/commit/fe83d06c3f57ff690feb35a3a96baa989ab4d740))
* Fix charm publishing workflow for single architecture ([#10](https://github.com/canonical/identity-credentials-workflows/issues/10)) ([0dd6951](https://github.com/canonical/identity-credentials-workflows/commit/0dd6951ac6ba76b2cad5806ee5ab59d482df15d6))
* Fix renovate usage documentation in README ([#28](https://github.com/canonical/identity-credentials-workflows/issues/28)) ([1c88a9a](https://github.com/canonical/identity-credentials-workflows/commit/1c88a9a3902d57dbfb47acd5f02bf5a9459d54a5))
* Provide the checkout ref as an input ([#23](https://github.com/canonical/identity-credentials-workflows/issues/23)) ([ebfc11e](https://github.com/canonical/identity-credentials-workflows/commit/ebfc11ef8d7f1011528abccc0814d46a26877e8b))
* Remove default track name ([#7](https://github.com/canonical/identity-credentials-workflows/issues/7)) ([2a76f0a](https://github.com/canonical/identity-credentials-workflows/commit/2a76f0a2895949b5d219a3e7fd0c2fa8a3de6aaf))
* specify correct path ([#18](https://github.com/canonical/identity-credentials-workflows/issues/18)) ([93425e7](https://github.com/canonical/identity-credentials-workflows/commit/93425e7f403eff6981c1353dd0e5dd501234ca5a))
* Use the right output for channel selection ([#11](https://github.com/canonical/identity-credentials-workflows/issues/11)) ([03e663c](https://github.com/canonical/identity-credentials-workflows/commit/03e663c323dc6d5dd7624d817a7b093c118772ee))
* Use the workflow ref, not the caller ref ([#22](https://github.com/canonical/identity-credentials-workflows/issues/22)) ([bd4a7d9](https://github.com/canonical/identity-credentials-workflows/commit/bd4a7d93c1484bb23ac4c1bfa16f0f2ef67363ea))
* use uv-lock-path in all locations ([#40](https://github.com/canonical/identity-credentials-workflows/issues/40)) ([803589a](https://github.com/canonical/identity-credentials-workflows/commit/803589af2ef8a638de1056a62b2b11caf0b2d049))

## [1.2.0](https://github.com/canonical/identity-credentials-workflows/compare/v1.1.0...v1.2.0) (2025-12-05)


### Features

* enable GitHub tag creation in publish-charm workflow ([feefa49](https://github.com/canonical/identity-credentials-workflows/commit/feefa492b6c54499ee8706b639c68e3fbdadeea0))

## [1.1.0](https://github.com/canonical/identity-credentials-workflows/compare/v1.0.0...v1.1.0) (2025-12-04)


### Features

* Add default Renovate configuration for reuse ([#26](https://github.com/canonical/identity-credentials-workflows/issues/26)) ([dd9fb1a](https://github.com/canonical/identity-credentials-workflows/commit/dd9fb1a0f17e76d2b81c95f341c369f4a7f07066))
* add multiarch rock build and publishing ([#16](https://github.com/canonical/identity-credentials-workflows/issues/16)) ([3a30982](https://github.com/canonical/identity-credentials-workflows/commit/3a30982a2c90e9a4ae087f1f026a006152f4f3bf))
* Add option to fetch latest charm libraries in TICS workflow ([#34](https://github.com/canonical/identity-credentials-workflows/issues/34)) ([0657295](https://github.com/canonical/identity-credentials-workflows/commit/06572957bd588e670f41e666b2b8bd0ae50c407f))
* Add uv-scan workflow to scan uv dependencies ([#29](https://github.com/canonical/identity-credentials-workflows/issues/29)) ([844c890](https://github.com/canonical/identity-credentials-workflows/commit/844c8903006c2af7afb830ed680e33cdd372cefe))
* Allow uv lock file location to be configured ([#39](https://github.com/canonical/identity-credentials-workflows/issues/39)) ([e34696c](https://github.com/canonical/identity-credentials-workflows/commit/e34696c96ac68881fefb1a43295b596ac0221add))
* create jira-sync.yaml ([#12](https://github.com/canonical/identity-credentials-workflows/issues/12)) ([8fec14c](https://github.com/canonical/identity-credentials-workflows/commit/8fec14c41a4f34c21c9b38461f05519c7a719c63))
* Enable using charmcraftcache ([#36](https://github.com/canonical/identity-credentials-workflows/issues/36)) ([4b6d0c6](https://github.com/canonical/identity-credentials-workflows/commit/4b6d0c67068b6fd3b10f2bc0f3c6c057bb3aeff2))
* Explicitly set name, path and artifact when building the charm ([#47](https://github.com/canonical/identity-credentials-workflows/issues/47)) ([5a654f4](https://github.com/canonical/identity-credentials-workflows/commit/5a654f4408424159696cbbe438524ed92dfc0803))
* Workflow to detect known vulnerabilities ([#21](https://github.com/canonical/identity-credentials-workflows/issues/21)) ([9401f83](https://github.com/canonical/identity-credentials-workflows/commit/9401f83e95f61df11b3024d3511e5a2eccb44b23))


### Bug Fixes

* Accept the required secrets in the workflow ([#15](https://github.com/canonical/identity-credentials-workflows/issues/15)) ([d300f0c](https://github.com/canonical/identity-credentials-workflows/commit/d300f0c6cfc765405edd110050fc6dc7da17acfc))
* download the charm to the provided path ([#24](https://github.com/canonical/identity-credentials-workflows/issues/24)) ([fe83d06](https://github.com/canonical/identity-credentials-workflows/commit/fe83d06c3f57ff690feb35a3a96baa989ab4d740))
* Fix charm publishing workflow for single architecture ([#10](https://github.com/canonical/identity-credentials-workflows/issues/10)) ([0dd6951](https://github.com/canonical/identity-credentials-workflows/commit/0dd6951ac6ba76b2cad5806ee5ab59d482df15d6))
* Fix renovate usage documentation in README ([#28](https://github.com/canonical/identity-credentials-workflows/issues/28)) ([1c88a9a](https://github.com/canonical/identity-credentials-workflows/commit/1c88a9a3902d57dbfb47acd5f02bf5a9459d54a5))
* Provide the checkout ref as an input ([#23](https://github.com/canonical/identity-credentials-workflows/issues/23)) ([ebfc11e](https://github.com/canonical/identity-credentials-workflows/commit/ebfc11ef8d7f1011528abccc0814d46a26877e8b))
* Remove default track name ([#7](https://github.com/canonical/identity-credentials-workflows/issues/7)) ([2a76f0a](https://github.com/canonical/identity-credentials-workflows/commit/2a76f0a2895949b5d219a3e7fd0c2fa8a3de6aaf))
* specify correct path ([#18](https://github.com/canonical/identity-credentials-workflows/issues/18)) ([93425e7](https://github.com/canonical/identity-credentials-workflows/commit/93425e7f403eff6981c1353dd0e5dd501234ca5a))
* Use the right output for channel selection ([#11](https://github.com/canonical/identity-credentials-workflows/issues/11)) ([03e663c](https://github.com/canonical/identity-credentials-workflows/commit/03e663c323dc6d5dd7624d817a7b093c118772ee))
* Use the workflow ref, not the caller ref ([#22](https://github.com/canonical/identity-credentials-workflows/issues/22)) ([bd4a7d9](https://github.com/canonical/identity-credentials-workflows/commit/bd4a7d93c1484bb23ac4c1bfa16f0f2ef67363ea))
* use uv-lock-path in all locations ([#40](https://github.com/canonical/identity-credentials-workflows/issues/40)) ([803589a](https://github.com/canonical/identity-credentials-workflows/commit/803589af2ef8a638de1056a62b2b11caf0b2d049))

## [0.1.0](https://github.com/canonical/identity-credentials-workflows/compare/v0.0.3...v0.1.0) (2025-09-30)


### Features

* Add default Renovate configuration for reuse ([#26](https://github.com/canonical/identity-credentials-workflows/issues/26)) ([dd9fb1a](https://github.com/canonical/identity-credentials-workflows/commit/dd9fb1a0f17e76d2b81c95f341c369f4a7f07066))
* add multiarch rock build and publishing ([#16](https://github.com/canonical/identity-credentials-workflows/issues/16)) ([3a30982](https://github.com/canonical/identity-credentials-workflows/commit/3a30982a2c90e9a4ae087f1f026a006152f4f3bf))
* Add option to fetch latest charm libraries in TICS workflow ([#34](https://github.com/canonical/identity-credentials-workflows/issues/34)) ([0657295](https://github.com/canonical/identity-credentials-workflows/commit/06572957bd588e670f41e666b2b8bd0ae50c407f))
* Add uv-scan workflow to scan uv dependencies ([#29](https://github.com/canonical/identity-credentials-workflows/issues/29)) ([844c890](https://github.com/canonical/identity-credentials-workflows/commit/844c8903006c2af7afb830ed680e33cdd372cefe))
* Allow uv lock file location to be configured ([#39](https://github.com/canonical/identity-credentials-workflows/issues/39)) ([e34696c](https://github.com/canonical/identity-credentials-workflows/commit/e34696c96ac68881fefb1a43295b596ac0221add))
* Enable using charmcraftcache ([#36](https://github.com/canonical/identity-credentials-workflows/issues/36)) ([4b6d0c6](https://github.com/canonical/identity-credentials-workflows/commit/4b6d0c67068b6fd3b10f2bc0f3c6c057bb3aeff2))
* Workflow to detect known vulnerabilities ([#21](https://github.com/canonical/identity-credentials-workflows/issues/21)) ([9401f83](https://github.com/canonical/identity-credentials-workflows/commit/9401f83e95f61df11b3024d3511e5a2eccb44b23))


### Bug Fixes

* download the charm to the provided path ([#24](https://github.com/canonical/identity-credentials-workflows/issues/24)) ([fe83d06](https://github.com/canonical/identity-credentials-workflows/commit/fe83d06c3f57ff690feb35a3a96baa989ab4d740))
* Fix renovate usage documentation in README ([#28](https://github.com/canonical/identity-credentials-workflows/issues/28)) ([1c88a9a](https://github.com/canonical/identity-credentials-workflows/commit/1c88a9a3902d57dbfb47acd5f02bf5a9459d54a5))
* Provide the checkout ref as an input ([#23](https://github.com/canonical/identity-credentials-workflows/issues/23)) ([ebfc11e](https://github.com/canonical/identity-credentials-workflows/commit/ebfc11ef8d7f1011528abccc0814d46a26877e8b))
* Use the workflow ref, not the caller ref ([#22](https://github.com/canonical/identity-credentials-workflows/issues/22)) ([bd4a7d9](https://github.com/canonical/identity-credentials-workflows/commit/bd4a7d93c1484bb23ac4c1bfa16f0f2ef67363ea))
* use uv-lock-path in all locations ([#40](https://github.com/canonical/identity-credentials-workflows/issues/40)) ([803589a](https://github.com/canonical/identity-credentials-workflows/commit/803589af2ef8a638de1056a62b2b11caf0b2d049))
