extends Node2D
class_name State

@onready var debug = owner.find_child("debug")
@onready var player = find_parent("world").find_child("Player")
@onready var animated_sprite_2d = owner.find_child("AnimatedSprite2D")

func _ready():
	set_physics_process(false)
	
func enter():
	set_physics_process(true)
	
func exit():
	set_physics_process(false)
	
func transition():
	pass
	
func _physics_process(_delta):
	transition()
	debug.text = name 
