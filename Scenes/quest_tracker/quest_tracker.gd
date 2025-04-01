extends Control

@onready var label: Label = $NinePatchRect/Label
@onready var label_2: Label = $NinePatchRect/Label2
@onready var label_3: Label = $NinePatchRect/Label3

var open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open = false
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	
	if Input.is_action_just_pressed("Quest"):
		visible = true
		open = true
	elif Input.is_action_just_pressed("Quest") && open == true:
		visible = false
		open = false
		
	if WorldManager.villages_Cleared:
		label_2.text = str("Villages Cleared :" + str(WorldManager.villages_Cleared) + " / 2")
		
	if WorldManager.waypoints_Cleared:
		label.text = str("Waypoints Cleared :" + str(WorldManager.waypoints_Cleared) + " / 2")
	
