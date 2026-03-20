extends CanvasLayer
@onready var btn_sound: TextureButton = $Pause/MarginContainer/VBoxContainer/HBoxContainer/SoundButton
@onready var btn_vibrate: TextureButton = $Pause/MarginContainer/VBoxContainer/HBoxContainer/VibrateButton
var sound1 = load("res://Assets/images/Icon_Large_Audio_Blank.png")
var sound2 = load("res://Assets/images/Icon_Large_AudioOff_Grey.png")
var vibrate1 = load("res://Assets/images/vibrate.png")
var vibrate2 = load("res://Assets/images/vibrate_cancel.PNG")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Pause/MarginContainer/VBoxContainer/Label.text = "Level "+str(GameTimer.current_level)
	#Sound
	#GameTimer.set_can_play_sound(!GameTimer.can_play_sound)
	if GameTimer.can_play_sound :
		btn_sound.texture_normal = sound1
	else :
		btn_sound.texture_normal = sound2
	
	#Vibrate
	#GameTimer.set_can_vibrate(!GameTimer.can_vibrate)
	if GameTimer.can_vibrate :
		btn_vibrate.texture_normal = vibrate1
	else :
		btn_vibrate.texture_normal = vibrate2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	queue_free()
	pass # Replace with function body.


func _on_home_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_sound_button_pressed() -> void:
	
	GameTimer.set_can_play_sound(!GameTimer.can_play_sound)
	if GameTimer.can_play_sound :
		btn_sound.texture_normal = sound1
	else :
		btn_sound.texture_normal = sound2
	pass # Replace with function body.


func _on_vibrate_button_pressed() -> void:
	GameTimer.set_can_vibrate(!GameTimer.can_vibrate)
	if GameTimer.can_vibrate :
		btn_vibrate.texture_normal = vibrate1
	else :
		btn_vibrate.texture_normal = vibrate2
	pass # Replace with function body.
