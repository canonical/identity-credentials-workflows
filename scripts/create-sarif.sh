#!/usr/bin/env bash
# This script creates a SARIF file from the matched CVE IDs.
# CVEs should be supplied on stdin line by line.
#
# input:
#   A list of CVEs, one per line
# output:
#   A SARIF file containing the matched CVEs

set -e

matched_sarif=$(cat <<EOF
{
  "\$schema": "https://schemastore.azurewebsites.net/schemas/json/sarif-2.1.0-rtm.4.json",
  "version": "2.1.0",
  "runs": [
    {
      "tool": {
        "driver": {
          "name": "KEV Identifier Workflow",
          "rules": [ ]
        }
      },
      "results": [ ]
    }
  ]
}
EOF
)
# Add matched KEVs to the SARIF file
while read -r cve; do
matched_sarif=$(jq \
--arg cve "$cve" \
  '.runs[0].tool.driver.rules +=
    [{
      "id": $cve,
      "name": $cve,
      "shortDescription": {
        "text": "\( $cve ) matched with KEV"
      },
      "help": {
        "text": "\( $cve ) matches the CISA KEV catalog."
      },
      "properties": {
        "tags": [
          "kev"
        ],
        "security-severity": "7.0",
        "precision": "very-high"
      }
    }]
  | .runs[0].results +=
    [{
      "ruleId": $cve,
      "message": {
        "text": "\( $cve ): This CVE matches the CISA KEV catalog."
      },
      "locations": [
        {
          "physicalLocation": {
            "artifactLocation": {
              "uri": "repo",
              "properties": {
                "tags": [
                  "KEV"
                ]
              }
            }
          }
        }
      ]
    }]' \
<<< "$matched_sarif")
done

echo "$matched_sarif"
