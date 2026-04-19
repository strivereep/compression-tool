class ByteConverter:
  @classmethod
  def convert(cls, byte_content: bytes) -> str:
    return ''.join("{0:b}".format(val).rjust(8, '0') for val in byte_content)