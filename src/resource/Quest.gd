class_name Quest
extends Node3D

@export var world: GameWorld

@export var car1: VehicleBody3D
@export var car2: VehicleBody3D

@export var spawn1: Marker3D
@export var spawn2: Marker3D

var parked_in_goal1 := false
var parked_in_goal2 := false

func _ready() -> void:
	if get_parent().world:
		world = get_parent().world

func _process(_delta: float) -> void:
	if not _car_stopped(car1) or not _car_stopped(car2):
		return
	if parked_in_goal1 and parked_in_goal2:
		world.completeLevel()

func _on_goal_entered(body: Node3D) -> void:
	if body is Car1:
		parked_in_goal1 = true
	elif body is Car2:
		parked_in_goal2 = true

func _on_goal_exited(body: Node3D) -> void:
	if body is Car1:
		parked_in_goal1 = false
	elif body is Car2:
		parked_in_goal2 = false

func _car_stopped(car: VehicleBody3D) -> bool:
	return car.linear_velocity.length() < 0.5

func init() -> void:
	car1.global_position = spawn1.global_position
