@tool
extends Node2D

func _on_player_detector_body_entered(body: Node2D) -> void:
	Events.room_entered.emit(self)

@onready var door_up = $DoorUp
@onready var door_down = $DoorDown
@onready var door_left = $DoorLeft
@onready var door_right = $DoorRight

@export_enum("Wall", "Door Open", "Door Locked", "Door Shut", "Wall Bombed") var door_up_state: int:
	set(value):
		door_up_state = value
		if door_up:
			door_up.door_state = value

@export_enum("Wall", "Door Open", "Door Locked", "Door Shut", "Wall Bombed") var door_down_state: int:
	set(value):
		door_down_state = value
		if door_down:
			door_down.door_state = value

@export_enum("Wall", "Door Open", "Door Locked", "Door Shut", "Wall Bombed") var door_left_state: int:
	set(value):
		door_left_state = value
		if door_left:
			door_left.door_state = value

@export_enum("Wall", "Door Open", "Door Locked", "Door Shut", "Wall Bombed") var door_right_state: int:
	set(value):
		door_right_state = value
		if door_right:
			door_right.door_state = value

func _ready() -> void:
	# Initialize each door's state
	if door_up:
		door_up.door_state = door_up_state
	if door_down:
		door_down.door_state = door_down_state
	if door_left:
		door_left.door_state = door_left_state
	if door_right:
		door_right.door_state = door_right_state
