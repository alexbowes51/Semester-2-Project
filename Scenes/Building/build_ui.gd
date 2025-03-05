extends Control

var is_open = false
@onready var wood_label: Label = $NinePatchRect/Wood/Wood_Label
@onready var bottles_label: Label = $NinePatchRect/Bottles/Bottles_Label
@onready var rubber_label: Label = $NinePatchRect/Rubber/Rubber_Label


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


	
func _process(delta):
	
		if is_open && WorldManager.player_in_build_zone == false:
			close()
	
		if Input.is_action_just_pressed("build_mode") && WorldManager.player_in_build_zone == true:
			
			if !is_open:
				open()
			else:
				close()
		
		if $NinePatchRect/GridContainer/house.button_pressed:
			WorldManager.building = "house"
			##print("building = " + str(WorldManager.building))
			if wood_label && bottles_label:
				wood_label.text = str(2)
				bottles_label.text = str(2)
			
			
			

		if $NinePatchRect/GridContainer/farm.button_pressed:
			WorldManager.building = "farm"
			##print("building = " + str(WorldManager.building))
			if wood_label && bottles_label:
				wood_label.text = str(2)
				bottles_label.text = str(2)
