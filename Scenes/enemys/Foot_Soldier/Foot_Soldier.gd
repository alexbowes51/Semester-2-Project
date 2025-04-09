extends CharacterBody2D

var speed = 2.5
var health = 100
var chasing_player = false 
var player = null

var attacking = false
var attacked = false
var damage = true

var receives_knockback = false
var knock_scale = 2.0


var bottle = preload("res://Scenes/Item/Bottle/bottle_collectable.tscn")
var rubber = preload("res://Scenes/Item/Rubber/rubber_collectable.tscn")
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var hit_by__sword: AudioStreamPlayer = $"hit_by _sword"
@onready var down: RayCast2D = $down
@onready var rigth: RayCast2D = $rigth
@onready var left: RayCast2D = $left
@onready var up: RayCast2D = $up

func ready() -> void:
	add_to_group("enemy")

func _physics_process(delta):
	left.global_rotation = 0
	rigth.global_rotation = 0
	down.global_rotation = 0
	up.global_rotation = 0
	deal_damage()

	if health > 0:
		if chasing_player && player != null and not attacking:
			if is_path_clear():  # Check if path to player is clear
				move_towards_player(delta)
			else:
				avoid_obstacle()  # Avoid obstacles
		elif not chasing_player:
			$AnimatedSprite2D.play("Foot_E_idle")

func is_path_clear() -> bool:
	var rays = [down, rigth, left, up]
	for ray in rays:
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider and not collider.is_in_group("enemy"):
				return false
	return true


func move_towards_player(delta: float):
	# Move towards player if path is clear
	position += (player.position - position) / speed * delta
	look_at(player.get_global_position())
	global_rotation_degrees += -90
	$AnimatedSprite2D.play("Foot_E_Walk")
	WorldManager.player_in_combat = true

func avoid_obstacle():
	if down.is_colliding():
		position += Vector2(0, -speed) * 2
	elif up.is_colliding():
		position += Vector2(0, speed) * 2
	elif rigth.is_colliding():
		position += Vector2(-speed, 0) * 2
	elif left.is_colliding():
		position += Vector2(speed, 0) * 2

func _on_dectector_body_entered(body):
	if body.has_method("Player") and health > 0:
		player = body
		chasing_player = true

func _on_dectector_body_exited(body):
	if body.has_method("Player") and health > 0:
		player = null
		chasing_player = false

func Foot_Soldier():
	pass

func _on_damage_cooldown_timeout() -> void:
	damage = true

func _on_foot_attack_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player") and health > 0:
		attacking = true
		$AnimatedSprite2D.play("Foot_E_Attack")

func _on_foot_attack_area_body_exited(body: Node2D) -> void:
	if body.has_method("Player") and health > 0:
		attacking = false

func _on_attack_cooldown_timeout() -> void:
	attacking = false
	attacked = false

func deal_damage():
	if attacked and WorldManager.player_current_attack:
		if damage and health > 0:
			health -= 20
			hit_by__sword.play()
			$damage_cooldown.start()

			$AnimatedSprite2D.play("Foot_E_Hurt")
			if health <= 0:
				health = 0
				player = null
				$AnimatedSprite2D.play("Foot_E_Death")
				var new_rubber = rubber.instantiate()
				get_parent().add_child(new_rubber)  # Add to the world instead of enemy
				new_rubber.global_position = Vector2(global_position.x - 40, global_position.y)

				var new_bottle = bottle.instantiate()
				get_parent().add_child(new_bottle)  # Add to the world instead of enemy
				new_bottle.global_position = Vector2(global_position.x + 40, global_position.y)
				damage = false
				await get_tree().create_timer(1).timeout
				self.queue_free()
				WorldManager.player_in_combat = false
				

func _on_foot_hit_area_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area and area.name == "Player_Attack_HitBox" and WorldManager.player_current_attack:
		attacked = true
		damage = true
		receives_knockback = true
		KnockBack(area.global_position)
		cpu_particles_2d.emitting = true

func _on_foot_hit_area_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area and area.name == "Player_Attack_HitBox":
		attacked = false
		damage = false

func KnockBack(damage_dir: Vector2):
	if receives_knockback and attacked:
		var knockback_dir = damage_dir.direction_to(self.global_position)
		var knockback_strength = 35 * knock_scale
		var knockback = knockback_dir * knockback_strength

		global_position += knockback
