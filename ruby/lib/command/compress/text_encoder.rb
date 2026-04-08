module Command
  module Compress
    class TextEncoder
      def self.encode(prefix_codes, content)
        new(prefix_codes, content).encode
      end

      private attr_reader :prefix_codes, :content

      def initialize(prefix_codes, content)
        @prefix_codes = prefix_codes
        @content = content
      end

      def encode
        encoded_result = ''
        content.each_char { |c| encoded_result << prefix_codes[c] }

        encoded_result
      end
    end
  end
end
