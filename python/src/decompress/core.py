from file_handler.decompress import DecompressFileHandler
from decompress.metadata_parser import MetadataParser
from decompress.byte_converter import ByteConverter
from huffman_tree import HuffmanTree, Node
from decompress.bit_decoder import BitDecoder

class DecompressCore:
  @classmethod
  def decompress(cls, input_path: str, output_path: str):
    file_handler: DecompressFileHandler = DecompressFileHandler(input_path=input_path, output_path=output_path)
    file_content: bytes = file_handler.load()
    frequency_dict, total_bit_count, byte_content = MetadataParser.parse(file_content=file_content)
    decoded_bits: str = ByteConverter.convert(byte_content=byte_content)
    root_node: Node = HuffmanTree.build_tree(input_dict=frequency_dict)
    prefix_codes: dict = HuffmanTree.set_prefix_code(root_node=root_node, prefix_code=None)
    bit_decoder: BitDecoder = BitDecoder(root_node=root_node, prefix_codes=prefix_codes, total_bit_count=total_bit_count, decoded_bits=decoded_bits)
    content: str = bit_decoder.decode()
    file_handler.save_file(content=content)
