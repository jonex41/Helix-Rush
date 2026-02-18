extends Button

var level_index := 0

func setup(level: int):
	level_index = level
	text = str(level)
	var score = 	int(GameTimer.get_value_unlocked_level(level))
	if score > 2:
		$VBoxContainer/HBoxContainer/TextureRect.visible = true
	if score >49:
		$VBoxContainer/HBoxContainer/TextureRect2.visible = true
	if score >74:
		$VBoxContainer/HBoxContainer/TextureRect3.visible = true
	
	if level % 10 == 0:
		$AnimatedSprite2D.visible = true
		#$AnimatedSprite2D.play()
	$VBoxContainer/Label.text = "Level "+str(level)
	if level > GameTimer.current_level :
		$ColorRect.visible = true
		
	else :	
		$VBoxContainer/HBoxContainer.visible = true
func _pressed():
	print("Level selected:", level_index)


func _on_pressed() -> void:
	print("my index", level_index)
	pass # Replace with function body.
