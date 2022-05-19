extends KinematicBody2D


onready var bullet = preload("res://Bullet.tscn")


const SPEED = 300
const MOVEBUFFER = 3

export var myTeam = "team1"
var health = 100

var mouseIn = false
onready var movePos = position

var targets = []




func _ready():
	add_to_group(myTeam)
	$Circle.visible = false
	$HealthBar.visible = false


func _process(delta):
	
	
	if position.distance_to(movePos) > MOVEBUFFER:
		move_and_slide(Vector2(movePos.x-position.x, movePos.y-position.y).normalized() * SPEED)
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


func move():
	movePos = get_viewport().get_mouse_position()
	$CollisionShape2D.rotate($CollisionShape2D.get_angle_to(movePos) - PI/2)
	$Sprite.rotate($Sprite.get_angle_to(movePos) - PI/2)

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

