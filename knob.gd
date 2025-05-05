extends Sprite2D

@onready var parent: Node2D = $".."

var pressing = false
@export var maxlength = 100
@export var deadzone = 10

func _reday():
	maxlength *= parent.scale.x
	
func _process(delta):
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxlength:
			global_position = get_global_mouse_position()
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent.global_position.x + cos(angle)+maxlength
			global_position.y = parent.global_position.y + cos(angle)+maxlength
		calculateVector()	
	else:
		global_position = lerp(global_position, parent.global_position, delta * 50)
		parent.posVector = Vector2(0,0)
	print(parent.posVector)
	
func calculateVector():
	if abs((global_position.x - parent.global_position.x)) >= deadzone:
		parent.posVector.x = (global_position.x - parent.global_position.x) / maxlength
	if abs((global_position.y- parent.global_position.y)) >= deadzone:
		parent.posVector.y = (global_position.y - parent.global_position.y) / maxlength
	

func _on_button_button_down() -> void:
	pressing = true


func _on_button_button_up() -> void:
	pressing = false
