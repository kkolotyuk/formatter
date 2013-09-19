require_relative './io_reader'
require_relative './std_writer'
require_relative './formatter'


if !File.exists?(ARGV[0])
  raise "File doesn't exist"
end
if !File.readable?(ARGV[0])
  raise "File is unreadable"
end

reader = IOReader.new(File.open(ARGV[0], 'r'))
writer = StdWriter.new
Formatter.format(reader, writer, {space: "\t", step: 1})