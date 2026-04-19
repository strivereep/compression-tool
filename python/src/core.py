from argparse import ArgumentParser
from compress.core import CompressCore
from decompress.core import DecompressCore


def main():
  parser = ArgumentParser(prog="compress")
  
  parser.add_argument("command", help="Utility command: compress | decompress")
  parser.add_argument("input_path", help="Path of the file to compress")
  parser.add_argument("output_path", help="Path of the file to be saved")

  args = parser.parse_args()
  if args.command and args.input_path and args.output_path:
    try:
      command: str = args.command.lower()
      if command == 'compress':
        CompressCore.compress(input_path=args.input_path, output_path=args.output_path)
      elif command == 'decompress':
        DecompressCore.decompress(input_path=args.input_path, output_path=args.output_path)
      else:
        print('Invalid command. Allowed command: compress and decompress')
    except Exception as e:
      print(f'Error: {e}')
  else:
    print('Either command or input file path or output file path is missing.')


if __name__ == "__main__":
  main()