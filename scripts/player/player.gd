extends Entity

class_name Player

#constantes relacionadas a fisica e gravidade

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

func _ready():
	MAX_SPEED = 64

func process_horizontal_movement(delta: float):
	.process_horizontal_movement(delta)
	if direction != 0:
		animation_player.play("walk")
		sprite.flip_h = direction < 0
	else:
		animation_player.play("idle")
	
func process_vertical_movement(delta: float):
	resistance = NO_RESISTANCE
	
	.process_vertical_movement(delta)
	#aumenta a gravidade a cada frame
	
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

# usamos _phiscs_process(delta) pois roda runtime em um valor fixo de frames
func _physics_process(delta: float):
	
	"""
	input_x faz um calculo do input de movimento do jogador
	 - Se o player está segurando para a direita o valor é 1
	 - Se o player está segurando para a esquerda o valor é -1 
	 - Se o player está segurando ambos o valor é 0
	 - Se o player não está segurando nada o valor é 0
	"""
	
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	physics_process(delta)
	
