extends StaticBody2D

@export var item : Inventory_Item
@onready var collision_explosion: CPUParticles2D = $CollisionExplosion
@onready var sprite_2d: Sprite2D = $Sprite2D


var player = null


func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.has_method("Player"):
			player = body
			collision_explosion.emitting = true
			playercollect()
			sprite_2d.visible = false
			self.queue_free()
			
		if body.has_method("Waypoint_1") && WorldManager.waypoint1clear:
			self.queue_free()
			
		if body.has_method("Waypoint_2") && WorldManager.waypoint2clear:
			self.queue_free()

func playercollect():
	player.collect(item)
	
func wood():
	pass
