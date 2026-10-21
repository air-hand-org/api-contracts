# API contracts

Shared API definitions and generated client/server contract packages.

## Licensing

Original project code is licensed under MIT; see [LICENSE](LICENSE).
`make buf-generate` exports available LICENSE/NOTICE files for imported BSR
modules to each package's versioned `third_party/` directory. These files and
the project `LICENSE` are included in the C# NuGet packages (`MIT AND Apache-2.0`).

## Versioning

Go modules stay on the v1 release line; schema/API versions live in generated
package paths. Released package paths are retained within the same module major
and deprecated when superseded.

See [ADR 0001: Contract versioning](docs/adr/0001-contract-versioning.md) for the
versioning and compatibility policy, including the Conventional Commit PR title
requirements enforced by CI.
