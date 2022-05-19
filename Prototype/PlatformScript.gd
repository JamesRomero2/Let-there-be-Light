extends StaticBody2D

onready var timer = get_node("Timer")

func _on_Player_flash_light():
	get_node("PlatformSprite").visible = true
	timer.set_wait_time(2)
	timer.start()

func _on_Timer_timeout():
	get_node("PlatformSprite").visible = false
