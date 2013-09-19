require_relative './reader'

# Implementation of {Reader} for work with IO objects.
class IOReader < Reader
  
  def initialize(io)
    @io = io
  end

  def read
    @io.getc
  end
end