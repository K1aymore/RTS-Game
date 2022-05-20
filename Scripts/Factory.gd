extends StaticBody2D

onready var unit = preload("res://Scenes/Unit.tscn")

var mouseIn = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if Input.is_action_just_pressed("select") and mouseIn:
		spawn_unit()


func spawn_unit():
	var newUnit = unit.instance()
	newUnit.position = Vector2(position.x, position.y + 200)
	get_parent().add_child(newUnit)


func _on_Factory_mouse_entered():
	mouseIn = true
func _on_Factory_mouse_exited():
	mouseIn = false
