extends Panel


@onready var item_visual: Sprite2D = $item_display

func update(items : Inventory):
	if !items:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = items.texture
