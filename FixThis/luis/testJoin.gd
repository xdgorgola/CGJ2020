extends KinematicBody2D

export(float) var speed = 200;
export(NodePath) var spring_joint;

var input : Vector2 = Vector2.ZERO;

func _process(delta):
	if (Input.is_action_pressed("ui_right")):
		input.x = 1;
	elif (Input.is_action_pressed("ui_left")):
		input.x = -1;
	else:
		input.x = 0;
		
	if (Input.is_action_pressed("ui_up")):
		input.y = -1;
	elif (Input.is_action_pressed("ui_down")):
		input.y = 1;
	else:
		input.y = 0;
		
	if( Input.is_action_just_pressed("ui_accept") ):
		spring_joint
		
func _physics_process(delta):
	move_and_slide(input.normalized()*speed);