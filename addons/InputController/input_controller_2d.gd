tool
class_name InputController2D, "res://addons/InputController/icon.png" extends Node

onready var parent = get_parent() as KinematicBody2D
export(NodePath) onready var texture = get_node(texture) as Sprite

export var action_left = "ui_left"
export var action_right = "ui_right"

export(float) var ACCELERATION = 50.0
export(float) var FRICTION = 0.5
export(float) var MAX_SPEED = 100.0

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO
var look_direction = Vector2.ZERO
var move_direction = Vector2.ZERO


func _physics_process(_delta):
	if Engine.is_editor_hint():
		return
		
	input_vector.x = Input.get_action_strength(action_right) - Input.get_action_strength(action_left)

	if input_vector.length() != 0:
		look_direction = input_vector.normalized()

	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)
	
	if get_parent() is KinematicBody2D:
		var parent = get_parent() as KinematicBody2D
		velocity = parent.move_and_slide(velocity)
	elif get_parent() is Node2D:
		var parent = get_parent() as Node2D
		parent.global_position += velocity
		
		
func apply_friction() -> void:
	parent.velocity.x = move_toward(parent.velocity.x, 0, FRICTION)


func apply_acceleration(amount:int) -> void:
	parent.velocity.x = move_toward(parent.velocity.x, MAX_SPEED * amount, ACCELERATION)


func flip() -> void:
	if parent.velocity.x < 0:
		texture.flip_h = true
	if parent.velocity.x > 0:
		texture.flip_h = false
