extends Entity

onready var animated_sprite = $AnimatedSprite
onready var ledge_collision = $Raycasts/LedgeCollision
onready var jump_collision = $Raycasts/JumpCollision
onready var wall_collision = $Raycasts/WallCollision
onready var top_area = $EventCollisions/TopArea

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
		if wall_collision.is_colliding() and jump_collision.is_colliding() == false:
			jump()
		elif wall_collision.is_colliding() or ledge_collision.is_colliding() == false:
			change_direction()

func _physics_process(delta: float):
	physics_process(delta)

func _on_TopArea_body_entered(body: Node):
	if body.global_position.y <= top_area.global_position.y - 12:
		queue_free()
	

func _on_SideArea_body_entered(body):
	if body.is_in_group("Player") and body.invulnerable == false:
		body.take_damage()


