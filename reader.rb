# Reader is an abstract class of reader. It contains all necessary and sufficient methods for reader which {Formatter#format} expects.
# Reader behavior is similar to that of {IO}
class Reader
  # Looks at next character or nil if there isn't next character. You can expect that the next call of {Reader.read} returns the same as {Reader.look_next}
  # @return [String]
  def look_next
  end

  # Reads next character. Before call of this method you can see what it returns using {Reader#look_next} call.
  # @return [String]
  def read
  end
end