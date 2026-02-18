extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$VBoxContainer/MarginContainer3/VBoxContainer2/VBoxContainer/MarginContainer/Panel/HBoxContainer/VBoxContainer/Panel/Power1.text = str(GameTimer.initial_power_antigravity)
	$VBoxContainer/MarginContainer3/VBoxContainer2/VBoxContainer2/MarginContainer/Panel/HBoxContainer/VBoxContainer/Panel/Power2.text = str(GameTimer.initial_power_collision)
	$VBoxContainer/MarginContainer2/HBoxContainer/HBoxContainer/LevelLabel.text = "Lv"+str(GameTimer.current_level)
	#$VBoxContainer/MarginContainer2/HBoxContainer/HBoxContainer/LevelLabel.text = "X"+str(1)
	pass


func _on_texture_button_pressed() -> void:
	$".".queue_free()
	
	GameTimer.reset()
	GameTimer.disable_rotation_input= false
	var scene = preload("res://Scene/play_ui.tscn")
	var instance = scene.instantiate()
	get_tree().current_scene.add_child(instance)
	#add objective to the screen
	
	
	

	pass # Replace with function body.


func _on_shop_pressed() -> void:
	var scene = preload("res://Scene/shop.tscn")
	var instance = scene.instantiate()
	add_child(instance)
	pass # Replace with function body.


func _on_skins_pressed() -> void:
	var scene = preload("res://Scene/Ui/skin.tscn")
	var instance = scene.instantiate()
	add_child(instance)
	pass # Replace with function body.


func _on_map_pressed() -> void:
	var scene = preload("res://Scene/Ui/level_map.tscn")
	var instance = scene.instantiate()
	add_child(instance)
	pass # Replace with function body.


func _on_power_2_add_pressed() -> void:
	if GameTimer.initial_coin_balance > 999:
		GameTimer.add_power_collision()
		GameTimer.update_initial_coin_balance(1000, true)
	pass # Replace with function body.


func _on_power_1_add_pressed() -> void:
	if GameTimer.initial_coin_balance > 1999:
		GameTimer.add_power_antigravity()
		GameTimer.update_initial_coin_balance(2000, true)
		
	pass # Replace with function body.


func _on_league_pressed() -> void:
	pass # Replace with function body.
