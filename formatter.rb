class Writer
  # Write string
  def write(str)
  end
end

class StdWriter < Writer
  def write(str)
    STDOUT.print(str)
  end
end

class Reader
  # Look at next character
  def look_next
  end

  # Read next character
  def read
  end

  # I have next character, don't I?
  def end?
  end
end

class IOReader < Reader
  
  def initialize(io)
    @io = io
  end

  def look_next
    pos = @io.pos
    char = @io.getc
    @io.pos=pos
    char
  end

  def read
    @io.getc
  end

  def end?
    @io.eof?
  end
end

class Formatter

  @@skip_chars = [" ", "\t", "\n"]
  @@default_conf = {step: 4}

  def self.format(reader, writer, conf)
    conf = @@default_conf.merge(conf)
    step = conf[:step]
    current_space = 0
    while (char = next_lexem(reader))
      # think about symbols
      if char == "{"
        writer.write(char + "\n")
        current_space += step if look_lexem(reader) != "}"
        writer.write(space_string current_space)
      elsif char == "}"
        writer.write(char + "\n")
        current_space -= step if look_lexem(reader) == "}"
        writer.write(space_string current_space)
      elsif char == ";"
        writer.write(char + "\n")
        current_space -= step if look_lexem(reader) == "}"
        writer.write(space_string current_space)
      else
        writer.write(char)
      end
    end
  end

  private

  def self.skip(reader)
    while @@skip_chars.include?(reader.look_next) && !reader.end?
      reader.read
    end
  end

  def self.next_lexem(reader)
    skip(reader)
    reader.end? ? nil : reader.read
  end

  def self.look_lexem(reader)
    skip(reader)
    reader.look_next
  end

  def self.look_lexem(reader)
    skip(reader)
    reader.look_next
  end

  def self.space_string(count)
    " " * count
  end

end


if !File.exists?(ARGV[0])
  puts "File doesn't exist"
end
if !File.readable?(ARGV[0])
  puts "File is unreadable"
end

reader = IOReader.new(File.open(ARGV[0], 'r'))
writer = StdWriter.new
Formatter.format(reader, writer, {})