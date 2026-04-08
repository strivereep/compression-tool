module Command
  module Compress
    class FrequencyCount
      class << self
        def frequency_hash(file_content)
          freq_hash = {}
          file_content.each_char do |c|
            freq_hash[c] = freq_hash[c].to_i + 1
          end

          freq_hash
        end
      end
    end
  end
end
