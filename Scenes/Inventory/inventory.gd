extends Resource

class_name Inventory

signal update

var Item_Name = "_"

@export var slots: Array[Inventory_Slot] = []


func insert(item : Inventory_Item):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty(): ##if existing item 
		itemslots[0].amount += 1
		
	else:	##if new item
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func Remove_Items(item : Inventory_Item):
	var bottle_slot = slots.filter(func(slot):return slot.item.name == "Bottle")
	if !bottle_slot.is_empty():
		bottle_slot[0].item.name = item.name
		bottle_slot[0].amount -= 1
		
	#var rubber_slot = slots.filter()
	update.emit()
	
	
		
	update.emit()

	
