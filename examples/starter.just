# This file imports the justfile from the identity-credentials-workflows repository, which contains the necessary tasks.
import? "https://raw.githubusercontent.com/canonical/identity-credentials-workflows/refs/tags/v2.0.1/justfile"

# Modifying the build command will
build:
    # move the built frontend to the correct location

    # call the build task
    just build-go
