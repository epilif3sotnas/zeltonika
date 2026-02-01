all: compile

compile:
	@zig build

compile-release:
	@zig build -Drelease-safe

example:
	@zig build run_$(file)

generate-docs:
	@rm -rf tmp/docs/zeltonika/html/
	@v doc -m src/public/ -o tmp/docs/zeltonika/html/ -f html

server-docs:
	@python3 -m http.server 8080 -d tmp/docs/zeltonika/html/

unit-tests:
	@v test src/tests/unit_tests/

integration-tests:
	@v test src/tests/integration_tests/

bench-tests:
	@v test src/tests/bench/

clean-all:
	@rm -rf tmp/docs/zeltonika/
