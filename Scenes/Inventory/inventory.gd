extends Resource

class_name Inventory

signal update
@export var slots: Array[Inventory_Slot] = []



func insert(item : Inventory_Item, amount : int):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty(): ##if existing item 
		itemslots[0].amount += 1
		
	else:	##if new item
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()


func Remove_Items(item : Inventory_Item, amount : int):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	var taken = false

	if !item_slots.is_empty() && !taken:
		item_slots[0].amount -= amount  
		print(str(item.name) + " - " + str(amount))
		taken = true

	if item_slots[0].amount == 0:
		item_slots[0].item = null
		print(str(item.name) + " = " + str(amount))

	taken = false  
	update.emit()


func Has_Items(item : Inventory_Item , amount : int):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if item_slots.is_empty() or item_slots[0].amount < amount:
				print("HAVE NO ITEMS")
				return false  # Not enough items
	
	print("HAS ITEMS")
	return true
