extends Control

var health : int
var battery : int

onready var healthUI = $Heart
onready var batteryUI = $Battery

func _ready()-> void :
	healthUI.rect_size.x = health * 32
	batteryUI.rect_size.x = battery * 32

#LISTEN TO SIGNAL IF THE PLAYER TAKE DAMAGE UPDATE UI
func _on_Player_update_player_health(INITIAL_HEALTH):
	health = clamp(INITIAL_HEALTH, -1, 4)
	if healthUI != null:
		healthUI.rect_size.x = health * 32
		
func _on_Player_update_flash_light_battery(INITIAL_BATTERY):
	battery = clamp(INITIAL_BATTERY, -1, 4)
	if batteryUI != null:
		batteryUI.rect_size.x = battery * 32



