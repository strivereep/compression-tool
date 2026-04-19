from file_handler.base import BaseHandler
import os

class DecompressFileHandler(BaseHandler):
  def load(self) -> bytes:
    if not self._is_input_path_valid():
      raise Exception('Invalid File')
    
    with open(self.input_path, 'rb') as file:
      return file.read()
  
  def save_file(self, **kwargs) -> None:
    if not self._is_output_path_valid():
      raise Exception('Invalid output file path')
    
    with open(self.output_path, 'w') as file:
      file.write(kwargs.get('content'))
  
  def _input_file_extension_is_valid(self) -> bool:
    return os.path.splitext(self.input_path)[-1] == '.bin'

  def _output_file_extension_is_valid(self) -> bool:
    return os.path.splitext(self.output_path)[-1] == '.txt'