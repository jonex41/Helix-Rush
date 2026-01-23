extends Node
#signal current_time(time_Remaining)


var disable_rotation_input:= false
var selectedBallScene:= "res://Scene/Balls/ball.tscn"
var initial_power_collision = 5
var initial_power_collision_timer = 3
var initial_power_antigravity = 5
var initial_power_antigravity_timer = 3
var power_is_active :=false
var initial_coin_balance = 10000
var initial_key_balance = 3
var pause_loosing_for_seconds:= false
var current_level = 1
var bounce_count = 0
var can_count_bounce = false
var is_playing = false
var can_play_sound = false
var can_vibrate = true


	
func reduce_power_antigravity()-> void:
	initial_power_antigravity-=1
	
func reduce_power_collision()-> void:
	initial_power_collision-=1
	
func add_power_antigravity()-> void:
	initial_power_antigravity+=1
	
func add_power_collision()-> void:
	initial_power_collision+=1
	
func set_is_power_active(is_active: bool)->void:
	power_is_active = is_active
	
func reduce_power_key()-> void:
	initial_key_balance-=1
	
func add_power_key()-> void:
	initial_key_balance+=1
	
func add_power_antigravity_timer()-> void:
	initial_power_antigravity_timer+=2
	
func add_power_collision_timer()-> void:
	initial_power_collision_timer+=2
	
func puase_lossing_stat()->void:
	pause_loosing_for_seconds= true
	await get_tree().create_timer(3.0).timeout
	pause_loosing_for_seconds= false
func increase_level()-> void:
	current_level+=1
	
func increase_ball_bounce()-> void:
	if can_count_bounce:
		bounce_count+=1
	
func can_count_num_bounce(canCount: bool)-> void:
	can_count_bounce = canCount
func set_is_playing(is_playing_inner: bool) :
	is_playing = is_playing_inner	

func set_can_play_sound(can_play: bool) :
	can_play_sound = can_play	


func reset():

	bounce_count = 0
	can_count_bounce = false
	


		
		


		
func format_money(amount: float) -> String:
	var abs_amount :float= abs(amount)
	var sign := "-" if amount < 0 else ""

	# Format small numbers with commas
	if abs_amount < 50_000:
		return sign + _format_with_commas(int(abs_amount))

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

		
