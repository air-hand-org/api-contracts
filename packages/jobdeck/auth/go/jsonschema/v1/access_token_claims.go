// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    accessTokenClaims, err := UnmarshalAccessTokenClaims(bytes)
//    bytes, err = accessTokenClaims.Marshal()

package jwtauthv1

import "encoding/json"

func UnmarshalAccessTokenClaims(data []byte) (AccessTokenClaims, error) {
	var r AccessTokenClaims
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *AccessTokenClaims) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

// Claims carried in access tokens issued by Jobdeck Auth. Signature, issuer, audience, and
// time validation are performed by the JWT verifier, not by JSON Schema validation.
type AccessTokenClaims struct {
	// Kind of authenticated actor: USER is a human account; SERVICE is a machine or service
	// account.
	ActorType                                                                                   ActorType `json:"actor_type"`
	// Intended recipients. It is always represented as a JSON array, including for one
	// audience. JWT consumers must require their own audience.
	Aud                                                                                         []string  `json:"aud"`
	// Expiry NumericDate: seconds since 1970-01-01T00:00:00Z. JWT consumers must reject expired
	// tokens.
	Exp                                                                                         int64     `json:"exp"`
	// Issued-at NumericDate: seconds since 1970-01-01T00:00:00Z.
	Iat                                                                                         int64     `json:"iat"`
	// Issuer identifier for Jobdeck Auth. JWT consumers must validate it.
	Iss                                                                                         Iss       `json:"iss"`
	// UUID of the authenticated actor.
	Sub                                                                                         string    `json:"sub"`
}

// Kind of authenticated actor: USER is a human account; SERVICE is a machine or service
// account.
type ActorType string

const (
	Service ActorType = "SERVICE"
	User    ActorType = "USER"
)

type Iss string

const (
	JobdeckAuth Iss = "jobdeck-auth"
)
