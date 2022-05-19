extends KinematicBody2D

# Signals
signal flash_light()
signal update_flash_light_battery(INITIAL_BATTERY)
signal empty_flash_light_battery()
signal damage_player()
signal update_player_health(INITIAL_HEALTH)
signal empty_player_health()

# Variables
const ACCELERATION : float = 100.00
const MAX_SPEED : float = 150.00
const GRAVITY : float = 20.00
const JUMP_HEIGHT : float = -450.00
const INITIAL_HEALTH : int = 4
const INITIAL_BATTERY : int = 4

var velocity : Vector2 = Vector2.ZERO
var player_initial_position : Vector2

onready var health : int = INITIAL_HEALTH setget set_health
onready var battery : int = INITIAL_BATTERY setget set_battery

# System Defined Methods
func _ready() -> void:
	player_initial_position = position
	emit_signal("update_player_health", health)
	emit_signal("update_flash_light_battery", battery)

func _physics_process(_delta) -> void:
	# Player Input Movement
	var input_movement : Vector2 = Vector2.ZERO

	if Input.get_action_strength("right"):
		velocity.x = min(input_movement.x + ACCELERATION, MAX_SPEED)
	elif Input.get_action_strength("left"):
		velocity.x = max(input_movement.x - ACCELERATION, -MAX_SPEED)
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)

	velocity.y = min(velocity.y + GameManager.gravity, GameManager.terminal_velocity)

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_HEIGHT

	if Input.is_action_just_pressed("light"):
		light_level()

	velocity = move_and_slide(velocity, Vector2.UP)
	self.position.x = clamp(position.x, 5, 473)

# User Defined Methods

# PLAYER DEATH
func _on_player_fall_death(_body) -> void:
	player_damage()

func player_reset_position() -> void:
	self.position = player_initial_position
	velocity = Vector2.ZERO
	
# FLASHLIGHT
func light_level() -> void:
	set_battery(battery - 1)
	print("Battery", battery)
	if battery < 0:
		return
	emit_signal("flash_light")
	
func set_battery(value) -> void:
	var previous_battery = battery
	battery = clamp(value, -1, INITIAL_BATTERY)
	if battery != previous_battery:
		emit_signal("update_flash_light_battery", battery)
		if battery < 0:
			empty_flash_light_battery()
			emit_signal("empty_flash_light_battery")

func empty_flash_light_battery() -> void:
	print("No Battery Left")

# HEALTH
func player_damage() -> void:
	set_health(health - 1)
	print("Health", health)
	if health < 0:
		return
	emit_signal("damage_player")
	player_reset_position()

func set_health(value) -> void:
	var previous_health = health
	health = clamp(value, -1, INITIAL_HEALTH)
	if health != previous_health:
		emit_signal("update_player_health", health)
		if health < 0:
			empty_player_health()
			emit_signal("empty_player_health")

func empty_player_health() -> void:
	print("No Health Left")
