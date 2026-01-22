extends Control
# Use Node3D if this is 3D (see note below)

func _process(delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	$CenterContainer/SpiningWheel.spin_wheel()
	
	pass # Replace with function body.


func _on_texture_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
