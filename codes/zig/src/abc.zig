const std = @import("std");
const utils = @import("../utils/utils.zig");
const io = utils.io;

test "123" {
    try std.testing.expect(1 == 1);

    const arr = [_]i32{0} ** 10;
    io.printArray(i32, &arr);
}

pub fn newabc() void {
    std.debug.print("new ab\n", .{});
}
