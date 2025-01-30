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
	
	if chasing_player && !attacking:
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


func _on_foot_hit_box_body_entered(body):
	if body.has_method("player"):
		body = player
		attacking = true
		attacked = true 
		if attacking:
			$AnimatedSprite2D.play("Foot_E_Attack")
			$Attack_cooldown_False.start()
		
	



func _on_foot_hit_box_body_exited(body):
	if body.has_method("player"):
		body = player
		attacking = false


func _on_attack_cooldown_timeout() -> void:
	attacking = false
	attacked = false
	
func deal_damage():
	if attacked && WorldManager.player_current_attack == true:
		if damage == true:
			health = health - 20
			$damage_cooldown.start()
			print("enemy health" + str(health))
			damage = false
			if health < 0:
				self.queue_free()
	


func _on_damage_cooldown_timeout() -> void:
	damage = true
