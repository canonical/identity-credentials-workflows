#!/usr/bin/env bash
set -e

repo="$1"

echoerr() { printf "%s\n" "$*" >&2; }

echoerr "Downloading known exploited vulnerabilities"
curl --fail -L https://www.cisa.gov/sites/default/files/feeds/known_exploited_vulnerabilities.json > known_exploited_vulnerabilities.json

echoerr "Downloading code scanning alerts from GitHub"
curl --fail -L -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/${repo}/code-scanning/alerts > alerts.json

# Get the CVEs from the current alerts
current_cves=$(jq -r '.[] | select(.state == "open") | .rule.id' alerts.json)
echoerr "Found $(wc -l <<<"$current_cves") CVEs currently open on repository"

# Get the list of KEV CVEs
kevs=$(jq -r '.vulnerabilities.[].cveID' known_exploited_vulnerabilities.json)
echoerr "Found $(wc -l <<<$kevs) KEV CVEs"

# Compare the lists of CVEs and output any common CVEs
common_cves=$(comm -12 <(sort <<< "$current_cves") <(sort <<< "$kevs"))
if [[ -z "$common_cves" ]]; then
  echoerr "No common CVEs found"
  exit 0
fi

echo "$common_cves"
exit 1
