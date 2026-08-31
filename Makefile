include ./mkfiles/*.mk

all: generate lint

generate: buf-generate

lint: buf-lint
