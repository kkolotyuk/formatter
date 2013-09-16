require './writer'

# Implementation of {Writer} for STDOUT
class StdWriter < Writer
  def write(str)
    STDOUT.print(str)
  end
end