#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

SHELL = /bin/sh

test_coverage:
	rm -rf coverage-ci
	mkdir ./coverage-ci
	go test -v -race -cover -tags=debug -coverpkg=./... -failfast -coverprofile=./coverage-ci/pipeline_jobs.out -covermode=atomic ./plugins/v2/jobs/pipeline
	echo 'mode: atomic' > ./coverage-ci/summary.txt
	tail -q -n +2 ./coverage-ci/*.out >> ./coverage-ci/summary.txt

test: ## Run application tests
	go test -v -race -tags=debug ./plugins/v2/jobs/pipeline

generate-proto:
	protoc -I./api/proto/jobs/v1beta --go_out=./api/proto/jobs/v1beta jobs.proto
	protoc -I./api/proto/kv/v1beta --go_out=./api/proto/kv/v1beta kv.proto
	protoc -I./api/proto/websockets/v1beta --go_out=./api/proto/websockets/v1beta websockets.proto
	protoc -I./api/proto/cache/v1beta --go_out=./api/proto/cache/v1beta response.proto