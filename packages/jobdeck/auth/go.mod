module github.com/air-hand-org/api-contracts/packages/jobdeck/auth/v2

go 1.26.4

retract (
	v2.0.0 // Published with an invalid v2 module path.
	v2.0.1 // Retraction-only release; continue using the v1 module.
)

require (
	buf.build/gen/go/bufbuild/protovalidate/protocolbuffers/go v1.36.11-20260415201107-50325440f8f2.1
	connectrpc.com/connect v1.20.0
	github.com/gorilla/mux v1.8.1
	google.golang.org/grpc v1.81.1
	google.golang.org/protobuf v1.36.11
)

require (
	go.opentelemetry.io/otel v1.45.0 // indirect
	go.opentelemetry.io/otel/sdk/metric v1.45.0 // indirect
	golang.org/x/net v0.57.0 // indirect
	golang.org/x/sys v0.47.0 // indirect
	golang.org/x/text v0.40.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260226221140-a57be14db171 // indirect
)
