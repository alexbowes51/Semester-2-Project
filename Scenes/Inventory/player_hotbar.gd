extends Control

@onready var player_inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")
@onready var hb_inv : Inventory = preload("res://Scenes/Inventory/Hot_bar.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


func _ready():
	player_inv.update.connect(update_slots)
	hb_inv.update.connect(update_slots)
	update_slots()


#slot: Inventory_Slot, inv: Inventory, p_inv: Inventory, s_inv: Inventory,h_inv :Inventory, shop_mode: bool
func update_slots():	
	for i in range(min(player_inv.slots.size(), slots.size())):
		slots[i].update(player_inv.slots[i], player_inv, player_inv, hb_inv, hb_inv, false)  
		
	for i in range(min(hb_inv.slots.size(), slots.size())):
		slots[i].update(hb_inv.slots[i], hb_inv, player_inv, player_inv, hb_inv, false)  
		
	for slot in slots:
		if slot.has_signal("hovered_item"):  # Check if the slot has the signal
			slot.hovered_item.connect(on_item_hovered)

func open():
	visible = true

func close():
	visible = false

func _process(_delta):
	pass

func on_item_hovered(item_name : String):
	pass
	
	
