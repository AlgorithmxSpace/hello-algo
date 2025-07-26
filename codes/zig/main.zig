const std = @import("std");

const array = @import("chapter_array_and_linkedlist/array.zig");
const linked_list = @import("chapter_array_and_linkedlist/linked_list.zig");
const list = @import("chapter_array_and_linkedlist/list.zig");
const my_list = @import("chapter_array_and_linkedlist/my_list.zig");

const iteration = @import("chapter_computational_complexity/iteration.zig");
const recursion = @import("chapter_computational_complexity/recursion.zig");

pub fn main() !void {
    try array.run();
    linked_list.run();
    try list.run();
    try my_list.run();

    try iteration.run();
    recursion.run();
}
