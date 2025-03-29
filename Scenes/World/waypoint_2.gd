extends Area2D

var entities_in_zone : Dictionary = {}  # Dictionary to track entities

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	cleanup_entities()  # Remove entities that no longer exist

func get_entities_in_zone() -> Array:
	return entities_in_zone.keys()  # Return a list of active entities

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("bottle") or body.has_method("rubber") or body.has_method("wood"):
		if not entities_in_zone.has(body):
			entities_in_zone[body] = true  # Store the entity
			print("Entity entered: ", body.name)
			print("Entities in zone: ", get_entities_in_zone())


func _on_body_exited(body: Node2D) -> void:
	if entities_in_zone.has(body):
		entities_in_zone.erase(body)  # Remove the entity
		print("Entity exited: ", body.name)
		print("Entities in zone: ", get_entities_in_zone())
		
func cleanup_entities() -> void:
	var to_remove = []
	for entity in entities_in_zone.keys():
		if not is_instance_valid(entity):  
			to_remove.append(entity)
		
			
	for entity in to_remove:
		entities_in_zone.erase(entity)  # Remove invalid entities
		print("Entity removed from tracking: ", entity)
	
	if entities_in_zone.is_empty():
			WorldManager.waypoint2clear = true
			print(WorldManager.waypoint2clear)
		
