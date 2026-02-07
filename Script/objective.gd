extends Control

func _ready():
	# Start off-screen (left)
	position.x = -size.x

	# Animate to center (0)
	var tween := create_tween()
	tween.tween_property(
		self,
		"position:x",
		0,
		0.6
	)\
	.set_trans(Tween.TRANS_CUBIC)\
	.set_ease(Tween.EASE_OUT)
func _process(_delta: float) -> void:
	$MarginContainer/CenterContainer2/BallBounceCount.text= str(GameTimer.bounce_count)
