extends Node2D

var target_scene = "res://Levels/MainMenu.tscn"

func return_main_menu():
	var ERR = get_tree().change_scene(target_scene)

	if ERR != OK:
		print("Error")


func _on_AnimationPlayer_animation_finished(_anim_name):
	return_main_menu()
