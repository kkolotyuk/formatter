require_relative './writer'
require_relative './reader'

# Reformats code of an abstract language.
# The language can contain special characters: semicolon and braces. All other characters are taken by the formatter as simple characters.
# The formatter works with syntactically valid code only (for instance if code contains unpaired '{' work of the formatter is unpredictable).
class Formatter

  # Array contains characters which will be skip
  SKIP_CHARS = [" ", "\t", "\n"]
  # Default configuration for the formatter
  DEFAULT_CONF = { step: 4, space: " " }

  # Reformats code according to conf parameter.
  #
  # @param reader [Reader] the formatter use reader.read method for reading code you want reformat.
  #   The reader must implements read and look_next methods. For more information look {Reader}
  # @param writer [Writer] the formatter use writer.write method to save reformatted code
  #   The writer must implements write method. For more information look {Writer}
  # @param conf [Hash] configuration for the formatter. You can customize step and/or space string the tab size sending !{step: 5, space: "any_string"} in conf.
  def self.format(reader, writer, conf = {})
    validate_reader reader
    validate_writer writer
    conf = DEFAULT_CONF.merge(conf)
    step = conf[:step]
    space_str = conf[:space]
    last_space = 0
    last_lexem = ""
    while (char = next_lexem(reader))
      if char == "{"
        last_space += step if last_lexem == "{"
        writer.write(space_string(space_str, last_space))
        writer.write(char + "\n")
      elsif char == "}"
        last_space -= step if last_lexem != "{"
        writer.write(space_string(space_str, last_space))
        writer.write(char + "\n")
      elsif char == ";"
        last_space += step if last_lexem == "{"
        writer.write(space_string(space_str, last_space)) if (last_lexem == "{" or last_lexem == ";")
        writer.write(char + "\n")
      else
        last_space += step if last_lexem == "{"
        writer.write(space_string(space_str, last_space)) if (last_lexem == "{" or last_lexem == ";")
        writer.write(char)
      end
      last_lexem = char
    end
  end

  private

  def self.validate_reader(reader)
    raise "Your reader is nil" if reader.nil?
    raise "Your reader can't read" unless reader.respond_to?(:read)
    raise "Your reader can't look next character" unless reader.respond_to?(:look_next)
  end

  def self.validate_writer(writer)
    raise "Your writer is nil" if writer.nil?
    raise "Your writer can't write" unless writer.respond_to?(:write)
  end

  def self.next_lexem(reader)
    char = SKIP_CHARS[0]
    while !char.nil? && SKIP_CHARS.include?(char)
      char= reader.read
    end
    char
  end

  def self.space_string(space, count)
    space * count
  end

end