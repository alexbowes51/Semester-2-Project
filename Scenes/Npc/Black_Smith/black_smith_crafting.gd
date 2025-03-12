extends Control

@onready var inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")
@onready var player_inv : Inventory = preload("res://Scenes/Inventory/BS_Inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	inv.update.connect(update_slots)
	player_inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i], inv, player_inv, inv, true)  # True for shop slots

	for i in range(min(player_inv.slots.size(), slots.size())):
		slots[i].update(player_inv.slots[i], player_inv, player_inv, inv, false)  # False for player slots
			

func open():
	visible = true
	is_open = true
	

func close():
	visible = false
	is_open = false
	
func _process(delta):
	if WorldManager.Bs_shop:
		open()
	elif !WorldManager.Bs_shop:
		close()
		
			
