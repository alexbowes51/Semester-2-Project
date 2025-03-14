extends Panel



@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text : Label = $CenterContainer/Panel/Label
@onready var label_2: Label = $CenterContainer/Panel/Label2
@onready var texture_button: TextureButton = $TextureButton

var slot_data: Inventory_Slot
var inventory: Inventory
var shop_inv: Inventory
var is_shop_slot = false  
@onready var player_inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")

@onready var WOOD_BUNDLE = preload("res://Scenes/Item/Wood/Wood_bundle.tres")
@onready var RUBBER = preload("res://Scenes/Item/Rubber/Rubber.tres")
@onready var BOTTLES = preload("res://Scenes/Item/Bottle/Bottles.tres")

func _ready():
	texture_button.connect("pressed", _on_texture_button_pressed)

func update(slot: Inventory_Slot, inv: Inventory, p_inv: Inventory, s_inv: Inventory, shop_mode: bool):
	slot_data = slot
	inventory = inv
	player_inv = p_inv
	shop_inv = s_inv
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

		if slot.item.name in ["sword", "damage_buff"]:
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

func _on_texture_button_pressed() -> void:
	if not slot_data or not slot_data.item:
		return  

	var item = slot_data.item

	if not shop_inv or not player_inv:
		return

	print("Before transaction:")
	print_inventory("Player Inventory", player_inv)
	print_inventory("Shop Inventory", shop_inv)

	if is_shop_slot:  # Player is trying to buy from the shop
		if shop_inv.Has_Items(item, 1) and player_inv.Has_Items(BOTTLES, 8):  
			print("Trading 8 Bottles for:", item.name)
			Remove(item)
			player_inv.insert(item, 1)           # Add new item to player inventory
			shop_inv.Remove_Items(item, 1)       # Remove bought item from shop inventory
	else:  # Player is selling to the shop
		if player_inv.Has_Items(item, 1):  
			print("Selling:", item.name)
			shop_inv.insert(item, 1)         # Add to shop inventory
			player_inv.Remove_Items(item, 1) # Remove from player inventory

	print("After transaction:")
	print_inventory("Player Inventory", player_inv)
	print_inventory("Shop Inventory", shop_inv)

	# Update UI
	player_inv.update.emit()
	shop_inv.update.emit()

func print_inventory(name: String, inv: Inventory):
	print(name, "slots:")
	for slot in inv.slots:
		if slot.item:
			print(slot.item.name, "-", slot.amount)


func Remove(item):
	if item.name == "sword":
		player_inv.Remove_Items(BOTTLES,8)
		player_inv.Remove_Items(RUBBER,4)
		return
	if item.name == "health_p":
		player_inv.Remove_Items(BOTTLES,5)
		player_inv.Remove_Items(WOOD_BUNDLE,1)
		return
	if item.name == "damage_buff":
		player_inv.Remove_Items(BOTTLES,5)
		player_inv.Remove_Items(WOOD_BUNDLE,5)
		player_inv.Remove_Items(RUBBER,5)
		return
		
		
	
