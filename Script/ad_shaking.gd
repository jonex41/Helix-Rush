extends TextureButton


@export var shake_strength := 12.0
@export var shake_duration := 0.35
@export var angle := -10.0        # degrees
@export var duration := 1.2     # seconds

var original_pos: Vector2

func _ready():
	pivot_offset = size / 2
	
	original_pos = position
	start_idle_shake()

func start_idle_shake():
	while true:
		await get_tree().create_timer(2.5).timeout
		start_rotation()

func play_shake():
	position = original_pos

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	var shakes := 8
	for i in shakes:
		var offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
		tween.tween_property(self, "position", original_pos + offset, shake_duration / shakes)

	tween.tween_property(self, "position", original_pos, 0.05)
	
func play_ad_shake():
	position = original_pos

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(self, "rotation", deg_to_rad(-5), 0.08)
	tween.tween_property(self, "rotation", deg_to_rad(5), 0.12)
	tween.tween_property(self, "rotation", deg_to_rad(-3), 0.1)
	tween.tween_property(self, "rotation", 0.0, 0.08)

func play_shake_scale():
	position = original_pos

	var tween := create_tween()
	tween.set_parallel(true)

	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)
	tween.tween_property(self, "scale", Vector2.ONE, 0.15)

	tween.set_parallel(false)

	for i in 6:
		var offset = Vector2(randf_range(-8, 8), 0)
		tween.tween_property(self, "position", original_pos + offset, 0.05)

	tween.tween_property(self, "position", original_pos, 0.05)

func start_rotation():
	var tween := create_tween()
	tween.set_loops() # infinite
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(self, "rotation", deg_to_rad(-angle), duration)
	tween.tween_property(self, "rotation", deg_to_rad(angle), duration)
