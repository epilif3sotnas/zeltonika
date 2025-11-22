// internal
const Priority = @import("../../../../../../public/avl_data/avl_data_array.zig").Priority;
const GpsElement = @import("GpsElement.zig");


pub const AvlBinData = @This();


timestamp: u64,
priority: Priority,
gps_element: GpsElement,
