extends Node3D

@export var thrust_vfx: Node3D
@export var sound: AudioStreamPlayer3D

# CARTOON TIMING
@export var burst_min := 0.05
@export var burst_max := 0.14
@export var pause_min := 0.05
@export var pause_max := 0.18

# SOUND GOOFINESS
@export var pitch_min := 0.8
@export var pitch_max := 1.5
@export var volume_min := 0.7
@export var volume_max := 1.0

var active := false

func start_thrust():
	if active:
		return
	active = true
	_cartoon_loop()

func stop_thrust():
	active = false
	_turn_off()

func _cartoon_loop():
	while active:
		# MAIN PULSE
		await _pulse(randf_range(burst_min, burst_max))

		# CARTOON DOUBLE BLINK
		if randf() < 0.45:
			await get_tree().create_timer(0.03).timeout
			await _pulse(randf_range(0.03, 0.06))

		await get_tree().create_timer(randf_range(pause_min, pause_max)).timeout

func _pulse(duration: float) -> void:
	# ON
	thrust_vfx.visible = true

	sound.pitch_scale = randf_range(pitch_min, pitch_max)
	sound.volume_db = linear_to_db(randf_range(volume_min, volume_max))

	# RESTART SOUND EVERY BLINK (CRITICAL)
	#sound.stop()
	sound.play()

	await get_tree().create_timer(duration).timeout

	# OFF
	_turn_off()

func _turn_off():
	thrust_vfx.visible = false
	sound.stop()
