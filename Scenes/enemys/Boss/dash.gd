extends State

var can_transition: bool = false

func enter():
	super.enter()
	animated_sprite_2d.play("glowing")
	await dash()
	can_transition = true


func dash():
	var tween = create_tween()
	tween.tween_property(owner, "position",player.position,2.0)
	await tween.finished

func transition():
	if can_transition:
		can_transition = false
		
	get_parent().change_state("Follow")
