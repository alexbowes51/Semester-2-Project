extends Control

@onready var inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")
@onready var bs_inv : Inventory = preload("res://Scenes/Inventory/BS_Inventory.tres")
@onready var hb_inv : Inventory = preload("res://Scenes/Inventory/Hot_bar.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


var is_open = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()
#(slot: Inventory_Slot, inv: Inventory, p_inv: Inventory, s_inv: Inventory, shop_mode: bool)
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i],inv,inv,bs_inv,hb_inv,false)
		
	for slot in slots:
		if slot.has_signal("hovered_item"):  # Check if the slot has the signal
			slot.hovered_item.connect(on_item_hovered)
			

func open():
	visible = true
	is_open = true
	

func close():
	visible = false
	is_open = false
	
func _process(_delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()
			

func on_item_hovered(item_name : String):
	pass
	
