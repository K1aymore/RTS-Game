extends Camera2D

const SPEED = 800


# Called when the node enters the scene tree for the first time.
func _ready():
	bar_update()


func _process(delta):
	position.x += Input.get_axis("ui_left", "ui_right") * SPEED * delta
	position.y += Input.get_axis("ui_up", "ui_down") * SPEED * delta


func bar_update():
	if get_tree().get_nodes_in_group("selected").size() > 0:
		$BottomBar.visible = true
		$BottomBar/Factory.visible = selected_has("factories")
	else:
		$BottomBar.visible = false


func _on_Tank_pressed():
	for f in selected_get_all("factories"):
		f.add_unit("Tank")




func selected_has(type):
	for i in get_tree().get_nodes_in_group("selected"):
		if i.is_in_group(type):
			return true
	return false

func selected_get_all(type):
	var array = []
	for i in get_tree().get_nodes_in_group("selected"):
		if i.is_in_group(type):
			array.append(i)
	return array

