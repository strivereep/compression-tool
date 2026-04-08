require 'optparse'

module Command
  class Cli
    def self.run(argv)
      new(argv).run
    rescue => error
      $stderr.puts error
      exit 1
    end

    def initialize(argv)
      @argv = argv
    end

    def run
      options = parse_options
      command = options[:command]
      raise "No command provided" unless command

      input_path = options[:input_path]
      raise "No input path file provided" unless input_path

      output_path = options[:output_path]
      raise "No output path to save file provided" unless output_path

      case command.downcase
      when 'compress'
        Compress::Command.run(input_path, output_path)
      when 'decompress'
        Decompress::Command.run(input_path, output_path)
      else
        raise "Invalid command provided, #{command}. Supported: compress, decompress"
      end
    end

    private

    def parse_options
      options = {}
      parser = OptionParser.new do |opts|
        opts.banner = 'Usage: bin/command -c [command=compress|decompress] -i [input_path] -o [output_path], For e.g. bin/command -c compress -i test/test.txt -o output/output.bin'

        opts.on('-c', '--command [COMMAND]', 'compress or decompress') do |c|
          options[:command] = c
        end

        opts.on('-i', '--input_path [INPUT_PATH]', 'Filepath to compress') do |input|
          options[:input_path] = input
        end

        opts.on('-o', '--output_path [OUTPUT_PATH]', 'Save the compress file') do |f|
          options[:output_path] = f
        end

        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end

      parser.parse!(@argv)
      options
    end
  end
end
