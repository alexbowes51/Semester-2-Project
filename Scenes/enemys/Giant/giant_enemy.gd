extends CharacterBody2D

var player = null

var health = 160
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

enum States{
	IDLE,
	CHASING,
	ATTACKING,
}

var current_state = States.IDLE
var attacked = false
var attacking = false
var alive = true

func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	if alive == true:
		damage()
		chasing()
		attack()
		is_alive()
		
	


func _on_g_e_chase_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		current_state = States.CHASING


func _on_g_e_chase_body_exited(body: Node2D) -> void:
		if body.has_method("Player"):
			player = body
			current_state = States.IDLE


func _on_g_h_area_body_entered(_body: Node2D) -> void:
	if _body.has_method("Player"):
		current_state = States.ATTACKING
		attacking = true
		attack()


func _on_g_h_area_body_exited(_body: Node2D) -> void:
	current_state = States.CHASING
	attacking = false
	


func _on_g_e_hb_area_entered(area: Area2D) -> void:
	if area && area.name == "Player_Attack_HitBox" && WorldManager.player_current_attack == true:
		attacked = true
		

func _on_g_e_hb_area_exited(area: Area2D) -> void:
	if area && area.name == "Player_Attack_HitBox" && WorldManager.player_current_attack == true :
		attacked = false
		

func damage():
	if alive == true:
		if alive == true && attacked == true:
			health -= 20
			attacked = false
			_on_attacked_cooldown_timeout()
		
func chasing():
	if alive == true:
		if player != null && current_state == States.CHASING:
			$AnimatedSprite2D.play("walk")
			position += ( player.global_position - global_position ).normalized() / 2
			look_at(player.get_global_position())
			global_rotation_degrees += -90
	
func attack():
	if alive == true:
		if player != null && current_state == States.ATTACKING:
			$AnimatedSprite2D.play("attack")
			attacking = true
			_on_attack_cooldown_timeout()

func is_alive():
	if health <= 0 :
		alive = false
		$AnimatedSprite2D.play("death")


func _on_attack_cooldown_timeout() -> void:
	attacking = false


func _on_attacked_cooldown_timeout() -> void:
	attacking = false
	attacked = false

func Giant_E():
	pass
