.PHONY: gen
gen:
	@protoc -I proto \
		--go_out proto/gen \
		--go_opt paths=source_relative \
		--go-grpc_out proto/gen \
		--go-grpc_opt paths=source_relative \
		proto/helloworld.proto

.PHONY: docker-build
docker-build:
	@docker build -t helloworld .

.PHONY: docker-run
docker-run:
	@docker run --rm -p 50051:50051 helloworld

.PHONY: grpcurl-local
grpcurl-local:
	@grpcurl \
  -plaintext \
  -import-path proto \
  -proto helloworld.proto \
  localhost:50051 helloworld.Greeter/SayHello

.PHONY: grpcurl-aws
grpcurl-aws:
	@grpcurl \
  -import-path proto \
  -proto helloworld.proto \
  test.cm-arai.com:443 helloworld.Greeter/SayHello
