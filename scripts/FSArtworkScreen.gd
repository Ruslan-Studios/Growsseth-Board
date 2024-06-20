extends CanvasLayer

signal fs_artwork_screen_exited

@onready var container = $".."
@onready var artwork_btn = %ArtworkBtn

func _input(event):
	if event is InputEventMouseButton and Input.is_action_just_pressed("mouse_right_click"):
		fs_artwork_screen_exited.emit()
		visible = false
		artwork_btn.visible = true
