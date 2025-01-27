extends StaticBody2D

@export var item : Inventory_Item
var player = null


func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.has_method("player"):
			player = body
			playercollect()
			self.queue_free()

func playercollect():
	player.collect(item)
