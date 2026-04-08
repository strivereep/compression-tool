require 'json'

module Command
  module FileHandler
    class Compress < Base

      def load
        if valid_input_file?
          File.read(input_path)
        else
          raise 'Invalid File'
        end
      end

      def save_file(header:, separator:, content:)
        raise 'Invalid output file path' unless valid_output_file_extension?

        byte_content, total_bit_count = byte_content_converter(content)
        # TODO: Write the header metadata
        # in bytes, might save more space
        # But extra operation required
        # in decompression
        File.open(output_path, 'wb') do |file|
          file.write("#{header.to_json}#{separator}total_bit_count=#{total_bit_count}#{separator}")
        end

        File.open(output_path, 'ab') do |file|
          file.write(byte_content)
        end
      end

      private

      def valid_input_file_extension?
        File.extname(input_path) == '.txt'
      end

      def valid_output_file_extension?
        File.extname(output_path) == '.bin'
      end

      def byte_content_converter(content)
        byte_content = ''
        buffer = 0
        bit_count = 0
        total_bit_count = 0

        content.each_char do |char|
          # for each char
          # left shift the buffer by 1
          buffer = buffer << 1

          # if char is 1 then OR 1
          # for char 0, not needed
          buffer |= 1 if char == '1'

          bit_count += 1
          total_bit_count += 1

          # if bit count is 8 i.e. 8 bits (1 byte)
          # write the file and reset the buffer and bit_count
          if bit_count == 8
            byte_content << [buffer].pack('C')

            buffer = 0
            bit_count = 0
          end
        end
        # edge case scenario
        # when bit count is not 8
        # i.e. 8 bits not fullfilled
        # mock the remaining bits
        # and add to the header
        if bit_count > 0
          buffer = buffer << (8 - bit_count)
          byte_content << [buffer].pack('C')
        end

        return byte_content, total_bit_count
      end
    end
  end
end
