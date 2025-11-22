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
    logging: ConfigLogging = .{},

    /// Parallelism and concurrency configuration.
    parallel: ConfigParallel = .{},

    /// AVL data configuration.
    avl_data: ConfigAvlData = .{},

    /// IO connection configuration.
    io_conn: ConfigIoConn = .{},
};
