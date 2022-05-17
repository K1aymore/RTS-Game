extends KinematicBody2D

const SPEED = 300


var mouseIn = false
onready var movePos = position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position != movePos:
		move_and_slide(Vector2(movePos.x - position.x, movePos.y - position.y).normalized()*SPEED)
	


func _on_Unit_mouse_entered():
	mouseIn = true
	print("hello")
func _on_Unit_mouse_exited():
	mouseIn = false
	print("goodbye")


func _input(event):
	if Input.is_action_just_pressed("select") and mouseIn:
		if is_in_group("selected"):
			remove_from_group("selected")
			$Sprite.flip_v = false
		else:
			add_to_group("selected")
			$Sprite.flip_v = true
			print("thanks for choosing me")


func move():
	movePos = get_viewport().get_mouse_position()
	rotate(get_angle_to(movePos) - PI/2)
	





