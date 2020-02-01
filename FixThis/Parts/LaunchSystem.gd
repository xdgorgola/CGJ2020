extends Node2D

export var direction : Vector2 = Vector2.RIGHT;
var speed : float = 10;

func _ready():
	get_parent().linear_velocity = direction * speed * 10;

func spawn_part(position, newDir, newSpeed):
	speed = newSpeed;
	launch_part(newDir);
	get_parent().global_position = position;
	
func launch_part(newDir):
	direction = newDir;
	get_parent().linear_velocity = direction * speed;
	
