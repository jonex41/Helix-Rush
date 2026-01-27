extends CanvasLayer

var fireworks_scene: PackedScene = preload("res://Scene/firework2d.tscn")
var view_size: Vector2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	view_size = get_viewport().get_visible_rect().size

	spawn_firewaork()
	
	ScoreManager.reset()
	#await get_tree().create_timer(3.0).timeout
	#get_tree().change_scene_to_file("res://reward_system.tscn")


	pass # Replace with function body.

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
	
	
