extends CharacterBody2D

var direction : Vector2 = Vector2.ZERO
var speed : float = 100
func _ready():
	velocity = direction * speed
	 

func _physics_process(delta):
	move_and_slide()

func set_direction(new_dir:Vector2):
	direction = new_dir
	velocity = direction * speed 
	rotation = direction.angle()
	
	



func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_arrow_hit_bow_enemy_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area && area.name == "Player_HitBox":
		self.queue_free()

func enemy_arrow():
	pass
