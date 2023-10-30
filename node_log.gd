class_name NodeLog extends Node

const MAX_PROCESS_COUNT: int = 3

static var init_count: int = 0
static var static_member: int = 42
static var process_logging: bool = true
static var input_logging: bool = true

@export var is_input_toggle: bool = false
@export var is_instantiate_packed_scene: bool = false

signal sig

var self_init_number: int = 0

var process_count: int = 0
var physics_process_count: int = 0

var new_scene: Node = null

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
	if is_instance_of(self, Control):
		var matched := true
		match what:
			Control.NOTIFICATION_FOCUS_ENTER:
				print(name, ": _notification(Control.NOTIFICATION_FOCUS_ENTER)")
			Control.NOTIFICATION_MOUSE_ENTER:
				print(name, ": _notification(Control.NOTIFICATION_MOUSE_ENTER)")
			_:
				matched = false
		if matched:
			return

	if is_instance_of(self, CanvasItem):
		var matched := true
		match what:
			CanvasItem.NOTIFICATION_DRAW:
				print(name, ": _notification(CanvasItem.NOTIFICATION_DRAW)")
			CanvasItem.NOTIFICATION_ENTER_CANVAS:
				print(name, ": _notification(CanvasItem.NOTIFICATION_ENTER_CANVAS)")
			CanvasItem.NOTIFICATION_VISIBILITY_CHANGED:
				print(name, ": _notification(CanvasItem.NOTIFICATION_VISIBILITY_CHANGED)")
			CanvasItem.NOTIFICATION_TRANSFORM_CHANGED:
				print(name, ": _notification(CanvasItem.NOTIFICATION_TRANSFORM_CHANGED)")
			_:
				matched = false
		if matched:
			return

	if is_instance_of(self, Node3D):
		var matched := true
		match what:
			Node3D.NOTIFICATION_ENTER_WORLD:
				print(name, ": _notification(Node3D.NOTIFICATION_ENTER_WORLD)")
			Node3D.NOTIFICATION_TRANSFORM_CHANGED:
				print(name, ": _notification(Node3D.NOTIFICATION_TRANSFORM_CHANGED)")
			_:
				matched = false
		if matched:
			return

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
			if process_count < MAX_PROCESS_COUNT:
				print(name, ": _notification(NOTIFICATION_PROCESS)")
		NOTIFICATION_PHYSICS_PROCESS:
			if physics_process_count < MAX_PROCESS_COUNT:
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
		_:
			print(name, ": _notification(constant ", what, ")")

func _input(event: InputEvent) -> void:
	if input_logging:
		print(name, ": _input(", event.as_text(), ")")

func _shortcut_input(event: InputEvent) -> void:
	if input_logging:
		print(name, ": _shortcut_input(", event.as_text(), ")")

func _unhandled_input(event: InputEvent) -> void:
	if input_logging:
		print(name, ": _unhandled_input(", event.as_text(), ")")

func _unhandled_key_input(event: InputEvent) -> void:
	if input_logging:
		print(name, ": _unhandled_key_input(", event.as_text(), ")")

func _enter_tree() -> void:
	print(name, ": _enter_tree() init_number: ", self_init_number)

func _exit_tree() -> void:
	print(name, ": _exit_tree()")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(name, ": _ready()")

func _physics_process(_delta: float) -> void:
	physics_process_count += 1
	if process_logging:
		print("pp", self_init_number)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	process_count += 1
	if process_logging:
		print("p", self_init_number)
	if process_count % 100 == 0 && sig.get_connections().size() > 0:
		print(name, ": emitting signal!")
		sig.emit()
	if process_count % 102 == 0 && is_instantiate_packed_scene:
		if new_scene == null:
			print(name, ": instantiating packed scene")
			new_scene = (StaticMembersAutoload as StaticMembers).MainScn.instantiate()
			print(name, ": add_child(new_scene)")
			add_child(new_scene)
			print(name, ": add_child(new_scene) complete!")
			var logger: NodeLog = new_scene.get_child(0) as NodeLog
			logger.is_instantiate_packed_scene = false # disable creation of new scene by child
		else:
			print(name, ": queue_free() on new_scene")
			new_scene.queue_free()
			new_scene = null

func _draw() -> void:
	print(name, ": _draw()")

func _pressed() -> void:
	print(name, ": _pressed()")
	if is_input_toggle:
		input_logging = !input_logging

func _button_down_sig() -> void:
	print(name, ": _button_down_sig()")

func _button_up_sig() -> void:
	print(name, ": _button_up_sig()")

func _pressed_sig() -> void:
	print(name, ": _pressed_sig()")

func _toggled_sig(toggled_on: bool) -> void:
	print(name, ": _toggled_sig(", toggled_on, ")")

func _custom_sig() -> void:
	print(name, ": received signal!")
