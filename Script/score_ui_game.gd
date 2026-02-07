extends Control
@onready var green_score: Label = $PanelContainer/MarginContainer/PanelContainer/MarginContainer/Control/PanelContainer/VBoxContainer/MarginContainer/PanelContainer/HBoxContainer/PanelContainer3/HBoxContainer/GreenScore
@onready var green_yellow_score: Label = $PanelContainer/MarginContainer/PanelContainer/MarginContainer/Control/PanelContainer/VBoxContainer/MarginContainer2/PanelContainer/HBoxContainer/PanelContainer3/HBoxContainer/GreenYellowScore
@onready var red_score: Label = $PanelContainer/MarginContainer/PanelContainer/MarginContainer/Control/PanelContainer/VBoxContainer/MarginContainer3/PanelContainer/HBoxContainer/PanelContainer3/HBoxContainer/RedScore
@onready var total_score: Label = $PanelContainer/MarginContainer/PanelContainer/MarginContainer/Control/PanelContainer/VBoxContainer/MarginContainer4/PanelContainer/HBoxContainer/PanelContainer3/HBoxContainer/TotalScore
var total:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animate_score(0,ScoreManager.green,green_score )
	animate_score(0,ScoreManager.green_yellow,green_yellow_score )
	animate_score(0,ScoreManager.red,red_score )
	total = ScoreManager.green+ScoreManager.green_yellow+ScoreManager.red
	animate_score(0,total,total_score )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func animate_score(from: int, to: int, total_score: Label ):
	total_score.scale = Vector2.ONE

	var tween := create_tween()

	tween.tween_method(
		func(v):
			total_score.text = str(int(v)),
		from,
		to,
		0.8
	)

	tween.parallel().tween_property(
		total_score,
		"scale",
		Vector2(1.2, 1.2),
		0.2
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween.tween_property(
		total_score,
		"scale",
		Vector2.ONE,
		0.2
	)


func _on_continue_pressed() -> void:
	#queue_free()
	
	ScoreManager.green=0
	ScoreManager.green_yellow=0
	ScoreManager.red=0
	if total >=75:
		get_parent().get_parent().get_parent().swap()
	else :
		get_tree().reload_current_scene()
	pass # Replace with function body.
