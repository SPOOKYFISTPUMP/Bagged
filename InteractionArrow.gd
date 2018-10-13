extends Node2D

signal player_sighted(entered)

export(bool) var player_in_sight = false

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		$AnimationPlayer.play("Show")
		player_in_sight = true
		emit_signal("player_sighted", player_in_sight)

func _on_Area2D_area_exited(area):
	if area.get_parent().is_in_group("Player"):
		$AnimationPlayer.play("RESET")
		player_in_sight = false
		emit_signal("player_sighted", player_in_sight)
