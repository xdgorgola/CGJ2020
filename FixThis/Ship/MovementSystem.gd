extends Node2D;

var isActive : bool = false;
export var acceleration : float = 10.0;
export var rotationSpeed : float = 1.0;
export var maxSpeed : float = 200.0;
export var minSpeed : float = 10.0;
export var friction : float = 10.0;
var speed : float = 0.0;
var velocity : Vector2 = Vector2.ZERO;
var direction : Vector2 = Vector2.RIGHT;
var orientation : float = 0;

func _ready():
	get_parent().rotation = orientation;
	direction = Vector2.RIGHT * cos(orientation) + Vector2.UP * sin(orientation);
	get_node("../GameManager").connect("started_game", self, "activate_movement");
	
func _process(delta):
	if (!isActive):
		return;
	rotation_input(delta);
	move_input(delta);
	get_parent().rotation = orientation;
	direction = Vector2.RIGHT * cos(orientation) + Vector2.UP * sin(orientation);
	velocity = get_parent().transform.x * speed;
	var colission = get_parent().move_and_collide(velocity);
	
func activate_movement():
	isActive = true;
	
func rotation_input(delta):
	if (Input.is_action_pressed("rotate_right")):
		orientation = orientation - rotationSpeed * delta;
	elif (Input.is_action_pressed("rotate_left")):
		orientation = orientation + rotationSpeed * delta;
		
func move_input(delta):
	if (Input.is_action_pressed("accelerate")):
		speed = speed + acceleration * delta;
		speed = min(speed, maxSpeed);
	elif (Input.is_action_pressed("deccelerate")):
		speed = speed - acceleration * delta;
		speed = max(speed, minSpeed);
	elif (!Input.is_action_pressed("accelerate") and !Input.is_action_pressed("deccelerate")):
		speed = speed - friction * delta;
		speed = max(speed, minSpeed);
