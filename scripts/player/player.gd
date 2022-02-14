extends KinematicBody2D

#constantes relacionadas a fisica e gravidade
const ACCELERATION = 256
const MAX_SPEED = 64
const FRICTION = 0.15
const AIR_RESISTANCE = 0.035
const GRAVITY = 300
const JUMP_FORCE = 150

var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

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
	
	if input_x != 0:
		animation_player.play("walk")
		#movimento no eixo x = input_x(esquerda ou direita) * aceleracao * real time
		motion.x += input_x * ACCELERATION * delta
		#seta uma velocidade minima e maxima pro player se não ele vira o sanic por causa da aceleracao
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		#vira o sprite na horizontal se o input_x for negativo
		sprite.flip_h = input_x < 0
	else:
		animation_player.play("idle")
	
	#aumenta a gravidade a cada frame
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if input_x == 0:
			#reduz a velocidade horizontal pela friccao ate chegar em 0
			motion.x = lerp(motion.x, 0, FRICTION)
		if Input.is_action_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") && motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	motion = move_and_slide(motion, Vector2.UP)
