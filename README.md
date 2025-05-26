# identity-credentials-workflows
GitHub workflows for the Identity (Credentials) team

## Renovate base configuration

This repository contains a base Renovate configuration. To use it in other
projects, create a `renovate.json5` file with the following content:

```json
{
    "extends": ["github>canonical/identity-credentials-workflows/renovate.json5#v0"]
}
```
