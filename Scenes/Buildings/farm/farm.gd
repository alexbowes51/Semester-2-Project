extends Sprite2D

var place = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if WorldManager.Build_mode:
		
		
		
		var grid_size = 100
		position = Vector2(round(position.x / grid_size) * grid_size,round(position.y / grid_size) * grid_size)
	
	if Input.is_action_just_pressed("build"):
		var place_position = position
		place = true
		WorldManager.building = "_"
		
	
