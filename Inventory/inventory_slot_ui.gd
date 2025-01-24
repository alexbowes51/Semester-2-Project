extends Panel


@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display

func update(items : Inventory_Item):
	if !items:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = items.texture
