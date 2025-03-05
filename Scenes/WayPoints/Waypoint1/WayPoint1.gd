extends CharacterBody2D

var active = false
var in_interact_zone = false
@onready var control: Control = $Control

func _ready():
	if control:
		control.visible = false

func _set_active():
	pass

func _process(delta):
	if in_interact_zone == true && Input.is_action_just_pressed("teleport") && WorldManager.tp_Wp1_A == "A":
		$AnimatedSprite2D.play("Active")
		WorldManager.tp_Wp1_A = "B"
		WorldManager.Wp1_tp = true
		
	elif in_interact_zone == true && Input.is_action_just_pressed("teleport") && WorldManager.tp_Wp1_A == "B":
			$AnimatedSprite2D.play("Active")
			WorldManager.tp_Wp1_A = "A"
			WorldManager.Wp1_tp = true
			


func _on_interact_body_entered(body):
	if body.has_method("Player"):
		in_interact_zone = true
		$AnimatedSprite2D.play("Active")
		if control:
			control.visible = true


func _on_interact_body_exited(body):
	if body.has_method("Player"):
		in_interact_zone = false
		active = false 
		$AnimatedSprite2D.play("Not_Active")
		if control:
			control.visible = false



func _on_spawn_area_body_entered(body):
	pass # Replace with function body.


func _on_spawn_area_body_exited(body):
	pass # Replace with function body.
