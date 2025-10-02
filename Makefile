all: compile

compile:
	@zig build

compile-release:
	@zig build -Drelease-safe

example:
	@zig build run_$(file)

generate-docs:
	@zig build docs

server-docs:
	@python3 -m http.server 8080 -d zig-out/docs/

unit-tests:
	@zig build unit-tests

integration-tests:
	@zig build integration-tests

bench-tests:
	@zig build bench-tests

clean:
	@rm -rf zig-out

clean-all:
	@rm -rf .zig-cache
	@rm -rf zig-out
