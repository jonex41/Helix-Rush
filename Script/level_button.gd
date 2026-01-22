extends Button

var level_index := 0

func setup(level: int):
	level_index = level
	text = str(level)
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
