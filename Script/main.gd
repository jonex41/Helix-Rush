extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if GameTimer.can_play_sound:
		$AudioStreamPlayer3D.volume_db = -80
		$AudioStreamPlayer3D.play()
		var t = create_tween()
		t.tween_property($AudioStreamPlayer3D, "volume_db", 0, 0.25)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	play_loop()
	pass
func play_loop():
	if not $AudioStreamPlayer3D.playing && GameTimer.can_play_sound:
		$AudioStreamPlayer3D.volume_db = -80
		$AudioStreamPlayer3D.play()
		var t = create_tween()
		t.tween_property($AudioStreamPlayer3D, "volume_db", 0, 0.25)
	if !GameTimer.can_play_sound:
		$AudioStreamPlayer3D.stop()
		

func stop_loop():
	$AudioStreamPlayer3D.stop()
