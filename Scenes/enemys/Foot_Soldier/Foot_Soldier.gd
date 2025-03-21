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


func _physics_process(delta):
	
	deal_damage()
	
	if health > 0:
		if chasing_player && player != null && attacking == false:
			position += (player.position - position) / speed * delta
			look_at(player.get_global_position())
			global_rotation_degrees += -90
			$AnimatedSprite2D.play("Foot_E_Walk")
		if !chasing_player:
			$AnimatedSprite2D.play("Foot_E_idle")
			

func _on_dectector_body_entered(body):
	if body.has_method("Player") && health > 0:
		player = body
		chasing_player = true

func _on_dectector_body_exited(body):
	if body.has_method("Player") && health > 0:
		player = null
		chasing_player = false

func Foot_Soldier():
	pass

func _on_damage_cooldown_timeout() -> void:
	damage = true

func _on_foot_attack_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player") && health > 0:
		attacking = true
		$AnimatedSprite2D.play("Foot_E_Attack")

func _on_foot_attack_area_body_exited(body: Node2D) -> void:
	if body.has_method("Player") && health > 0:
		attacking = false

func _on_attack_cooldown_timeout() -> void:
	attacking = false
	attacked = false

func deal_damage():
	if attacked && WorldManager.player_current_attack:
		if damage && health > 0:
			health = health - 20
			hit_by__sword.play()
			$damage_cooldown.start()
			
			$AnimatedSprite2D.play("Foot_E_Hurt")
			if health <= 0:
				health = 0
				player = null
				$AnimatedSprite2D.play("Foot_E_Death")
				await get_tree().create_timer(1).timeout
				self.queue_free()
				
				var new_rubber = rubber.instantiate()
				get_parent().add_child(new_rubber) # Add to the world instead of enemy
				new_rubber.global_position = Vector2(global_position.x - 40,global_position.y) 
				
				var new_bottle = bottle.instantiate()
				get_parent().add_child(new_bottle) # Add to the world instead of enemy
				new_bottle.global_position = Vector2(global_position.x + 40,global_position.y) 
				damage = false

func _on_foot_hit_area_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
		if area && area.name == "Player_Attack_HitBox" && WorldManager.player_current_attack:
			attacked = true
			damage = true
			receives_knockback = true
			KnockBack(area.global_position)
			cpu_particles_2d.emitting = true
			
			

func _on_foot_hit_area_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area && area.name == "Player_Attack_HitBox":
			attacked = false
			damage = false


func KnockBack(damage_dir: Vector2):
	if receives_knockback && attacked:
		var knockback_dir = damage_dir.direction_to(self.global_position)
		var knockback_strength = 35 * knock_scale
		var knockback = knockback_dir * knockback_strength
		
		global_position += knockback
	
