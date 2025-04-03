extends State


# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	animated_sprite_2d.play("death")
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play("dead")
	
