extends CharacterBody2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var fire_timer: Timer = $Fire_Timer
@export var ammo : PackedScene

var player = null 

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	aim()
	check_collision()
	
	
func aim():
	if player != null:
		ray_cast_2d.target_position = to_global(player.position)
		look_at(player.get_global_position())
		global_rotation_degrees += -90
		
	
	

func check_collision():
	if ray_cast_2d.get_collider() == player and fire_timer.is_stopped():
		fire_timer.start()
	elif ray_cast_2d.get_collider() != player and fire_timer.is_stopped():
		fire_timer.stop()
	
	
func Cross_Bow_Soldier():
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player = null

		

func _on_fire_timer_timeout() -> void:
	shoot()
	
	
func shoot():
	if player != null:
		var bullet = ammo.instantiate()
		get_parent().get_parent().add_child(bullet)
		bullet.position = position
		var shooting_dir = (player.global_position - global_position).normalized()
		bullet.set_direction(shooting_dir)
		bullet.global_rotation -= 140
	

	
	
	
