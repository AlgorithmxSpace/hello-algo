const std = @import("std");
const abc = @import("../abc.zig");

pub fn say() void {
    std.debug.print("hello\n", .{});
}

test "1111" {
    abc.newabc();
}
