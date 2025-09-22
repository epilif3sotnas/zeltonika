const std = @import("std");

pub fn build(b: *std.Build) void {
    const build_options = buildOptions(b);
    const project_properties = projectProperties(b);

    const lib = library(b, build_options, project_properties);
    dependencies(b, lib);

    const run_lib_unit_tests = testLibrary(b, build_options, project_properties);
    testRunCmd(b, run_lib_unit_tests);
}

const BuildOptions = struct {
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
};

fn buildOptions(b: *std.Build) BuildOptions {
    return BuildOptions {
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    };
}

const ProjectProperties = struct {
    name: []const u8,
    root_source_file: ?std.Build.LazyPath,
};

fn projectProperties(b: *std.Build) ProjectProperties {
    return ProjectProperties {
        .name = "zeltonika",
        .root_source_file = b.path("src/zeltonika.zig"),
    };
}

fn library(
    b: *std.Build,
    build_options: BuildOptions,
    project_properties: ProjectProperties,
) *std.Build.Step.Compile {
    return b.addModule(.{
        .name = project_properties.name,
        .root_source_file = project_properties.root_source_file,
        .target = build_options.target,
        .optimize = build_options.optimize,
    });
}

fn dependencies(b: *std.Build, lib: *std.Build.Step.Compile) void {
    // No Dependencies
    _ = b;
    _ = lib;

    // Example
    // const url = b.dependency("url", .{});
    // lib.addImport("url", url.module("url"));
}

fn testLibrary(
    b: *std.Build,
    build_options: BuildOptions,
    project_properties: ProjectProperties,
    root_module: *std.Build.Step.Compile,
) *std.Build.Step.Compile {
    return b.addTest(.{
        .root_module = root_module,
        .root_source_file = project_properties.root_source_file.?,
        .target = build_options.target,
        .optimize = build_options.optimize,
    });
}

fn testRunCmd(b: *std.Build, lib: *std.Build.Step.Compile) void {
    const run_lib_unit_tests = b.addRunArtifact(lib);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}