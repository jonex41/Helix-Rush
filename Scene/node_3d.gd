extends Node

@export var volume := 0.6

var playback: AudioStreamGeneratorPlayback
var phase := 0.0
var wobble_phase := 0.0
var pulse_phase := 0.0
var freq := 60.0

func _ready():
	var player := AudioStreamPlayer.new()
	var gen := AudioStreamGenerator.new()
	gen.mix_rate = 44100
	gen.buffer_length = 0.6

	player.stream = gen
	player.volume_db = linear_to_db(volume)
	add_child(player)
	player.play()

	playback = player.get_stream_playback()

func _process(delta):
	if playback.get_frames_available() > 0:
		_generate(delta)

func _generate(delta):
	var frames := playback.get_frames_available()

	# INSANE cartoon pitch ramp
	freq = lerp(freq, 800.0, delta * 0.9)

	for i in frames:
		wobble_phase += delta * 12.0
		pulse_phase += delta * 6.0

		var wobble := sin(wobble_phase) * 0.25
		var pulse = abs(sin(pulse_phase)) * 0.8

		phase += (freq * (1.0 + wobble)) / 44100.0
		phase = fmod(phase, 1.0)

		# CARTOON SOUND STACK
		var sine := sin(phase * TAU)
		var square = sign(sin(phase * TAU * 0.5))
		var noise := randf_range(-0.15, 0.15)

		var sample =sine * 0.5 +square * 0.35 +noise * pulse

		# HARD CLIP for silly distortion
		sample = clamp(sample * 1.4, -1.0, 1.0)

		playback.push_frame(Vector2(sample, sample))
