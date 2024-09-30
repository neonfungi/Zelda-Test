extends CharacterBody2D

# Movement variables
@export var speed: float = 100.0

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var input_vector: Vector2 = Vector2.ZERO
var knockback_vector = Vector2.DOWN

# AnimatedSprite2D reference
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var swordHitbox = $HitboxPivot/SwordHitbox

func _ready() -> void:
	swordHitbox.knockback_vector = knockback_vector

func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()

func move_state() -> void:
	var input_vector = Vector2.ZERO
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_vector = input_vector.normalized() # Normalize direction for diagonal movement
	velocity = input_vector * speed
	move_and_slide()

	if input_vector != Vector2.ZERO:
		knockback_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
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
