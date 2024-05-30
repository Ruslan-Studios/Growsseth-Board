extends Button

@onready var card_inv = $"../../../MarginContainer/VBoxContainer/InventoryContainer/CardInv"
@onready var matchUI = $"../../.."
@export var card_scene: PackedScene

func _on_pressed():
	var card_instance = card_scene.instantiate()
	print("Size: ", card_instance.size )
	print("Size2: ", card_instance.get_child(0).size )
	card_instance.get_child(0).size = card_instance.size
	# Ensure the card_instance has at least one child
	if card_instance.get_child_count() > 0:
		var child = card_instance.get_child(0)
		child.position = Vector2(0, 0)
	else:
		print("No children found in card_instance")
	
	matchUI.add_child(card_instance)
	card_instance.position = Vector2(card_inv.position.x, card_inv.position.y + 550)
