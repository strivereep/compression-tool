module Command
  module Decompress
    class ByteConverter
      def self.convert(content)
        new(content).convert
      end

      private attr_reader :content

      def initialize(content)
        @content = content
      end

      def convert
        decoded_bits = ''
        content.each_char do |char|
          unpack_char = char.unpack('C')[0].to_s(2)
          unpack_char = unpack_char.rjust(8, '0') if unpack_char.size < 8
          puts unpack_char if unpack_char.size < 8
          decoded_bits << unpack_char
        end

        decoded_bits
      end
    end
  end
end
