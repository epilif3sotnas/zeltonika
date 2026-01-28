module config


// ZeltonikaConfig Configurations related with the Zeltonika library.
// All the configurations required for the library to function properly
// are defined in this struct.
pub struct ZeltonikaConfig {
pub:
  // logging Logging configuration.
  logging     ConfigLogging

  // parallel Parallelism and concurrency configuration.
  parallel    ConfigParallel

  // avl_data AVL data configuration.
  avl_data    ConfigAvlData

  // io_conn IO connection configuration.
  io_conn     ConfigIoConn
}
