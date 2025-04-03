extends State

@onready var cpu_particles_2d: CPUParticles2D = $"../../CPUParticles2D"
var can_transition : bool = false
@onready var buff_time: Timer = $"../../Buff_Time"
@onready var damage_cooldown: Timer = $"../../damage_cooldown"


func enter():
	super.enter()
	animated_sprite_2d.play("buff")
	cpu_particles_2d.emitting = true
	await animated_sprite_2d.animation_finished
	can_transition = true

func transition():
	if can_transition:
		can_transition = false
		buff_time.start()
		damage_cooldown.start()
		get_parent().change_state("Dash")
		

func _on_buff_time_timeout() -> void:
	cpu_particles_2d.emitting = false
