extends Node2D

export var isActive : bool = false;
export var initialX : float = 0.0;
export var finalX : float = 1000.0;
var progress : float = 0.0;
export var progSpeed : float = 10.0;

func _ready():
	stop_progress();
	get_parent().connect("lostpart", self, "update_speed");
	get_parent().connect("bigOof", self, "stop_progress")
	get_node("../GameManager").connect("started_game", self, "start_progress");
func _process(delta):
	if (!isActive):
		return;
	progress_ship(delta);
	get_parent().emit_signal("progressed", progress);

func stop_progress():
	isActive = false;

func start_progress():
	isActive = true;
	
func update_speed(remaining):
	progSpeed = remaining;

func progress_ship(delta):
	progress = abs(finalX - global_position.x + progSpeed * delta);
	if (progress <= 0):
		get_parent().emit_signal("reached_goal");
	get_parent().global_position += Vector2.RIGHT * progSpeed * delta;

