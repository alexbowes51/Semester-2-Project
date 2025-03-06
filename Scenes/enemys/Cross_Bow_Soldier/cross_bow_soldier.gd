extends CharacterBody2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var fire_timer: Timer = $Fire_Timer
@export var ammo : PackedScene

@export var nav : NavigationAgent2D
@export var speed = 50
var target_node = null

var player = null 

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum States{
	IDLE,
	SHOOTING,
	AIMING,
	FLEEING,
}

func _physics_process(delta: float) -> void:
	aim()
	check_collision()
	
	#nav.path_desired_distance = 4
	#nav.target_desired_distance = 4
	
	
func aim():
	if player != null:
		ray_cast_2d.target_position = to_global(player.position)
		look_at(player.get_global_position())
		global_rotation_degrees += -90
		
	if nav && nav.is_navigation_finished():
		return
	
	#var axis = to_local(nav.get_next_path_position()).normalized()
	#velocity = axis * speed
	#move_and_slide()


func recalc_path():
	if target_node:
		nav.target_position = target_node.global_position

	

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
	

	
	
	


func _on_danger_close_body_entered(body: Node2D) -> void:
	pass
		
		


func _on_danger_close_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_thinking_thime_timeout() -> void:
	recalc_path()


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
