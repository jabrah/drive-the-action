extends Node3D

@export var world: GameWorld

@export var car1: VehicleBody3D
@export var car2: VehicleBody3D

@onready var quest: Quest = $Quest

var parked_in_goal1 := false
var parked_in_goal2 := false

var completed := false

func _ready() -> void:
	var parent = get_parent()
	if not world:
		world = parent
	if not car1:
		car1 = parent.car1
	if not car2:
		car2 = parent.car2
	
	quest.world = world
	quest.car1 = car1
	quest.car2 = car2

func _process(_delta: float) -> void:
	if not _car_stopped(car1) or not _car_stopped(car2):
		return
	if not completed and parked_in_goal1 and parked_in_goal2:
		world.completeLevel()
		completed = true

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
