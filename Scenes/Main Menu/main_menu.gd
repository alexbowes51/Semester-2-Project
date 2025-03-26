extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(6).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	audio_stream_player.play()
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/World/world.tscn")


func _on_options_pressed() -> void:
	audio_stream_player.play()
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(3).timeout
	pass # Replace with function body.


func _on_leave_pressed() -> void:
	audio_stream_player.play()
	$AnimationPlayer.play("fade_out")
	get_tree().quit()
