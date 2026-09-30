# ADR 0001: Separate Go module versions from contract versions

Status: Accepted

## Context

This repository publishes generated API contract packages. Consumers need to
adopt new schema/API versions independently while existing imports remain usable.
Go module major versions and schema/API versions therefore serve different
purposes. Release Please derives releases from the squash-merged commit history.

## Decision

- Keep Go modules on the v1 release line with unsuffixed module paths, such as
  `github.com/air-hand-org/api-contracts/packages/jobdeck/auth`.
- Represent schema/API versions in generated package paths, such as
  `go/proto/v1` and `go/proto/v2`. Introducing a new contract version does not by
  itself require a new Go module major version. Add the new version alongside
  existing versions so consumers can migrate independently.
- Within the same Go module major, do not delete a generated package path once
  it has been released. Keep its published API compatible and retain the source
  definitions and generation configuration needed to reproduce it.
- When a released package or API is no longer recommended, preserve it and mark
  it deprecated. Where the source format supports it, use consumer-visible
  metadata, such as Protobuf `deprecated` options on the relevant declarations,
  and document the recommended replacement. Deprecation is not permission to
  remove the package within the same module major.
- Use Conventional Commit PR titles: `type: description` or
  `type(scope): description`. `fix` indicates a patch and `feat` indicates a
  minor release; other types such as `refactor`, `docs`, and `ci` describe their
  respective changes without declaring a major release.
- Do not use breaking-change markers (`feat!:`, `fix!:`, `type(scope)!:`,
  `BREAKING CHANGE:`, or `BREAKING-CHANGE:`) on the v1 release line. Preserve
  compatibility or introduce a new schema/API package version instead.

The repository uses squash merge. Keep the validated PR title as the squash
commit subject consumed by Release Please. CI checks the title on PR creation,
updates, reopening, and title edits. The title guard does not inspect the squash
commit body: reviewers must also ensure that the final merge message contains
no breaking-change footers or manual release overrides that contradict this
policy.

## Consequences

Consumers can keep using released imports while migrating to newer contract
versions. Deprecated packages and their generation inputs remain maintained
within the module major, increasing the compatibility surface we must preserve.

An intentional future Go module major bump requires revisiting this ADR and the
CI guard before proceeding, including the new module path, migration plan, and
compatibility boundary. It must not happen implicitly through a PR title.

## References

- [Go major version module paths](https://go.dev/doc/modules/major-version)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
