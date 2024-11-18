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
- `_ready()`, `NOTIFICATION_READY`, and `NOTIFICATION_POST_ENTER_TREE` are called children first. This means a parent `Node` will only get these notifications when all its its children have already received these notifications.
- `_input()` and `_unhandled_input()` are called bottom to top. This means nodes later in the tree get first chance to handle input.
- `_exit_tree()` and related notifications are called bottom to top. (Conversely, `NOTIFICATION_UNPARENTED` are called top to bottom.)

![script-execution-order](https://github.com/user-attachments/assets/e0642a00-c286-4a3d-ad76-7ee4aca6bb8d)

Most notifications are given to all nodes before moving on to the next notification. Exceptions to this are:
-  `_ready()`, `NOTIFICATION_READY`, and `NOTIFICATION_POST_ENTER_TREE` happen in that order for each node before moving to the next node.
-  `_physics_process()` and `NOTIFICATION_PHYSICS_PROCESS` happen in that order for each node before moving to the next node.
-  `_process()` and `NOTIFICATION_PROCESS` happen in that order for each node before moving to the next node.
- `_exit_tree()` and related notifications such as `NOTIFICATION_EXIT_TREE`, `Control.NOTIFICATION_MOUSE_EXIT`, and `CanvasItem.NOTIFICATION_EXIT_CANVAS` happen in that order for each node before moving to the next node.

## Signals
When a signal is emitted, it is received in the order that the connections were made. Signals are received immediately when they are emitted, even in the middle of a `_process` sequence, for example.

## `*_input` Methods, `Button` Methods, etc.
`*_input` methods are called between `_process` and `_physics_process` calls and do not interrupt the sequence of `_process` or `_process_physics`. `Button` signals and methods are similarly called after the all of the `*_input` methods have been completed.

## `queue_free()`
`queue_free()` will free those objects without interrupting the `_process` or `_physics_process` sequence.

# Example Log
Here is an example of the output from the project. It is not uncommon for the output to overflow when moving a mouse around, but input logging can be disabled to reduce log messages.

[script-execution-log-example.txt](https://github.com/allenwp/godot-script-execution-order/files/13210959/script-execution-log-example.txt)
