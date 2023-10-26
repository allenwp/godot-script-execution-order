class_name NodeLog extends Node

static var init_count: int = 0
var self_init_number: int = 0
var process_count: int = 0
var physics_process_count: int = 0

func _init() -> void:
	init_count += 1
	self_init_number = init_count
	print("_init() #", self_init_number)

static func _static_init() -> void:
	print("NodeLog: _static_init()")

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_READY:
			print(name, ": _notification(NOTIFICATION_READY)")
		NOTIFICATION_ENTER_TREE:
			print(name, ": _notification(NOTIFICATION_ENTER_TREE)")
		NOTIFICATION_EXIT_TREE:
			print(name, ": _notification(NOTIFICATION_EXIT_TREE)")
		NOTIFICATION_POSTINITIALIZE:
			print(name, ": _notification(NOTIFICATION_POSTINITIALIZE)")
		NOTIFICATION_INTERNAL_PHYSICS_PROCESS:
			print(name, ": _notification(NOTIFICATION_INTERNAL_PHYSICS_PROCESS)")
		NOTIFICATION_INTERNAL_PROCESS:
			print(name, ": _notification(NOTIFICATION_INTERNAL_PROCESS)")
		NOTIFICATION_PROCESS:
			if process_count < 5:
				print(name, ": _notification(NOTIFICATION_PROCESS)")
		NOTIFICATION_PHYSICS_PROCESS:
			if physics_process_count < 5:
				print(name, ": _notification(NOTIFICATION_PHYSICS_PROCESS)")
		NOTIFICATION_PARENTED:
			print(name, ": _notification(NOTIFICATION_PARENTED)")
		NOTIFICATION_CHILD_ORDER_CHANGED:
			print(name, ": _notification(NOTIFICATION_CHILD_ORDER_CHANGED)")
		NOTIFICATION_SCENE_INSTANTIATED:
			print(name, ": _notification(NOTIFICATION_SCENE_INSTANTIATED)")
		NOTIFICATION_POST_ENTER_TREE:
			print(name, ": _notification(NOTIFICATION_POST_ENTER_TREE)")
		NOTIFICATION_APPLICATION_FOCUS_IN:
			print(name, ": _notification(NOTIFICATION_APPLICATION_FOCUS_IN)")
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			print(name, ": _notification(NOTIFICATION_APPLICATION_FOCUS_OUT)")
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			print(name, ": _notification(NOTIFICATION_WM_WINDOW_FOCUS_IN)")
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			print(name, ": _notification(NOTIFICATION_WM_WINDOW_FOCUS_OUT)")
		NOTIFICATION_WM_MOUSE_ENTER:
			print(name, ": _notification(NOTIFICATION_WM_MOUSE_ENTER)")
		NOTIFICATION_WM_MOUSE_EXIT:
			print(name, ": _notification(NOTIFICATION_WM_MOUSE_EXIT)")
		41:
			print(name, ": _notification(NOTIFICATION_ENTER_WORLD (Node3D) or NOTIFICATION_MOUSE_ENTER (Control))")
		_:
			print(name, ": _notification(", what, ")")

func _input(event: InputEvent) -> void:
	print(name, ": _input(", event.as_text(), ")")

func _shortcut_input(event: InputEvent) -> void:
	print(name, ": _shortcut_input(", event.as_text(), ")")

func _unhandled_input(event: InputEvent) -> void:
	print(name, ": _unhandled_input(", event.as_text(), ")")

func _unhandled_key_input(event: InputEvent) -> void:
	print(name, ": _unhandled_key_input(", event.as_text(), ")")

func _enter_tree() -> void:
	print(name, ": _enter_tree()")

func _exit_tree() -> void:
	print(name, ": _exit_tree()")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(name, ": _ready() init_number: ", self_init_number)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	process_count += 1
	if process_count < 5:
		print(name, " (init_number ", self_init_number, "): _process()")

func _physics_process(delta: float) -> void:
	physics_process_count += 1
	if physics_process_count < 5:
		print(name, " (init_number ", self_init_number, "): _physics_process()")
