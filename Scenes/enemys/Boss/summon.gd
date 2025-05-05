extends State

@onready var summon_cooldown: Timer = $"../../summon_cooldown"
@export var archer_scene : PackedScene
@export var pike_scene : PackedScene
var can_transition: bool = false
var can_summon: bool = true

func enter():
	super.enter()
	animated_sprite_2d.play("idle")
	await animated_sprite_2d.animation_finished
	Summon()
	can_transition = true

func Summon():
	if can_summon == true:
		var archer_1 = archer_scene.instantiate()
		archer_1.global_position = Vector2(owner.global_position.x - 100,owner.global_position.y + 100)
		get_tree().current_scene.add_child(archer_1)
		
		var solider_1 = pike_scene.instantiate()
		solider_1.global_position = Vector2(owner.global_position.x + 100,owner.global_position.y + 100)
		get_tree().current_scene.add_child(solider_1)
		print("summon")

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("RockThrow")


func _on_summon_cooldown_timeout() -> void:
	can_summon = true
	
