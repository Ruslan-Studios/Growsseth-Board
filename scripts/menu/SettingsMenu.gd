extends MarginContainer

@export var close_settings_btn: Button

func _ready():
	close_settings_btn.connect("pressed", _on_close_settings_btn_pressed)

func _on_close_settings_btn_pressed():
	visible = false
