extends Button

@onready var card_inv = $"../../../MarginContainer/VBoxContainer/InventoryContainer/CardInv"

@export var card_scene: PackedScene

func _on_pressed():
	var card_instance = card_scene.instantiate()
	card_instance.get_child(0).scale = Vector2(0.7, 0.7)
	card_inv.add_child(card_instance)
