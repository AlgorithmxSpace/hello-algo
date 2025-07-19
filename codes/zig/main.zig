// File: chapter_tests.zig
// 数组和链表章节的统一测试文件

const std = @import("std");
const array = @import("chapter_array_and_linkedlist/array.zig");

test "hello algo" {
    try std.testing.expect(1 == 1);

    // 导入数组和链表章节的测试文件
    _ = @import("chapter_array_and_linkedlist/array.zig");
    // _ = @import("chapter_array_and_linkedlist/linked_list.zig");
    // _ = @import("chapter_array_and_linkedlist/list.zig");
    // _ = @import("chapter_array_and_linkedlist/my_list.zig");

    // 导入工具模块的测试
    _ = @import("utils/utils.zig");

    // 使用 std.testing.refAllDecls 自动运行所有测试
    std.testing.refAllDeclsRecursive(@This());
}
