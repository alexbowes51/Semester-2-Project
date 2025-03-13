extends Control

@onready var player_inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")
@onready var bs_inv : Inventory = preload("res://Scenes/Inventory/BS_Inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	player_inv.update.connect(update_slots)
	bs_inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(player_inv.slots.size(), slots.size())):
		slots[i].update(player_inv.slots[i], player_inv, bs_inv, player_inv, true)  # True for shop slots

	for i in range(min(bs_inv.slots.size(), slots.size())):
		slots[i].update(bs_inv.slots[i], bs_inv, bs_inv, player_inv, false)  # False for player slots
			

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
		
	
			
