module HexFile
  class InvalidRecord < StandardError; end

  class Record
    DATA = '00'
    END_OF_FILE = '01'
    EXTENDED_SEGMENT_ADDRESS = '02'
    START_SEGMENT_ADDRESS = '03'
    EXTENDED_LINEAR_ADDRESS = '04'
    START_LINEAR_ADDRESS = '05'
    
    attr_reader :type, :byte_count, :address, :data, :checksum

    def initialize(record_ascii)
      parse(record_ascii)
    end

    def data_size
      @byte_count.to_i(16)
    end

    def ok?
      @checksum.to_i(16) == calculate_checksum
    end

    private

    def parse(record_ascii)
      @raw = record_ascii
      fail HexFile::InvalidRecord, 'Missing start code' unless @raw.start_with?(':')
      @byte_count = record_ascii[1..2]
      @address = record_ascii[3..6]
      @type = record_ascii[7..8]
      @data = record_ascii[9..-3]
      @checksum = record_ascii[-2..-1]
    end

    def calculate_checksum
      256 -
        (@raw[1...-2]
          .scan(/../)
          .map { |x| x.to_i(16) }
          .inject(:+)) & 0xFF
    end
  end
end
