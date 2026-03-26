extends MarginContainer

func _ready():
	apply_safe_area()

func apply_safe_area():
	var safe = DisplayServer.get_display_safe_area()
	var screen = get_viewport().get_visible_rect()

	add_theme_constant_override("margin_left", safe.position.x)
	add_theme_constant_override("margin_top", safe.position.y)
	add_theme_constant_override("margin_right", screen.size.x - safe.end.x)
	add_theme_constant_override("margin_bottom", screen.size.y - safe.end.y)
