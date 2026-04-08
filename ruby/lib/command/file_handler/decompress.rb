module Command
  module FileHandler
    class Decompress < Base

      def load
        if valid_input_file?
          File.binread(input_path)
        else
          raise 'Invalid File'
        end
      end

      def save_file(content:)
        raise 'Invalid output file path' unless valid_output_file_extension?

        File.open(output_path, 'w') do |file|
          file.write(content)
        end
      end

      private

      def valid_input_file_extension?
        File.extname(input_path) == '.bin'
      end

      def valid_output_file_extension?
        File.extname(output_path) == '.txt'
      end
    end
  end
end
