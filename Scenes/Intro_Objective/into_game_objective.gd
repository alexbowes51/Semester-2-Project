extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		audio_stream_player.play()
		WorldManager.Objective = false
		
	if WorldManager.Objective:
		visible = true
	elif !WorldManager.Objective:
		visible = false
