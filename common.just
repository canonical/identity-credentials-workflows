working-directory := "."
set working-directory := working-directory

j := "just working-directory=" + quote(working-directory)

set allow-duplicate-recipes
set allow-duplicate-variables
set positional-arguments

# print list of available commands
[default]
help:
    just --list --unsorted

# =============================================================================
# Install Dependencies
# =============================================================================

# install and bootstrap dependencies
setup:
    #!/usr/bin/env bash
    @set -euo pipefail
    @echo "installing dependencies..."

    toolchains=(${TOOLCHAINS:-})
    for toolchain in "${toolchains[@]}"; do
        case "$toolchain" in
            go) {{ j }} setup-go ;;
            python) {{ j }} setup-python ;;
            typescript) {{ j }} setup-typescript ;;
            charmcraft) {{ j }} setup-charmcraft ;;
            snapcraft) {{ j }} setup-snapcraft ;;
            rockcraft) {{ j }} setup-rockcraft ;;
            juju-k8s) {{ j }} setup-juju-k8s ;;
            juju-machine) {{ j }} setup-juju-machine ;;
            *) echo "unknown toolchain: $toolchain" >&2; exit 1;;
        esac
    done

    sudo snap install yq
    extra_snaps=(${EXTRA_SNAPS:-})
    for snap in "${extra_snaps[@]}"; do
        sudo snap install "$snap" || true
    done

    if [ -n "${EXTRA_DEBS:-}" ]; then
        sudo apt-get update
        sudo apt-get install -y $EXTRA_DEBS
    fi

[private]
setup-go:
    #!/usr/bin/env bash
    set -euo pipefail

    go_version="${GO_VERSION:-}"
    if [ -z "$go_version" ] && [ -f "go.mod" ]; then
        go_version=$(grep -m1 '^go[[:space:]]' go.mod | awk '{print $2}' | cut -d. -f1,2)
        echo "Detected Go version from go.mod: $go_version"
    fi

    sudo snap install go --classic --channel="${go_version:-latest}/stable"
    go version

[private]
setup-typescript:
    #!/usr/bin/env bash
    set -euo pipefail
    sudo apt update
    sudo apt install -y unzip

    curl -fsSL https://bun.com/install | bash
    bun --version
    bun install

[private]
setup-python:
    #!/usr/bin/env bash
    set -euo pipefail
    sudo snap install astral-uv --classic

    python_version="${PYTHON_VERSION:-}"
    if [ -z "$python_version" ] && [ -f "pyproject.toml" ]; then
        python_version=$(grep 'requires-python' pyproject.toml | grep -oE '[0-9]+\.[0-9]+' | head -1)
        if [ -n "$python_version" ]; then
            echo "Detected Python version from pyproject.toml: $python_version"
        fi
    fi

    if [ -n "$python_version" ]; then
        uv python install "$python_version"
    else
        uv python install
    fi

[private]
setup-charmcraft:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install charmcraft --classic --channel=${CHARMCRAFT_CHANNEL:-latest}/stable
    charmcraft version

[private]
setup-snapcraft:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install snapcraft --classic --channel=${SNAPCRAFT_CHANNEL:-latest}/stable
    snapcraft version

[private]
setup-rockcraft:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install rockcraft --classic --channel=${ROCKCRAFT_CHANNEL:-latest}/stable
    rockcraft version

[private]
setup-juju-k8s:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install concierge --classic --channel=latest/stable
    args=("-p" "k8s")
    [ -n "${JUJU_CHANNEL:-}" ] && args+=(--juju-channel "${JUJU_CHANNEL}")
    [ -n "${K8S_CHANNEL:-}" ] && args+=(--k8s-channel "${K8S_CHANNEL}")
    sudo concierge prepare "${args[@]}"

[private]
setup-juju-machine:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install concierge --classic --channel=latest/stable
    args=("-p" "machine")
    [ -n "${JUJU_CHANNEL:-}" ] && args+=(--juju-channel "${JUJU_CHANNEL}")
    [ -n "${LXD_CHANNEL:-}" ] && args+=(--lxd-channel "${LXD_CHANNEL}")
    sudo concierge prepare "${args[@]}"

# =============================================================================
# Code Health
# =============================================================================

# run linters, formatters, and other code health tools
code-health:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "${GO_ENABLED:-false}" = "true" ] && {{ j }} code-health-go
    [ "${PYTHON_ENABLED:-false}" = "true" ] && {{ j }} code-health-python
    [ "${TYPESCRIPT_ENABLED:-false}" = "true" ] && {{ j }} code-health-typescript
    [ "${CHARMCRAFT_ENABLED:-false}" = "true" ] && {{ j }} lint-charmcraft
    [ "${SNAPCRAFT_ENABLED:-false}" = "true" ] && {{ j }} lint-snapcraft
    [ "${ROCKCRAFT_ENABLED:-false}" = "true" ] && {{ j }} lint-rockcraft
    [ "${GRAFANA_ENABLED:-false}" = "true" ] && {{ j }} lint-grafana

[private]
code-health-go: setup-go
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "linting Golang code..."

    go install github.com/golangci/golangci-lint/cmd/golangci-lint@v2.12.2
    go vet ./...
    golangci-lint run ./...

[private]
code-health-typescript: setup-typescript
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "linting TypeScript code..."

    bun run code-health

[private]
code-health-python: setup-python
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "linting Python code..."

    uv tool install tox --with tox-uv 2>/dev/null || true
    tox -e lint
    tox -e static
    tox -e format -- --check

[private]
lint-grafana: setup-go
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "linting Grafana dashboards..."

    go install github.com/grafana/dashboard-linter@v0.1.1
    dashboard-linter lint $GRAFANA_DASHBOARD_FILE_PATH --strict -c grafana.lint

[private]
lint-charmcraft: setup-charmcraft
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "linting charm..."

    charmcraft expand-extensions

[private]
lint-snapcraft: setup-snapcraft
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "linting snap..."

    snapcraft lint

[private]
lint-rockcraft: setup-rockcraft
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "linting rock..."

    rockcraft expand-extensions

# =============================================================================
# Unit Testing
# =============================================================================

# run unit tests
test-unit:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "${GO_ENABLED:-false}" = "true" ] && {{ j }} test-unit-go
    [ "${PYTHON_ENABLED:-false}" = "true" ] && {{ j }} test-unit-python
    [ "${TYPESCRIPT_ENABLED:-false}" = "true" ] && {{ j }} test-unit-typescript

[private]
test-unit-go: setup-go
    #!/usr/bin/env bash
    set -euo pipefail

    go test -v -cover ./...

[private]
test-unit-typescript: setup-typescript
    #!/usr/bin/env bash
    set -euo pipefail

    bun run test

[private]
test-unit-python:
    #!/usr/bin/env bash
    set -euo pipefail

    uv tool install tox --with tox-uv
    tox -e unit

# =============================================================================
# Security Scanning
# =============================================================================

# run security scanning tools and generate reports
security-scan:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "${GO_SCAN_ENABLED:-false}" = "true" ] && {{ j }} secscan-go
    [ "${KEV_SCAN_ENABLED:-false}" = "true" ] && {{ j }} secscan-identify-kevs

[private]
secscan-identify-kevs:
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "identifying known exploited vulnerabilities (KEVs)"

    {{ justfile_directory() }}/scripts/identify-kevs.sh "$GITHUB_REPOSITORY" > cves.txt
    {{ justfile_directory() }}/scripts/create-sarif.sh < cves.txt > cves.sarif
    {{ justfile_directory() }}/scripts/upload-sarif.sh cves.sarif "$GITHUB_REPOSITORY"

[private]
secscan-go: setup-go
    #!/usr/bin/env bash
    set -euo pipefail

    # Gosec Scan
    go install github.com/securego/gosec/v2/cmd/gosec@v2.27.1
    gosec ./...

    gosec -fmt sarif -out results.sarif ./...

    # Trivy Scan
    go install github.com/aquasecurity/trivy/cmd/trivy@v0.45.1
    trivy fs --scanners vuln,secret,misconfig .

# TODO: this should be outside,
# since it doesn't operate on the code or its artifacts
[private]
secscan-canonical:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install canonical-secscan-client
    sudo snap connect canonical-secscan-client:home system:home

    sudo snap install juju --channel=4.0/stable
    juju download <charm-name> --arch=<architecture> --channel=<channel> --filepath=charm-under-test.charm

    set +e
    secscan-client --batch submit --scanner trivy --type package --format charm charm-under-test.charm --wait-and-print | tee charm-secscan.txt
    @echo "secscan-return-code=$?"
    set -e

# =============================================================================
# Build
# =============================================================================

# build artifacts
build:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "${GO_ENABLED:-false}" = "true" ] && {{ j }} build-go
    [ "${PYTHON_ENABLED:-false}" = "true" ] && {{ j }} build-python
    [ "${TYPESCRIPT_ENABLED:-false}" = "true" ] && {{ j }} build-typescript
    [ "${CHARMCRAFT_ENABLED:-false}" = "true" ] && {{ j }} build-charm
    [ "${SNAPCRAFT_ENABLED:-false}" = "true" ] && {{ j }} build-snap
    [ "${ROCKCRAFT_ENABLED:-false}" = "true" ] && {{ j }} build-rock

[private]
build-python:
    #!/usr/bin/env bash
    set -euo pipefail

    uv build

[private]
build-typescript:
    #!/usr/bin/env bash
    set -euo pipefail

    bun run build

[private]
build-go:
    #!/usr/bin/env bash
    set -euo pipefail

    go build ./...

[private]
build-charm:
    #!/usr/bin/env bash
    set -euo pipefail

    charmcraft fetch-libs
    charmcraft build --verbose

[private]
build-snap:
    #!/usr/bin/env bash
    set -euo pipefail

    snapcraft pack --verbose

[private]
build-rock:
    #!/usr/bin/env bash
    set -euo pipefail

    rockcraft pack

# =============================================================================
# Integration Testing
# =============================================================================

# test built artifacts in a production-like environment
test-integration:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "${CHARM_ENABLED:-false}" = "true" ] && {{ j }} test-integration-charm
    [ "${SNAP_ENABLED:-false}" = "true" ] && {{ j }} test-integration-snap
    [ "${ROCK_ENABLED:-false}" = "true" ] && {{ j }} test-integration-rock

[private]
test-integration-charm:
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "running integration test for $CHARM_FILE_NAME"

    uv tool install tox --with tox-uv
    tox -e integration --charm_path "$CHARM_FILE_NAME"

[private]
test-integration-snap:
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "running integration test for $SNAP_FILE_NAME"

    sudo snap install --dangerous $SNAP_FILE_NAME
    if [ -n "${SNAP_SERVICE_NAME:-}" ]; then
        sudo snap start "$SNAP_SERVICE_NAME"
        sleep 10
        if [ -n "${SNAP_SERVICE_PORT:-}" ] && [ "$SNAP_SERVICE_PORT" != "0" ]; then
            if ss -tuln | grep ":${SNAP_SERVICE_PORT}"; then
                echo "service is listening on port ${SNAP_SERVICE_PORT}"
            else
                echo "service is NOT listening on port ${SNAP_SERVICE_PORT}"
                sudo snap remove --purge $SNAP_FILE_NAME
                exit 1
            fi
        fi
    fi

    which $SNAP_EXECUTABLE_NAME
    $SNAP_EXECUTABLE_NAME --help

[private]
test-integration-rock:
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "running integration test for $ROCK_FILE_NAME"

    sudo rockcraft.skopeo --insecure-policy copy \
        oci-archive:"$ROCK_FILE_NAME" \
        docker-daemon:"$ROCK_FILE_NAME:latest"
    docker run --rm -d --name rock-integration-test "$ROCK_FILE_NAME:latest"
    sleep 5

    if docker ps | grep rock-integration-test; then
        echo "rock container is running successfully"
    else
        echo "rock container failed to start"
        docker logs rock-integration-test
        exit 1
    fi

# =============================================================================
# Publishing
# =============================================================================

# publish built artifacts to their respective stores/registries
publish:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "${PUBLISH_CHARM:-false}" = "true" ] && {{ j }} publish-charm
    [ "${PUBLISH_SNAP:-false}" = "true" ] && {{ j }} publish-snap
    [ "${PUBLISH_ROCK:-false}" = "true" ] && {{ j }} publish-rock
    [ "${PUBLISH_PYTHON:-false}" = "true" ] && {{ j }} publish-python

# publish a charm to CharmHub
[private]
publish-charm:
    #!/usr/bin/env bash
    set -euo pipefail

    channel="${CHARM_CHANNEL:-latest}"
    channel="$channel/edge"
    echo "publishing charm(s) to channel: $channel"


    charm=$(ls *.charm 2>/dev/null | head -n 1)
    if [ -z "$charm" ]; then
        echo "::error::No charm file found to publish"
        exit 1
    fi

    charm_name=$(yq -r '.name' charmcraft.yaml)

    @echo "Uploading $charm"
    revision=$(charmcraft upload "$charm" --format json | yq -r '.revision')
    @echo "Releasing $charm_name revision $revision to $channel"
    charmcraft release "$charm_name" --revision "$revision" --channel "$channel"

# publish a snap to the Snap Store
[private]
publish-snap:
    #!/usr/bin/env bash
    set -euo pipefail

    release_channel="${SNAP_TRACK:-latest}/edge"

    snap=$(ls *.snap 2>/dev/null | head -n 1)
    if [ -z "$snap" ]; then
        echo "::error::No snap file found to publish"
        exit 1
    fi

    echo "Publishing $snap to $release_channel"
    snapcraft upload "$snap" --release "$release_channel"

# publish a rock to a container registry
[private]
publish-rock:
    #!/usr/bin/env bash
    set -euo pipefail

    image_name=$(yq -r '.name' rockcraft.yaml)
    version=$(yq -r '.version' rockcraft.yaml)
    prefix="ghcr.io/canonical/${image_name}"

    # Parse the JSON array of architectures, e.g. '["amd64", "arm64"]'.
    read -r -a ARCH_LIST <<< "${ROCK_ARCHITECTURES:-amd64}"

    for arch in "${ARCH_LIST[@]}"; do
        rock_file=$(ls *_"${arch}".rock 2>/dev/null | head -n 1)
        if [ -z "$rock_file" ]; then
            echo "::error::No rock file found for architecture: $arch"
            exit 1
        fi

        @echo "importing $rock_file as ${prefix}:${version}-${arch}"
        sudo rockcraft.skopeo --insecure-policy copy \
            oci-archive:"$rock_file" \
            docker-daemon:"${prefix}:${version}-${arch}"
        docker push "${prefix}:${version}-${arch}"
    done

    # Build and push a multi-arch manifest list pointing at the per-arch images.
    echo "Creating multi-arch manifest: ${prefix}:${version}"
    MANIFEST_ARGS=()
    for arch in "${ARCH_LIST[@]}"; do
        MANIFEST_ARGS+=("${prefix}:${version}-${arch}")
    done
    docker manifest create "${prefix}:${version}" "${MANIFEST_ARGS[@]}"
    docker manifest push "${prefix}:${version}"

    echo "creating latest manifest: ${prefix}:latest"
    docker manifest create "${prefix}:latest" "${MANIFEST_ARGS[@]}"
    docker manifest push "${prefix}:latest"

# publish a package to PyPI
[private]
publish-python:
    #!/usr/bin/env bash
    set -euo pipefail

    uv publish
