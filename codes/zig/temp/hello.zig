const std = @import("std");
const io = @import("../utils/utils.zig").io;

test "sum" {
    try std.testing.expect(1 == 1);

    var arr = [_]i32{0} ** 10;
    io.printArray(i32, arr[0..]);
}

pub fn main() void {
    std.debug.print("hello world\n", .{});
}
