$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
require 'hex_file_reader'

HexFileReader::Parse.new(File.open(ARGV[0]))
