extends Area2D



export(float) var max_length;
export(float) var time_to_fly;
var timer : float = 0.0;
onready var line : Line2D = $Line2D;


func _process(delta):
	print("ahhh");
	timer += delta;
	position = -lerp(Vector2.ZERO, Vector2(0,max_length), timer/time_to_fly);
	if (timer >= time_to_fly):
		get_parent().remove_child(self)
		


	
#Here we initialize the variables in the object
func _exit_tree():
	timer = 0;
	position = Vector2.ZERO;
	




	
	