require_relative './reader'

# Implementation of {Writer} for work with IO objects.
class IOWriter < Writer
  
  def initialize(io)
    @io = io
  end

  def write(str)
    @io.print str
  end
end