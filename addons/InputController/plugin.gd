tool
extends EditorPlugin

func _init():
	print("InputController2D Iniciado")

func _enter_tree():
	add_custom_type("InputController2D", "Node", preload("input_controller_2d.gd"), preload("icon.png"))

func _exit_tree():
	remove_custom_type("MyButton")
