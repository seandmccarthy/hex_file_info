module HexFile
  class InvalidRecord < StandardError;
  end

  class Record
    DATA = '00'
    END_OF_FILE = '01'
    EXTENDED_SEGMENT_ADDRESS = '02'
    START_SEGMENT_ADDRESS = '03'
    EXTENDED_LINEAR_ADDRESS = '04'
    START_LINEAR_ADDRESS = '05'

    attr_reader :type, :byte_count, :address, :data, :checksum

    def initialize(record_ascii)
      fail HexFile::InvalidRecord, 'Missing start code' unless record_ascii.start_with?(':')
      @byte_count = record_ascii[1..2]
      @address = record_ascii[3..6]
      @type = record_ascii[7..8]
      @data = record_ascii[9..-3]
      @checksum = record_ascii[-2..-1]
    end
    
    def raw
      ":#{record_content}#{@checksum}"
    end

    def record_content
      "#{@byte_count}#{@address}#{@type}#{@data}"
    end

    def set_hex_data data
      raise "Data should be of length #{data_size}!" unless data.length == @data.length

      @data = data
      update_checksum
    end

    def set_data data
      data = data.unpack('C*') if data.is_a? String # Assume binary string
      hexdata = data.map{ |d| "%02X" % d }.join
      
      set_hex_data hexdata
    end

    def update_checksum
      @checksum = "%02X" % calculate_checksum
    end

    def data_size
      @byte_count.to_i(16)
    end

    def ok?
      @checksum.to_i(16) == calculate_checksum
    end


    def calculate_checksum record = record_content
      256 - (record
                 .scan(/../)
                 .map { |x| x.to_i(16) }
                 .reduce(:+)
      ) & 0xFF
    end

  end
end
