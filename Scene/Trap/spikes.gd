extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var area = $Area2D
	# Проверяем и подключаем сигнал 'body_entered'
	if not area.is_connected("body_entered", Callable(self, "_on_area_2d_body_entered")):
		area.connect("body_entered", Callable(self, "_on_area_2d_body_entered"))
	# Проверяем и подключаем сигнал 'body_exited'
	if not area.is_connected("body_exited", Callable(self, "_on_area_2d_body_exited")):
		area.connect("body_exited", Callable(self, "_on_area_2d_body_exited"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.health -= 100  # Уменьшаем здоровье игрока на 100
		if body.health <= 0:
			body.die()  # Вызываем функцию смерти у игрока

func _on_area_2d_body_exited(body):
	pass
