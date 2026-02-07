extends Area3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body):
	

	if body.is_in_group("Player") && !GameTimer.pause_loosing_for_seconds:
		
		var rb := body as RigidBody3D
		EventBus.emit_signal("pause_game", true)
		#VIbrate
		# Camera shake
		
		# Mobile vibration
		Input.vibrate_handheld(500) # milliseconds

		#Vibrate

		# Stop all movement
		rb.freeze = true
		
		GameTimer.set_is_playing(false) 
		await get_tree().create_timer(1).timeout
		#get_tree().reload_current_scene()
		GameTimer.reset()
		GameTimer.disable_rotation_input = false
		#var scene = preload("res://blink_layer.tscn")
		
		get_tree().call_group("Levels", "show_hide_blink_screen")
		
		var scene = preload("res://Scene/game_over.tscn")
		var instance = scene.instantiate()
		add_child(instance)
		
		
