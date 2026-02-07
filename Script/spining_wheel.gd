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

var spinning := false
var is_key := false
var _last_picked_segment := -1

func  _ready() -> void:
	EventBus.send_has_spin.emit(false, is_key)

func _draw() -> void:
	var offset = SPRITE_SIZE/-2
	
	draw_circle(Vector2.ZERO, outer_radius, bkg_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)
	
	if len(options)>=3 :
		#draw seprator lines
		for i in range(len(options)-1):
			var rads = TAU * i/((len(options)-1))
			var point = Vector2.from_angle(rads)
			draw_line(
				point* inner_radius,
				point*outer_radius,
				line_color,
				line_width,
				true
			)
	#draw_texture_rect_region(options[0].atlas, 
	#Rect2(offset, SPRITE_SIZE), options[0].region)
	for i in range(1, len(options)):
		var start_rads = (TAU*(i-1))/(len(options)-1)
		var end_rads = (TAU*i)/ (len(options)-1)
		var mid_rads = (start_rads+ end_rads)/2.0*-1
		var radius_mid = (inner_radius+ outer_radius)/2.0
		
		var draw_pos = radius_mid* Vector2.from_angle(mid_rads)+offset
		
		draw_texture_rect_region(options[i].atlas,
		Rect2(draw_pos, SPRITE_SIZE),
		options[i].region)
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()
	
	pass

#for spinning
func spin_wheel():
	if spinning:
		return
	EventBus.send_has_spin.emit(false, is_key)
	spinning = true

	var segment_angle := 360.0 / segments

	# 1. Pick random segment
	_last_picked_segment = randi_range(0, segments - 1)
	print(_last_picked_segment)
	# 2. Segment center
	var segment_center_angle := _last_picked_segment * segment_angle + segment_angle / 2.0

	# 3. Final target rotation (clockwise only)
	var target_rotation := -segment_center_angle
	target_rotation -= 360.0 * full_spins

	# 4. Split time
	var ease_in_time := spin_duration * ease_in_ratio
	var ease_out_time := spin_duration - ease_in_time

	# 5. Mid rotation (acceleration phase)
	var start_rotation := rotation_degrees
	var mid_rotation := start_rotation + (target_rotation - start_rotation) * 0.35

	# 6. Tween
	var tween := create_tween()

	# Ease-IN
	tween.tween_property(
		self,
		"rotation_degrees",
		mid_rotation,
		ease_in_time
	)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_IN)

	# Ease-OUT
	tween.tween_property(
		self,
		"rotation_degrees",
		target_rotation,
		ease_out_time
	)\
	.set_trans(Tween.TRANS_EXPO)\
	.set_ease(Tween.EASE_OUT)

	tween.finished.connect(_on_spin_finished)
	
func _on_spin_finished():
	EventBus.send_has_spin.emit(true, is_key)
	spinning = false

	# Normalize rotation so it stays clean
	_normalize_rotation()

	print("Landed on segment:", _last_picked_segment)

	if _last_picked_segment == 1:
		print('100 coins')
		GameTimer.initial_coin_balance+=100
		is_key = false
		pass
	elif _last_picked_segment == 2:
		print('200 coins')
		GameTimer.initial_coin_balance+=200
		is_key = false
		pass
	elif _last_picked_segment == 3:
		print('2 keys')
		GameTimer.initial_key_balance+=2
		is_key = true
		pass
	elif _last_picked_segment == 4:
		print('500 coins')
		GameTimer.initial_coin_balance+=500
		is_key = false
		pass
	elif _last_picked_segment == 5:
		print('300 coins')
		GameTimer.initial_coin_balance+=300
		is_key = false
		pass
	elif _last_picked_segment == 6:
		print('1 keys')
		GameTimer.initial_key_balance+=1
		is_key = true
		pass
	elif _last_picked_segment == 7:
		print('700 coins')
		GameTimer.initial_key_balance+=7
		is_key = false
		pass
		
		
	
func _normalize_rotation():
	rotation_degrees = fposmod(rotation_degrees, 360.0)
