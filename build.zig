// std
const std = @import("std");


const BuildOptions = struct {
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
};

const ConfigProperties = struct {
    name: []const u8,
    root_source_file: ?std.Build.LazyPath,
    dependencies: []const []const u8,
    description: []const u8,
};

const ProjectProperties = struct {
    module: ConfigProperties,
    unit_tests: ConfigProperties,
    integration_tests: ConfigProperties,
    bench: ConfigProperties,
    docs: ConfigProperties,
};


fn buildOptions(b: *std.Build) BuildOptions {
    return .{
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    };
}

fn projectProperties(b: *std.Build) ProjectProperties {
    return .{
        .module = .{
            .name = "zeltonika",
            .root_source_file = b.path("src/zeltonika.zig"),
            .dependencies = &[_][]const u8{},
            .description = "Zeltonika is a library whose main goal is handling the data of the Teltonika trackers.",
        },

        .unit_tests = .{
            .name = "unit-tests",
            .root_source_file = b.path("src/unit_tests.zig"),
            .dependencies = &[_][]const u8{},
            .description = "Zeltonika unit tests.",
        },

        .integration_tests = .{
            .name = "integration-tests",
            .root_source_file = b.path("src/integration_tests.zig"),
            .dependencies = &[_][]const u8{},
            .description = "Zeltonika integration tests.",
        },

        .bench = .{
            .name = "bench-tests",
            .root_source_file = b.path("src/bench_tests.zig"),
            .dependencies = &[_][]const u8{ "zbench" },
            .description = "Zeltonika benchmark tests.",
        },

        .docs = .{
            .name = "docs",
            .root_source_file = b.path("docs/docs.zig"),
            .dependencies = &[_][]const u8{},
            .description = "Zeltonika documentation.",
        },
    };
}

pub fn build(b: *std.Build) void {
    const build_options = buildOptions(b);
    const project_properties = projectProperties(b);

    const mod = createModule(b, build_options, project_properties.module);
    const lib = createLibrary(b, mod, project_properties.module);
    const docs = createDocs(b, lib);
    const unit_tests = createTest(b, project_properties.unit_tests);
    const integration_tests = createTest(b, project_properties.integration_tests);
    const bench = createTest(b, project_properties.bench);

    addDependencies(b, mod, project_properties.module);
    addDependenciesTests(b, unit_tests, project_properties.unit_tests);
    addDependenciesTests(b, integration_tests, project_properties.integration_tests);
    addDependenciesTests(b, bench, project_properties.bench);

    addRunCmdDocs(b, lib, docs, project_properties.docs);
    addRunCmd(b, unit_tests, project_properties.unit_tests);
    addRunCmd(b, integration_tests, project_properties.integration_tests);
    addRunCmd(b, bench, project_properties.bench);

    addExample(b, "decode_tcp", project_properties.module, build_options, mod);
    addExample(b, "decode_udp", project_properties.module, build_options, mod);
    addExample(b, "encode_tcp", project_properties.module, build_options, mod);
    addExample(b, "encode_udp", project_properties.module, build_options, mod);
}

fn createModule(
    b: *std.Build,
    build_options: BuildOptions,
    config: ConfigProperties,
) *std.Build.Module {
    return b.addModule(config.name, .{
        .root_source_file = config.root_source_file,
        .target = build_options.target,
        .optimize = build_options.optimize,
    });
}

fn createExecutable(
    b: *std.Build,
    build_options: BuildOptions,
    config: ConfigProperties,
) *std.Build.Step.Compile {
    return b.addExecutable(.{
        .name = config.name,
        .root_source_file = config.root_source_file,
        .target = build_options.target,
        .optimize = build_options.optimize,
    });
}

fn createLibrary(
    b: *std.Build,
    mod: *std.Build.Module,
    config: ConfigProperties,
) *std.Build.Step.Compile {
    return b.addLibrary(.{
        .name = config.name,
        .root_module = mod,
    });
}

fn createDocs(
    b: *std.Build,
    lib: *std.Build.Step.Compile,
) *std.Build.Step.InstallDir {
    return b.addInstallDirectory(.{
        .source_dir = lib.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs",
    });
}

fn createTest(
    b: *std.Build,
    config: ConfigProperties,
) *std.Build.Step.Compile {
    return b.addTest(.{
        .name = config.name,
        .root_source_file = config.root_source_file,
    });
}

fn addDependencies(b: *std.Build, mod: *std.Build.Module, config: ConfigProperties) void {
    for (config.dependencies) |dep| {
        const dep_mod = b.dependency(dep, .{}).module(dep);
        mod.addImport(dep, dep_mod);
    }
}

fn addDependenciesTests(b: *std.Build, mod_test: *std.Build.Step.Compile, config: ConfigProperties) void {
    for (config.dependencies) |dep| {
        const dep_mod = b.dependency(dep, .{}).module(dep);
        mod_test.root_module.addImport(dep, dep_mod);
    }
}

fn addRunCmd(b: *std.Build, lib: *std.Build.Step.Compile, config: ConfigProperties) void {
    const artifact = b.addRunArtifact(lib);

    const step = b.step(config.name, config.description);
    step.dependOn(&artifact.step);
}

fn addRunCmdDocs(b: *std.Build, lib: *std.Build.Step.Compile, docs: *std.Build.Step.InstallDir, config: ConfigProperties) void {
    b.installArtifact(lib);

    const step = b.step(config.name, config.description);
    step.dependOn(&docs.step);
}

fn addExample(
    b: *std.Build,
    name: []const u8,
    config: ConfigProperties,
    build_options: BuildOptions,
    mod: *std.Build.Module,
) void {
    const tmp_config: ConfigProperties = .{
        .name = config.name,
        .root_source_file = b.path(b.fmt("examples/{s}.zig", .{name})),
        .description = config.description,
        .dependencies = config.dependencies,
    };
    const example = createExecutable(b, build_options, tmp_config);

    example.root_module.addImport(config.name, mod);

    const install_artifact = b.addInstallArtifact(example, .{});
    b.getInstallStep().dependOn(&install_artifact.step);

    const build_step = b.step(b.fmt("{s}", .{name}), b.fmt("Build Zeltonika example ({s})", .{name}));
    build_step.dependOn(&install_artifact.step);

    const run_artifact = b.addRunArtifact(example);
    run_artifact.step.dependOn(&install_artifact.step);

    const run_step = b.step(b.fmt("run_{s}", .{name}), b.fmt("Run Zeltonika example ({s})", .{name}));
    run_step.dependOn(&install_artifact.step);
    run_step.dependOn(&run_artifact.step);
}
