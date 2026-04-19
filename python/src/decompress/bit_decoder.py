from huffman_tree import Node

class BitDecoder:
  def __init__(self, root_node: Node, prefix_codes: dict, total_bit_count: int, decoded_bits: str) -> None:
    self.root_node: Node = root_node
    self.prefix_codes: dict = prefix_codes
    self.total_bit_count: int = total_bit_count
    self.decoded_bits: str = decoded_bits
  
  def decode(self) -> str:
    content: list[str] = []
    current_node: Node = self.root_node
    word_bit: list[str] = []
    mapped_text: str = ''
    bit_count: int = 0
    for bit in self.decoded_bits:
      word_bit.append(bit)
      bit_count += 1
      if bit == '1':
        current_node = current_node.right 
      else:
        current_node = current_node.left

      # leaf node
      if current_node.left is None and current_node.right is None:
        mapped_text = next(key for key, value in self.prefix_codes.items() if value == ''.join(word_bit))
        
        content.append(mapped_text)
        word_bit = []
        current_node = self.root_node
    
      if bit_count == self.total_bit_count:
        break
    
    return ''.join(content)