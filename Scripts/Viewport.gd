extends Camera2D

onready var main = get_parent()

const SPEED = 800

var mouseStopPos
var velocity = Vector2.ZERO

var placing = ""

var newZoom = Vector2.ONE
var newPos = position


# Called when the node enters the scene tree for the first time.
func _ready():
	bar_update()


func _process(delta):
	velocity = Vector2.ZERO
	
	process_zoom(delta)
	move(delta)
	bar_update()
	
	position += velocity
	
	if Input.is_action_just_pressed("select") && placing != "":
		if placing == "energy":
			var build = preload("res://Scenes/Energy Generator.tscn").instance()
			build.position = get_global_mouse_position()
			main.add_child(build)
		
		placing = ""


func process_zoom(delta):
	if Input.is_action_just_released("zoom_in"):
		newZoom.x -= .1
		newPos = (position + get_global_mouse_position())/2
	elif Input.is_action_just_released("zoom_out"):
		newZoom.x += .1
		newPos.x = (position.x + position.x - (get_global_mouse_position().x - position.x))/2
		newPos.y = (position.y + position.y - (get_global_mouse_position().y - position.y))/2
	
	newZoom.y = newZoom.x
	zoom = zoom.linear_interpolate(newZoom, .5)
	scale = zoom
	
	velocity += (newPos - position)/10


func move(delta):
	velocity.x += Input.get_axis("ui_left", "ui_right") * SPEED * delta
	velocity.y += Input.get_axis("ui_up", "ui_down") * SPEED * delta
	
	if Input.is_action_just_pressed("move"):
		mouseStopPos = get_global_mouse_position()
	if Input.is_action_pressed("move"):
		velocity += (mouseStopPos - get_global_mouse_position())
		newPos = position



func bar_update():
	$BottomBar/Main.visible = !get_tree().get_nodes_in_group("selected").size() > 0
	$BottomBar/Factory.visible = selected_has("factories")
	
	$MassBar.value = main.mass
	$EnergyBar.value = main.mass



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



func _on_Tank_pressed():
	for f in selected_get_all("factories"):
		f.add_unit("Tank")


func _on_Energy_pressed():
	placing = "energy"
