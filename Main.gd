extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("command"):
		 get_tree().call_group("selected", "move")
