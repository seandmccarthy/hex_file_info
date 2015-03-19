# HexFile

Parses Intel HEX files and gives metadata about the file and records.

See http://en.wikipedia.org/wiki/Intel_HEX for information on the file format

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hex_file'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hex_file

## Usage

    info = HexFile::Info.new(File.open('myfile.hex', 'r'))

    info.format
    # I8HEX

    info.binary_size
    # 12134

    info.records.each do |record|
      puts record.data_size
      puts record.byte_count
      puts record.address
      puts record.type
      puts record.data
      puts record.checksum
      puts record.ok?
    end

## Contributing

1. Fork it ( https://github.com/seandmccarthy/hex_file/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
