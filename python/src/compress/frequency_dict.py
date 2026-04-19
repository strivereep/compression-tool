class FrequencyDict:
  @classmethod
  def frequency_dict(cls, file_content: str) -> dict:
    frequency_count: dict = {}
    for char in file_content:
      if frequency_count.get(char) is not None:
        frequency_count[char] += 1
      else:
        frequency_count[char] = 1
    
    return frequency_count