extends State

@onready var collision_shape_2d: CollisionShape2D = $"../../PlayerDection/CollisionShape2D"
@onready var progress_bar: ProgressBar = $"../../CanvasLayer/ProgressBar"



# Called when the node enters the scene tree for the first time.
var player_entered: bool = false:
	set(value):
		player_entered = value 
		collision_shape_2d.set_deferred("disabled",value)
		progress_bar.set_deferred("visible", value)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func transition():
	if player_entered:
		get_parent().change_state("Follow")


func _on_player_dection_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player_entered = true
