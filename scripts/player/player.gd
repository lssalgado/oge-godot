extends KinematicBody2D

#constantes relacionadas a fisica e gravidade
const ACCELERATION = 256
const MAX_SPEED = 64
const FRICTION = 0.15
const NO_RESISTANCE = 0.0
const AIR_RESISTANCE = 0.035
const GRAVITY = 300
const JUMP_FORCE = 150

var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

func process_horizontal_movement(direction, delta):
	if direction != 0:
		animation_player.play("walk")
		#movimento no eixo x = direction(esquerda ou direita) * aceleracao * real time
		motion.x += direction * ACCELERATION * delta
		#seta uma velocidade minima e maxima pro player se não ele vira o sanic por causa da aceleracao
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		#vira o sprite na horizontal se o direction for negativo
		sprite.flip_h = direction < 0
	else:
		animation_player.play("idle")
	
func process_vertical_movement(direction, delta):
	var resistance = NO_RESISTANCE
	#aumenta a gravidade a cada frame
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if direction == 0:
			#reduz a velocidade horizontal pela friccao ate chegar em 0
			resistance = FRICTION
		if Input.is_action_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") && motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		resistance = AIR_RESISTANCE
	
	return resistance

# usamos _phiscs_process(delta) pois roda runtime em um valor fixo de frames
func _physics_process(delta):
	
	"""
	input_x faz um calculo do input de movimento do jogador
	 - Se o player está segurando para a direita o valor é 1
	 - Se o player está segurando para a esquerda o valor é -1 
	 - Se o player está segurando ambos o valor é 0
	 - Se o player não está segurando nada o valor é 0
	"""
	
	var input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	process_horizontal_movement(input_x, delta)
	
	var resistance = process_vertical_movement(input_x, delta)
	
	motion.x = lerp(motion.x, 0, resistance)
	motion = move_and_slide(motion, Vector2.UP)
