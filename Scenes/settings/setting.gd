extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if WorldManager.Settings:
		visible = true
	elif !WorldManager.Settings:
		visible = false

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)
	$NinePatchRect/MarginContainer/VBoxContainer/Volume/Label.text = str("Volume slider =" + str(value))

func _on_on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)
	
func _on_resolution_item_selected(index: int) -> void:
	match index:
		0: DisplayServer.window_set_size(Vector2i(1920,1080))
		1: DisplayServer.window_set_size(Vector2i(1600,900))
		2: DisplayServer.window_set_size(Vector2i(1280,720))


func _on_leave_pressed() -> void:
	WorldManager.Settings = false
	audio_stream_player.play()
