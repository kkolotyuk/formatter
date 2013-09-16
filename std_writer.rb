require './writer'

class StdWriter < Writer
  def write(str)
    STDOUT.print(str)
  end
end