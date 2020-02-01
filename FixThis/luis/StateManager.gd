extends Node2D



export(NodePath) var hook_path;
export(NodePath) var catcher_path;

enum states {catching, aiming}

var state : int;
onready var hook = get_node(hook_path);
onready var catcher = get_node(catcher_path);


func _ready():
	hook.node_b = get_parent().get_path();
	remove_child(catcher);
	state = states.aiming
	
func _process(delta):
	if(Input.is_action_just_pressed("ui_accept") ):
		if(state == states.catching):
			state_aim();
		elif(state == states.aiming):
			try_to_catch();
	
		
	

func state_catch(obj : RigidBody2D) -> void:
	get_parent().add_child(hook);
	hook.node_b =  obj.get_path();
	state = states.catching;
	get_parent().remove_child(catcher);
	
	pass

func state_aim() -> void:
	state = states.aiming;
	hook.node_b = get_parent().get_path();
	pass
	

func try_to_catch() -> void:
	print(catcher)
	get_parent().add_child(catcher);
	pass
	



func _on_catcher_body_entered(body):
	pass # Replace with function body.
