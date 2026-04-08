require_relative '../file_handler/base'
require_relative '../file_handler/compress'
require_relative 'frequency_count'
require_relative '../huffman_tree'
require_relative 'text_encoder'

module Command
  module Compress
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
        # get file content
        file_content = FileHandler::Compress.new(input_path: input_path).load

        # using file content, generate frequency hash
        frequency_hash = FrequencyCount.frequency_hash(file_content)

        # build huffman tree
        root_node = HuffmanTree.build_tree(frequency_hash)

        # assign prefix code
        prefix_hash = HuffmanTree.assign_prefix_code(root_node, nil)

        # encode text with prefix hash
        encoded_text = TextEncoder.encode(prefix_hash, file_content)

        # save file
        FileHandler::Compress.new(output_path: output_path).save_file(header: frequency_hash, separator: '~', content: encoded_text)
      end
    end
  end
end
