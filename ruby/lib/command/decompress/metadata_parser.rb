require 'json'

module Command
  module Decompress
    class MetadataParser
      def self.parse(content)
        new(content).parse
      end

      def initialize(content)
        @content = content
      end

      def parse
        frequency_hash_metadata, total_bit_count_metadata, byte_content = extract_metadata
        frequency_hash = JSON.parse(frequency_hash_metadata)
        total_bit_count = total_bit_count_metadata.split('=')[-1].to_i
        return frequency_hash, total_bit_count, byte_content
      end

      private

      attr_reader :content

      def extract_metadata
        separator = 0
        frequency_hash_metadata = ''
        total_bit_count_metadata = ''
        byte_content = ''
        content.each_char do |char|
          if char == '~' && separator < 2
            separator += 1
            next
          end

          frequency_hash_metadata << char if separator.zero?
          total_bit_count_metadata << char if separator == 1
          byte_content << char if separator > 1
        end

        return frequency_hash_metadata, total_bit_count_metadata, byte_content
      end
    end
  end
end
