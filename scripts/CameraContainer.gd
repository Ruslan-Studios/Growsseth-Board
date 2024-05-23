extends Marker3D

#	Title: MAP GENERATOR
#	Description: Map generator based on a seed
#   Made by: NoelEm

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var dragging = false
var sensitivity = 0.005
var lerp_factor = 0.05
var target_rotation = Vector3()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed

	if event is InputEventMouseMotion and dragging:
		target_rotation.y -= event.relative.x * sensitivity
		target_rotation.x -= event.relative.y * sensitivity
		target_rotation.x = clamp(target_rotation.x, 0, 0.7)

func _process(delta):
	rotation.x = lerp(rotation.x, target_rotation.x, lerp_factor)
	rotation.y = lerp(rotation.y, target_rotation.y, lerp_factor)
