// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    executionRequested, err := UnmarshalExecutionRequested(bytes)
//    bytes, err = executionRequested.Marshal()

package jobv1

import "encoding/json"

func UnmarshalExecutionRequested(data []byte) (ExecutionRequested, error) {
	var r ExecutionRequested
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *ExecutionRequested) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

// Execution requested
type ExecutionRequested struct {
	// UUID of the requested execution.
	ExecutionID                        string `json:"execution_id"`
}
