extends CanvasLayer

@onready var sub_viewport_container: SubViewportContainer = $Control/MarginContainer/SubViewportContainer
@onready var sub_viewport: SubViewport = $Control/MarginContainer/SubViewportContainer/SubViewport
@onready var mini_map_camera: Camera2D = $Control/MarginContainer/SubViewportContainer/SubViewport/MiniMap_Camera
@onready var player_marker: ColorRect = $Control/MarginContainer/SubViewportContainer/SubViewport/PlayerMarker

var player_node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for tilemap in owner.get_node("TileMap").get_children():
		var mini_tilemap = tilemap.duplicate()
		setup_mini(mini_tilemap)
		
		var used_rect : Rect2i = tilemap.get_used_rect()
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_node:
		mini_map_camera.global_position = lerp(mini_map_camera.global_position, player_node.global_position,0.2)
	player_marker.global_position = player_node.global_position
	
func setup_mini(mini_tilemap : TileMapLayer) -> void:
	sub_viewport.add_child(mini_tilemap)
	
func set_minimap_limits(used_rect: Rect2i):
	mini_map_camera.limit_left = used_rect.position.x * 100
	mini_map_camera.limit_top = used_rect.position.y * 100
	mini_map_camera.limit_right =(used_rect.position.x + used_rect.size.x) * 100
	mini_map_camera.limit_bottom = (used_rect.position.x + used_rect.size.y) * 100
