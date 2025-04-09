extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blurr")
	visible = false

func pause():
	visible = true
	get_tree().paused = true
	$AnimationPlayer.play("blurr")
	
func tab():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()
		
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tab()
	
func _on_texture_button_pressed() -> void:
	resume()

func _on_texture_button_2_pressed() -> void:
	WorldManager.Settings = true



func _on_texture_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/Main Menu.tscn")

func _on_texture_button_4_pressed() -> void:
	get_tree().reload_current_scene()
