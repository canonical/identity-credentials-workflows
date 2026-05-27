# identity-credentials-workflows

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
