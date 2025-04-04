extends Node2D

@onready var camera_2d: Camera2D = $Path2D/PathFollow2D/Camera2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D



var path_follow = false
var open_scene = false
var played = false
var played2 = false
func ready():
	cutscenceopening()
	
func cutscenceopening():
	
	if !played:
		played = true
		animation_player.play("fade_in")
		open_scene = true
		path_follow = true
		camera_2d.enabled = true
	
func cutsceneclose():
	
	if !played2:
		played2 = true
		animation_player.play("Fade_out")
		open_scene = false
		path_follow = false
		get_tree().change_scene_to_file("res://Scenes/World/world.tscn")
	
	
func _process(delta: float) -> void:
		cutscenceopening()
		if path_follow_2d:
			path_follow_2d.progress_ratio += 0.00015
		
			
			if path_follow_2d.progress_ratio >= 0.9990:
				cutsceneclose()
