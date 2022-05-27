extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	bar_update()


func bar_update():
	if get_tree().get_nodes_in_group("selected").size() > 0:
		$BottomBar.visible = true
		$BottomBar/Factory.visible = get_tree().get_nodes_in_group("selected")[0].name == "Factory"
	else:
		$BottomBar.visible = false


func _on_Tank_pressed():
	get_tree().get_nodes_in_group("selected")[0].add_unit("Tank")
