extends Node
#signal current_time(time_Remaining)

const SAVE_PATH := "user://savegame.json"
var disable_rotation_input:= false
var selectedBallScene:= "res://Scene/Balls/ball.tscn"
var initial_power_collision:int = 5
var initial_power_collision_timer:int = 3
var initial_power_antigravity: int = 5
var initial_power_antigravity_timer:int = 3
var initial_coin_balance: int = 10000
var initial_key_balance:int = 3
var power_is_active :=false
var pause_loosing_for_seconds:= false
var current_level :int = 1
var bounce_count :int= 0
var can_count_bounce = false
var is_playing = false
var can_play_sound = true
var can_vibrate = true
var current_color_background: float = 0
var unlocked_levels: Array = []

func _ready() -> void:
	load_data()

func update_initial_coin_balance(value : int , is_remove: bool)-> void:
	if is_remove:
		initial_coin_balance-=value
	else :
		initial_coin_balance+=value
	save()
func reduce_power_antigravity()-> void:
	initial_power_antigravity-=1
	save()
	
func reduce_power_collision()-> void:
	initial_power_collision-=1
	save()
	
func add_power_antigravity()-> void:
	initial_power_antigravity+=1
	save()
	
func add_power_collision()-> void:
	initial_power_collision+=1
	save()
	
func set_is_power_active(is_active: bool)->void:
	power_is_active = is_active
	
func reduce_power_key()-> void:
	initial_key_balance-=1
	save()
	
func add_power_key()-> void:
	initial_key_balance+=1
	save()
	
func add_power_antigravity_timer()-> void:
	initial_power_antigravity_timer+=2
	save()
	
func add_power_collision_timer()-> void:
	initial_power_collision_timer+=2
	save()
	
func puase_lossing_stat()->void:
	pause_loosing_for_seconds= true
	await get_tree().create_timer(3.0).timeout
	pause_loosing_for_seconds= false
func increase_level()-> void:
	current_level+=1
	save()

func decrease_level()-> void:
	current_level-=1
	save()
	
func increase_ball_bounce()-> void:
	if can_count_bounce:
		bounce_count+=1
		
	
func can_count_num_bounce(canCount: bool)-> void:
	can_count_bounce = canCount
func set_is_playing(is_playing_inner: bool) :
	is_playing = is_playing_inner	

func set_can_play_sound(can_play: bool) :
	can_play_sound = can_play	
	save()
	
func set_can_vibrate(can_play: bool) :
	can_vibrate = can_play	
	save()

func increase_current_color_background()-> void:
	current_color_background+=1

func decrease_current_color_background()-> void:
	current_color_background-=1
func reset():

	bounce_count = 0
	can_count_bounce = false
	
	
func add_unlocked_level(level_name: String) -> void:
		unlocked_levels.append(level_name)
		save()
func get_value_unlocked_level(index : int)-> String:
	#print("my index", index)
	#print("my levels", unlocked_levels)
	index = index-1
	if index >= 0 and index < unlocked_levels.size():
		return unlocked_levels[index]
	return "-1"
	
		
		


		
func format_money(amount: float) -> String:
	var abs_amount :float= abs(amount)
	var sign_me := "-" if amount < 0 else ""

	# Format small numbers with commas
	if abs_amount < 50_000:
		return sign_me + _format_with_commas(int(abs_amount))

	var value := 0.0
	var suffix := ""

	if abs_amount >= 1_000_000_000:
		value = abs_amount / 1_000_000_000
		suffix = "B"
	elif abs_amount >= 1_000_000:
		value = abs_amount / 1_000_000
		suffix = "M"
	else:
		value = abs_amount / 1_000
		suffix = "K"

	var text := "%.1f" % value
	if text.ends_with(".0"):
		text = text.left(text.length() - 2)

	return "%s%s%s" % [sign, text, suffix]

func _format_with_commas(value: int) -> String:
	var s := str(value)
	var result := ""
	var count := 0

	for i in range(s.length() - 1, -1, -1):
		result = s[i] + result
		count += 1
		if count == 3 and i != 0:
			result = "," + result
			count = 0

	return result
## for saving data	


# 🔹 SAVE / LOAD
func save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify({
		"current_level": current_level,
		"can_play_sound": can_play_sound,
		"can_vibrate": can_vibrate,
		"initial_power_collision" :initial_power_collision ,
		"initial_power_collision_timer" :initial_power_collision_timer ,
		"initial_power_antigravity" :initial_power_antigravity ,
		"initial_power_antigravity_timer" :initial_power_antigravity_timer ,
		"initial_coin_balance" :initial_coin_balance ,
		"initial_key_balance" :initial_key_balance ,
		"unlocked_levels" : unlocked_levels
	}))
	file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()

	if data:
		current_level = data.get("current_level", 0)
		can_vibrate = data.get("can_vibrate", 0)
		can_play_sound = data.get("can_play_sound", 0)
		initial_power_collision = data.get("initial_power_collision", 5)
		initial_power_collision_timer = data.get("initial_power_collision_timer", 3)
		initial_power_antigravity = data.get("initial_power_antigravity", 5)
		initial_power_antigravity_timer = data.get("initial_power_antigravity_timer", 3)
		initial_coin_balance = data.get("initial_coin_balance", 10000)
		initial_key_balance = data.get("initial_key_balance", 3)
		unlocked_levels = data.get("unlocked_levels", [])




		

		
