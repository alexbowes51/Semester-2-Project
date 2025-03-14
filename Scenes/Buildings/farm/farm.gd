extends CharacterBody2D

var place = false
var placed_in_zone = false
var place_position 
var built = false
var can_build = true

##inventory varibales
@onready var inv : Inventory = preload("res://Scenes/Inventory/player_Inventory.tres")

##items varibales
@onready var WOOD_BUNDLE = preload("res://Scenes/Item/Wood/Wood_bundle.tres")
@onready var RUBBER = preload("res://Scenes/Item/Rubber/Rubber.tres")
@onready var BOTTLES = preload("res://Scenes/Item/Bottle/Bottles.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		if WorldManager.Build_mode != true && !place:
			self.queue_free()
		
		if WorldManager.building != "farm" && !place:
			self.queue_free()
			

func _input(_event):
	if WorldManager.Build_mode && !place:
		move_position_mouse()
	
		if Input.is_action_just_pressed("build") && can_build:
			
			can_build = false
			if !place && inv.Has_Items(WOOD_BUNDLE,2) && inv.Has_Items(BOTTLES,2):
				build()

func farm():
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "BuildArea":
			placed_in_zone = true



func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "BuildArea":
			placed_in_zone = false

func build():
	if built:
	
		return
		
	built = true
	place_position = position
	place = true
	
	if !place || !WorldManager.Build_mode && placed_in_zone || !placed_in_zone:
		self.queue_free()
		return

	if place && placed_in_zone:
		remove_item()
		return
	else:
		self.queue_free()
	
	await get_tree().create_timer(0.5).timeout 
	can_build = true  

func move_position_mouse():
		position = get_global_mouse_position()
		var grid_size = 100
		position = Vector2(round(position.x / grid_size) * grid_size,round(position.y / grid_size) * grid_size)


func remove_item():
	inv.Remove_Items(WOOD_BUNDLE,2)
	inv.Remove_Items(BOTTLES,2)
	return
