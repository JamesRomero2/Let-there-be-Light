extends TileMap

onready var animationPlatform = $AnimationPlayer

func _ready() -> void:
	animationPlatform.play("FadeInPlatform")


