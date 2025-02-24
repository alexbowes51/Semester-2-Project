extends CharacterBody2D

var active = false
var in_interact_zone = false

func _ready():
	pass

func _set_active():
	pass

func _process(delta):
	if in_interact_zone == true && Input.is_action_just_pressed("chat") && WorldManager.tp_Wp2_A == "A":
		$AnimatedSprite2D.play("active")
		WorldManager.tp_Wp2_A = "B"
		WorldManager.Wp2_tp = true
		
	elif in_interact_zone == true && Input.is_action_just_pressed("chat") && WorldManager.tp_Wp2_A == "B":
			$AnimatedSprite2D.play("active")
			WorldManager.tp_Wp2_A = "A"
			WorldManager.Wp2_tp = true
			


func _on_interact_body_entered(body):
	in_interact_zone = true


func _on_interact_body_exited(body):
	in_interact_zone = false
	active = false 
	$AnimatedSprite2D.play("de_active")
