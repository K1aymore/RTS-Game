extends KinematicBody2D

const SPEED = 300
const MOVEBUFFER = 3

var mouseIn = false
onready var movePos = position

var targets = []


func _ready():
	$Circle.visible = false


func _process(delta):
	if position.distance_to(movePos) > MOVEBUFFER:
		move_and_slide(Vector2(movePos.x-position.x, movePos.y-position.y).normalized() * SPEED)
	else:
		position = movePos
	
	if is_in_group("selected"):
		$Circle.visible = true
	else:
		$Circle.visible = false


func _unhandled_input(event):
	if Input.is_action_just_pressed("select") and mouseIn and is_in_group("team1"):
		get_tree().set_input_as_handled()
		if is_in_group("selected"):
			remove_from_group("selected")
		else:
			add_to_group("selected")


func move():
	movePos = get_viewport().get_mouse_position()
	rotate(get_angle_to(movePos) - PI/2)



func _on_Unit_mouse_entered():
	mouseIn = true
func _on_Unit_mouse_exited():
	mouseIn = false

func _on_Range_body_entered(body):
	if is_in_group("team1") && body.is_in_group("team2") \
			or is_in_group("team2") && body.is_in_group("team1"):
		targets.append(body)
		print(targets)
func _on_Range_body_exited(body):
	if targets.has(body):
		targets.remove(targets.find(body))
		print(targets)



