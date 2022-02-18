extends KinematicBody2D

class_name Entity

const ACCELERATION: int = 256
const GRAVITY: int = 300
const FRICTION: float = 0.15
const NO_RESISTANCE: float = 0.0
const AIR_RESISTANCE: float = 0.035

var max_speed: int = 32
var jump_force: int = 120
var lives: int = 1
var invulnerable: bool = false
var resistance: float = NO_RESISTANCE
var direction: float = 1
var counter: int = 0
var motion: Vector2 = Vector2.ZERO

func process_horizontal_movement(delta: float):
	motion.x += direction * ACCELERATION * delta
	motion.x = clamp(motion.x, -max_speed, max_speed)

func process_vertical_movement(delta: float):
	motion.y += GRAVITY * delta

func jump():
	motion.y = -jump_force
	resistance = AIR_RESISTANCE

func take_damage():
	pass

func physics_process(delta: float):
	process_horizontal_movement(delta)
	process_vertical_movement(delta)
	
	if (resistance != NO_RESISTANCE):
		motion.x = lerp(motion.x, 0, resistance)
	
	motion = move_and_slide(motion, Vector2.UP)
