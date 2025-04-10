extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text : Label = $CenterContainer/Panel/Label
@onready var label_2: Label = $CenterContainer/Panel/Label2
@onready var texture_button: TextureButton = $TextureButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var slot_data: Inventory_Slot
var inventory: Inventory

var is_shop_slot = false  
@onready var player_inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")
@onready var hot_inv : Inventory = preload("res://Scenes/Inventory/Hot_bar.tres")
@onready var shop_inv : Inventory = preload("res://Scenes/Inventory/BS_Inventory.tres")

@onready var WOOD_BUNDLE = preload("res://Scenes/Item/Wood/Wood_bundle.tres")
@onready var RUBBER = preload("res://Scenes/Item/Rubber/Rubber.tres")
@onready var BOTTLES = preload("res://Scenes/Item/Bottle/Bottles.tres")

signal hovered_item(item_name : String)

func _ready():
	texture_button.connect("pressed", _on_texture_button_pressed)

func _process(_delta):
	if texture_button.is_hovered() and slot_data and slot_data.item:
		hovered_item.emit(slot_data.item.name)

func update(slot: Inventory_Slot, inv: Inventory, p_inv: Inventory, s_inv: Inventory, h_inv: Inventory, shop_mode: bool):
	slot_data = slot
	inventory = inv
	player_inv = p_inv
	shop_inv = s_inv
	hot_inv = h_inv
	is_shop_slot = shop_mode

	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
		label_2.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		label_2.visible = true
		label_2.text = slot.item.name

		if slot.item.name == "sword":
			item_visual.scale = Vector2(0.05, 0.05)
		elif slot.item.name == "health_p":
			item_visual.scale = Vector2(0.15, 0.15)
		else:
			item_visual.scale = Vector2(0.5, 0.5)  # Default scale

		if slot.amount > 1:
			amount_text.visible = true
			amount_text.text = str(slot.amount)
		else:
			amount_text.visible = false

func _on_texture_button_pressed():
	audio_stream_player.play()
	if not slot_data or not slot_data.item:
		return  

	var item = slot_data.item
	if not shop_inv or not player_inv or not hot_inv:
		return

	print("Before transaction:")
	print_inventory("Player Inventory", player_inv)
	print_inventory("Shop Inventory", shop_inv)
	print_inventory("Hotbar", hot_inv)


	if is_shop_slot and shop_inv.Has_Items(item, 1):
		if item.name == "sword" and player_inv.Has_Items(BOTTLES, 8) and player_inv.Has_Items(RUBBER, 4):
			Remove_cost(item)
			player_inv.insert(item, 1)
			shop_inv.Remove_Items(item, 1)

		elif item.name == "damage_buff" and player_inv.Has_Items(BOTTLES, 5) and player_inv.Has_Items(RUBBER, 5) and player_inv.Has_Items(WOOD_BUNDLE, 5):
			Remove_cost(item)
			player_inv.insert(item, 1)
			shop_inv.Remove_Items(item, 1)

		elif item.name == "health_p" and player_inv.Has_Items(BOTTLES, 5) and player_inv.Has_Items(WOOD_BUNDLE, 1):
			Remove_cost(item)
			player_inv.insert(item, 1)
			shop_inv.Remove_Items(item, 1)

	
	elif hot_inv.Has_Items(item, 1):  
		var transfer_amount = min(slot_data.amount, 1)  
		
		if hot_inv.Has_Items(item,1) && item.name == "health_p" && WorldManager.player_needs_healing:
			WorldManager.player_healed = true
			hot_inv.Remove_Items(item,1)
			
		if hot_inv.Has_Items(item, transfer_amount): 
			hot_inv.Remove_Items(item, transfer_amount)  
			player_inv.insert(item, transfer_amount) 
			
	
	elif player_inv.Has_Items(item, 1):  
		var transfer_amount = min(slot_data.amount, 1)  
		if player_inv.Has_Items(item, transfer_amount):  
			player_inv.Remove_Items(item, transfer_amount) 
			hot_inv.insert(item, transfer_amount) 

	print("After transaction:")
	print_inventory("Player Inventory", player_inv)
	print_inventory("Shop Inventory", shop_inv)
	print_inventory("Hotbar", hot_inv)

	player_inv.update.emit()
	hot_inv.update.emit()
	shop_inv.update.emit()


	print("After transaction:")
	print_inventory("Player Inventory", player_inv)
	print_inventory("Shop Inventory", shop_inv)
	print_inventory("Hotbar", hot_inv)



func print_inventory(name: String, inv: Inventory):
	print(name, "slots:")
	for slot in inv.slots:
		if slot.item:
			print(slot.item.name, "-", slot.amount)

func Remove_cost(item):
	if not item or not item.name:
		print("Error: Attempted to remove a null item!")
		return
	
	match item.name:
		"sword":
			player_inv.Remove_Items(BOTTLES, 8)
			player_inv.Remove_Items(RUBBER, 4)
		"health_p":
			player_inv.Remove_Items(BOTTLES, 5)
			player_inv.Remove_Items(WOOD_BUNDLE, 1)
		"damage_buff":
			player_inv.Remove_Items(BOTTLES, 5)
			player_inv.Remove_Items(WOOD_BUNDLE, 5)
			player_inv.Remove_Items(RUBBER, 5)
