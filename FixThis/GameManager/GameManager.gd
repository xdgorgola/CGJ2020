extends Node

export var timeToStart : int = 4;

signal lost_game;
signal started_game;
signal won_game;

var timer : Timer = Timer.new();

func _ready():
	add_child(timer);
	timer.connect("timeout", self, "start_game");
	timer.start(timeToStart);

func lost_action():
	emit_signal("lost_game");
	
func won():
	emit_signal("won_game");

func start_game():
	emit_signal("started_game");
