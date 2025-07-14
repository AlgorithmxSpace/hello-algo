const std = @import("std");

pub fn main() !void {
    std.debug.print("hello-algo\n", .{});
}

test {
    _ = @import("../chapter_array_and_linkedlist/array.zig");
}
