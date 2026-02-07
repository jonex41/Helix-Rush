extends Control
# Use Node3D if this is 3D (see note below)
func _ready() -> void:
	EventBus.send_has_spin.connect(has_spin_wheel)

func has_spin_wheel(has_spin):
	$Button.text = "Spin Again" if has_spin else "Spinning"
	pass

func _process(_delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	$CenterContainer/SpiningWheel.spin_wheel()
	
	pass # Replace with function body.


func _on_texture_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
