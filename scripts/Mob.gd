extends KinematicBody2D


const ACCELERATION: int = 256
const MAX_SPEED: int = 32
const GRAVITY: int = 300

var direction: int = 1
var motion: Vector2 = Vector2.ZERO

func _ready():
	$AnimatedSprite.play("walk")

func process_horizontal_movement(delta: float):
	motion.x += direction * ACCELERATION * delta
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
	if $Ledge.is_colliding() == false:
		direction = direction * -1
		$Ledge.position.x *= -1
	
	if is_on_wall() == true:
		direction = direction * -1
		$Ledge.position.x *= -1
	
func process_vertical_movement(delta: float):
	motion.y += GRAVITY * delta
	

func _physics_process(delta: float):
	process_horizontal_movement(delta)
	process_vertical_movement(delta)
	
	motion = move_and_slide(motion, Vector2.UP)

func _on_Top_body_entered(body: Node):
	if body.is_in_group("Player") == true:
		queue_free()
