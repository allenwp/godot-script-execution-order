# Godot Script Execution Order
Demonstration project that logs script execution order in Godot.

# Takeaways
## Initialization
Member initialization happens in this order:
1) `static` members are initialized.
2) `_static_init()` is called.
3) instance members are initialized.
4) `_init()` is called.
5) `@export` initialization is applied, which uses property setters if available.

## Notifications
Most execution is done from top to bottom of the order of the scene if all nodes are expanded. Exceptions to this are:
- `_ready()`, `NOTIFICATION_READY`, and `NOTIFICATION_POST_ENTER_TREE` are called children first, top to bottom. This means a parent will only get these notifications when its children have already received these notificaitons.
- `_input()` and `_unhandled_input()` are called bottom to top. This means nodes later in the tree get first chance to handle input.

Most notifications are given to all nodes before moving on to the next notification. Exceptions to this are:
-  `_ready()`, `NOTIFICATION_READY`, and `NOTIFICATION_POST_ENTER_TREE` happen in that order for each node before moving to the next node.
-  `_physics_process()` and `NOTIFICATION_PHYSICS_PROCESS` happen in that order for each node before moving to the next node.
-  `_process()` and `NOTIFICATION_PROCESS` happen in that order for each node before moving to the next node.
