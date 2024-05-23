extends Node3D

var isBookOpen: bool = false

@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AnimationPlayer2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true and isBookOpen == false:
			print("skibidi sigma")
			isBookOpen = true
			animation_player.play("LibroCopertinaAction")
			animation_player_2.play("PagineAction")
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true and isBookOpen == true:
			print("sigma skibidi")
			isBookOpen = false
			animation_player.play_backwards("LibroCopertinaAction")
			animation_player_2.play_backwards("PagineAction")
