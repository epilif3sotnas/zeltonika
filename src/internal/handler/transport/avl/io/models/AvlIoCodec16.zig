// internal
const Generation = @import("../../../../../../public/avl_data/avl_data_array.zig").Generation;


pub const AvlIoCodec16 = @This();


event_io_id: u16,
generation_type: Generation,
number_of_total_io: u8,
