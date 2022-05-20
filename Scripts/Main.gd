extends Node2D

const CAMERASPEED = 800

var team = "team1"

var dragging = false
var drag_start
var select_rect = RectangleShape2D.new()

func _process(delta):
	if Input.is_action_just_pressed("command"):
		 get_tree().call_group("selected", "move")
	
	$Camera2D.position.x += Input.get_axis("ui_left", "ui_right") * CAMERASPEED * delta
	$Camera2D.position.y += Input.get_axis("ui_up", "ui_down") * CAMERASPEED * delta


func _draw():
	if dragging:  # draw rectangle
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), Color(.5, .5, .6), true)
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), Color(0, 0, 1), false)


func _unhandled_input(event):
	if event is InputEventMouseMotion and dragging:
		update()
		
	if Input.is_action_just_pressed("select"):
		dragging = true
		drag_start = event.position
	
	if Input.is_action_just_released("select"):
		# deselect all units
		for i in get_tree().get_nodes_in_group("selected"):
			i.remove_from_group("selected")
		# finish dragging box
		if dragging:
			dragging = false
			update()
			select_rect.extents = (event.position - drag_start) / 2
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (event.position + drag_start) / 2)
			for i in space.intersect_shape(query):
				if i.collider.is_in_group("team1"):
					i.collider.add_to_group("selected")




