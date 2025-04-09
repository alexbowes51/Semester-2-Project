extends CharacterBody2D

var player = null
var speed = 10
var health = 150
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var hit_by__sword: AudioStreamPlayer = $"hit_by _sword"
@onready var down: RayCast2D = $down
@onready var rigth: RayCast2D = $rigth
@onready var left: RayCast2D = $left
@onready var up: RayCast2D = $up


var bottle = preload("res://Scenes/Item/Bottle/bottle_collectable.tscn")
var rubber = preload("res://Scenes/Item/Rubber/rubber_collectable.tscn")

var receives_knockback = false
var knock_scale = 1.0

enum States{
	IDLE,
	CHASING,
	ATTACKING,
}

var current_state = States.IDLE
var attacked = false
var attacking = false
var alive = true

func ready() -> void:
	add_to_group("enemy")


func _physics_process(_delta: float) -> void:
	left.global_rotation = 0
	rigth.global_rotation = 0
	down.global_rotation = 0
	up.global_rotation = 0
	if alive == true && is_path_clear():
		damage()
		chasing()
		attack()
		is_alive()
	else:
		avoid_obstacle()  # Avoid obstacles
		
	


func _on_g_e_chase_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		current_state = States.CHASING


func _on_g_e_chase_body_exited(body: Node2D) -> void:
		if body.has_method("Player"):
			player = body
			current_state = States.IDLE


func _on_g_h_area_body_entered(_body: Node2D) -> void:
	if _body.has_method("Player"):
		current_state = States.ATTACKING
		attacking = true
		attack()


func _on_g_h_area_body_exited(_body: Node2D) -> void:
	current_state = States.CHASING
	attacking = false
	


func _on_g_e_hb_area_entered(area: Area2D) -> void:
	if area && area.name == "Player_Attack_HitBox" && WorldManager.player_current_attack == true:
		attacked = true
		receives_knockback = true
		KnockBack(area.global_position)
		

func _on_g_e_hb_area_exited(area: Area2D) -> void:
	if area && area.name == "Player_Attack_HitBox" && WorldManager.player_current_attack == true :
		attacked = false
		

func damage():
	if alive == true:
		if alive == true && attacked == true:
			health -= 20
			attacked = false
			_on_attacked_cooldown_timeout()
			hit_by__sword.play()
		
func chasing():
	if alive == true:
		if player != null && current_state == States.CHASING:
			WorldManager.player_in_combat = true
			$AnimatedSprite2D.play("walk")
			position += ( player.global_position - global_position ).normalized() / 2
			var target_rotation = (player.global_position - global_position).angle() + -90 
			rotation = lerp_angle(rotation, target_rotation, 0.019)  
	
func attack():
	if alive == true:
		if player != null && current_state == States.ATTACKING:
			$AnimatedSprite2D.play("attack")
			attacking = true
			cpu_particles_2d.emitting = true
			_on_attack_cooldown_timeout()

func is_alive():
	if health <= 0 :
		alive = false
		$AnimatedSprite2D.play("death")
		var new_rubber = rubber.instantiate()
		get_parent().add_child(new_rubber)  # Add to the world instead of enemy
		new_rubber.global_position = Vector2(global_position.x - 40, global_position.y)
		var new_bottle = bottle.instantiate()
		get_parent().add_child(new_bottle)  # Add to the world instead of enemy
		new_bottle.global_position = Vector2(global_position.x + 40, global_position.y)
		await get_tree().create_timer(1).timeout
		self.queue_free()
		WorldManager.player_in_combat = false


func _on_attack_cooldown_timeout() -> void:
	attacking = false


func _on_attacked_cooldown_timeout() -> void:
	attacking = false
	attacked = false

func Giant_E():
	pass

func KnockBack(damage_dir: Vector2):
	if receives_knockback && attacked:
		var knockback_dir = damage_dir.direction_to(self.global_position)
		var knockback_strength = 25 * knock_scale
		var knockback = knockback_dir * knockback_strength
		
		global_position += knockback
	
func is_path_clear() -> bool:
	var rays = [down, rigth, left, up]
	for ray in rays:
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider and not collider.is_in_group("enemy"):
				return false
	return true

func avoid_obstacle():
	if down.is_colliding():
		position += Vector2(0, -speed) / 10
	elif up.is_colliding():
		position += Vector2(0, speed) / 10
	elif rigth.is_colliding():
		position += Vector2(-speed, 0) / 10
	elif left.is_colliding():
		position += Vector2(speed, 0) / 10
