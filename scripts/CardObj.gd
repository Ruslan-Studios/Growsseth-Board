extends Button
class_name CardObj

@export var angle_x_max: float = 15.0
@export var angle_y_max: float = 15.0
@export var max_offset_shadow: float = 50.0

@export_category("Oscillator")
@export var spring: float = 140.0
@export var damp: float = 20.0
@export var velocity_multiplier: float = 2.0
@export var displacementMultiplier: float = 0.15

var displacement: float = 0.0 
var oscillator_velocity: float = 0.0

var tween_rot: Tween
var tween_hover: Tween
var tween_destroy: Tween
var tween_handle: Tween

var last_mouse_pos: Vector2
var mouse_velocity: Vector2
var following_mouse: bool = false
var last_pos: Vector2
var velocity: Vector2

@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
@onready var layout_texture: TextureRect = $SubViewportContainer/SubViewport/Layout
@onready var artwork_texture: TextureRect = $SubViewportContainer/SubViewport/Layout/Artwork
# @onready var shadow: TextureRect = $SubViewportContainer/SubViewport/Layout/Ombra
# @onready var collision_shape = $DestroyArea/CollisionShape2D

func _ready() -> void:
	# Convert to radians because lerp_angle is using that
	angle_x_max = deg_to_rad(angle_x_max)
	angle_y_max = deg_to_rad(angle_y_max)
	
	self.scale = Vector2(0.5, 0.5)
	# collision_shape.set_deferred("disabled", true)

func _process(delta: float) -> void:
	rotate_velocity(delta)
	follow_mouse(delta)
	# handle_shadow(delta)

func rotate_velocity(delta: float) -> void:
	if not following_mouse: return
	var center_pos: Vector2 = global_position - (size/2.0)
	print("Pos: ", center_pos)
	#print("Pos: ", last_pos)
	# Compute the velocity
	velocity = (position - last_pos) / delta
	last_pos = position
	
	#print("Velocity: ", velocity)
	oscillator_velocity += velocity.normalized().x * velocity_multiplier
	
	# Oscillator stuff
	var force = -spring * displacement - damp * oscillator_velocity
	oscillator_velocity += force * delta
	displacement += oscillator_velocity * delta
	
	rotation = displacement * displacementMultiplier

#func handle_shadow(delta: float) -> void:
	## Y position is never changed.
	## Only x changes depending on how far we are from the center of the screen
	#var center: Vector2 = get_viewport_rect().size / 2.0
	#var distance: float = global_position.x - center.x
	#
	#shadow.position.x = lerp(0.0, -sign(distance) * max_offset_shadow, abs(distance/(center.x)))

func follow_mouse(delta: float) -> void:
	
	if not following_mouse: return
	
	var mouse_pos: Vector2 = get_global_mouse_position()
	global_position = lerp(position, (mouse_pos - (size/2.5)), 0.1)

func handle_mouse_click(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	
	if event.is_pressed():
		following_mouse = true
	else:
		# drop card
		following_mouse = false
		#collision_shape.set_deferred("disabled", false)
		if tween_handle and tween_handle.is_running():
			tween_handle.kill()
		tween_handle = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween_handle.tween_property(self, "rotation", 0.0, 0.3)

func _on_gui_input(event: InputEvent) -> void:
	
	handle_mouse_click(event)
	
	# Don't compute rotation when moving the card
	if following_mouse: return
	if not event is InputEventMouseMotion: return
	
	# Handles rotation
	# Get local mouse pos
	var mouse_pos: Vector2 = get_local_mouse_position()
	#print("Mouse: ", mouse_pos)
	#print("Card: ", position + size)
	var diff: Vector2 = (position + size) - mouse_pos

	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)
	#print("Lerp val x: ", lerp_val_x)
	#print("lerp val y: ", lerp_val_y)

	# Handle card rotation on hover 
	var rot_x: float = -rad_to_deg(lerp_angle(-angle_x_max, angle_x_max, lerp_val_x))
	var rot_y: float = -rad_to_deg(lerp_angle(angle_y_max, -angle_y_max, lerp_val_y))
	#print("Rot x: ", rot_x)
	#print("Rot y: ", rot_y)
	
	sub_viewport_container.material.set_shader_parameter("x_rot", rot_y)
	sub_viewport_container.material.set_shader_parameter("y_rot", rot_x)

func _on_mouse_entered() -> void:
	
	if following_mouse: return
	
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(.5, .5), 0.5)

func _on_mouse_exited() -> void:
	
	if following_mouse: return
	
	# Reset rotation
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(sub_viewport_container.material, "shader_parameter/x_rot", 0.0, 0.5)
	tween_rot.tween_property(sub_viewport_container.material, "shader_parameter/y_rot", 0.0, 0.5)
	
	# Reset scale
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(.5, .5), 0.5)
