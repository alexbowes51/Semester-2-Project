extends CharacterBody2D

var speed = 5
var health = 100
var chasing_player = false 
var player = null

func _physics_process(delta):
	if chasing_player:
		position += (player.position - position) / speed * delta
		look_at(player.position)
		$AnimatedSprite2D.play("Foot_E_Walk")
	else:
		$AnimatedSprite2D.play("Foot_E_idle")
			

func _on_dectector_body_entered(body):
	player = body
	chasing_player = true

func _on_dectector_body_exited(body):
	player = null
	chasing_player = false
