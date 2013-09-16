# Reader is an abstract class of reader. It contains all necessary and sufficient methods for reader which {formatter#format} expects.
# Reader behavior is similar to that of IO class from ruby core.
# @abstract
class Reader
  # Looks at next character or nil if there isn't next character. You can expect that the next call of {reader#read} returns the same as {reader#look_next}
  # @return [String]
  def look_next
  end

  # Reads next character. Before call of this method you can see what it returns using {reader#look_next} call.
  # @return [String]
  def read
  end
end