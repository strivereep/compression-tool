module Command
  module FileHandler
    class Base
      def initialize(input_path: nil, output_path: nil)
        @input_path = input_path
        @output_path = output_path
      end

      def load
        raise NotImplementedError
      end

      def save_file(options = {})
        raise NotImplementedError
      end

      private

      attr_reader :input_path, :output_path

      def valid_input_file?
        return false unless File.exists?(input_path)
        return false if File.zero?(input_path)
        return false unless File.readable?(input_path)
        return false unless valid_input_file_extension?

        true
      end

      def valid_output_file?
        valid_output_file_extension?
      end

      def valid_input_file_extension?
        raise NotImplementedError
      end

      def valid_output_file_extension?
        raise NotImplementedError
      end
    end
  end
end
