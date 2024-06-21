extends Camera3D

var mousePos: Vector2 = Vector2()

func _input(event):
	if event is InputEventMouse:
		mousePos = event.position
		# Check mouse over su carta
		get_selection()
	if event is InputEventMouseButton and Input.is_action_just_pressed("mouse_right_click"):
		# Check tasto destro su carta
		var result = get_selection()
		if result and result.collider is Card3D:
			card_right_click(result)

func get_selection():
	var worldspace = get_world_3d().direct_space_state
	
	var ray_start = project_ray_origin(mousePos)
	var ray_end = project_position(mousePos, 1000)
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(ray_start, ray_end))
	
	print("Raycast result: " + str(result))
	
	return result

func card_right_click(result):
	set_process_input(false)
	result.collider.show_card_info()
	result.collider.get_node("CardInfoScreen").connect("card_info_screen_exited", enable_input_process)

func enable_input_process():
	set_process_input(true)
