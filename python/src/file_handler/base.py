from abc import ABC, abstractmethod
import os

class BaseHandler(ABC):
  def __init__(self, input_path: str, output_path: str) -> None:
    self.input_path: str = input_path
    self.output_path: str = output_path
  
  @abstractmethod
  def load(self) -> str:
    pass

  @abstractmethod
  def save_file(self, **kwargs) -> None:
    pass

  def _is_input_path_valid(self) -> bool:
    if not os.path.exists(self.input_path):
      return False
    elif os.path.getsize(self.input_path) == 0:
      return False
    elif not os.access(self.input_path, os.R_OK):
      return False
    elif not self._input_file_extension_is_valid():
      return False
    else:
      return True
  
  def _is_output_path_valid(self) -> bool:
    return self._output_file_extension_is_valid()
    
  @abstractmethod
  def _input_file_extension_is_valid(self) -> bool:
    pass

  @abstractmethod
  def _output_file_extension_is_valid(self) -> bool:
    pass