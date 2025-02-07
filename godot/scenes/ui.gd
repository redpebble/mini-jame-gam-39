extends Control

func update_hp(hp, max_hp):
	$HealthBar.max_value = max_hp
	$HealthBar.value = hp

func update_points(points):
	$PointsLabel.text = str(points)

func game_over():
	$GameOverLabel.show()
