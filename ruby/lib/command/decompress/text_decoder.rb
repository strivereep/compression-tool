module Command
  module Decompress
    class TextDecoder
      def self.decode(root_node, prefix_hash, decoded_bits, total_bit_count)
        new(root_node, prefix_hash, decoded_bits, total_bit_count).decode
      end

      private attr_reader :root_node, :prefix_hash, :decoded_bits, :total_bit_count

      def initialize(root_node, prefix_hash, decoded_bits, total_bit_count)
        @root_node = root_node
        @prefix_hash = prefix_hash
        @decoded_bits = decoded_bits
        @total_bit_count = total_bit_count
      end

      def decode
        decoded_string = ''
        decoded_word = ''
        current_node = root_node
        bit_count = 0
        decoded_bits.each_char do |bit|
          decoded_word << bit
          bit_count += 1
          if bit == '1'
            current_node = current_node.right
          else
            current_node = current_node.left
          end

          # check leaf node
          if current_node.left.nil? && current_node.right.nil?
            decoded_string << prefix_hash.key(decoded_word).to_s
            decoded_word = ''
            current_node = root_node
          end

          break if total_bit_count == bit_count
        end

        decoded_string
      end
    end
  end
end
