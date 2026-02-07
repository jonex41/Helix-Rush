extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.reset()
	$VBoxContainer/HBoxContainer/WordPress.text = 'Revive with your Key ('+str(GameTimer.initial_key_balance)+')'
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	


func _on_no_thanks_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	queue_free()
	pass # Replace with function body.


func _on_word_press_pressed() -> void:
	revive_game()
		
	pass # Replace with function body.


func _on_key_press_pressed() -> void:
	revive_game()
	pass # Replace with function body.
	
func revive_game()->void:
	if GameTimer.initial_key_balance >0:
		GameTimer.reduce_power_key()
		GameTimer.puase_lossing_stat()
		
		var balls := get_tree().get_nodes_in_group("Player")
		if balls.size() > 0:
			var rb: RigidBody3D = balls[0]
			rb.freeze = false
			rb.apply_impulse(Vector3.UP * 5)
		GameTimer.disable_rotation_input= false

		queue_free()
	else :
		get_tree().reload_current_scene()
		#var scene = preload("res://Scene/shop.tscn")
		#var instance = scene.instantiate()
		#get_tree().current_scene.add_child(instance)
		#queue_free()
		
