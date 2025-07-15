const std = @import("std");

pub fn printArray(comptime T: type, arr: []const T) void {
    if (arr.len == 0) {
        std.debug.print("[]", .{});
        return;
    }
    std.debug.print("[", .{});
    for (arr, 0..) |item, i| {
        std.debug.print("{}{s}", .{ item, if (i == arr.len - 1) "]" else ", " });
    }
    std.debug.print("\n", .{});
}
