extends Node2D

@export var next_scene: String

func _ready() -> void:
	var go_to_next_scene_area = $GoToNextScene
	var door_open_animate_area = $DoorOpenAnimate

	# Проверяем и подключаем сигнал 'body_entered' для GoToNextScene
	if not go_to_next_scene_area.is_connected("body_entered", Callable(self, "_on_go_to_next_scene_body_entered")):
		go_to_next_scene_area.connect("body_entered", Callable(self, "_on_go_to_next_scene_body_entered"))
	
	# Проверяем и подключаем сигнал 'body_exited' для GoToNextScene
	if not go_to_next_scene_area.is_connected("body_exited", Callable(self, "_on_go_to_next_scene_body_exited")):
		go_to_next_scene_area.connect("body_exited", Callable(self, "_on_go_to_next_scene_body_exited"))
	
	# Проверяем и подключаем сигнал 'body_entered' для DoorOpenAnimate
	if not door_open_animate_area.is_connected("body_entered", Callable(self, "_on_door_open_animate_body_entered")):
		door_open_animate_area.connect("body_entered", Callable(self, "_on_door_open_animate_body_entered"))
	
	# Проверяем и подключаем сигнал 'body_exited' для DoorOpenAnimate
	if not door_open_animate_area.is_connected("body_exited", Callable(self, "_on_door_open_animate_body_exited")):
		door_open_animate_area.connect("body_exited", Callable(self, "_on_door_open_animate_body_exited"))

func _process(_delta: float) -> void:
	pass

func _on_go_to_next_scene_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		call_deferred("change_scene")

func _on_go_to_next_scene_body_exited(_body: Node2D) -> void:
	pass

func _on_door_open_animate_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$OpenDoor.show()

func _on_door_open_animate_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$OpenDoor.hide()

func change_scene() -> void:
	get_tree().change_scene_to_file(next_scene)
