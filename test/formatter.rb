require_relative '../src/formatter'
require_relative '../src/io_writer'
require_relative '../src/io_reader'
require 'test/unit'
require 'fileutils'

class TestFormatter < Test::Unit::TestCase

  FIXTURE_PATH = File.expand_path("../fixtures", __FILE__)
  OUTPUT_PATH = "output.txt"

  def setup
    @output = File.open(OUTPUT_PATH, "w")
  end

  def teardown
    File.delete(OUTPUT_PATH)
  end

  def test_valid
    reader = IOReader.new(File.open(FIXTURE_PATH + "/input1.txt", 'r'))
    writer = IOWriter.new(@output)
    Formatter.format(reader, writer)
    @output.close
    expected_path = FIXTURE_PATH + "/output1.txt"
    assert FileUtils.compare_file(OUTPUT_PATH, expected_path), "Files are not identical"
  end
end