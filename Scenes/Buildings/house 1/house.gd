extends Sprite2D

var place = false

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
	

	
	if !WorldManager.Build_mode && !place && !WorldManager.building != "house":
		self.queue_free()
