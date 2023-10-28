class_name NodeLog extends Node

static var init_count: int = 0
static var static_member: int = 42

var self_init_number: int = 0

var process_count: int = 0
var physics_process_count: int = 0
var draw_count: int = 0

var member: int = 42
var property_member: int = 42:
	get:
		print(name, ": property_member: get")
		return property_member
	set(value):
		print(name, ": property_member: set(", value, ")")
		property_member = value
@export var export_member: int = 42:
	get:
		print(name, ": export_member: get")
		return export_member
	set(value):
		print(name, ": export_member: set(", value, ")")
		export_member = value

func _init() -> void:
	init_count += 1
	self_init_number = init_count
	print("_init() #", self_init_number, " (member: ", member, " export_member: ", export_member, ")")

static func _static_init() -> void:
	print("NodeLog: _static_init() (static_member: ", static_member, ")")

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
		NOTIFICATION_NODE_RECACHE_REQUESTED:
			print(name, ": _notification(NOTIFICATION_NODE_RECACHE_REQUESTED)")
		NOTIFICATION_WM_CLOSE_REQUEST:
			print(name, ": _notification(NOTIFICATION_WM_CLOSE_REQUEST)")
		Node2D.NOTIFICATION_DRAW:
			print(name, ": _notification(NOTIFICATION_DRAW)")
		Node2D.NOTIFICATION_ENTER_CANVAS:
			print(name, ": _notification(NOTIFICATION_ENTER_CANVAS)")
		Node2D.NOTIFICATION_VISIBILITY_CHANGED:
			print(name, ": _notification(NOTIFICATION_VISIBILITY_CHANGED)")
		Node3D.NOTIFICATION_ENTER_WORLD:
			print(name, ": _notification(NOTIFICATION_ENTER_WORLD (Node3D) or NOTIFICATION_MOUSE_ENTER (Control))")
		2000:
			print(name, ": _notification(NOTIFICATION_TRANSFORM_CHANGED)")
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
	print(name, ": _enter_tree() init_number: ", self_init_number)

func _exit_tree() -> void:
	print(name, ": _exit_tree()")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(name, ": _ready()")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if process_count < 3:
		process_count += 1
		print(name, ": _process()")

func _physics_process(_delta: float) -> void:
	if physics_process_count < 3:
		physics_process_count += 1
		print(name, ": _physics_process()")

func _draw() -> void:
	if draw_count < 3:
		draw_count += 1
		print(name, ": _draw()")
