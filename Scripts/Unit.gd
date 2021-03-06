extends KinematicBody2D


onready var bullet = preload("res://Scenes/Bullet.tscn")
onready var main = get_parent()

const SPEED = 300
const MOVEBUFFER = 3

export var myTeam = "team1"
var health = 100

var mouseIn = false
onready var movePos = position

var targets = []



func _ready():
	add_to_group(myTeam)
	add_to_group("units")
	$Circle.visible = false
	$HealthBar.visible = false


func _process(delta):
	if position.distance_to(movePos) > MOVEBUFFER:
		move()
	else:
		position = movePos
	
	if is_in_group("selected"):
		$Circle.visible = true
	else:
		$Circle.visible = false	


#func _unhandled_input(event):
#	if Input.is_action_just_pressed("select") and mouseIn and is_in_group("team1"):
#		add_to_group("selected")
#		for i in get_tree().get_nodes_in_group("selected"):
#			i.remove_from_group("selected")


func mouse_move_pos():
	movePos = get_global_mouse_position()
	var selected = get_tree().get_nodes_in_group("selected")
	# if shouldn't be in the middle, go to the sides
	if selected.find(self) > 0 && selected.find(self) % 3 != 0:
		if selected.find(self) % 2 == 0:
			movePos.x += 100
		else:
			movePos.x -= 100
	# after every three, go back a row
	for i in selected.find(self)/3:
		movePos.y += 100


func move():
	# turn towards point
	$CollisionShape2D.rotate($CollisionShape2D.get_angle_to(movePos) - PI/2)
	$Sprite.rotate($Sprite.get_angle_to(movePos) - PI/2)
	
	move_and_slide(Vector2(movePos.x-position.x, movePos.y-position.y).normalized() * SPEED)



# shoot
func _on_FireRate_timeout():
	var newBul = bullet.instance()
	newBul.position = position
	newBul.target = targets[0]
	newBul.myTeam = myTeam
	get_parent().add_child(newBul)

func damage(amount):
	health -= amount
	$HealthBar.visible = true
	$HealthBar.value = health
	if health <= 0:
		queue_free()



func _on_Unit_mouse_entered():
	mouseIn = true
func _on_Unit_mouse_exited():
	mouseIn = false


func _on_Range_body_entered(body):
	if is_in_group("team1") && body.is_in_group("team2") \
			or is_in_group("team2") && body.is_in_group("team1"):
		targets.append(body)
		$FireRate.start()
func _on_Range_body_exited(body):
	if targets.has(body):
		targets.remove(targets.find(body))
		if targets.size() <= 0:
			$FireRate.stop()

