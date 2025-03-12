extends Resource

class_name Inventory

signal update
@export var slots: Array[Inventory_Slot] = []



func insert(item : Inventory_Item, amount : int):
	print("Attempting to insert:", amount, "of", item.name)
	
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if !item_slots.is_empty():
		print("Before insert:", item_slots[0].amount, "of", item.name)
		item_slots[0].amount += amount
		print("After insert:", item_slots[0].amount, "of", item.name)
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			print("Adding new item:", item.name, "to an empty slot.")
			empty_slots[0].item = item
			empty_slots[0].amount = amount
		else:
			print("No empty slots available for", item.name)

	update.emit()  # Ensure UI updates


func Remove_Items(item : Inventory_Item, amount : int):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if item_slots.is_empty():
		print("ERROR: No matching item found to remove:", item.name)
		return
	
	print("Before removal:", item_slots[0].amount, "of", item.name)
	item_slots[0].amount -= amount  
	print("After removal:", item_slots[0].amount, "of", item.name)
	
	if item_slots[0].amount <= 0:
		print("Item count reached zero. Removing item slot.")
		item_slots[0].item = null  # Clear slot if empty
	
	update.emit()  # Ensure UI updates


func Has_Items(item : Inventory_Item , amount : int):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if item_slots.is_empty() or item_slots[0].amount < amount:
				print("HAVE NO ITEMS")
				return false  # Not enough items
	
	print("HAS ITEMS")
	return true
