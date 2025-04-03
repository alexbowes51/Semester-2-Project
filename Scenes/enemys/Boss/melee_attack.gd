extends State

func enter():
	super.enter()
	animated_sprite_2d.play("attack")
	
func transition():
	if owner.direction.length() > 100:
		get_parent().change_state("Follow")
