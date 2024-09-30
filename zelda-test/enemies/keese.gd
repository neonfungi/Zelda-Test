extends CharacterBody2D

@onready var stats = $Stats
@onready var timer = $Timer
@onready var health_label = $HealthLabel

const EnemyDeathEffect = preload("res://Effects/enemy_death_effect.tscn")

func _ready() -> void:
	update_health_label()

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
	move_and_slide()
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	velocity = area.knockback_vector * 100
	stats.health -= area.damage
	update_health_label()

func _on_stats_no_health() -> void:
	timer.start()
	await timer.timeout
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func update_health_label() -> void:
	health_label.text = "Health: %s" % stats.health
