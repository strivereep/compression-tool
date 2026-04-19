from typing import Union

class Node:
  def __init__(self, value: Union[str, None], frequency: int) -> None:
    self.value: Union[str, None] = value
    self.frequency: int = frequency
    self.left : Union[None, Node] = None
    self.right: Union[None, Node] = None
  
class HuffmanTree:
  @classmethod
  def build_tree(cls, input_dict: dict) -> Node:
    nodes: list = []

    for item in input_dict.items():
      nodes.append(Node(value=item[0], frequency=item[1]))

    while len(nodes) > 1:
      nodes = sorted(nodes, key=lambda x: x.frequency)

      left_node: Node = nodes.pop(0)
      right_node: Node = nodes.pop(0)
      sum_frequency: int = left_node.frequency + right_node.frequency
      merged_node: Node = Node(value=None, frequency=sum_frequency)
      merged_node.left = left_node
      merged_node.right = right_node
      nodes.append(merged_node)
    
    return nodes[0]
  
  @classmethod
  def traverse_tree(cls, root_node: Node):
    if root_node:
      cls.traverse_tree(root_node=root_node.left)
      print(root_node.value) if root_node.value else ''
      cls.traverse_tree(root_node=root_node.right)

  @classmethod
  def set_prefix_code(cls, root_node: Node, prefix_code: Union[None, str]) -> dict:
    prefix_codes: dict = {}
    if root_node:
      if prefix_code:
        prefix_codes[root_node.value] = prefix_code
      prefix_codes = prefix_codes | cls.set_prefix_code(root_node=root_node.left, prefix_code=prefix_code + '0' if prefix_code else '0')
      prefix_codes = prefix_codes | cls.set_prefix_code(root_node=root_node.right, prefix_code=prefix_code + '1' if prefix_code else '1')
    
    return { key: value for key, value in prefix_codes.items() if key is not None }