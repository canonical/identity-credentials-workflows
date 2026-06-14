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

    toolchains=($TOOLCHAINS)
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
            *) echo "unknown toolchain: $toolchain";;
        esac
    done

    sudo snap install yq
    extra_snaps=($EXTRA_SNAPS)
    if [ -z "${EXTRA_SNAPS+x}" ]; then
        for snap in "${extra_snaps[@]}"; do
            sudo snap install "$snap" || true
        done
    fi

    if [ -z "${EXTRA_DEBS+x}" ]; then
        sudo apt-get update
        sudo apt-get install -y $EXTRA_DEBS
    fi

[private]
setup-go:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install go --classic --channel=$GO_VERSION/stable
    go version

[private]
setup-typescript:
    #!/usr/bin/env bash
    set -euo pipefail
    sudo apt install unzip

    curl -fsSL https://bun.com/install | bash
    bun --version
    bun install

[private]
setup-python:
    #!/usr/bin/env bash
    set -euo pipefail
    sudo snap install astral-uv --classic

    uv python install

[private]
setup-charmcraft:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install charmcraft --classic --channel=$CHARMCRAFT_CHANNEL
    charmcraft version

[private]
setup-snapcraft:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install snapcraft --classic --channel=$SNAPCRAFT_CHANNEL
    snapcraft version

[private]
setup-rockcraft:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install rockcraft --classic --channel=$ROCKCRAFT_CHANNEL
    rockcraft version

[private]
setup-juju-k8s:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install concierge --classic --channel=latest/stable
    sudo concierge prepare -p k8s

[private]
setup-juju-machine:
    #!/usr/bin/env bash
    set -euo pipefail

    sudo snap install concierge --classic --channel=latest/stable
    sudo concierge prepare -p machine

# =============================================================================
# Code Health
# =============================================================================

# run linters, formatters, and other code health tools
code-health:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "$GO_ENABLED" = "true" ] && {{ j }} code-health-go
    [ "$PYTHON_ENABLED" = "true" ] && {{ j }} code-health-python
    [ "$TYPESCRIPT_ENABLED" = "true" ] && {{ j }} code-health-typescript
    [ "$CHARMCRAFT_ENABLED" = "true" ] && {{ j }} lint-charmcraft
    [ "$SNAPCRAFT_ENABLED" = "true" ] && {{ j }} lint-snapcraft
    [ "$ROCKCRAFT_ENABLED" = "true" ] && {{ j }} lint-rockcraft
    [ "$GRAFANA_ENABLED" = "true" ] && {{ j }} lint-grafana

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

    [ "$GO_ENABLED" = "true" ] && {{ j }} test-unit-go
    [ "$PYTHON_ENABLED" = "true" ] && {{ j }} test-unit-python
    [ "$TYPESCRIPT_ENABLED" = "true" ] && {{ j }} test-unit-typescript

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
secscan:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "$GO_SCAN_ENABLED" = "true" ] && {{ j }} secscan-go
    [ "$KEV_SCAN_ENABLED" = "true" ] && {{ j }} secscan-identify-kevs

[private]
secscan-identify-kevs:
    #!/usr/bin/env bash
    set -euo pipefail
    @echo "identifying known exploited vulnerabilities (KEVs)"

    ./scripts/identify-kevs.sh "$GITHUB_REPOSITORY" > cves.txt 2>/dev/null
    ./scripts/create-sarif.sh < cves.txt > cves.sarif 2>/dev/null
    ./scripts/upload-sarif.sh cves.sarif "$GITHUB_REPOSITORY" 2>/dev/null

[private]
secscan-go: setup-go
    #!/usr/bin/env bash
    set -euo pipefail

    # Gosec Scan
    go install github.com/securego/gosec/v2/cmd/gosec@2.27.1
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

    [ "$GO_ENABLED" = "true" ] && {{ j }} build-go
    [ "$PYTHON_ENABLED" = "true" ] && {{ j }} build-python
    [ "$TYPESCRIPT_ENABLED" = "true" ] && {{ j }} build-typescript
    [ "$CHARMCRAFT_ENABLED" = "true" ] && {{ j }} build-charm
    [ "$SNAPCRAFT_ENABLED" = "true" ] && {{ j }} build-snap
    [ "$ROCKCRAFT_ENABLED" = "true" ] && {{ j }} build-rock

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

    [ "$CHARM_ENABLED" = "true" ] && {{ j }} test-integration-charm
    [ "$SNAP_ENABLED" = "true" ] && {{ j }} test-integration-snap
    [ "$ROCK_ENABLED" = "true" ] && {{ j }} test-integration-rock

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

publish:
    #!/usr/bin/env bash
    set -euo pipefail

    [ "$PUBLISH_CHARM" = "true" ] && {{ j }} publish-charm
    [ "$PUBLISH_SNAP" = "true" ] && {{ j }} publish-snap
    [ "$PUBLISH_ROCK" = "true" ] && {{ j }} publish-rock
    [ "$PUBLISH_BIN" = "true" ] && {{ j }} publish-bin

# publish a charm to CharmHub
[private]
publish-charm:
    #!/usr/bin/env bash
    set -euo pipefail
    cd "path"

    CHANNEL="channel"
    if [ -n "branch-name" ]; then
        SANITIZED=$(echo "branch-name" | sed 's#[/_.]#-#g')
        CHANNEL="${CHANNEL}/${SANITIZED}"
    fi

    echo "Publishing charm to channel: ${CHANNEL}"
    echo "Charm paths: charm-paths"
    echo "Charm publishing is handled by canonical/charming-actions/upload-charm in the workflow"

# publish a snap to the Snap Store
[private]
publish-snap:
    #!/usr/bin/env bash
    set -euo pipefail
    RELEASE_CHANNEL="track }}/channel"
    echo "Publishing snap-file to ${RELEASE_CHANNEL}"
    snapcraft upload "snap-file" --release "${RELEASE_CHANNEL}"

# publish a rock to a container registry
[private]
publish-rock:
    #!/usr/bin/env bash
    set -euo pipefail

    IMAGE_NAME=$(yq -r '.name' rockcraft.yaml)
    VERSION=$(yq -r '.version' rockcraft.yaml)

    REPO="${GITHUB_REPOSITORY:-canonical/${IMAGE_NAME}}"
    PREFIX="registry/${REPO}/${IMAGE_NAME}"

    # Parse architectures
    mapfile -t ARCH_LIST < <(echo 'architectures' | jq -r '.[]')

    for arch in "${ARCH_LIST[@]}"; do
        rock_file=$(ls *_"${arch}".rock 2>/dev/null | head -n 1)
        if [ -z "$rock_file" ]; then
            echo "::error::No rock file found for architecture: $arch"
            exit 1
        fi

        echo "Importing $rock_file as ${PREFIX}:${VERSION}-${arch}"
        sudo rockcraft.skopeo --insecure-policy copy \
            oci-archive:"$rock_file" \
            docker-daemon:"${PREFIX}:${VERSION}-${arch}"
        docker push "${PREFIX}:${VERSION}-${arch}"
    done

    # Build manifest list
    echo "Creating multi-arch manifest: ${PREFIX}:${VERSION}"
    MANIFEST_ARGS=()
    for arch in "${ARCH_LIST[@]}"; do
        MANIFEST_ARGS+=("${PREFIX}:${VERSION}-${arch}")
    done
    docker manifest create "${PREFIX}:${VERSION}" "${MANIFEST_ARGS[@]}"
    docker manifest push "${PREFIX}:${VERSION}"

    if [ "tag-latest" = "true" ]; then
        echo "Creating latest manifest: ${PREFIX}:latest"
        docker manifest create "${PREFIX}:latest" "${MANIFEST_ARGS[@]}"
        docker manifest push "${PREFIX}:latest"
    fi

# publish a package to pypi
[private]
publish-python:
    #!/usr/bin/env bash
    set -euo pipefail

    uv build

# publish a binary to the configured store
[private]
publish-bin:
    #!/usr/bin/env bash
    set -euo pipefail

    cd "path"
    if [ -f "charmcraft.yaml" ]; then
        just publish-charm "path" "channel" "branch-name" "charm-paths"
    elif [ -f "snapcraft.yaml" ]; then
        snap_file="snap-file"
        if [ -z "$snap_file" ]; then
            snap_file=$(ls *.snap | head -n 1)
        fi
        just publish-snap "$snap_file" "track" " risk"
    elif [ -f "rockcraft.yaml" ]; then
        just publish-rock "path" "registry" "image-name" " version" ' architectures' " tag-latest"
    else
        echo "No recognized craft type found in path"
        exit 1
    fi

# =============================================================================
# TODO: Promote
# =============================================================================

promote:
    #!/usr/bin/env bash
    set -euo pipefail

    case "current-risk" in
        edge) TARGET_RISK="beta" ;;
        beta) TARGET_RISK="candidate" ;;
        candidate) TARGET_RISK="stable" ;;
        stable) echo "Already at stable, nothing to promote"; exit 1 ;;
        *) echo "Unknown risk level: current-risk"; exit 1 ;;
    esac

    echo "Promoting craft-name }} from track }}/ current-risk to  track/${TARGET_RISK}"

    case "craft-type" in
        charm)
            charmcraft release "craft-name }}" --channel=" track/${TARGET_RISK}"
            ;;
        snap)
            snapcraft promote "craft-name }}" --from-channel="track }}/ current-risk" --to-channel=" track/${TARGET_RISK}" --yes
            ;;
        rock)
            echo "Rock promotion requires re-tagging the container image"
            echo "This should be handled via the container registry"
            ;;
        *)
            echo "Unknown craft type: craft-type"
            exit 1
            ;;
    esac
