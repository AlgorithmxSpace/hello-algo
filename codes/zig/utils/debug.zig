const std = @import("std");
const ListNode = @import("ListNode.zig").ListNode;

// 打印数组
pub fn printArray(comptime T: type, arr: []const T) void {
    std.debug.print("[", .{});
    if (arr.len > 0) {
        std.debug.print("[", .{});
        for (arr, 0..) |item, i| {
            std.debug.print("{}{s}", .{ item, if (i == arr.len - 1) "]" else ", " });
        }
    } else {
        std.debug.print("]", .{});
    }
    std.debug.print("\n", .{});
}

// 打印列表
pub fn printList(comptime T: type, list: std.ArrayList(T)) void {
    std.debug.print("[", .{});
    if (list.items.len > 0) {
        for (list.items, 0..) |item, i| {
            std.debug.print("{}{s}", .{ item, if (i == list.items.len - 1) "]" else ", " });
        }
    } else {
        std.debug.print("]", .{});
    }
    std.debug.print("\n", .{});
}

// 打印链表
pub fn printLinkedList(comptime T: type, node: *const ListNode(T)) void {
    std.debug.print("{}", .{node.val});
    if (node.next) |next_node| {
        std.debug.print("->", .{});
        printLinkedList(T, next_node); // 采用递归
    } else {
        std.debug.print("\n", .{});
    }
}
