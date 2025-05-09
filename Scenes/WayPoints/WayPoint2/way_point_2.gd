extends CharacterBody2D

var active = false
var in_interact_zone = false
@onready var control: Control = $Control

func _ready():
	if control:
		control.visible = false


func _process(_delta):
	if in_interact_zone == true && Input.is_action_just_pressed("teleport") && WorldManager.tp_Wp2_A == "A" && WorldManager.waypoint1clear == true:
		$AnimatedSprite2D.play("active")
		WorldManager.tp_Wp2_A = "B"
		WorldManager.Wp2_tp = true
		
	elif in_interact_zone == true && Input.is_action_just_pressed("teleport") && WorldManager.tp_Wp2_A == "B" && WorldManager.waypoint1clear == true:
			$AnimatedSprite2D.play("active")
			WorldManager.tp_Wp2_A = "A"
			WorldManager.Wp2_tp = true
			


func _on_interact_body_entered(body):
	if body.has_method("Player"):
		in_interact_zone = true
		$AnimatedSprite2D.play("active")
		if control:
			control.visible = true
	

func _on_interact_body_exited(body):
	if body.has_method("Player"):
		in_interact_zone = false
		active = false 
		$AnimatedSprite2D.play("de_active")
		if control:
			control.visible = false
