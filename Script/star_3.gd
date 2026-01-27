extends TextureRect
@onready var marker := $"../../../../Marker2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	slide_in_with_overshoot()
	pass # Replace with function body.

func slide_in_with_overshoot():
	var final_pos := global_position
	global_position = marker.global_position

	var overshoot_offset := Vector2(25, 0) # tweak this

	var tween := create_tween()

	# Move past target
	tween.tween_property(
		self,
		"global_position",
		final_pos + overshoot_offset,
		0.45
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

	# Settle back
	tween.tween_property(
		self,
		"global_position",
		final_pos,
		0.2
	).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
