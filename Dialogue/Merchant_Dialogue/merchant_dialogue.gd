extends Control

@export_file("*.json") var M_D_file

signal end_dialogue


var dialogue = []
var current_dialogue_id = 0
var dia_active = false

func _ready():
	$NinePatchRect.visible = false
	$NinePatchRect/TextureButton.visible = false
	$"NinePatchRect/TextureButton/unFollow Text".visible  = false

func _process(delta):
	if $NinePatchRect/TextureButton.button_pressed && !WorldManager.Merchant_follow_player:
		print("follow me punk")
		WorldManager.Merchant_follow_player = true 
		$"NinePatchRect/TextureButton/Follow Text".visible = false
		$"NinePatchRect/TextureButton/unFollow Text".visible = true
	elif $NinePatchRect/TextureButton.button_pressed && WorldManager.Merchant_follow_player:
		WorldManager.Merchant_follow_player = false
		$"NinePatchRect/TextureButton/Follow Text".visible = true
		$"NinePatchRect/TextureButton/unFollow Text".visible = false


func start():
	if dia_active:
		return
	dia_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1 
	next_script()
	
func load_dialogue():
	var file = FileAccess.open("res://Dialogue/Merchant_Dialogue/merchant_dialogue1.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func _input(event):
	if !dia_active:
		return
		
	if event.is_action_pressed("ui_accept"):
		next_script()
	
func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id == 3:
		$NinePatchRect/TextureButton.visible = true
		$"NinePatchRect/TextureButton".visible = true
	
	if current_dialogue_id >= len(dialogue):
		dia_active = false
		$NinePatchRect.visible = false
		$"NinePatchRect/TextureButton".visible = false
		current_dialogue_id = -1 
		emit_signal("end_dialogue")
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]['text']
