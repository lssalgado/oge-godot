extends Node

export(PackedScene) var player_scene
export(PackedScene) var mob_scene

const COLLUMS = 20
const ROWS = 11

const TILE_SIZE = 16

const START_POSITION = Vector2(8.0, 24.0)

var player
var mobs = Array()

func get_tile_position(collum, row):
	var x = (collum * 16 + 8)
	var y = (row * 16 + 8)
	return Vector2(x, y)

func add_mob(collum, row):
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

func new_game():
	get_tree().reload_current_scene()

func _ready():
	add_mobs()

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		new_game()


func _on_Void_body_entered(body):
	if body.is_in_group("Player") == true:
		new_game()
	elif body.is_in_group("Mob") == true:
		body.queue_free()
