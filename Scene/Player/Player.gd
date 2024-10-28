extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -280.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
var health = 100
var is_dead = false  # Флаг для проверки состояния игрока

func _physics_process(delta):
	if is_dead:
		return  # Если игрок мертв, не выполнять обычную логику

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")

	if direction == -1:
		$AnimatedSprite2D.flip_h = true

	elif direction == 1:
		$AnimatedSprite2D.flip_h = false

	if velocity.y > 0:
		anim.play("Fall")

	if health <= 0 and not is_dead:
		die()

	move_and_slide()

func die() -> void:
	is_dead = true  # Устанавливаем флаг состояния игрока
	anim.play("Death")  # Воспроизводим анимацию смерти
	anim.connect("animation_finished", Callable(self, "_on_death_animation_finished"))  # Подключаемся к сигналу завершения анимации
	# Создаем таймер на случай, если сигнал не сработает
	var death_timer = Timer.new()
	death_timer.one_shot = true
	death_timer.wait_time = 1.0  # Продолжительность анимации смерти
	death_timer.connect("timeout", Callable(self, "_on_death_animation_finished"))
	add_child(death_timer)
	death_timer.start()

func _on_death_animation_finished():
	# Перезагружаем сцену на меню
	get_tree().change_scene_to_file("res://Scene/Level/level_2.tscn")
