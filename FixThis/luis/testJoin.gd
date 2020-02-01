extends KinematicBody2D

export(float) var speed = 200;
export(NodePath) var spring_joint;

var input : Vector2 = Vector2.ZERO;
onready var hook : DampedSpringJoint2D = $hook;
onready var catcher : Area2D = $catcher
onready var line : Line2D = $Line2D;

enum states {catching, aiming}
var state;

func _ready():
	state = states.aiming;
	remove_child(hook);
	

func _process(delta):
	#catch input:
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
		
	
	#Throw the catcher
	if (Input.is_action_just_pressed("ui_accept")):
		
		if(state == states.aiming):
			catch();
		elif(state == states.catching):
			print("apunto")
			aim_state();
			
		
			
	if(line != null):
		
		line.points = [Vector2.ZERO,catcher.position];
		
func _physics_process(delta):
	move_and_slide(input.normalized()*speed);

#Change the state to catching, turn off the catcher and the line, 
# turns on the hook
func catch_state(obj : PhysicsBody2D) -> void:
	return;
	state = states.catching;
	add_child(hook);
	remove_child(catcher); #Prone to errors
	hook.node_a = get_path();
	hook.node_b = obj.get_path();
	
	print(hook.node_b);


#Change the current state to aiming, disable the hook
func aim_state() -> void:
	return
	state = states.aiming;
	add_child(catcher);
	remove_child(hook);
	
	
	
func catch() -> void:
	return
	add_child(catcher)
	pass
func _draw():
	var temp : Vector2;
	var hooked : Node2D = get_node(hook.node_b);
	
	print(hooked);
	
	if hooked == null:
		temp = Vector2.ZERO;
	else:
		temp = hook.position;
#	draw_line(Vector2.ZERO, get_node(hook.node_a).position, Color.white, 2,false);
	draw_circle(temp,6,Color.white);
	print("Postiion parent: ", position);
	print("Position hooked: ", hook.node_b);
	pass
	
	
	