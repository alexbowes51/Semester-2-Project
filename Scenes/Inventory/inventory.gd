extends Resource

class_name Inventory

signal update
@export var slots: Array[Inventory_Slot] = []



func insert(item : Inventory_Item, amount : int):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if !item_slots.is_empty():
		item_slots[0].amount += amount
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = amount

	update.emit()  # Ensure UI updates


func Remove_Items(item : Inventory_Item, amount : int):
	var remaining = amount  # Amount that still needs to be removed
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if item_slots.is_empty():
		print("ERROR: No matching item found to remove:", item.name)
		return
	
	for slot in item_slots:
		if remaining <= 0:
			break  # Stop when we've removed enough
		
		var to_remove = min(slot.amount, remaining)
		slot.amount -= to_remove
		remaining -= to_remove
		
		if slot.amount <= 0:
			slot.item = null  # Clear slot if empty

	if remaining > 0:
		print("ERROR: Not enough", item.name, "to remove. Still missing:", remaining)

	update.emit()  # Ensure UI updates


func Has_Items(item : Inventory_Item , amount : int):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if item_slots.is_empty() or item_slots[0].amount < amount:
		return false  # Not enough items
		
	return true
