extends StaticBody3D

var bounce_count := 0
var was_moving_up := false




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_collision_shape_3d_child_exiting_tree(node: Node) -> void:
	
	pass # Replace with function body.


func _on_collision_shape_3d_2_child_exiting_tree(node: Node) -> void:
	pass # Replace with function body.
