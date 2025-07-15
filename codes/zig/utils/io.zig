const std = @import("std");

// 打印数组
pub fn printArray(comptime T: type, arr: []T) void {
    if (arr.len == 0) {
        std.debug.print("[]", .{});
        return;
    }
    std.debug.print("[", .{});
    for (arr) |value| {
        std.debug.print("{any}", .{value});
    }
    // for (arr) |item| {
    //     std.debug.print("{}", .{item});
    // }
    std.debug.print("]", .{});
}

pub fn say() void {
    std.debug.print("say hello \n", .{});
}
