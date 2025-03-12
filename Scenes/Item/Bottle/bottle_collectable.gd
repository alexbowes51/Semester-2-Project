extends StaticBody2D

@onready var collision_explosion: CPUParticles2D = $CollisionExplosion
@export var item: Inventory_Item
@onready var sprite_2d: Sprite2D = $Sprite2D

var player = null

func _on_interactable_area_body_entered(body):
	if body.has_method("Player"):
		player = body
		if sprite_2d.visible != false:
			playercollect()
			sprite_2d.visible = false
			collision_explosion.emitting = true
			await get_tree().create_timer(1).timeout
			self.queue_free()

func playercollect():
	player.collect(item)
	collision_explosion.emitting = true
