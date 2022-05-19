extends Node2D

onready var anim_player_light = $AnimationPlayer

func _ready() -> void:
	emit_light()

func emit_light() -> void:
	anim_player_light.play("LightAnimation")

func _on_Player_flash_light():
	emit_light()
