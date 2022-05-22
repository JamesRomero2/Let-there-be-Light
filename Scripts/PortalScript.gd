extends Area2D

export(PackedScene) var target_scene

func _on_body_entered(body):
	if body.name == "Player":
		if !target_scene:
			return
		if get_overlapping_bodies().size() > 0:
			next_level()

func next_level():
	var ERR = get_tree().change_scene_to(target_scene)

	if ERR != OK:
		print("Error")
