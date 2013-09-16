require './writer'
require './reader'

# Reformats code of an abstract language.
# The language can contain special characters: semicolon and braces. All other characters are taken by the formatter as simple characters.
# The formatter works with syntactically valid code only (for instance if code contains unpaired '{' work of the formatter is unpredictable).
class Formatter

  # Array contains characters which will be skip
  SKIP_CHARS = [" ", "\t", "\n"]
  # Default configuration for the formatter
  DEFAULT_CONF = {step: 4}

  # Reformats code according to conf parameter.
  #
  # @param reader [Reader] the formatter use reader.read method for reading code you want reformat.
  #   The reader must implements read and look_next methods. For more information look {Reader}
  # @param writer [Writer] the formatter use writer.write method to save reformatted code
  #   The writer must implements write method. For more information look {Writer}
  # @param conf [Hash] configuration for the formatter. You can customize the tab size sending {step: 5} as conf.
  def self.format(reader, writer, conf)
    validate_reader reader
    validate_writer writer
    conf = DEFAULT_CONF.merge(conf)
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

  def self.validate_reader(reader)
    raise "Your reader can't read" unless reader.respond_to?(:read)
    raise "Your reader can't look next character" unless reader.respond_to?(:look_next)
  end

  def self.validate_writer(writer)
    raise "Your writer can't write" unless writer.respond_to?(:write)
  end

  def self.skip(reader)
    while !reader.look_next.nil? && SKIP_CHARS.include?(reader.look_next)
      reader.read
    end
  end

  def self.next_lexem(reader)
    skip(reader)
    reader.read
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