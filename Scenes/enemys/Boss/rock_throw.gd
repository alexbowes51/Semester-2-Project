extends State

@export var rock_scene : PackedScene
var can_transition: bool = false

func enter():
	super.enter()
	animated_sprite_2d.play("attack")
	await animated_sprite_2d.animation_finished
	throw()
	can_transition = true

func throw():
	var rock = rock_scene.instantiate()
	rock.global_position = owner.global_position 
	get_tree().current_scene.add_child(rock)
	print("throw")
	

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
