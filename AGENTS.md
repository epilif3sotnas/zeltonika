# Zeltonika Agent Guide

## Project overview

Zeltonika is an Apache-2.0 V library for encoding and decoding Teltonika tracker data. It supports Teltonika binary codecs and the Teltonika JSON codec, including TCP and UDP payloads. The root module is `zeltonika` (`v.mod`).

## Repository layout

- `zeltonika/public/api/` contains the public library API, including the `Zeltonika` facade and public data models.
- `zeltonika/internal/` contains codec parsing, transport framing, CRC, and utility implementation details. Keep these packages internal.
- `zeltonika/tests/helpers/` provides shared fixtures and real codec vectors.
- `zeltonika/tests/unit_tests/` and `zeltonika/tests/integration_tests/` contain automated V tests.
- `examples/` contains runnable TCP and UDP encoding/decoding programs. Its `v.mod` declares the library dependency used by the examples.
- `docs/` is reserved for project documentation. Generated API documentation is written to `tmp/docs/zeltonika/html/`.
- `Taskfile.yaml` is the source of truth for the supported development commands.

## Development workflow

- Follow `.editorconfig`: use UTF-8, LF endings, four-space indentation, no trailing whitespace, and a final newline for V and Markdown files.
- Keep the public API in `zeltonika/public/api/`; do not expose implementation details from `zeltonika/internal/` without an intentional API change.
- Preserve Teltonika protocol compatibility. Changes to encoding or decoding must cover the affected codec (`Codec8`, `Codec8E`, or `Codec16`) and transport (TCP or UDP).
- Put behavior tests in the relevant V test package. Tests use `test_` functions, `assert`, fixtures from `tests.helpers`, and `or { ... }` blocks to assert expected errors.
- Update examples or documentation when user-facing APIs or behavior change.
- Do not add a formatter, linter, or build step to documented workflows unless the repository configures one. No such command is currently configured.
- Never commit credentials or other secrets. Do not create Git commits or push branches; leave version-control publishing actions to the user.

## Commands

Run these from the repository root:

```bash
# Run the full test suite (preferred before handing off a behavior change)
task all-tests

# Run focused suites
task unit-tests
task integration-tests

# Run an example; defaults to encode_tcp
task example
task example file=decode_udp

# Generate and remove API documentation
task generate-docs
task clean-all
```

`task example` temporarily copies the local module into `~/.vmodules/zeltonika/` and removes that directory after execution. Avoid running it concurrently with work that uses that module path. `task server-docs` starts a persistent HTTP server on port 8080; run it manually when needed rather than as part of automated validation.

## Validation

- Run `task all-tests` for library behavior changes; use the focused test task while iterating when appropriate.
- The configured GitLab pipeline is currently a deliberately no-op placeholder, so passing CI does not replace local test execution.
- Run `task generate-docs` after public API documentation changes and use `task clean-all` to remove generated output when finished.

## Contributions

Follow [CONTRIBUTING.md](CONTRIBUTING.md): target `main`, keep a pull or merge request to at most two commits, ensure configured checks pass, add or update tests for changes, document new features, and explain the approach and alternatives considered.
