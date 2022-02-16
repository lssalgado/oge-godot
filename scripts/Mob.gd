extends Entity


func _ready():
	set_physics_process(true)
	$AnimatedSprite.play("walk")

func change_direction():
	direction = direction * -1
	$Ledge.position.x *= -1
	$WallCollision.position.x *= -1

func process_horizontal_movement(delta: float):
	.process_horizontal_movement(delta)
	if $Ledge.is_colliding() == false:
		change_direction()
	
	if $WallCollision.is_colliding() == true:
		change_direction()


func _physics_process(delta: float):
	physics_process(delta)

func _on_Top_body_entered(body: Node):
	if body.is_in_group("Player") == true:
		queue_free()
