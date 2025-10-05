// std
const std = @import("std");

// external
const zbench = @import("zbench");


// fn factorial(comptime T: type, n: T) T {
//     var res: T = @as(T, 1);
//     var i: T = @as(T, 2);
//     while (i <= n) : (i += 1) res *= i;
//     return res;
// }

// fn factorialRecursive(comptime T: type, n: T) T {
//     if (n < 2 and n > 0) return 1 else return n * factorial(T, n - 1);
// }

// pub fn factorialComptime(comptime T: type, n: T) T {
//     comptime var i = @as(T, 0);
//     inline while (i < 12) : (i += 1) if (i == n) return comptime factorial(T, i);
//     return 1;
// }


fn myBenchmark(allocator: std.mem.Allocator) void {
    for (0..1000) |_| {
        const buf = allocator.alloc(u8, 512) catch @panic("Out of memory");
        defer allocator.free(buf);
    }
}


test "bench test" {
    const  writer = std.io.getStdOut().writer();

    var bench = zbench.Benchmark.init(std.testing.allocator, .{});
    defer bench.deinit();

    // try bench.add("factorial", factorial, .{});
    // try bench.add("factorialRecursive", factorialRecursive, .{});
    // try bench.add("factorialComptime", factorialComptime, .{});
    try bench.add("myBenchmark", myBenchmark, .{});

    try writer.writeAll("\n");
    try bench.run(writer);
}
