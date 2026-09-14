// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    accessTokenHeader, err := UnmarshalAccessTokenHeader(bytes)
//    bytes, err = accessTokenHeader.Marshal()

package jwtauthv1

import "encoding/json"

func UnmarshalAccessTokenHeader(data []byte) (AccessTokenHeader, error) {
	var r AccessTokenHeader
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *AccessTokenHeader) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

// Protected JOSE header carried by Jobdeck access tokens.
type AccessTokenHeader struct {
	// Signature algorithm. Consumers must only accept EdDSA.
	Alg                                                                                     Alg    `json:"alg"`
	// Signing-key identifier used to select the matching public key from the JWKS document.
	Kid                                                                                     string `json:"kid"`
	// JOSE media type for a JSON Web Token.
	Typ                                                                                     Typ    `json:"typ"`
}

type Alg string

const (
	EdDSA Alg = "EdDSA"
)

type Typ string

const (
	Jwt Typ = "JWT"
)
