//! Library for streaming data to json.
const std = @import("std");
const print = std.debug.print;
const File = std.fs.File;
const writeStream = std.json.writeStream;
const StringifyOptions = std.json.StringifyOptions;
const Allocator = std.mem.Allocator;

// pub fn jsonGenerator(out_stream: anytype, options: StringifyOptions) JsonGenerator(@TypeOf(out_stream)) {
//     const write_stream = writeStream(out_stream, options);
//     return JsonGenerator(@TypeOf(write_stream)).init(write_stream);
// }

pub fn JsonGenerator(comptime WriteStream: type) type {
    return struct {
        const Self = @This();

        writer: WriteStream,

        pub fn init(write_stream: WriteStream) Self {
            return .{ .writer = write_stream };
        }

        pub fn write_start_object(self: *Self) anyerror!void {
            _ = try self.writer.beginObject();
        }
    };
}

pub fn main() void {
    const multiline =
        \\test multiline stuff
        \\very cool
        \\i don't know if I like it but it is cool.
        \\what is up
        \\I will use this in the json generator
    ;
    var x: i32 = 1;
    const x_ptr = &x;
    print("x_tpr type: {any}\n", .{@TypeOf(x_ptr)});
    print("{s}\n", .{multiline});
    print("Hello, world!\n", .{});
}

test JsonGenerator {
    const file = try std.fs.cwd().createFile("/Users/damontingey/personal/zson/test.txt", .{});
    defer file.close();
    const out_stream = file.writer();
    const write_stream = writeStream(out_stream, .{ .whitespace = .indent_2 });
    var json_generator = JsonGenerator(@TypeOf(write_stream)).init(write_stream);
    _ = try json_generator.write_start_object();
}

// test jsonGenerator {
//     const file = try std.fs.cwd().createFile("/Users/damontingey/personal/zson/test.txt", .{});
//     defer file.close();
//     const out_stream = file.writer();
//     var json_generator = jsonGenerator(out_stream, .{ .whitespace = .indent_2 });
//     _ = try json_generator.write_start_object();
// }
