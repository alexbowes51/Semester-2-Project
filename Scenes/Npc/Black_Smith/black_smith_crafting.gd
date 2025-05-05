extends Control

@onready var player_inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")
@onready var bs_inv : Inventory = preload("res://Scenes/Inventory/BS_Inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

@onready var b_label: Label = $NinePatchRect/GridContainer/Control/bottle/Label
@onready var r_label: Label = $NinePatchRect/GridContainer/Control/rubber/Label
@onready var w_label: Label = $NinePatchRect/GridContainer/Control/wood/Label


var is_open = false

func _ready():
	player_inv.update.connect(update_slots)
	bs_inv.update.connect(update_slots)
	update_slots()
	close()
#slot: Inventory_Slot, inv: Inventory, p_inv: Inventory, s_inv: Inventory,h_inv :Inventory, shop_mode: bool
func update_slots():
	for i in range(min(player_inv.slots.size(), slots.size())):
		slots[i].update(player_inv.slots[i], player_inv, player_inv, bs_inv, bs_inv, false)  # Player selling

	for i in range(min(bs_inv.slots.size(), slots.size())):
		slots[i].update(bs_inv.slots[i], bs_inv, player_inv, bs_inv, bs_inv, true) 
		

func open():
	visible = true
	is_open = true
	

func close():
	visible = false
	is_open = false
	
func _process(_delta):
	if WorldManager.Bs_shop:
		open()
	elif !WorldManager.Bs_shop:
		close()
		
	
func on_item_hovered(item_name : String):
	match item_name:
		"sword":
			r_label.text = str(4)
			b_label.text = str(8)
			w_label.text = str(0)
		"health_p":
			b_label.text = str(5)
			w_label.text = str(1)
			r_label.text = str(0)
		"damage_buff":
			b_label.text = str(5)
			w_label.text = str(5)
			r_label.text = str(5)
		"":
			b_label.text = str(0)
			w_label.text = str(0)
			r_label.text = str(0)

	
			
