extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_flat(get_tree().current_scene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func apply_flat(node: Node):
	if node is MeshInstance3D:
		node.material_override = FlatMaterials.flat_material

	for child in node.get_children():
		apply_flat(child)
