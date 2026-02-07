extends MenuButton

@export var audio_icon: Texture2D
@export var audio_icon_off: Texture2D
@export var vibrate_icon: Texture2D
@export var vibrate_icon_off: Texture2D
@export var privacy_icon: Texture2D
@export var icon_size := Vector2i(100, 100)

var popup: PopupMenu
var last_selected_id := -1

func _ready():
	popup = get_popup()
	var themes = Theme.new()

	# Set icon size for popup menu items
	themes.set_constant("icon_max_width", "PopupMenu", icon_size.x)
	themes.set_constant("icon_max_height", "PopupMenu", icon_size.y)

	popup.theme = themes
	popup.id_pressed.connect(_on_item_pressed)

	# Example items (optional if already added in editor)
	popup.clear()
	popup.add_item("Audio", 0)
	popup.add_item("Vibrate", 1)
	popup.add_item("Privacy", 2)

	# Set default icons
	#for i in popup.item_count:
	

	
	if GameTimer.can_play_sound :
		popup.set_item_icon(0, audio_icon)
	else :
		popup.set_item_icon(0, audio_icon_off)
			
	
	if GameTimer.can_vibrate :
		popup.set_item_icon(1, vibrate_icon)
	else :
		popup.set_item_icon(1, vibrate_icon_off)
	popup.set_item_icon(2, privacy_icon)

func _on_item_pressed(id: int):
	# Reset previous item icon
	

	# Set new selected icon
	var index := popup.get_item_index(id)
	if index == 0:
		GameTimer.can_play_sound= !GameTimer.can_play_sound
		if GameTimer.can_play_sound :
			popup.set_item_icon(index, audio_icon)
		else :
			popup.set_item_icon(index, audio_icon_off)
			
	if index == 1:
		GameTimer.can_vibrate= !GameTimer.can_vibrate
		if GameTimer.can_vibrate :
			popup.set_item_icon(index, vibrate_icon)
		else :
			popup.set_item_icon(index, vibrate_icon_off)

	if index == 2:
		var scene = preload("res://Scene/privacy.tscn")
		var instance = scene.instantiate()
		add_child(instance)


func _on_pressed() -> void:
	pass # Replace with function body.
