module HexFile
  class Info
    def initialize(input_stream)
      @records = input_stream.readlines.map do |record_line|
        Record.new(record_line.strip)
      end
    end

    def records
      @records.each
    end

    def binary_size
      records.map { |r| r.data_size }.reduce(:+)
    end

    def format
      if linear_record_types?(record_types)
        'I32HEX'
      elsif start_segment_record_type?(record_types)
        'I16HEX'
      else
        'I8HEX'
      end
    end

    private

    def record_types
      @record_types ||= records.map { |r| r.type }.uniq
    end

    def linear_record_types?(record_types)
      record_types.include?(Record::EXTENDED_LINEAR_ADDRESS) ||
         record_types.include?(Record::START_LINEAR_ADDRESS)
    end

    def start_segment_record_type?(record_types)
      record_types.include?(Record::START_SEGMENT_ADDRESS)
    end
  end
end
