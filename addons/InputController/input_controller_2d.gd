tool
class_name InputController2D, "res://addons/InputController/icon.png" extends Node

onready var parent = get_parent() as KinematicBody2D
export(NodePath) onready var texture = get_node(texture) as Sprite

export var action_left = "ui_left"
export var action_right = "ui_right"
export var action_jump = ""

export(float) var ACCELERATION = 50.0
export(float) var FRICTION = 0.5
export(float) var MAX_SPEED = 100.0

export(int) var JUMP_FORCE = 0
export(int) var GRAVITY = 0
export(int) var ADDICIONAL_FALL_GRAVITY = 0

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO
var look_direction = Vector2.ZERO
var move_direction = Vector2.ZERO


func _physics_process(_delta):
	if Engine.is_editor_hint():
		return
		
	move()
	jump()
		
	
		
func move() -> void:
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


func jump() -> void:
	apply_gravity()
	
	if parent.is_on_floor():
		if Input.is_action_pressed(action_jump):
			velocity.y = JUMP_FORCE
	else:
		apply_addicional_fall_gravity()
		
		
func apply_friction() -> void:
	velocity.x = move_toward(velocity.x, 0, FRICTION)


func apply_acceleration(amount:int) -> void:
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)


func apply_gravity() -> void:
	velocity.y += GRAVITY
	
	
func apply_addicional_fall_gravity() -> void:
	if velocity.y > 0:
		velocity.y += ADDICIONAL_FALL_GRAVITY


func flip() -> void:
	if velocity.x < 0:
		texture.flip_h = true
	if velocity.x > 0:
		texture.flip_h = false
