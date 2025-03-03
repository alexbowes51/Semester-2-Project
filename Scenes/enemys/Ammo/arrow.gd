extends CharacterBody2D

var direction : Vector2 = Vector2.ZERO
var speed : float = 100

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		queue_free()
