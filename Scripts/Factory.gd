extends StaticBody2D

onready var unit = preload("res://Scenes/Unit.tscn")

export var myTeam = "team1"

var unitQueue = []

var mouseIn = false



# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(myTeam)
	add_to_group("factories")
	$ProgressBar.visible = false
	

func _process(delta):
	$ProgressBar.value = (($UnitTimer.wait_time - $UnitTimer.time_left) / $UnitTimer.wait_time) * 100
	
	if is_in_group("selected"):
		$Circle.visible = true;
	else:
		$Circle.visible = false;



#func _unhandled_input(event):
#	if Input.is_action_just_pressed("select") and mouseIn:
#		spawn_unit()

func add_unit(type):
	unitQueue.append(type)
	$ProgressBar.visible = true
	if unitQueue.size() <= 1:
		timer_start()


func timer_start():
	$UnitTimer.wait_time = 1.5
	$UnitTimer.start()


# spawn unit
func _on_UnitTimer_timeout():
	unitQueue.remove(0)
	var newUnit = unit.instance()
	newUnit.position = Vector2(position.x, position.y + 200)
	newUnit.myTeam = myTeam
	get_parent().add_child(newUnit)
	
	if unitQueue.size() > 0:
		timer_start()
	else:
		$ProgressBar.visible = false



func _on_Factory_mouse_entered():
	mouseIn = true
func _on_Factory_mouse_exited():
	mouseIn = false



