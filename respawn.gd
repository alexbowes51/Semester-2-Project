extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")


func _on_texture_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/Main Menu.tscn")
