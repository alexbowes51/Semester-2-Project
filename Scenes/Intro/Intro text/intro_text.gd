extends Control

@export_file("*.json") var Intro_D_file

var dialogue = []
var current_dialogue_id = -1
var dia_active = false

var typing_speed = 0.03  # seconds between each letter
var typing_timer = 0.0
var full_text = ""
var current_text = ""
var is_typing = false

func _ready() -> void:
	dialogue = load_dialogue()
	hide()  # Hide UI until needed

func load_dialogue():
	var file = FileAccess.open(Intro_D_file, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	if typeof(content) == TYPE_ARRAY:
		return content
	else:
		push_error("Failed to load dialogue from JSON")
		return []

func show_dialogue(index: int):
	if index >= 0 and index < dialogue.size():
		current_dialogue_id = index
		full_text = dialogue[index]["Intro"]
		current_text = ""
		$Intro.text = ""
		typing_timer = 0.0
		is_typing = true
		show()
		dia_active = true
	else:
		hide()
		dia_active = false

func _process(delta: float) -> void:
	if is_typing:
		typing_timer += delta
		if typing_timer >= typing_speed:
			typing_timer = 0.0
			if current_text.length() < full_text.length():
				current_text += full_text[current_text.length()]
				$Intro.text = current_text
			else:
				is_typing = false


func next_script():
	if is_typing:
		# Skip typing, show full text immediately
		$Intro.text = full_text
		is_typing = false
	else:
		current_dialogue_id += 1
		if current_dialogue_id < dialogue.size():
			show_dialogue(current_dialogue_id)
		else:
			hide()
			dia_active = false


func reset():
	current_dialogue_id = -1
	hide()
	dia_active = false
