const std = @import("std");

// 打印数组
pub fn printArray(comptime T: type, arr: []T) void {
    if (arr.len == 0) {
        std.debug.print("[]", .{});
        return;
    }
    std.debug.print("[", .{});
    if (arr.len > 0) {
        for (arr, 0..) |num, j| {
            std.debug.print("{}{s}", .{ num, if (j == arr.len - 1) "]" else ", " });
        }
    } else {
        std.debug.print("]", .{});
    }
}
