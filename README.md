<p align="center">
  <a href="https://www.veille.io"><img src="images/banner.png" alt="IBAN Validation API by Veille" width="100%"></a>
</p>

# IBAN Validation API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Veille-Get%20an%20API%20key-111827)](https://app.veille.io/register) [![API docs](https://img.shields.io/badge/Docs-API%20reference-0EA5E9)](https://app.veille.io/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Veille IBAN Validation API** validates IBANs so payouts, direct debits and invoices use correct bank details.

- **IBAN Validation API** — Validate any IBAN and retrieve associated bank details.

Use it in payout flows, SEPA direct debit setup and supplier onboarding.

| Endpoint | Request | Credits |
|---|---|---|
| [IBAN Validation API](#iban-validation-api) | `GET /v1/vat/iban` | 1 |

## Table of contents

- [How it works](#how-it-works)
- [IBAN Validation API](#iban-validation-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Use cases](#use-cases)
- [Why Veille?](#why-veille)
- [FAQ](#faq)
- [Official SDKs](#official-sdks)
- [Related repositories](#related-repositories)
- [Support](#support)

## How it works

1. **Create a Veille account** and copy your API key from the [dashboard](https://app.veille.io/register).
2. **Call `https://api.veille.io`** with the header `x-api-key: YOUR_API_KEY`.
3. **Use the result** in your app — no infrastructure to run.

```bash
export VEILLE_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

## IBAN Validation API

Validate any IBAN and retrieve associated bank details. Returns the BIC/SWIFT code, bank name, country, BBAN structural breakdown, and SEPA zone membership.

`GET https://api.veille.io/v1/vat/iban` · **1 credit per request** · [API reference](https://app.veille.io/openapi)

### Request parameters

| Parameter | In | Type | Required | Description |
|---|---|---|---|---|
| `query` | query | string | ✅ | The IBAN to validate (e.g. FR7630006000011234567890189). |

### Python example

```python
import os

import requests

API_KEY = os.environ["VEILLE_API_KEY"]
HEADERS = {"x-api-key": API_KEY}

response = requests.get(
    "https://api.veille.io/v1/vat/iban",
    headers=HEADERS,
    params={
        "query": "FR7630006000011234567890189",
    },
    timeout=120,
)
response.raise_for_status()

data = response.json()
print(data)
```

### TypeScript example

```typescript
type IbanValidationApi = {
  bic?: string;
  bban?: string;
  iban?: string;
  valid?: boolean;
  bank_code?: string;
  bank_name?: string;
  branch_code?: string;
  country_code?: string;
  country_name?: string;
  in_sepa_zone?: boolean;
  account_number?: string;
  checksum_digits?: string;
};

const headers = { "x-api-key": process.env.VEILLE_API_KEY!, "Content-Type": "application/json" };

const params = new URLSearchParams({
  "query": "FR7630006000011234567890189",
});

const response = await fetch(`https://api.veille.io/v1/vat/iban?${params}`, { headers });
if (!response.ok) throw new Error(`HTTP ${response.status}: ${await response.text()}`);

const data = (await response.json()) as IbanValidationApi;
console.log(data);
```

### Output example

Example response from the API reference, abridged.

```json
{
  "bic": "AGRIFRPPXXX",
  "bban": "30006000011234567890189",
  "iban": "FR7630006000011234567890189",
  "valid": true,
  "bank_code": "30006",
  "bank_name": "CREDIT AGRICOLE SA",
  "branch_code": "00001",
  "country_code": "FR",
  "country_name": "France",
  "in_sepa_zone": true,
  "account_number": "12345678901",
  "checksum_digits": "76"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `bic` | string |  |
| `bban` | string |  |
| `iban` | string |  |
| `valid` | boolean |  |
| `bank_code` | string |  |
| `bank_name` | string |  |
| `branch_code` | string |  |
| `country_code` | string |  |
| `country_name` | string |  |
| `in_sepa_zone` | boolean |  |
| `account_number` | string |  |
| `checksum_digits` | string |  |

## Code examples in other languages

Ready-to-run examples live in [`examples/`](examples); each reads your key from `VEILLE_API_KEY`.

| Language | `vat-iban` |
|---|---|
| cURL (Bash) | [vat_iban.sh](examples/curl/vat_iban.sh) |
| PHP | [vat_iban.php](examples/php/vat_iban.php) |
| C# | [VatIban.cs](examples/csharp/VatIban.cs) |
| Go | [vat_iban.go](examples/go/vat_iban.go) |
| Java | [VatIbanExample.java](examples/java/VatIbanExample.java) |
| Ruby | [vat_iban.rb](examples/ruby/vat_iban.rb) |
| Node.js | [vat_iban.mjs](examples/nodejs/vat_iban.mjs) |

## Use cases

- **Payouts** — Avoid failed transfers caused by invalid IBANs.
- **Supplier onboarding** — Validate bank details as they are entered.

## Why Veille?

- **Stop fake sign-ups** — validate emails and domains before creating accounts.
- **Block abuse** — check IP reputation to stop bots and automated attacks.
- **Clean billing data** — validate VAT numbers and IBANs, get exchange rates.
- **Fast** — designed to run inline in sign-up and checkout flows.
- **Copy-paste examples** — Python and TypeScript in each README, 7 more languages in `examples/`.

## FAQ

### How do I authenticate?

Create an account on [Veille](https://app.veille.io/register), copy your API key and send it in the `x-api-key` header of every request to `https://api.veille.io`.

### How much does a request cost?

Credits per call: `/v1/vat/iban` **1**. See [Veille pricing](https://www.veille.io/pricing).

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Official SDKs

Use Veille from your own language with a typed client:

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@veilleio/sdk`](https://www.npmjs.com/package/@veilleio/sdk) | `npm install @veilleio/sdk` |
| Python | [`veille`](https://pypi.org/project/veille/) | `pip install veille` |
| Go | [`veille-go`](https://pkg.go.dev/github.com/veilleio/veille-go) | `go get github.com/veilleio/veille-go` |
| .NET | [`Veille`](https://www.nuget.org/packages/Veille) | `dotnet add package Veille` |
| Ruby | [`veille`](https://rubygems.org/gems/veille) | `gem install veille` |
| PHP | [`veille/sdk`](https://packagist.org/packages/veille/sdk) | `composer require veille/sdk` |
| Java | [`veille-java`](https://github.com/veilleio/veille-java) | build from source, see its README |
| CLI | [`@veilleio/cli`](https://www.npmjs.com/package/@veilleio/cli) | `npm install -g @veilleio/cli` |
| MCP server | [`@veilleio/mcp`](https://www.npmjs.com/package/@veilleio/mcp) | `npx -y @veilleio/mcp` |

## Related repositories

- [Email Validation API](https://github.com/veilleio/email-validation-api)
- [Email Qualification API](https://github.com/veilleio/email-qualification-api)
- [Domain Validation API](https://github.com/veilleio/domain-validation-api)
- [IP Reputation API](https://github.com/veilleio/ip-reputation-api)
- [VAT Validation API](https://github.com/veilleio/vat-validation-api)
- [Exchange Rates API](https://github.com/veilleio/exchange-rates-api)
- [All Veille repositories](https://github.com/veilleio)

## Support

- 💬 Join the [Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Read the [API reference](https://app.veille.io/openapi).
- 🔑 [Get your API key](https://app.veille.io/register).

---

<p align="center">
  <a href="https://www.veille.io">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Veille" height="28">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.veille.io">Veille</a>. Examples are released under the MIT license.</sub>
</p>
