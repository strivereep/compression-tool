from compress.frequency_dict import FrequencyDict
from huffman_tree import HuffmanTree, Node
from compress.text_encoder import TextEncoder
from file_handler.compress import CompressFileHandler

class CompressCore:
  @classmethod
  def compress(cls, input_path: str, output_path: str):
    file_handler: CompressFileHandler = CompressFileHandler(input_path=input_path, output_path=output_path)
    file_content: str = file_handler.load()
    frequency_count: dict = FrequencyDict.frequency_dict(file_content=file_content)
    root_node: Node = HuffmanTree.build_tree(input_dict=frequency_count)
    prefix_codes: dict = HuffmanTree.set_prefix_code(root_node=root_node, prefix_code=None)
    encoded_text: str = TextEncoder(file_content=file_content, prefix_codes=prefix_codes).encode()
    file_handler.save_file(header=frequency_count, encoded_text=encoded_text, separator='~')
