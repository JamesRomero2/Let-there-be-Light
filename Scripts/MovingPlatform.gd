tool 
extends Node2D

export var duration : float = 1
export var move_from: Vector2 = Vector2.ZERO
export var move_to: Vector2 = Vector2.ZERO

onready var line : Node2D = $DebugLine
onready var base : Node2D = $PlatformBase
onready var tween : Tween = $PlatformBase/Tween
onready var animationPlatform = $PlatformBase/Sprite/AnimationPlayer

var direction_forward : bool = false

func _ready() -> void :
	animationPlatform.play("FadeIn")
	if ! Engine.is_editor_hint():
		set_tween(move_from, move_to)

func _physics_process(_delta) -> void:
	if Engine.is_editor_hint():
		update()

func _draw():
	if Engine.is_editor_hint():
		if line:
			draw_line(line.position + move_from, line.position + move_to, Color.blue, 2) 

func set_tween(from, to) -> void :
	tween.interpolate_property(base, "position", from, to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_completed(_object, _key):
	if direction_forward: 
		set_tween(move_from, move_to)
	else:
		set_tween(move_to, move_from)

	direction_forward = ! direction_forward
