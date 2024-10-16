@tool
extends StaticBody2D

@onready var door_sprite = $Sprite2D
@onready var door_collision = $CollisionShape2D

@export_enum("Wall", "Door Open", "Door Locked", "Door Shut", "Wall Bombed") var door_state: int:
	set(value):
		door_state = value
		if door_sprite:
			door_sprite.frame = door_state
		update_collision_state()

func _ready() -> void:
	door_sprite.frame = door_state
	update_collision_state()

func update_collision_state() -> void:
	if door_collision:
		# Disable the collision shape when the door is "Door Open" or "Wall Bombed"
		door_collision.disabled = (door_state == 1 or door_state == 4)
