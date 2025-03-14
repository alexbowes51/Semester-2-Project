extends StaticBody2D

@export var item : Inventory_Item
@onready var collision_explosion: CPUParticles2D = $CollisionExplosion
@onready var sprite_2d: Sprite2D = $Sprite2D


var player = null


func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.has_method("Player"):
			player = body
			playercollect()
			sprite_2d.visible = false
			collision_explosion.emitting = true
			self.queue_free()

func playercollect():
	player.collect(item)
	
	
