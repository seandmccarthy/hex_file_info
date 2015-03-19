require 'minitest/autorun'
require 'hex_file/info'
require 'hex_file/record'
require 'stringio'

class TestInfo < MiniTest::Unit::TestCase
  def setup
    string_io = StringIO.new(<<EOS)
:100083000227EFE5C754F84401F5C77901220000C0
:0300300002337A1E
EOS
    @info = HexFile::Info.new(string_io)
  end

  def test_records
    assert_equal @info.records.count, 2
  end

  def test_record_iteration
    @info.records.each do |record|
      assert record.ok?
    end
  end

  def test_binary_size
    assert_equal @info.binary_size, 19
  end

  def test_format_i32hex
    info = HexFile::Info.new(StringIO.new(':02000004FFFFFC'))
    assert_equal info.format, 'I32HEX'
  end

  def test_format_i16hex
    info = HexFile::Info.new(StringIO.new(':0400000300003800C1'))
    assert_equal info.format, 'I16HEX'
  end

  def test_format_i8hex
    assert_equal @info.format, 'I8HEX'
  end
end
