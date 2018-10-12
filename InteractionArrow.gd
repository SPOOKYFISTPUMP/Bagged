extends Node2D

export(bool) var player_in_sight = false

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		$AnimationPlayer.play("Show")
		player_in_sight = true

func _on_Area2D_area_exited(area):
	if area.get_parent().is_in_group("Player"):
		$AnimationPlayer.play("RESET")
		player_in_sight = false
