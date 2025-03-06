extends CharacterBody2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_2d: RayCast2D = $NAV/RayCast2D
@onready var fire_timer: Timer = $NAV/Fire_Timer
@export var ammo : PackedScene

@export var nav : NavigationAgent2D
@export var speed = 50
var target_node = null

var player = null 
var attacking = false
var attacked = false
var alive = true 

var health = 100

enum States{
	IDLE,
	SHOOTING,
	AIMING,
	FLEEING,
	FOLLOWING,
}

var current_state = States.IDLE

func _physics_process(delta: float) -> void:
	if alive == true:
		aim()
		fleeing()
		following()
		damage()
		_is_alive()
		check_collision()
		idle()
	


func aim():
	if alive == true:
		if player != null && current_state != States.FLEEING:
			ray_cast_2d.target_position = to_global(player.position)
			look_at(player.get_global_position())
			global_rotation_degrees += -90
		
		
	
func fleeing():
	if alive == true:
		if player != null && current_state == States.FLEEING:
			position -= (player.position - position) / speed / 5
			$AnimatedSprite2D.play("walk")


func following():
	if alive == true:
		if player != null && current_state == States.FOLLOWING:
			position += (player.position - position) / speed / 5
			$AnimatedSprite2D.play("walk")
			look_at(player.get_global_position())
			global_rotation_degrees += -90

func idle():
	if alive == true:
		if current_state == States.IDLE:
			$AnimatedSprite2D.play("idle")

func damage():
	if alive == true && attacked == true:
		health -= 50
		

func _is_alive():
	if health <= 0:
		$AnimatedSprite2D.play("death")
		alive = false

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
		current_state = States.SHOOTING
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		current_state = States.FOLLOWING

func _on_fire_timer_timeout() -> void:
	shoot()

func shoot():
	if alive == true:
		if player != null && current_state == States.SHOOTING:
			var bullet = ammo.instantiate()
			get_parent().get_parent().add_child(bullet)
			bullet.position = position
			var shooting_dir = (player.global_position - global_position).normalized()
			bullet.set_direction(shooting_dir)
			$AnimatedSprite2D.play("attacking")

func _on_danger_close_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		current_state = States.FLEEING
		
		

func _on_danger_close_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		current_state = States.SHOOTING

func _on_thinking_thime_timeout() -> void:
	#recalc_path()
	pass


func _on_chase_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		current_state = States.FOLLOWING

func _on_chase_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		current_state = States.IDLE

func _on_cross_e_hit_area_entered(area: Area2D) -> void:
	if area && area.name == "Player_Attack_HitBox" && WorldManager.player_current_attack == true :
		attacked = true

func _on_cross_e_hit_area_exited(area: Area2D) -> void:
	if area && area.name == "Player_Attack_HitBox" && WorldManager.player_current_attack == true :
		attacked = false
