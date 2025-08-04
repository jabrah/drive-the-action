class_name GameWorld
extends Node

var init_pos1: Vector3
var init_angle: Vector3

var init_pos2: Vector3
var init_angle2: Vector3

@onready var car1: VehicleBody3D = %car1
@onready var car2: VehicleBody3D = %car2

@onready var ui_success_modal := %SuccessModal

func _ready() -> void:
	init_pos1 = car1.global_position
	init_angle = car1.global_rotation
	init_pos2 = car2.global_position
	init_angle2 = car2.global_rotation
	
	EventBus.subscribe("ok_btn_pressed", _on_level_ok)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		_restart()

func _restart() -> void:
	car1.linear_velocity = Vector3.ZERO
	car1.angular_velocity = Vector3.ZERO
	car2.linear_velocity = Vector3.ZERO
	car2.angular_velocity = Vector3.ZERO

	car2.global_position = init_pos2
	car2.global_rotation = init_angle2
	car1.global_position = init_pos1
	car1.global_rotation = init_angle


## Levels / Quests will call this to be completed
# Use this instead of signals to guarantee sequence of events
func completeLevel() -> void:
	# Pause physics for the cars
	# Show UI modal
	ui_success_modal.visible = true

func failLevel() -> void:
	pass

func _on_level_ok(data: Dictionary) -> void:
	print("Game OK: ", data.name)
	ui_success_modal.visible = false
