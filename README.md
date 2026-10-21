# API contracts

Shared API definitions and generated client/server contract packages.

## Licensing

Original project code is licensed under MIT; see [LICENSE](LICENSE).
The generated Buf validation code retains its Apache-2.0 terms; see
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for scope and provenance.
Both C# NuGet packages include these documents and the upstream Apache license
text, and declare `MIT AND Apache-2.0` for their combined contents.

## Versioning

Go modules stay on the v1 release line; schema/API versions live in generated
package paths. Released package paths are retained within the same module major
and deprecated when superseded.

See [ADR 0001: Contract versioning](docs/adr/0001-contract-versioning.md) for the
versioning and compatibility policy, including the Conventional Commit PR title
requirements enforced by CI.
