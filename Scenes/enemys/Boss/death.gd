extends State

@onready var collision_shape_2d_b: CollisionShape2D = $"../../Boss_1_hb/CollisionShape2D"
@onready var collision_shape_2d_a: CollisionShape2D = $"../../Boss_1_ha/CollisionShape2D"

# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	CombatMusic.stop()
	collision_shape_2d_a.disabled = true
	collision_shape_2d_b.disabled = true 
	animated_sprite_2d.play("death")
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play("dead")
	
	
	
