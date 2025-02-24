extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var mini_map: CanvasLayer = $MiniMap
@onready var build_area: Area2D = $"Build-Area"
@onready var way_point_1_a_: CharacterBody2D = $"WayPoint1(A)"
@onready var way_point_1_b_: CharacterBody2D = $"WayPoint1(B)"


#preloading the house / farm 
var farm_scene = preload("res://Scenes/Buildings/farm/farm.tscn")
var house_scene = preload("res://Scenes/Buildings/house 1/house.tscn")


#tilemap variables
var building = "None"

#player world varibales
var player_current_attack = false
var Build_mode = false

var tp_Wp1_A = "A"
var tp_Wp2_A = "A"

var Wp1_tp = false
var Wp2_tp = false

var Wp1_A = Vector2(4550,4370)
var Wp1_B = Vector2(16950,3670)

var Wp2_A = Vector2(2850,470)
var Wp2_B = Vector2(4750,15370)


#npc follow 
var Merchant_follow_player = false

#building/crafting material


# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		mini_map.player_node = player
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		var mouse_pos = get_global_mouse_position()
		
		
		
		
		if Build_mode == true && Input.is_action_pressed("build"):
			
			if building == "house":
				var built_house = house_scene.instantiate()
				add_child(built_house)
				building = "none"
		
			if building == "farm":
				var built_farm = farm_scene.instantiate()
				add_child(built_farm)
				building = "none"
		
			
		
	
