#!/usr/bin/env bash
# IBAN Validation API – cURL example
# Usage: VEILLE_API_KEY=your-key bash vat_iban.sh
set -euo pipefail

curl -sS -G "https://api.veille.io/v1/vat/iban" \
  -H "x-api-key: ${VEILLE_API_KEY}" \
  --data-urlencode query=YOUR_VALUE
