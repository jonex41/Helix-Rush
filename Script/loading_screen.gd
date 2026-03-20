extends Control

@onready var progress_bar = $MarginContainer/VBoxContainer/ProgressBar
var scenes_to_load = [
	"res://Scene/Ui/health_bar.tscn",
	"res://Scene/jetpack/jet_thruster.tscn",
	"res://Scene/main.tscn",
	"res://Scene/pick_up_vfx.tscn",
	"res://Scene/main.tscn",
	"res://Scene/play_ui.tscn",
	"res://Scene/Ui/play_ui_bottom.tscn",
	"res://Scene/jetpack_pick.tscn",
	"res://Scene/Balls/ball.tscn",
	"res://Scene/Balls/football_ruggy.tscn",
	"res://Scene/Balls/monkey_ball.tscn",
	"res://Scene/Balls/coin_ball.tscn",
]
var jetpack_scene = preload("res://Scene/jetpack/jet_thruster.tscn")
var healthbar_scene = preload("res://Scene/Ui/health_bar.tscn")
var loaded = 0
var total = 0
var texts = [
	"Collect coins to buy boost for powerup",
	"Use the jetpack to fly, the card at your left side",
	"Avoid obstacles on the way up- the reds spikes",
	"Key revives, collect them"
]
var index = 0
var last_index = -1


	

func swap_text():
	while true:
		var i = randi() % texts.size()
		
		while i == last_index:
			i = randi() % texts.size()
		
		last_index = i
		$MarginContainer/VBoxContainer/Label.text = texts[i]
		
		await get_tree().create_timer(3.0).timeout

func _ready():
	#await warmup_jetpack()
	$MarginContainer/VBoxContainer/Health_bar.set_bar_value(0)
	swap_text()
	total = scenes_to_load.size()
	load_next_scene()
func warmup_jetpack():
	var jetpack = jetpack_scene.instantiate()
	add_child(jetpack)
	var jetpack2 = healthbar_scene.instantiate()
	add_child(jetpack2)


	await get_tree().process_frame

	jetpack.queue_free()
func load_next_scene():
	if loaded >= total:
		finish_loading()
		return
		
	ResourceLoader.load_threaded_request(scenes_to_load[loaded])

func _process(delta):
	if loaded >= total:
		return
		
	var status = ResourceLoader.load_threaded_get_status(scenes_to_load[loaded])
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene = ResourceLoader.load_threaded_get(scenes_to_load[loaded])
		
		loaded += 1
		$MarginContainer/VBoxContainer/Health_bar.set_bar_value( float(loaded) / total * 100) 
		
		load_next_scene()

func finish_loading():
	print("All scenes loaded")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Scene/main.tscn")
