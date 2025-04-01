//! Library for streaming data to json.
const std = @import("std");
const print = std.debug.print;
const File = std.fs.File;
const JsonWriter = @import("JsonWriter.zig");

const JsonGenerator = @This();

json_writer: JsonWriter,
trim_whitespace: bool = true,

pub fn init(file: File, indent: u8, trim_whitespace: bool) JsonGenerator {
    // set default values
    return JsonGenerator{ .json_writer = JsonWriter{ .file = file, .indent = indent }, .trim_whitespace = trim_whitespace };
}

pub fn main() void {
    const multiline =
        \\test multiline stuff
        \\very cool
        \\i don't know if I like it but it is cool.
        \\I will use this in the json generator
    ;
    var x: i32 = 1;
    const x_ptr = &x;
    print("x_tpr type: {any}\n", .{@TypeOf(x_ptr)});
    print("{s}\n", .{multiline});
    print("Hello, world!\n", .{});
}

// This is a doc test
test main {
    main();
}

test "test slice types" {
    const array = [_]i32{ 0, 1, 2, 3, 4 };
    print("{any}\n", .{array[0..3]});
    print("{any}\n", .{@TypeOf(array[0..3])});

    print("\n", .{});

    var runtime_zero: usize = 0;
    _ = &runtime_zero;
    print("{any}\n", .{array[runtime_zero..3]});
    print("{any}\n", .{@TypeOf(array[runtime_zero..3])});
}

test init {
    var file = try std.fs.cwd().createFile("/Users/damontingey/personal/zson/test.txt", .{});
    defer file.close();
    const json_generator = init(file, 0, false);
    _ = &json_generator;
}

test "file json ge" {
    var file = try std.fs.cwd().createFile("/Users/damontingey/personal/zson/test.txt", .{});
    defer file.close();
    print("{any}\n", .{@TypeOf(file)});
}
