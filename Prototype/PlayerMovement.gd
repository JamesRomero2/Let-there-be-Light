extends KinematicBody2D

signal update_health(health)
signal killed()
signal update_battery(health)
signal empty_battery()
signal flash_light()

const ACCELERATION : float = 100.00
const MAX_SPEED : float = 200.00
const GRAVITY : float = 20.00
const JUMP_HEIGHT : float = -400.00
const INITIAL_HEALTH : float = 3.0
const INITIAL_BATTERY : int = 3

onready var health : float = INITIAL_HEALTH setget _set_health
onready var battery : float = INITIAL_BATTERY setget _set_battery

var velocity : Vector2 = Vector2.ZERO
var toggle : bool = false

func _physics_process(_delta):
	var input_movement : Vector2 = Vector2.ZERO

	if Input.get_action_strength("right"):
		velocity.x = min(input_movement.x + ACCELERATION, MAX_SPEED)
	elif Input.get_action_strength("left"):
		velocity.x = max(input_movement.x - ACCELERATION, -MAX_SPEED)
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)

	velocity.y += GRAVITY

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_HEIGHT

	if Input.is_action_just_pressed("light"):
		light_level()

	velocity = move_and_slide(velocity, Vector2.UP)

func damage_player():
	_set_health(health - 1)
	print(health)
	if health == 0:
		return
	velocity.y = JUMP_HEIGHT

func light_level():
	_set_battery(battery - 1)
	print(battery)
	if battery == 0:
		return
	
	emit_signal("flash_light")

func kill():
	print("Game Over")

func no_light():
	print("No Battery Left")

func _set_health(value): 
	var prev_health = health
	health = clamp(value, 0, INITIAL_HEALTH)
	if health != prev_health:
		emit_signal("update_health", health)
		if health == 0:
			kill()
			emit_signal("killed")

func _on_Spiky_Platform_body_entered(_body):
	damage_player()

func _set_battery(value):
	var prev_battery = battery
	battery = clamp(value, 0, INITIAL_BATTERY)
	if battery != prev_battery:
		emit_signal("update_battery", battery)
		if battery == 0:
			no_light()
			emit_signal("empty_battery")
