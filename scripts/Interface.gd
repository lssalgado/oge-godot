extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var heart_scene
onready var grid_container = $GridContainer
var hearts = Array()

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
	

