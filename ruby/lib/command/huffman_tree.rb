module Command
  class Node
    attr_accessor :value, :left, :right, :frequency

    def initialize(value, frequency)
      @value = value
      @frequency = frequency
      @left = nil
      @right = nil
    end
  end

  class HuffmanTree
    def self.build_tree(input_hash)
      nodes = []
      input_hash.each { |k, v| nodes << Node.new(k, v) }

      while nodes.size > 1
        nodes.sort_by! { |node| node.frequency }

        left_node = nodes.shift
        right_node = nodes.shift
        sum_frequency = left_node.frequency + right_node.frequency
        merged_node = Node.new(nil, sum_frequency)
        merged_node.left = left_node
        merged_node.right = right_node
        nodes << merged_node
      end

      nodes[0]
    end

    # use preorder traversal
    def self.assign_prefix_code(root_node, prefix_code)
      hash = {}
      if root_node
        hash[root_node.value] = prefix_code if prefix_code
        hash.merge!(assign_prefix_code(root_node.left, prefix_code ? prefix_code + '0' : '0'))
        hash.merge!(assign_prefix_code(root_node.right, prefix_code ? prefix_code + '1': '1'))
      end

      hash.reject { |k, _| k.nil? }
    end
  end
end
