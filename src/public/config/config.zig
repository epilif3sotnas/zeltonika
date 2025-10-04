// internal
const ConfigLogging = @import("logging.zig").ConfigLogging;
const ConfigParallel = @import("parallel.zig").ConfigParallel;
const ConfigAvlData = @import("avl_data.zig").ConfigAvlData;
const ConfigIoConn = @import("io/io.zig").ConfigIoConn;


/// Configurations related with the Zeltonika library.
/// All the configurations required for the library to function properly
/// are defined in this struct.
pub const ZeltonikaConfig = struct {

    /// Logging configuration.
    pub const logging: *const ConfigLogging = .{};

    /// Parallelism and concurrency configuration.
    pub const parallel: *const ConfigParallel = .{};

    /// AVL data configuration.
    pub const avl_data: *const ConfigAvlData = .{};

    /// IO connection configuration.
    pub const io_conn: *const ConfigIoConn = .{};
};
