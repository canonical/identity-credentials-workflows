# identity-credentials-workflows

This repository is the single source of truth for all development workflows and configurations for the identity TLS team. This includes GitHub Actions workflows, Renovate configuration, and any other development related configurations.

## Repos

A list of all Identity (TLS) repositories can be found under the `identity-team` [topic](https://github.com/search?q=org%3Acanonical%20topic%3Aidentity-team&type=repositories) on GitHub.

## GitHub Workflows

The workflows in the repositories are common processes we've adapted for our software development lifecycle.

Workflows with a `__` prefix are workflows for this repository. They are not intended to be used in other repositories.

Workflows with a `_` prefix are private workflows that are used by the public workflows.

Workflows without a prefix are public workflows that are intended to be used in other repositories.

### Supported workflow types

| Category     | Workflows                                                                                          | Description                                                |
| ------------ | -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **Charm CI** | `charm-build.yaml`, `charm-publish.yaml`, `charm-integration-test.yaml`                            | Multi-arch charm build, publish, and test                  |
| **Rock CI**  | `rock-build.yaml`, `rock-publish.yaml`, `rock-scan.yaml`                                           | Multi-arch rock build, publish, and scan                   |
| **Snap CI**  | `snap-build.yaml`, `snap-publish.yaml`, `snap-test.yaml`                                           | Multi-arch snap build, publish, and test                   |
| **Quality**  | `lint-report.yaml`, `static-analysis.yaml`, `unit-test.yaml`, `grafana-dashboard-lint-report.yaml` | Code quality checks                                        |
| **Security** | `secscan.yaml`, `uv-scan.yaml`                                                                     | Pre-publish security scanning                              |
| **Release**  | `release-please.yaml`                                                                              | Automated releases with mono-repo and track-branch support |

Build workflows take explicit `arch` and `runner` inputs — callers invoke
them once per target architecture. Publish workflows collect all built
artifacts using a glob pattern.

## GitHub Actions

The actions for continuous integration are designed to adapt to any of our projects' structures in an opinionated way. Tools and configuration will be picked up from the project itself to avoid any CI drift.

We use a common.just file from [just.systems](https://just.systems/) to keep all of our actions consistent in our repos. The actions will call predetermined just recipes for all repos. Overrides can be used to customize the actions for a specific repo.

 There are 6 main just recipes that our GitHub Actions call for CI tasks (plus `setup` for installing toolchains). They are:

### Code Health

The code health script is designed to do linting, formatting and other types of static analysis on the code. The only exclusions are security scanning tools because of their complex dependencies and configurations. The tools used should be defined in code, and the script should only use tools like `tox`, `bun` or other CLI based tools.

### Unit Test

The unit test script is designed to run the unit tests for the project. They should also be defined in code and invoked using a CLI based tool.

### Security Scan

The security scan script is designed to run security scanning on the code. Unlike code health tools, security scanning tools target specific vulnerabilities or problems in the repo that may or may not be independent from the code itself.

### Build 

The build script is designed to build the project. This is the build that will be staged for release.

all build artifacts should be stored with the name {{project_name}}-{{arch}}-{{type}}.{{filetype}}. The moving and renaming of the final artifacts for integration testing and release is left up to the workflow implementing the action.

### Integration Test

The integration test script is designed to run the integration tests for the project. It usually requires the built artifact to run as well as the use of a CLI tool. Any test that requires the built artifact should inherently be considered an integration test.

### Publish

Unlike the other actions, the publish script should not run in the PR, but after a merge to a main branch. It expects the appropriate secrets to be available in the repository to be able to release the project.

### Working with the justfile

You can override the exact steps you need to override in the justfile, and call the original steps via the module prefix. There is an example justfile in the `examples/` folder.

## Releases

We use release_please to do releases for all of our projects including this one. A basic configuration is defined in `release-please-config.json`.

## Renovate

Renovate is used to keep our dependencies up to date. Renovate is configured in `renovate.json5` and a shared configuration is defined in `identity-credentials-workflows` repo.
