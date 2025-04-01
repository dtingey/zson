const std = @import("std");
const File = std.fs.File;

const JsonWriter = @This();

file: File,
level: u32 = 0,
indent: u8 = 0,
comptime const writer = file.writer();

fn _write_indent(self: *JsonWriter) !void {
    try self.file.write("testing");
}

test _write_indent {
    var file = try std.fs.cwd().createFile("/Users/damontingey/personal/zson/test.txt", .{});
    defer file.close();
    var writer: JsonWriter = .{ .file = file };
    try &writer._write_indent();
}
