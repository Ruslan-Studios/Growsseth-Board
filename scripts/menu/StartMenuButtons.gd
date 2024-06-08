extends MarginContainer

# Pulsanti
@export var play: Button
@export var settings: Button
@export var rules: Button
@export var credits: Button
@export var exit: Button

@export var playScene: PackedScene
@onready var settings_menu = $"../SettingsMenu"

func _on_play_pressed():
	get_tree().change_scene_to_packed(playScene)

func _on_settings_pressed():
	settings_menu.visible = true

func _on_exit_pressed():
	get_tree().quit()

func _on_back_btn_pressed():
	pass # Replace with function body.
