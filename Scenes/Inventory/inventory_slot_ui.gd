extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text : Label = $CenterContainer/Panel/Label
@onready var label_2: Label = $CenterContainer/Panel/Label2
@onready var texture_button: TextureButton = $TextureButton

var slot_data: Inventory_Slot
var inventory: Inventory
var player_inv: Inventory
var shop_inv: Inventory
var is_shop_slot = false  

func _ready():
	# Connect the button once in _ready()
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
		print("No item in slot.")
		return  

	var item = slot_data.item
	
	if not shop_inv or not player_inv:
		print("ERROR: Missing inventory references.")
		return

	if is_shop_slot:  
		print("Trying to buy:", item.name)
		if shop_inv.Has_Items(item, 1):  # Check if the shop has at least one of the item
			player_inv.insert(item, 1)    # Add the item to the player's inventory
			shop_inv.Remove_Items(item, 1)  # Remove the item from the shop inventory
			print("Bought:", item.name, "New Player Inventory:", player_inv.slots)
		else:
			print("Shop doesn't have enough of", item.name)
	else:  
		print("Trying to sell:", item.name)
		if player_inv.Has_Items(item, 1):  # Check if the player has at least one of the item
			shop_inv.insert(item, 1)         # Add the item to the shop inventory
			player_inv.Remove_Items(item, 1)   # Remove the item from the player's inventory
			print("Sold:", item.name, "New Shop Inventory:", shop_inv.slots)
		else:
			print("Player doesn't have enough of", item.name)
