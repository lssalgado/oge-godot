extends Node

class_name OgeWorld

export(PackedScene) var player_scene
export(PackedScene) var mob_scene

const COLLUMS: int = 20
const ROWS: int = 11
const TILE_SIZE: int = 16

var player_collum: int = 0
var player_row: int = 1

const START_POSITION: Vector2 = Vector2(8.0, 24.0)

var player: Player
var mobs = Array()

func get_tile_position(collum: int, row: int)-> Vector2:
	var x = (collum * 16 + 8)
	var y = (row * 16 + 8)
	return Vector2(x, y)

func add_mob(collum: int, row: int):
	var mob = mob_scene.instance()
	add_child(mob)
	mob.position = get_tile_position(collum, row)
	return mob

func add_mobs():
	for mob in mobs:
		remove_child(mob)
	
	var mob = add_mob(18, 6)
	mobs.append(mob)
	mob = add_mob(12, 3)
	mobs.append(mob)
	mob = add_mob(2, 6)
	mobs.append(mob)

func place_player():
	print("place_player")
	player = player_scene.instance()
	add_child(player)
	player.position= get_tile_position(player_collum, player_row)

func new_game():
	print("new_game")
	get_tree().reload_current_scene()

func _ready():
	print("_ready")
	add_mobs()
	place_player()

func _process(delta: float):
	if Input.is_action_just_pressed("restart"):
		new_game()

func _on_Void_body_entered(body: Node):	
	if body.is_in_group("Player") == true:
		new_game()
	elif body.is_in_group("Mob") == true:
		body.queue_free()
