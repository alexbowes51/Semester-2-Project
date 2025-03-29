extends Node2D

var player 
var minimap 

#preloading the house / farm 
var farm_scene = preload("res://Scenes/Buildings/farm/farm.tscn")
var house_scene = preload("res://Scenes/Buildings/house 1/house.tscn")

var black_smith = preload("res://Scenes/Buildings/Black_smiths/blacksmith.tscn")

var black_smith_built = false

@onready var day_night_cycle = $"DAY+NIGHT CYCLE"
@onready var time_label = $MiniMap/Time_Label


@export var enable_cycle: bool = true

#tilemap variables
var building = "None"
var player_in_build_zone = false

#player world varibales
var player_current_attack = false
var Build_mode = false
var player_weapon = "none"
var player_healed = false


#teleport variables
var tp_Wp1_A = "A"
var tp_Wp2_A = "A"

var Wp1_tp = false
var Wp2_tp = false

var Wp1_A = Vector2(4550,4370)
var Wp1_B = Vector2(16950,3670)

var Wp2_A = Vector2(2850,470)
var Wp2_B = Vector2(4750,15370)

var home_spawn = Vector2(1850,3933)
var villages_Cleared : int = 0
var waypoints_Cleared : int = 0
var waypoint1clear : bool = false
var waypoint2clear : bool = false

#npc varibales 
var Merchant_follow_player = false
var player_talking_Merchant = false


var Black_smith_follow_player = false
var player_talking_Black_Smith = false
var Bs_shop = false
var Item_Selling = "none"

func _ready():
	
	minimap = $MiniMap
	player = $Player
	
	if player:
		minimap.player_node = player
	
	if enable_cycle:
		_setup_cycle()
	else:
		Day_Night_Manager.visible = false
		Day_Night_Manager.process_mode = Node.PROCESS_MODE_DISABLED


func _setup_cycle() -> void:
	if day_night_cycle:
		day_night_cycle.time_change.connect(change_time)
	
func change_time(_hour: float, time_string: String) -> void:
	if time_label:
		time_label.text = time_string

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		
			
		if Build_mode == true && Input.is_action_just_pressed("build"):
			build()

			


func build():
	if building == "house":
		var built_house = house_scene.instantiate()
		add_child(built_house)
		building = "none"
				
		
	if building == "farm":
		var built_farm = farm_scene.instantiate()
		add_child(built_farm)
		building = "none"
		
	if building == "black_smith" && black_smith_built == false:
		var built_black = black_smith.instantiate()
		add_child(built_black)
		building = "none"
	





func _on_build_zone_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area && area.name == "Player_HitBox":
		WorldManager.player_in_build_zone = true


func _on_build_zone_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area && area.name == "Player_HitBox":
		WorldManager.player_in_build_zone = false


func _on_waypoint_1_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
