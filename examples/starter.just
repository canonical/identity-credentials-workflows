# This file imports the justfile from the identity-credentials-workflows repository, which contains the necessary tasks.
import? "https://raw.githubusercontent.com/canonical/identity-credentials-workflows/refs/tags/v3.0.0/common.just"

# You can make any task you would like to use
fun:
    pwd

# You can override the existing tasks from the imported justfile if you want to customize them for your project
build:
    echo "This is the build task for my project. You can add your build commands here."
