extends Camera2D

const SPEED = 800

var mouseStopPos
var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	bar_update()


func _process(delta):
	velocity = Vector2.ZERO
	
	process_zoom()
	move(delta)
	
	position += velocity


func process_zoom():
	if Input.is_action_just_pressed("zoom_in"):
		zoom.x -= .2
		scale.x -= .2
	elif Input.is_action_just_pressed("zoom_out"):
		zoom.x += .2
		scale.x += .2
	zoom.y = zoom.x
	scale.y = scale.x


func move(delta):
	velocity.x += Input.get_axis("ui_left", "ui_right") * SPEED * delta
	velocity.y += Input.get_axis("ui_up", "ui_down") * SPEED * delta
	
	if Input.is_action_just_pressed("move"):
		mouseStopPos = get_global_mouse_position()
	if Input.is_action_pressed("move"):
		velocity += (mouseStopPos - get_global_mouse_position())



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

