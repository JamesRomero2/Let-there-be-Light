extends Area2D

onready var health_animation = $AnimationPlayer

func _ready():
	health_animation.play("Float")

func _on_body_entered(body):
	if body.name == "Player":
		hide()
		queue_free()

