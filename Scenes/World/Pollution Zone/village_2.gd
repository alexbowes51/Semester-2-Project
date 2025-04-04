extends Area2D

var entities_in_zone : Dictionary = {}  # Dictionary to track entities
var is_cleared : bool = false  # Track if this area has already been cleared
@onready var off_screen_marker: Node2D = $OffScreenMarker

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	cleanup_entities()  

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Cross_Bow_Soldier") or body.has_method("Giant_E") or body.has_method("Foot_Soldier"):
		if not entities_in_zone.has(body):
			entities_in_zone[body] = true  
			print("Entity entered: ", body.name)
			print("Entities in zone: ", get_entities_in_zone())
			is_cleared = false 

func _on_body_exited(body: Node2D) -> void:
	if entities_in_zone.has(body):
		entities_in_zone.erase(body)  
		print("Entity exited: ", body.name)
		print("Entities in zone: ", get_entities_in_zone())

func cleanup_entities() -> void:
	var to_remove = []
	for entity in entities_in_zone.keys():
		if not is_instance_valid(entity):  
			to_remove.append(entity)
	
	for entity in to_remove:
		entities_in_zone.erase(entity)  
		print("Entity removed from tracking: ", entity)
	
	
	if entities_in_zone.is_empty() and not is_cleared:
		WorldManager.villages_Cleared += 1
		print("Villages Cleared: ", WorldManager.villages_Cleared)
		is_cleared = true  
		off_screen_marker.visible = false
	 	
func get_entities_in_zone() -> Array:
	return entities_in_zone.keys()  
