require_relative '../file_handler/base'
require_relative '../file_handler/decompress'
require_relative 'metadata_parser'
require_relative 'byte_converter'
require_relative '../huffman_tree'
require_relative 'text_decoder'

module Command
  module Decompress
    class Command
      def self.run(input_path, output_path)
        new(input_path, output_path).run
      rescue => error
        $stderr.puts error
        exit 1
      end

      private attr_reader :input_path, :output_path

      def initialize(input_path, output_path)
        @input_path = input_path
        @output_path = output_path
      end

      def run
        # load the file content (bytes) from binary file
        file_content = FileHandler::Decompress.new(input_path: input_path).load

        # parse the header metadata, total bit count and byte content
        frequency_hash, total_bit_count, byte_content = MetadataParser.parse(file_content)

        # decode the byte content
        decoded_bits = ByteConverter.convert(byte_content)

        # build the huffman tree
        root_node = HuffmanTree.build_tree(frequency_hash)

        # generate the prefix hash
        prefix_hash = HuffmanTree.assign_prefix_code(root_node, nil)

        # decode the text by traversing the huffman tree
        decoded_text = TextDecoder.decode(root_node, prefix_hash, decoded_bits, total_bit_count)

        # save the decoded text
        FileHandler::Decompress.new(output_path: output_path).save_file(content: decoded_text)
      end
    end
  end
end
