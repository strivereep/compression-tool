from file_handler.base import BaseHandler
import os
import json
from typing import Tuple

class CompressFileHandler(BaseHandler):
  def load(self) -> bytes:
    if not self._is_input_path_valid():
      raise Exception("Invalid input file")
  
    with open(self.input_path, 'r') as f:
      return f.read()
  
  def save_file(self, **kwargs) -> None:
    if not self._is_output_path_valid():
      raise Exception("Invalid Output file")

    header: dict = kwargs.get('header')
    separator: str = kwargs.get('separator')
    encoded_text: str = kwargs.get('encoded_text')
    
    byte_content, total_bit_count = self._byte_content_converter(encoded_text=encoded_text)
    metadata: str = f'{json.dumps(header)}{separator}total_bit_count={total_bit_count}{separator}'
    # write the metadata
    with open(self.output_path, 'wb') as f:
      f.write(metadata.encode('UTF-8'))
    
    # append
    with open(self.output_path, 'ab') as f:
      f.write(byte_content)
  
  def _input_file_extension_is_valid(self) -> bool:
    return os.path.splitext(self.input_path)[-1] == '.txt'

  def _output_file_extension_is_valid(self) -> bool:
    return os.path.splitext(self.output_path)[-1] == '.bin'
  
  def _byte_content_converter(self, encoded_text: str) -> Tuple[bytes, int]:
    buffer: int = 0
    bit_count: int = 0
    total_bit_count: int = 0
    byte_content: list = bytearray()

    for char in encoded_text:
      buffer = buffer << 1
      if char == '1':
        buffer = buffer | 1
      
      bit_count += 1
      total_bit_count += 1

      # in order to write to file
      # need to make bytes (8 bits)
      if bit_count == 8:
        byte_content.append(buffer)
        # reset bit_count and buffer
        bit_count = 0
        buffer = 0

    if bit_count > 0:
      buffer = buffer << (8 - bit_count)
      byte_content.append(buffer)
    
    return bytes(byte_content), total_bit_count