extends KinematicBody2D

const SPEED = 800

var target
var velocity
var myTeam

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate(get_angle_to(target.position) - PI/2)
	velocity = Vector2(target.position.x-position.x, target.position.y-position.y).normalized()*SPEED

func _process(delta):
	move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	if !body.is_in_group(myTeam):
		queue_free()
