extends Node2D

var team = "team1"

func _process(delta):
	if Input.is_action_just_pressed("command"):
		 get_tree().call_group("selected", "move")

func _unhandled_input(event):
	if Input.is_action_just_pressed("select"):
		for i in get_tree().get_nodes_in_group("selected"):
			i.remove_from_group("selected")
