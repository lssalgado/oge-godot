extends Entity

onready var animated_sprite = $AnimatedSprite
onready var ledge_collision = $Raycasts/LedgeCollision
onready var jump_collision = $Raycasts/JumpCollision
onready var wall_collision = $Raycasts/WallCollision
onready var top_collision = $EventCollisions/TopCollision

func _ready():
	set_physics_process(true)
	animated_sprite.play("walk")

func change_direction():
	direction = direction * -1
	ledge_collision.position.x *= -1
	wall_collision.position.x *= -1
	wall_collision.cast_to *= Vector2(-1,0)
	jump_collision.position.x *= -1
	jump_collision.cast_to *= Vector2(-1,0)

func process_horizontal_movement(delta: float):
	.process_horizontal_movement(delta)

	if is_on_floor():
		if $Raycasts/WallCollision.is_colliding() and $Raycasts/WallCollision2.is_colliding() == false:
			jump()
		elif $Raycasts/WallCollision.is_colliding() or $Raycasts/Ledge.is_colliding() == false:
			change_direction()

func _physics_process(delta: float):
	physics_process(delta)

func _on_TopCollision_body_entered(body: Node):
	if body.global_position.y > top_collision.global_position.y - 5:
		return
	queue_free()

func _on_SideCollision_body_entered(body):
	if body.is_in_group("Player") and body.invulnerable == false:
		body.take_damage()
