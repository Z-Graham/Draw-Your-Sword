extends CharacterBody2D


@export var speed := 150

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		
	
	
	move_and_slide()
