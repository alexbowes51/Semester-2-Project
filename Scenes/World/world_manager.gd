extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var mini_map: CanvasLayer = $MiniMap

#preloading the house / farm 
var farm_scene = preload("res://Scenes/Buildings/farm/farm.tscn")
var house_scene = preload("res://Scenes/Buildings/house 1/house.tscn")

#tilemap variables
var tilemap : TileMap
var building = "None"

#player world varibales
var player_current_attack = false
var Build_mode = false
var Build_mode_avaible 

#npc follow 
var Merchant_follow_player = false

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = $TileMap
	
	if player and mini_map:
		mini_map.player_node = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
		if building == "house" && Build_mode == true && Input.is_action_pressed("build"):
			var built_house = house_scene.instantiate()
			add_child(built_house)
			building = "None"
		
	
	
		if building == "farm" && Build_mode == true && Input.is_action_pressed("build"):
			var built_farm = farm_scene.instantiate()
			add_child(built_farm)
			building = "None"
			
		
		
		
	
