# identity-credentials-workflows

This repository is the single source of truth for all development workflows and configurations for the identity TLS team. This includes GitHub Actions workflows, Renovate configuration, and any other development related configurations.

## Repos

A list of all Identity (TLS) repositories can be found under the `identity-team` [topic](https://github.com/search?q=org%3Acanonical%20topic%3Aidentity-team&type=repositories) on GitHub.

## GitHub Actions Workflows

The workflows for continuous integration are designed to adapt to any of our projects' structures in an opinionated way, whether that's as monorepos or demo repos. Tools and configuration will be picked up from the project itself to avoid any CI drift.

Workflows with a `__` prefix are workflows for this repository. They are not intended to be used in other repositories.

Workflows with a `_` prefix are private workflows that are used by the public workflows.

Workflows without a prefix are public workflows that are intended to be used in other repositories.

All workflows use just.systems, and expect a justfile to be present in the repository. The justfile should have the appropriate commands defined for the workflows to use. For example, if the repository is a binary repository, the justfile should have the `code-health`, `test unit`, `build`, `test integration` and `release project` commands defined.

All workflows will install the necessary tools in the setup step, and will not assume that any tools are pre-installed.

* for python, the codespell, ruff and pyright tools are supported. pyproject.toml will be used for configuration. uv will be used to run the checks.
* for go, golangci-lint will be used. .golangci.yaml will be used for the configuration.
* for typescript, the "ci" script in the package.json will be used. bun will be used to run the script.
* for binaries, `just run code-health` will be used. It must be defined in the justfile.
* for snapcraft.yaml, snapcraft lint will be used.
* for rockcraft.yaml, rockcraft expand-extensions will be used. This will can catch any issues with the rockcraft.yaml file without building the rock.
* for charmcraft.yaml, there is currently no linting tool in the charmcraft binary. Python linting process will apply.

There are 6 steps in the CI workflow:

### Code Health

The code health workflow is designed to do linting, formatting and other types of static analysis on the code.

* for python, the codespell, ruff and pyright tools are supported. pyproject.toml will be used for configuration. uv will be used to run the checks.
* for go, golangci-lint will be used. .golangci.yaml will be used for the configuration.
* for typescript, the "ci" script in the package.json will be used. bun will be used to run the script.
* for binaries, `just run code-health` will be used. It must be defined in the justfile.
* for snapcraft.yaml, snapcraft lint will be used.
* for rockcraft.yaml, rockcraft expand-extensions will be used. This will can catch any issues with the rockcraft.yaml file without building the rock.
* for charmcraft.yaml, there is currently no linting tool in the charmcraft binary. Python linting process will apply.

### Security Scan

The security scan workflow is designed to run security scanning on the code. The tools used for security scanning do not depend on the code itself at all, and are externally configured. For all types of projects, enabling or disabling the security scan must be explicit by defining "enabled: false" in the workflow configuration.

### Unit Test

The unit test workflow is designed to run the unit tests for the project. 

* for binaries, `just test unit` will be used. It must be defined in the justfile.
* for snapcraft.yaml, no unit tests will run by default since there is no "code". An override allows a command to be run in this step.
* for rockcraft.yaml, no unit tests will run by default since there is no "code". An override allows a command to be run in this step.
* for charmcraft.yaml, no unit tests will run by default since there is no "code". Python unit test process will apply.

### Build 

The build workflow is designed to build the project. This is the build that will be released.

* for binaries, `just build` will be used. It must be defined in the justfile.
* for snapcraft.yaml, snapcraft pack will be used.
* for rockcraft.yaml, rockcraft pack will be used.
* for charmcraft.yaml, charmcraft pack will be used.

all build artifacts will be stored with the name {{project_name}}-{{arch}}-{{type}}.{{filetype}} where type is one of "binary", "snap", "rock" or "charm" depending on the type of project.

### Integration Test

The integration test workflow is designed to run the integration tests for the project. It is the only step that depends on the build step.

* for binaries, `just test integration` will be used. It must be defined in the justfile.
* for snapcraft.yaml, the run commands in the apps will be tested to see if they respond without error.
* for rockcraft.yaml, the rock will be deployed in a container and the server will be tested.
* for charmcraft.yaml, `tox -e integration` will be used to run the package integration tests.

### Release

The release workflow is designed to run in the main repository. It should be the only running workflow in release branches. It expects the appropriate secrets to be available in the repository to be able to release the project.

* for binaries, `just release project` will be used. It must be defined in the justfile.
* for snapcraft.yaml, the packed snap will be released to the configured track.
* for rockcraft.yaml, the packed rock will be released to the configured track.
* for charmcraft.yaml, the packed charm will be released to the configured track.

### Promote

This workflow is special, and is designed to only be run manually. It will receive a choice of *craft.yaml file, the track, and the risk that will be promoted. It will promote the latest released build to the specified track and risk. The chosen track and risk will be promoted to the risk above it, following edge -> beta -> candidate -> stable. This workflow is designed to be used in all repositories, but it will only run when manually triggered.
GitHub workflows for the Identity (Credentials) team.

## Usage

Downstream repositories should reference workflows using release tags
(e.g. `@v1.3.1`) or `@main` for bleeding-edge features.

Build workflows are invoked **once per architecture**. The caller specifies
`arch` and `runner` explicitly:

```yaml
jobs:
  build-amd64:
    uses: canonical/identity-credentials-workflows/.github/workflows/charm-build.yaml@main
    with:
      arch: amd64
      runner: '"ubuntu-24.04"'
      path: k8s
      artifact-suffix: k8s

  build-arm64:
    uses: canonical/identity-credentials-workflows/.github/workflows/charm-build.yaml@main
    with:
      arch: arm64
      runner: '["self-hosted", "linux", "ARM64", "medium", "noble"]'
      path: k8s
      artifact-suffix: k8s

  publish:
    needs: [build-amd64, build-arm64]
    uses: canonical/identity-credentials-workflows/.github/workflows/charm-publish.yaml@main
    with:
      artifacts-key: ${{ github.sha }}-build-k8s-*
      path: k8s
    secrets:
      CHARMCRAFT_AUTH: ${{ secrets.CHARMCRAFT_AUTH }}
```

## Supported workflow types

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

## Renovate base configuration

This repository contains a base Renovate configuration. To use it in other
projects, create a `renovate.json5` file with the following content:

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "https://raw.githubusercontent.com/canonical/identity-credentials-workflows/refs/heads/main/renovate.json5"
  ]
}
```

## Repos

A list of all Identity (Credentials) repositories can be found under the
`identity-team` [topic](https://github.com/search?q=org%3Acanonical%20topic%3Aidentity-team&type=repositories) on GitHub.

## Inputs

While the workflows don't appear to have any inputs or outputs, the justfile and any automation does. Here are the list of environment variables that exist in the workflows that can be passed to the job:

| Name | Description | Required |
| --- | --- | --- |
| `arch` | The architecture that the workflow is running for. This is used to determine the runner that will be used, and the name of the artifact that will be produced. | Yes |
| `runner` | The runner that will be used to run the workflow. This should be a valid GitHub runner label. | Yes |
| `path` | The path to the project that the workflow will run on. This is used to determine where the justfile is located, and where the code is located. | Yes |
| `artifact-suffix` | The suffix that will be added to the artifact name. This is used to differentiate between different builds of the same project. | No |
| `artifacts-key` | The key that will be used to upload the artifacts to the workflow. This is used to determine which artifacts to upload, and which artifacts to download in the publish workflow. | Yes |

## Using the justfile

you can override the exact steps you need to override in the justfile, and call the original steps via the module prefix. For example, if you want to override the build step, you can do the following:

# your justfile
mod parent "parent.justfile"

# Override with your own
build:
    echo "child build"

# Call original via module prefix
build-with-parent:
    just parent::build
    just build

# Pattern for env vars

<LANGUAGE>_<STEP>_<ARCH>

Where:
- `<LANGUAGE>` is the language of the project (e.g. PYTHON, GO, TYPESCRIPT, BINARY, SNAP, ROCK, CHARM)
- `<STEP>` is the step of the workflow (e.g. CODE_HEALTH, SECURITY_SCAN, UNIT_TEST, BUILD, INTEGRATION_TEST, RELEASE)

# Runners

You can pick your selection of runners from https://documentation.ubuntu.com/self-hosted-runners/en/latest/usage/available_runners/

# Overrides

If you want to override any script, you can do so by creating an overrides.just file that has the same build script as the original justfile. The preparation script will automatically import this file and merge it with the original justfile, so as long as the file is defined you don't have to do anything extra in the action.
