extends Control

@export var coin_scene: PackedScene
@export var coin_target: Node2D
@onready var test_coin_move: Node2D = $TestCoinMove

var total_coins: int = 0


func _ready():
	randomize()

	spawn_coins(5)
	


func spawn_coins(amount: int = 5):
	for i in amount:
		var coin = coin_scene.instantiate()
		add_child(coin)

		coin.global_position = test_coin_move.global_position
		coin.scale = Vector2(0.2, 0.2)

		animate_coin(coin, i)


func animate_coin(coin: Node2D, index: int) -> void:
	await get_tree().create_timer(index * 0.05).timeout

	var target_pos = coin_target.get_global_transform_with_canvas().origin

	# random spread (first stop position)
	var offset = Vector2(
		randf_range(-100, 100),
		randf_range(-120, -60)
	)

	var mid_pos = coin.global_position + offset

	# 🟢 START spinning (fake 3D)
	spin_coin(coin)

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	# ✨ pop in
	tween.tween_property(coin, "scale", Vector2(1, 1), 0.15)

	# 🟢 move to mid point
	tween.tween_property(coin, "global_position", mid_pos, 0.3)

	# 🟢 pause at mid point
	tween.tween_interval(0.2)

	# 🟢 move to UI
	tween.tween_property(coin, "global_position", target_pos, 0.5)

	# rotate (2D spin)
	tween.parallel().tween_property(
		coin, "rotation",
		randf_range(4.0, 8.0),
		0.8
	)

	# shrink into UI
	tween.parallel().tween_property(
		coin, "scale",
		Vector2(0.4, 0.4),
		0.8
	)

	await tween.finished

	queue_free()
	add_coin(1)


# 🟢 FAKE 3D ROTATION (flip on X axis)
func spin_coin(coin: Node2D):
	var tween = create_tween()
	tween.set_loops() # infinite loop

	tween.tween_property(coin, "scale:x", -1.0, 0.2)
	tween.tween_property(coin, "scale:x", 1.0, 0.2)


func add_coin(amount: int):
	total_coins += amount
	
	if has_node("CanvasLayer/TopBar/Label"):
		$CanvasLayer/TopBar/Label.text = str(total_coins)
