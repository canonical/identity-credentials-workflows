# Changelog

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
