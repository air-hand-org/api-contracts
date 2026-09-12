# AsyncAPI contracts

This directory holds machine-readable descriptions of Jobdeck's asynchronous
service contracts. Each definition describes the interaction between services;
deployment-specific configuration stays with infrastructure code.

## Execution requests

[`jobdeck/job/v1/execution-request.yaml`](jobdeck/job/v1/execution-request.yaml)
describes the flow from `job-api` to `job-worker` through Google Cloud Pub/Sub.
The document is written in AsyncAPI 3.1.0 and is the source for generated
human-readable documentation. Its description includes the flow diagram in a
Mermaid code block; GitHub renders it in the generated Markdown document.

The payload schema remains Protocol Buffers. Its canonical definition is
[`ExecutionRequested`](../proto/jobdeck/job/v1/execution.proto), identified in
the AsyncAPI document as `jobdeck.job.v1.ExecutionRequested`.

AsyncAPI permits Protobuf payloads, but does not permit a `$ref` to one message
within a `.proto` file: the complete Protobuf schema would have to be embedded
as a string. We intentionally avoid that duplicate source of truth. The
`x-protobuf` extension retains the exact repository path, fully qualified type,
and binary encoding for readers and tooling that understand this convention.

## Local validation and HTML preview

Run the following from the repository root:

```sh
make asyncapi-check
make asyncapi-markdown
make asyncapi-html
```

The first command checks that the documented Protobuf source and message still
exist, then validates the AsyncAPI definition. The second generates the
Git-managed Markdown document at
[`docs/asyncapi/execution-request.md`](../docs/asyncapi/execution-request.md).
The third generates a static HTML preview in `artifacts/asyncapi/`; generated
HTML files are not committed.

The pinned AsyncAPI CLI runs as an official Docker image fixed by digest. The
HTML template is installed at its pinned version only inside the temporary
generation container. This keeps both npm dependency graphs out of the
development environment.

GitHub Pages is not used because private Pages requires GitHub Enterprise
Cloud. CI regenerates the Markdown document and rejects a change when it is out
of sync with the AsyncAPI definition.
