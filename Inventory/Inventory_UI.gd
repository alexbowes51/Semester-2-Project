extends Control

@onready var inv : Inventory = preload("res://Inventory/player_Inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func update_slots():
	for i in range(min(Inventory.items.size(), slots.size())):
		slots[i].update(Inventory.items[i])

func _ready():
	update_slots()
	close()
	
func open():
	visible = true
	is_open = true
	

func close():
	visible = false
	is_open = false
	
func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()
	
