extends Entity


func _ready():
	set_physics_process(true)
	$Skin/AnimatedSprite.play("walk")

func change_direction():
	direction = direction * -1
	$Raycasts/Ledge.position.x *= -1
	$Raycasts/WallCollision.position.x *= -1
	$Raycasts/WallCollision2.position.x *= -1

func process_horizontal_movement(delta: float):
	.process_horizontal_movement(delta)

	if is_on_floor():
		if $Raycasts/WallCollision.is_colliding() and $Raycasts/WallCollision2.is_colliding() == false:
			jump()
		elif $Raycasts/WallCollision.is_colliding() or $Raycasts/Ledge.is_colliding() == false:
			change_direction()

func _physics_process(delta: float):
	physics_process(delta)

func _on_Top_body_entered(body: Node):
	if body.is_in_group("Player"):
		queue_free()

func _on_Sides_body_entered(body):
	if body.is_in_group("Player") and body.invulnerable == false:
		body.take_damage()
