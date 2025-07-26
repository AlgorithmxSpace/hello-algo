const std = @import("std");

const array = @import("chapter_array_and_linkedlist/array.zig");
const linked_list = @import("chapter_array_and_linkedlist/linked_list.zig");
const list = @import("chapter_array_and_linkedlist/list.zig");
const my_list = @import("chapter_array_and_linkedlist/my_list.zig");

pub fn main() !void {
    try array.run();
    linked_list.run();
    try list.run();
    try my_list.run();
}
