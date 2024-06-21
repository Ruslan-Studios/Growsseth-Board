extends Camera3D

var sensivity = 0.2
@onready var raycastPointer = $"../Raycast"

func _process(delta):
	if raycastPointer.is_colliding():
		#print(raycastPointer.get_collision_point())
		pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		position.z += sensivity
		position.y += sensivity
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		position.z -= sensivity
		position.y -= sensivity
		
	position.y = clamp(position.y, 7, 21)
	position.z = clamp(position.z, 7, 21)
