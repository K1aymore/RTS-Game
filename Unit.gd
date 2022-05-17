extends KinematicBody2D

var mouseIn = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_in_group("selected"):
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false


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
		else:
			add_to_group("selected")
			print("thanks for choosing me")
