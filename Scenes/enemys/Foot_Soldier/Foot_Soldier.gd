extends CharacterBody2D

var speed = 5
var health = 100
var chasing_player = false 
var player = null

var attacking = false
var attacked = false
var damage = true

func _physics_process(delta):
	deal_damage()
	
	if chasing_player && !attacking && player != null:
		position += (player.position - position) / speed * delta
		look_at(player.position)
		$AnimatedSprite2D.play("Foot_E_Walk")
	if !chasing_player:
		$AnimatedSprite2D.play("Foot_E_idle")
	
			

func _on_dectector_body_entered(body):
	player = body
	chasing_player = true
	

func _on_dectector_body_exited(body):
	player = null
	chasing_player = false
	

func Foot_Soldier():
	pass
	
	

func _on_damage_cooldown_timeout() -> void:
	damage = true


func _on_foot_hit_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body 
		attacked = true
		damage = true
		


func _on_foot_hit_area_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player = null
		attacked = false
		damage = false


func _on_foot_attack_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body 
		attacking = true
		$AnimatedSprite2D.play("Foot_E_Attack")


func _on_foot_attack_area_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player = null
		attacking = false



func _on_attack_cooldown_timeout() -> void:
	attacking = false
	attacked = false
	
func deal_damage():
	if attacked && WorldManager.player_current_attack:
		if damage:
			health = health - 20
			$damage_cooldown.start()
			print("enemy health" + str(health))
			$AnimatedSprite2D.play("Foot_E_Hurt")
			if health <= 0:
				player = null
				self.queue_free()
			damage = false
	
