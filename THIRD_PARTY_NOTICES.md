# Third-party notices

The original api-contracts code is licensed under the MIT license in `LICENSE`.
Third-party material retains its own license; the MIT grant does not replace it.
The C# NuGet packages contain both MIT and Apache-2.0 material and declare
`MIT AND Apache-2.0`, not a choice of either license.

## Buf protovalidate

Copyright 2023-2026 Buf Technologies, Inc.

Licensed under the Apache License, Version 2.0. The original license text is
included at `licenses/bufbuild-protovalidate/LICENSE`, in both this repository
and each of the `Jobdeck.Auth.Contracts` and `Jobdeck.Job.Contracts` NuGet
packages.

Covered generated sources:

- `packages/jobdeck/auth/csharp/Generated/Buf/Validate/Validate.cs`
- `packages/jobdeck/job/csharp/Generated/Buf/Validate/Validate.cs`

These files represent the upstream `buf/validate/validate.proto`, including
its schema, embedded expressions and descriptor, as generated C# code. They
are compiled into the corresponding contract DLLs. They are not original
MIT-only api-contracts code.

Provenance:

- BSR module: `buf.build/bufbuild/protovalidate`
- BSR commit: `50325440f8f24053b047484a6bf60b76` (pinned in `buf.lock`)
- Corresponding upstream release: `bufbuild/protovalidate` `v1.2.0`
- Upstream Git commit: `db025da6a327e2860b48cee1d03911d7ad6f9578`
- Input: `proto/protovalidate/buf/validate/validate.proto` in that upstream commit
- Source repository: https://github.com/bufbuild/protovalidate

The files are mechanically generated with `buf.build/protocolbuffers/csharp:v36.0`
and the Buf managed options in `proto/jobdeck/{auth,job}/buf.gen.yaml`.
Generation changes the representation to C# and applies managed namespace/file
options; the checked-in C# files are not verbatim copies of the upstream proto.
Run `make buf-generate` to regenerate them; do not hand-edit generated files.

No upstream NOTICE file was present in the pinned BSR module or the corresponding
upstream Git revision. This document is api-contracts' own attribution statement,
not a purported copy of an upstream NOTICE.

## Package dependencies and other distributions

NuGet `PackageReference` dependencies remain separately identified packages
with their own license terms. This notice covers the Buf code actually included
in the contract assemblies; it is not an inventory of every runtime/package
that a downstream application might redistribute. Container images and other
redistributed artifacts must retain applicable notices for the additional
components they contain.
