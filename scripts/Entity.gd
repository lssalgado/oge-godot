extends KinematicBody2D

class_name Entity

const ACCELERATION: int = 256
const GRAVITY: int = 300
const FRICTION: float = 0.15
const NO_RESISTANCE: float = 0.0
const AIR_RESISTANCE: float = 0.035
const JUMP_FORCE: int = 150

var MAX_SPEED: int = 32
var motion: Vector2 = Vector2.ZERO
var direction: float = 1
var resistance: float = NO_RESISTANCE
var counter: int = 0

func _ready():
	pass # Replace with function body.

func process_horizontal_movement(delta: float):
	#movimento no eixo x = direction(esquerda ou direita) * aceleracao * real time
	motion.x += direction * ACCELERATION * delta
	#seta uma velocidade minima e maxima pro player se não ele vira o sanic por causa da aceleracao
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

func process_vertical_movement(delta: float):
	motion.y += GRAVITY * delta

func physics_process(delta: float):
	print("entity counter = %d" % counter)
	process_horizontal_movement(delta)
	process_vertical_movement(delta)
	if (resistance != NO_RESISTANCE):
		motion.x = lerp(motion.x, 0, resistance)
	motion = move_and_slide(motion, Vector2.UP)
