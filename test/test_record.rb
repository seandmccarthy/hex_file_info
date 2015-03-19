require 'minitest/autorun'
require 'hex_file/record'

class TestRecord < MiniTest::Unit::TestCase
  def setup
    @record = HexFile::Record.new(':0300300002337A1E')
  end

  def test_type
    assert_equal HexFile::Record::DATA, @record.type
  end

  def test_record_ok
    assert @record.ok?
  end

  def test_data_size
    assert_equal @record.data_size, 3
  end

  def test_byte_count
    assert_equal @record.byte_count, '03'
  end

  def test_data
    assert_equal @record.data, '02337A'
  end

  def test_address
    assert_equal @record.address, '0030'
  end

  def test_checksum
    assert_equal @record.checksum, '1E'
  end

  def test_bad_checksum
    assert !HexFile::Record.new(':0300300002337AFF').ok?
  end

  def test_invalid_record
    assert_raises HexFile::InvalidRecord do
      HexFile::Record.new('')
    end
  end
end
