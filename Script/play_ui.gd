extends Control
var game_time := 0.0
var running := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/HBoxContainer/Panel/HBoxContainer/levelLabel.text = "Lv"+str(GameTimer.current_level)
	#$MarginContainer/VBoxContainer/HBoxContainer/Panel/HBoxContainer/levelLabel.text = "X"+str(1)
	pass # Replace with function body.



	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameTimer.is_playing:
		game_time += delta
	$MarginContainer/VBoxContainer/HBoxContainer/Panel/HBoxContainer/TimerLabel.text = get_formatted_time()
		
	$MarginContainer/VBoxContainer/HBoxContainer2/Panel2/HBoxContainer/CoinCount.text = str(ScoreManager.score)
	$MarginContainer/VBoxContainer/HBoxContainer3/Panel2/HBoxContainer/Label2.text= str(ScoreManager.key)
	pass




func _on_pause_play_button_pressed() -> void:
	var scene = preload("res://Scene/Ui/pause_canvas.tscn")
	var instance = scene.instantiate()
	GameTimer.set_is_playing(false) 
	add_child(instance)
	pass # Replace with function body.
	
func get_formatted_time() -> String:
	var total_seconds := int(game_time)
	var minutes := total_seconds / 60
	var seconds := total_seconds % 60
	return "%02d:%02d" % [minutes, seconds]
