# Jobdeck access-token JWT profile v1

`access-token-claims.schema.json` defines the payload claims issued by Jobdeck Auth.
`access-token-header.schema.json` defines its protected JOSE header. Both schemas use
JSON Schema draft 2020-12 and are versioned by directory.

JSON Schema defines the payload shape only. A JWT consumer must additionally verify
the EdDSA signature against the configured JWKS, require `iss` to be `jobdeck-auth`,
require its own audience in `aud`, and validate `iat` and `exp` with its clock.

`fixtures/verification-cases.json` describes fixed-clock verification cases. The
tokens are signed by the public key in `fixtures/jwks.json`; no private key is stored
in this repository. A verifier should select a JWKS key by `kid` before verifying the
signature, then enforce the expected result and failure reason in the case file.

The fixed validation time is deliberately 31 seconds after the expired token's `exp`.
With the declared 30-second leeway, that token must still be rejected.

Run `make jsonschema-generate` to regenerate the Go and C# models. The generator is
the pinned `quicktype` CLI. It accepts JSON Schema and supports many other targets;
for example, `mise exec -- quicktype --src-lang schema --lang typescript --top-level
AccessTokenClaims jsonschema/jobdeck/auth/v1/access-token-claims.schema.json` produces
a TypeScript model without changing this contract.

The C# claim and header models use separate namespaces because quicktype emits shared
JSON converter helper names for each generation unit.

Generated Go models live below `packages/jobdeck/auth/go/jsonschema`; C# models live in
`packages/jobdeck/auth/csharp/JSONSchema/Generated` so they are included by the Auth
`Contracts.csproj`. Both locations are separate from the directories cleaned by Buf.

Generation jobs, including their schema input, target language, and output path, are
declared in [`jsonschema/quicktype.config.json`](../../../quicktype.config.json).
