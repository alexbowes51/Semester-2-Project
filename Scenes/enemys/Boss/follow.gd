extends State

@onready var summon_cooldown: Timer = $"../../summon_cooldown"
var summon : bool = true
@onready var aggressive: Timer = $"../../aggressive"
var attack = false

# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	owner.set_physics_process(true)
	animated_sprite_2d.play("idle")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var distance = owner.direction.length()
	CombatMusic.play()
	if distance < 200:
		get_parent().change_state("MeleeAttack")
	elif distance > 500:
		get_parent().change_state("RockThrow")
	elif distance > 450 && summon == true:
		get_parent().change_state("Summon")
		summon = false
		summon_cooldown.start()
	elif distance > 200 && distance < 350 && attack == false:
		attack = true
		aggressive.start()
		var chance = randi() % 2
		match  chance:
			0: get_parent().change_state("Dash")
			1: get_parent().change_state("Summon")
		

func _on_summon_cooldown_timeout() -> void:
	summon = true 


func _on_aggressive_timeout() -> void:
	attack = false
