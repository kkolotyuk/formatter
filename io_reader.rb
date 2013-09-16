require './reader'

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
end