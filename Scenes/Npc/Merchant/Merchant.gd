extends CharacterBody2D

const speed = 2.25

var current_state = IDLE

var is_roaming = true
var is_chatting = false
var player = null
var player_in_interact_range = false
var is_following_player = false

var dir = Vector2.RIGHT
var player_position : Vector2
var start_pos

enum {
	IDLE,
	FOLLOW,
	MOVE,
	NEW_DIR,
	RETURN_START
}

signal start_dia

func _ready():
	randomize()
	start_pos = position


func _physics_process(delta):
	
	if WorldManager.Merchant_follow_player == true:
		is_following_player = true
		current_state = FOLLOW
	else:
		is_following_player = false
	
	if current_state == 0:
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
			FOLLOW:
				position += (player.global_position - global_position) * speed * delta
				
				
	
	
	if player_in_interact_range:
		if Input.is_action_just_pressed("chat"):
			print("chatting with player")
			WorldManager.player_talking_Merchant = true
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
		player = body
		player_in_interact_range = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player_in_interact_range = false
		WorldManager.player_talking_Merchant = false
		is_chatting = false
		is_roaming = true
		

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5,1.0,1.5])
	current_state = choose([IDLE,NEW_DIR,MOVE])


func _on_merchant_dialogue_end_dialogue() -> void:
	is_chatting = false
	is_roaming = true


func _on_follow_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
