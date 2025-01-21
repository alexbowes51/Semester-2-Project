extends CharacterBody2D

export var speed = 200
var player_position
var target_position 
onready var player = get_parent().get_parent().get_node("Player")
