extends Node2D

var team = "team1"

var mass = 50
var energy = 50
var maxMass = 100
var maxEnergy = 100

var dragging = false
var drag_start
var select_rect = RectangleShape2D.new()


func _process(delta):
	if Input.is_action_just_pressed("command"):
		 get_tree().call_group("selected", "mouse_move_pos")
	
	mass += delta
	energy += delta


func _draw():
	if dragging:  # draw rectangle
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), Color(.5, .5, .6), true)
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), Color(0, 0, 1), false)


func _unhandled_input(event):
	if event is InputEventMouseMotion and dragging:
		update()
	
	if Input.is_action_just_pressed("select"):
		dragging = true
		drag_start = get_global_mouse_position()
	
	if Input.is_action_just_released("select"):
		if !Input.is_action_pressed("shift"):
			deselect_all()
		
		# finish dragging box
		if dragging:
			dragging = false
			update()
			select_rect.extents = (get_global_mouse_position() - drag_start) / 2
			
			# Magic
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (get_global_mouse_position() + drag_start) / 2)
			for i in space.intersect_shape(query):
				if i.collider.is_in_group("team1"):
					i.collider.add_to_group("selected")
			
			if get_tree().get_nodes_in_group("selected").size() > 0:
				if selected_has("factories") && selected_has("units"):
					while selected_has("factories"):
						selected_get("factories").remove_from_group("selected")
		


func deselect_all():
	for i in get_tree().get_nodes_in_group("selected"):
			i.remove_from_group("selected")


func selected_has(type):
	for i in get_tree().get_nodes_in_group("selected"):
		if i.is_in_group(type):
			return true
	return false


func selected_get(type):
	for i in get_tree().get_nodes_in_group("selected"):
		if i.is_in_group(type):
			return i

