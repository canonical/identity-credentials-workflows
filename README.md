# identity-credentials-workflows
GitHub workflows for the Identity (Credentials) team

## Renovate base configuration

This repository contains a base Renovate configuration. To use it in other
projects, create a `renovate.json5` file with the following content:

```json
{
    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
    "extends": ["https://raw.githubusercontent.com/canonical/identity-credentials-workflows/refs/heads/v0/renovate.json5"]
}
```
