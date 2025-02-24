extends CharacterBody2D

var place = false
var in_zone 
var placed_in_zone 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if WorldManager.Build_mode && !place:
		position = get_global_mouse_position()
		
		
		var grid_size = 100
		position = Vector2(round(position.x / grid_size) * grid_size,round(position.y / grid_size) * grid_size)
	
	
		if Input.is_action_just_pressed("build"):
		
			var place_position = position
			place = true
	
			if place != true && WorldManager.Build_mode == false:
				self.queue_free()	
	
			if place != true && WorldManager.building != "house":
				self.queue_free()
		
			if place == true && placed_in_zone != true:
				self.queue_free()
			

func house():
	pass
	



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "BuildArea":
			placed_in_zone = true
			print("true")


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "BuildArea":
			placed_in_zone = false
			print("false")
