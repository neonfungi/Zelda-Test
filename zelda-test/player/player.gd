extends CharacterBody2D

# Movement variables
@export var speed: float = 100.0

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var direction: Vector2 = Vector2.ZERO

# AnimatedSprite2D reference
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()

func move_state() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction = direction.normalized() # Normalize direction for diagonal movement
	velocity = direction * speed
	move_and_slide()

	if direction != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", direction)
		animationTree.set("parameters/Walk/blend_position", direction)
		animationTree.set("parameters/Attack/blend_position", direction)
		animationState.travel("Walk")
	else:
		animationState.travel("Idle")
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state() -> void:
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE
