require './io_reader'
require './std_writer'
require './formatter'


if !File.exists?(ARGV[0])
  rescue "File doesn't exist"
end
if !File.readable?(ARGV[0])
  rescue "File is unreadable"
end

reader = IOReader.new(File.open(ARGV[0], 'r'))
writer = StdWriter.new
Formatter.format(reader, writer, {})