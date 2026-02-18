extends CanvasLayer

var fireworks_scene: PackedScene = preload("res://Scene/firework2d.tscn")
var view_size: Vector2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	view_size = get_viewport().get_visible_rect().size

	spawn_firewaork()
	EventBus.send_has_spin.connect(check_has_spin)
	ScoreManager.reset()
	#await get_tree().create_timer(3.0).timeout
	#get_tree().change_scene_to_file("res://reward_system.tscn")


	pass # Replace with function body.
func check_has_spin(has_spin:bool, is_key:bool):
	$Control/VBoxContainer/ContinueReplay.visible = has_spin
	
	if is_key:
		animate_texture_move(
		preload("res://Assets/Atlas/key.png"),
		
		$Marker2DCenter,
		$Marker2DKey
		)
		print("is key")
	else :
		animate_texture_move(
		preload("res://Assets/images/Icon_Small_CoinDollar.png"),
		$Marker2DCenter,
		$Marker2DCoin
		)
		print('is coin')
	pass
func spawn_firewaork():
	var firework = fireworks_scene.instantiate()
	firework.position = rand_pos()
	add_child(firework)
	
func rand_pos()-> Vector2:
	var x_pos = randf() * view_size.x
	var y_pos = randf() * view_size.y
	return Vector2(x_pos, y_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	


func _on_no_thanks_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	#queue_free()
	GameTimer.decrease_level()
	get_tree().reload_current_scene()
	pass # Replace with function body.
	


func _on_timer_timeout() -> void:
	spawn_firewaork()
	pass # Replace with function body.


func _on_replay_btn_pressed() -> void:
	GameTimer.decrease_level()
	get_tree().reload_current_scene()
	pass # Replace with function body.
	

func animate_texture_move(
	texture: Texture2D,
	start_marker: Control,
	end_marker: Control
):
	var img := TextureRect.new()
	img.texture = texture
	img.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	# Start big
	img.scale = Vector2(2.0, 2.0)

	# Position at start marker
	img.position = start_marker.global_position

	add_child(img)

	var tween := create_tween()
	tween.set_parallel(false)

	# Move to end marker
	tween.tween_property(
		img,
		"global_position",
		end_marker.global_position,
		0.6
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# Scale down while arriving
	tween.parallel().tween_property(
		img,
		"scale",
		Vector2.ONE * 0.6,
		0.6
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	# Small delay
	tween.tween_interval(0.1)

	# Free it
	tween.tween_callback(img.queue_free)
	
