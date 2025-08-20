const std = @import("std");
const builtin = @import("builtin");

var debug_allocator: std.heap.DebugAllocator(.{}) = .init;

pub fn globalAllocator() std.mem.Allocator {
    return switch (builtin.mode) {
        .Debug => debug_allocator.allocator(),
        .ReleaseFast, .ReleaseSafe, .ReleaseSmall => std.heap.smp_allocator,
    };
}
