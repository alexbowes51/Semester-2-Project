extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var mini_map: CanvasLayer = $MiniMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if player and mini_map:
		mini_map.player_node = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
