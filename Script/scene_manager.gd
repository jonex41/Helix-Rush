extends Node

var scene_stack: Array[String] = []

# Normal navigation (can go back)
func go_to(scene_path: String):
	var current := get_tree().current_scene
	if current:
		scene_stack.push_back(current.scene_file_path)

	get_tree().change_scene_to_file(scene_path)

# Replace current scene (no back to it)
func replace_with(scene_path: String):
	get_tree().change_scene_to_file(scene_path)

# Go back safely
func go_back():
	if scene_stack.is_empty():
		return

	var previous_scene = scene_stack.pop_back()
	get_tree().change_scene_to_file(previous_scene)

# Reset to start screen
func go_to_start(start_scene_path: String):
	scene_stack.clear()
	get_tree().change_scene_to_file(start_scene_path)
