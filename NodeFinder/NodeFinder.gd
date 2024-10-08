extends Node


func find_node_by_name(root_node: Node, node_name: String) -> Node:
	if !root_node:
		print("ERROR NODE FINDER: INVALID ROOT NODE")
		return
	if root_node.name == node_name:
		return root_node
	for child in root_node.get_children():
		if child is Node:
			var found_node = find_node_by_name(child, node_name)
			if found_node != null:
				return found_node
	return null
