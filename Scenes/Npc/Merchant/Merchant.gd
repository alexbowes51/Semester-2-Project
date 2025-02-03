extends CharacterBody2D

const speed = 30
var current_state = IDLE

var is_roaming = true
var is_chatting = false
var player = null
var player_in_interact_range = false

var dir = Vector2.RIGHT
var start_pos

enum {
	IDLE,
	FOLLOW,
	MOVE,
	NEW_DIR
}


func _ready():
	randomize()
	start_pos = position


func _physics_process(delta: float) -> void:
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("Mechant_idle")
		
	elif current_state == 2 and !is_chatting:
		
		if dir.x == -1:
			$AnimatedSprite2D.play("Mechant_Move")
			$AnimatedSprite2D.rotation = rad_to_deg(-90)
			
		if dir.x == 1:
			$AnimatedSprite2D.play("Mechant_Move")
			$AnimatedSprite2D.rotation = rad_to_deg(90)
			
		if dir.y == -1:
			$AnimatedSprite2D.play("Mechant_Move")
			$AnimatedSprite2D.rotation = rad_to_deg(-180)
			
		if dir.y == 1:
			$AnimatedSprite2D.play("Mechant_Move")
			$AnimatedSprite2D.rotation = rad_to_deg(0)
			
	if is_roaming:
		match  current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT,Vector2.UP,Vector2.LEFT,Vector2.DOWN])
			MOVE:
				move(delta)
	if Input.is_action_just_pressed("chat"):
		print("chatting with player")
		$Merchant_Dialogue.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("Mechant_Iteract")

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		position += dir * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		body = player
		player_in_interact_range = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player_in_interact_range = false
		player = null
		

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5,1.0,1.5])
	current_state = choose([IDLE,NEW_DIR,MOVE])


func _on_merchant_dialogue_end_dialogue() -> void:
	is_chatting = false
	is_roaming = true
