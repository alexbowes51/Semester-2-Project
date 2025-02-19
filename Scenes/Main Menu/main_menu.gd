extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	print("Start Pressed")
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")


func _on_options_pressed() -> void:
	print("options Pressed")
	pass # Replace with function body.


func _on_leave_pressed() -> void:
	print("quit Pressed")
	get_tree().quit()
