# API contracts

Shared API definitions and generated client/server contract packages for Jobdeck.

## Versioning

Go modules stay on the v1 release line; schema/API versions live in generated
package paths. Released package paths are retained within the same module major
and deprecated when superseded.

See [ADR 0001: Contract versioning](docs/adr/0001-contract-versioning.md) for the
versioning and compatibility policy, including the Conventional Commit PR title
requirements enforced by CI.
