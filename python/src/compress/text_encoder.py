class TextEncoder:
  def __init__(self, file_content: str, prefix_codes: dict) -> None:
    self.file_content = file_content
    self.prefix_codes = prefix_codes
  
  def encode(self) -> str:
    encoded_str: list[str] = []
    for char in self.file_content:
      encoded_str.append(self.prefix_codes.get(char))
    
    return ''.join(encoded_str)
