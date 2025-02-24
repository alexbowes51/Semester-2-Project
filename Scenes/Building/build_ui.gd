extends Control

var is_open = false
@onready var inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")



func _ready():
	inv.update
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
	
		if Input.is_action_just_pressed("build_mode"):
			
			if !is_open:
				open()
			else:
				close()

		if $NinePatchRect/GridContainer/house.button_pressed:
			WorldManager.building = "house"
			##print("building = " + str(WorldManager.building))
			
			
			

		if $NinePatchRect/GridContainer/farm.button_pressed:
			WorldManager.building = "farm"
			##print("building = " + str(WorldManager.building))

		if $"NinePatchRect/GridContainer/wall (TL)".button_pressed:
			WorldManager.building = "Wall_TL"
			print("building = " + str(WorldManager.building))

		if $"NinePatchRect/GridContainer/wall (S)".button_pressed:
			WorldManager.building = "Wall_S"
			print("building = " + str(WorldManager.building))

		if $"NinePatchRect/GridContainer/wall (TR)".button_pressed:
			WorldManager.building = "Wall_TR"
			print("building = " + str(WorldManager.building))

		if $"NinePatchRect/GridContainer/wall (L)".button_pressed:
			WorldManager.building = "Wall_L"
			print("building = " + str(WorldManager.building))

		if $"NinePatchRect/GridContainer/wall (R)".button_pressed:
			WorldManager.building = "Wall_R"
			print("building = " + str(WorldManager.building))

		if $"NinePatchRect/GridContainer/wall (BR)".button_pressed:
			WorldManager.building = "Wall_BR"
			print("building = " + str(WorldManager.building))

		if $"NinePatchRect/GridContainer/wall (BL)".button_pressed:
			WorldManager.building = "Wall_BL"
			print("building = " + str(WorldManager.building))
