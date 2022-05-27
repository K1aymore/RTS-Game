extends StaticBody2D

onready var unit = preload("res://Scenes/Unit.tscn")

export var myTeam = "team1"

var mouseIn = false



# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(myTeam)


func _process(delta):
	if is_in_group("selected"):
		$Circle.visible = true;
	else:
		$Circle.visible = false;



#func _unhandled_input(event):
#	if Input.is_action_just_pressed("select") and mouseIn:
#		spawn_unit()

func add_unit():
	$UnitTimer.wait_time = 3
	$UnitTimer.start()


# spawn unit
func _on_UnitTimer_timeout():
	var newUnit = unit.instance()
	newUnit.position = Vector2(position.x, position.y + 200)
	newUnit.myTeam = myTeam
	get_parent().add_child(newUnit)



func _on_Factory_mouse_entered():
	mouseIn = true
func _on_Factory_mouse_exited():
	mouseIn = false



