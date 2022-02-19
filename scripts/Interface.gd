extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var heart_scene
onready var grid_container = $GridContainer
var hearts = Array()

func _ready():
	var player_node = get_tree().get_root().find_node("Player",true,false)
	var amount: int
	player_node.connect("health_changed",self,"_on_player_health_changed")
	update_heart_count(player_node.lives)

func update_heart_count(amount: int):
	if hearts.size() < amount:
		var hearts_to_add = amount - hearts.size()
		for i in range(0, hearts_to_add, 1):
			var heart = heart_scene.instance()
			hearts.append(heart)
			grid_container.add_child(heart)
	else:
		var hearts_to_remove = hearts.size() - amount
		for i in range(0, hearts_to_remove, 1):
			var heart = hearts.pop_back()
			heart.queue_free()
	

func _on_player_health_changed(amount: int):
	update_heart_count(amount)
