from typing import Tuple
import json


class MetadataParser:
  @classmethod
  def parse(cls, file_content: bytes) -> Tuple[dict, int, bytes]:
    frequency_dict_metadata, total_bit_count_metadata, byte_content = cls._metadata_extractor(file_content=file_content)
    frquency_dict: dict = json.loads(frequency_dict_metadata)
    total_bit_count: int = int(total_bit_count_metadata.split('=')[-1])
    return frquency_dict, total_bit_count, byte_content

  @classmethod
  def _metadata_extractor(cls, file_content) -> Tuple[str, str, bytes]:
    content_list: list[bytes] = file_content.split(b'~')
    frequency_dict_metadata: str = content_list[0].decode('UTF-8')
    total_bit_count_metadata: str = content_list[1].decode('UTF-8') 
    byte_content: bytes = b'~'.join(content_list[2:])
    
    return frequency_dict_metadata, total_bit_count_metadata, byte_content
