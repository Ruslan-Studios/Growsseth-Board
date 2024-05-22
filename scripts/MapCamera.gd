extends Camera3D

#	Title: MAP GENERATOR
#	Description: Map generator based on a seed
#   Made by: NoelEm

var sensivity = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
