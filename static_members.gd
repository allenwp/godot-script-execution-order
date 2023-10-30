class_name StaticMembers extends Node

const MainScn = preload("res://main.tscn")

func _init() -> void:
	print ("static_members autoload: _init()")

func _ready() -> void:
	print ("static_members autoload: _ready()")
