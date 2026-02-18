@tool
extends Control


@export var bkg_color : Color
@export var line_color: Color

@export var outer_radius:int = 256
@export var inner_radius:int = 64
@export var line_width:int = 4

@export var options : Array[WheelOption]
const SPRITE_SIZE = Vector2(200, 200)

#for spiniing

@export var segments := 6

# Fixed spin behavior
@export var full_spins := 12
@export var spin_duration := 4.5
@export var ease_in_ratio := 0.1
@export var speed: int = 10
@export var power: int = 2
var spinning := false
var is_key := false
var _last_picked_segment := -1
@export var reward_position = 0

func  _ready() -> void:
	EventBus.send_has_spin.emit(false, is_key)

func _draw() -> void:
	var offset = SPRITE_SIZE / -2

# Background
	draw_circle(Vector2.ZERO, outer_radius, bkg_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)

	var count := len(options)

	if count >= 2:
	# Draw separator lines
		for i in range(count):
			var rads = TAU * i / count
			var point = Vector2.from_angle(rads)
			draw_line(
			point * inner_radius,
			point * outer_radius,
			line_color,
			line_width,
			true
			)

# Draw textures
	for i in range(count):
		var start_rads = TAU * i / count
		var end_rads = TAU * (i + 1) / count
		var mid_rads = (start_rads + end_rads) / 2.0
	
		var radius_mid = (inner_radius + outer_radius) / 2.0
		var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + offset
	
		draw_texture_rect_region(
		options[i].atlas,
		Rect2(draw_pos, SPRITE_SIZE),
		options[i].region
		)
	#var offset = SPRITE_SIZE/-2
	#
	#draw_circle(Vector2.ZERO, outer_radius, bkg_color)
	#draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)
	#
	#if len(options)>=3 :
		##draw seprator lines
		#for i in range(len(options)-1):
			#var rads = TAU * i/((len(options)-1))
			#var point = Vector2.from_angle(rads)
			#draw_line(
				#point* inner_radius,
				#point*outer_radius,
				#line_color,
				#line_width,
				#true
			#)
#
	#for i in range(1, len(options)):
		#var start_rads = (TAU*(i-1))/(len(options)-1)
		#var end_rads = (TAU*i)/ (len(options)-1)
		#var mid_rads = (start_rads+ end_rads)/2.0*-1
		#var radius_mid = (inner_radius+ outer_radius)/2.0
		#
		#var draw_pos = radius_mid* Vector2.from_angle(mid_rads)+offset
		#
		#draw_texture_rect_region(options[i].atlas,
		#Rect2(draw_pos, SPRITE_SIZE),
		#options[i].region)
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()
	
	pass

#for spinning
func spin_wheel():
	spinning = true
	if GameTimer.can_play_sound :
		$"../../AudioStreamPlayer3D".play()
	var slice_count = options.size()
	var slice_size = 360.0 / slice_count
	var slice_index = randi() % slice_count
	EventBus.send_has_spin.emit(true, is_key)

# Center of slice
	var slice_angle = slice_index * slice_size + slice_size / 2

# 12 o'clock in Godot = 270°
	var target_angle = 270 - slice_angle

# Normalize current rotation
	var current_rotation = fmod(rotation_degrees, 360)
	if current_rotation < 0:
		current_rotation += 360

# Force clockwise spin
	var delta = target_angle - current_rotation
	if delta < 0:
		delta += 360

# Big dramatic spins
	var extra_spins = 360 * 6

# Final resting rotation
	var final_rotation = rotation_degrees + delta + extra_spins

# ✨ Overshoot amount (small bounce past target)
	var overshoot_amount = slice_size * 0.35

	var tween = get_tree().create_tween()

# Main spin (fast → slow)
	tween.tween_property(self, "rotation_degrees", final_rotation + overshoot_amount, 3.0)\
	.set_trans(Tween.TRANS_QUINT)\
	.set_ease(Tween.EASE_OUT)

# Bounce back settle
	tween.tween_property(self, "rotation_degrees", final_rotation, 0.35)\
	.set_trans(Tween.TRANS_BACK)\
	.set_ease(Tween.EASE_OUT)

	tween.finished.connect(func():
		rotation_degrees = fmod(rotation_degrees, 360)
		print("Winner:", options[slice_index].name)
		spinning = false
		if int(options[slice_index].name)>2:
			EventBus.send_has_spin.emit(true, false)
		else :
			EventBus.send_has_spin.emit(true, true)
		var my_value = options[slice_index].name
		if my_value == "100":
		#print('700 coins')
			GameTimer.initial_coin_balance+=100
		#is_key = false
		#pass
		elif my_value == "200":
		#print('100 coins')
			GameTimer.initial_coin_balance+=200
		#is_key = false
		#pass
		elif  my_value == "2 key":
		##print('100 coins')
		##
			GameTimer.initial_key_balance+=2
		##is_key = true
		##pass
		elif my_value == "500":
		#print('2 keys')
		#
			GameTimer.initial_coin_balance+=500
		#is_key = false
		#pass
		elif  my_value == "300":
		#print('500 coins')
		#
			GameTimer.initial_coin_balance+=300
		#is_key = false
		#pass
		elif  my_value == "1 key":
		#print('1 keys')
		#
			GameTimer.initial_key_balance+=1
		#is_key = true
		#pass
		elif  my_value == "700":
		#
		#print('700 coins')
			GameTimer.initial_coin_balance+=700
		#is_key = false
		#pass
			
	)
		
		#tween.finished.connect(_on_spin_finished)
	#if spinning:
		#return
	#EventBus.send_has_spin.emit(false, is_key)
	#spinning = true
#
	#var segment_angle := 360.0 / segments
#
	## 1. Pick random segment
	#_last_picked_segment = randi_range(0, segments - 1)
	#print(_last_picked_segment)
	## 2. Segment center
	#var segment_center_angle := _last_picked_segment * segment_angle + segment_angle / 2.0
#
	## 3. Final target rotation (clockwise only)
	#var target_rotation := -segment_center_angle
	#target_rotation -= 360.0 * full_spins
#
	## 4. Split time
	#var ease_in_time := spin_duration * ease_in_ratio
	#var ease_out_time := spin_duration - ease_in_time
#
	## 5. Mid rotation (acceleration phase)
	#var start_rotation := rotation_degrees
	#var mid_rotation := start_rotation + (target_rotation - start_rotation) * 0.35
#
	## 6. Tween
	#var tween := create_tween()
#
	## Ease-IN
	#tween.tween_property(
		#self,
		#"rotation_degrees",
		#mid_rotation,
		#ease_in_time
	#)\
	#.set_trans(Tween.TRANS_QUAD)\
	#.set_ease(Tween.EASE_IN)
#
	## Ease-OUT
	#tween.tween_property(
		#self,
		#"rotation_degrees",
		#target_rotation,
		#ease_out_time
	#)\
	#.set_trans(Tween.TRANS_EXPO)\
	#.set_ease(Tween.EASE_OUT)

	#tween.finished.connect(_on_spin_finished)
	
func _on_spin_finished():
	EventBus.send_has_spin.emit(true, is_key)
	spinning = false

	# Normalize rotation so it stays clean
	#_normalize_rotation()
#
	#print("Landed on segment:", _last_picked_segment)
#
	#if _last_picked_segment == 0:
		#print('700 coins')
		#GameTimer.initial_coin_balance+=100
		#is_key = false
		#pass
	#elif _last_picked_segment == 1:
		#print('100 coins')
		#GameTimer.initial_coin_balance+=200
		#is_key = false
		#pass
	##elif _last_picked_segment == 2:
		##print('100 coins')
		##
		##GameTimer.initial_key_balance+=2
		##is_key = true
		##pass
	#elif _last_picked_segment ==2:
		#print('2 keys')
		#
		#GameTimer.initial_coin_balance+=500
		#is_key = false
		#pass
	#elif _last_picked_segment == 3:
		#print('500 coins')
		#
		#GameTimer.initial_coin_balance+=300
		#is_key = false
		#pass
	#elif _last_picked_segment == 4:
		#print('1 keys')
		#
		#GameTimer.initial_key_balance+=1
		#is_key = true
		#pass
	#elif _last_picked_segment == 5:
		#
		#print('700 coins')
		#GameTimer.initial_key_balance+=7
		#is_key = false
		#pass
		
		
	
func _normalize_rotation():
	rotation_degrees = fposmod(rotation_degrees, 360.0)
