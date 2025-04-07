extends Control

@export_file("*.json") var B_D_file



var dialogue = []
var current_dialogue_id = 0
var dia_active = false


func _ready():
	$NinePatchRect.visible = false
	$NinePatchRect/TextureButton.visible = false
	$NinePatchRect/TextureButton2.visible = false
	$NinePatchRect/TextureButton2.pressed.connect(_on_texture_button_2_pressed)

func _process(_delta):
	pass
	

func start():
	if dia_active:
		return
	dia_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1 
	next_script()

func load_dialogue():
	var file = FileAccess.open("res://Dialogue/Black_Smith DiaLogue/Black_smith_dialogue.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event):
	if !dia_active:
		return
		
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id == 2:
		$NinePatchRect/TextureButton.visible = true
		$NinePatchRect/TextureButton2.visible = true
		
	if current_dialogue_id >= len(dialogue):
		dia_active = false
		$NinePatchRect.visible = false
		$NinePatchRect/TextureButton.visible = false
		$NinePatchRect/TextureButton2.visible = false
		current_dialogue_id = -1 
		WorldManager.player_talking_Black_Smith = false
		WorldManager.Bs_shop = false
		emit_signal("end_dialogue")
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]['text']

func reset():
	current_dialogue_id = -1 


func _on_texture_button_2_pressed():
	WorldManager.Bs_shop = !WorldManager.Bs_shop


func _on_texture_button_pressed():
	WorldManager.Black_smith_follow_player = !WorldManager.Black_smith_follow_player

	$"NinePatchRect/TextureButton/Follow Text".visible = !WorldManager.Black_smith_follow_player
	$"NinePatchRect/TextureButton/unFollow Text".visible = WorldManager.Black_smith_follow_player
