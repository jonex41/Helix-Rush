extends CanvasLayer

@export var total_levels: int = 500
@export var button_scene: PackedScene

@onready var content := $LevelMap/ScrollContainer/VBoxContainer
@onready var scroll := $LevelMap/ScrollContainer

func _ready():
	generate_level_list()

func generate_level_list():
	# Optional: clear previous
	#content.clear()

	# Create buttons 1 → total_levels
	for i in total_levels:
		var btn = button_scene.instantiate()
		btn.setup(i + 1)  # level index (1-based)
		content.add_child(btn)
	scroll_to_index(GameTimer.current_level)
	
	
	
	


func _on_texture_button_pressed() -> void:
	queue_free()
	pass # Replace with function body.
func _process(_delta: float) -> void:
	
	pass
	#scroll_to_index_centered(300)
	
var scroll_tween: Tween

func scroll_to_index(index: int):


	if index < 0 or index >= content.get_child_count():
		return

	await get_tree().process_frame

	var target := content.get_child(index)
	var target_scroll = target.position.y

	if scroll_tween and scroll_tween.is_running():
		scroll_tween.kill()

	scroll_tween = create_tween()
	scroll_tween.tween_property(
		scroll,
		"scroll_vertical",
		target_scroll,
		0.35
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
