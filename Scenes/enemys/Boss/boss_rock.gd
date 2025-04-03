extends Area2D

@onready var cpu_particles_2d_2: CPUParticles2D = $CPUParticles2D2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = find_parent("world").find_child("Player")
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var speed = 200.0
var target_position: Vector2 = Vector2.ZERO
var moving = false  # Ensure movement only happens after setting target

func _ready() -> void:
	if player != null:
		target_position = player.global_position  # Store player's last position at spawn
		moving = true  # Enable movement toward target

func _physics_process(delta: float) -> void:
	if moving:
		var dir = (target_position - global_position).normalized()
		var velocity = dir * speed * delta  # Multiply by delta for frame independence
		position += velocity * 3
		
		
		# Stop moving if close enough to target
		if global_position.distance_to(target_position) <= 5.0:
			moving = false  # Stop updating movement
			cpu_particles_2d.emitting = true
			cpu_particles_2d_2.emitting = true
			collision_shape_2d.disabled = true
			animated_sprite_2d.play("stopped")
			audio_stream_player.play()
			


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):  # Ensure the player is in a designated group
		self.queue_free()
