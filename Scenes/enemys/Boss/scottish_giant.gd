extends CharacterBody2D

@onready var player = find_parent("world").find_child("Player")
@onready var sprite = $AnimatedSprite2D
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar
@onready var damage_cooldown: Timer = $damage_cooldown
@onready var cpu_particles_2d_2: CPUParticles2D = $CPUParticles2D2
@onready var damage_audio: AudioStreamPlayer = $damage


var vunrible = true

var direction : Vector2

var health = 100:
	set(value):
		health = value
		progress_bar.value = value 
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2:
			find_child("FiniteStateMachine").change_state("Buff")
			

func _ready():
	set_physics_process(false)
	progress_bar.value = health
	
func _process(_delta):
	direction = player.position - position 
	if health > 0:
		look_at(player.position)
		rotation += rad_to_deg(90)
	

func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta * 2)

func damage():
	health -= 20
	cpu_particles_2d_2.emitting = true
	damage_audio.play()
	

func _on_boss_1_hb_area_entered(area: Area2D) -> void:
	if area.name == "Player_Attack_HitBox" && WorldManager.player_current_attack == true && vunrible == true:
		damage()
		damage_cooldown.start()
		vunrible = false
		progress_bar.visible = false

func _on_damage_cooldown_timeout() -> void:
	vunrible = true
	progress_bar.visible = true
	
