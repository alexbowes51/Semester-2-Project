extends Control

var is_open = false
@onready var wood_label: Label = $NinePatchRect/Wood/Wood_Label
@onready var bottles_label: Label = $NinePatchRect/Bottles/Bottles_Label
@onready var rubber_label: Label = $NinePatchRect/Rubber/Rubber_Label
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	close()


func open():
	visible = true
	is_open = true
	WorldManager.Build_mode = true
	

func close():
	WorldManager.Build_mode = false
	visible = false
	is_open = false


	
func _process(_delta):
	
		if is_open && WorldManager.player_in_build_zone == false:
			close()
	
		if Input.is_action_just_pressed("build_mode") && WorldManager.player_in_build_zone == true && WorldManager.player_talking_Black_Smith == false && WorldManager.player_talking_Merchant == false:
			if is_open:
				close()
			else:
				open()
		
		if WorldManager.Build_mode == true && WorldManager.player_talking_Merchant == true or WorldManager.player_talking_Black_Smith == true:
			close()
		

		
		if $NinePatchRect/GridContainer/house.button_pressed:
			audio_stream_player.play()
			WorldManager.building = "house"
			if wood_label && bottles_label:
				wood_label.text = str(2)
				bottles_label.text = str(2)
			
			
		if $NinePatchRect/GridContainer/farm.button_pressed:
			audio_stream_player.play()
			WorldManager.building = "farm"
			if wood_label && bottles_label:
				wood_label.text = str(2)
				bottles_label.text = str(2)

		if $NinePatchRect/GridContainer/black_smith.button_pressed:
			audio_stream_player.play()
			WorldManager.building = "black_smith"
			if wood_label && bottles_label:
				wood_label.text = str(2)
				bottles_label.text = str(2)
