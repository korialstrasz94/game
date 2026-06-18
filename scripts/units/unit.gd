extends CharacterBody3D

# --- MOVEMENT & AVOIDANCE (Points 1 & 2) ---
@onready var nav_agent = $NavigationAgent3D
@export var max_speed: float = 5.0
@export var acceleration: float = 8.0
@export var rotation_speed: float = 10.0

# --- COMMAND QUEUE (Point 3) ---
var command_queue: Array = []
var current_command: Dictionary = {}

# --- COMBAT SYSTEM (Point 5) ---
@export var max_health: int = 100
var health: int
@export var attack_damage: int = 15
@export var attack_range: float = 2.0
@export var attack_cooldown: float = 1.2
var attack_timer: float = 0.0
var current_target: Node3D = null

# --- ANIMATION ---
# Assuming you have an AnimationTree with a parameter called "parameters/BlendSpace1D/blend_position"
@onready var anim_tree = $AnimationTree 

func _ready():
	health = max_health
	
	# Setup Navigation Agent for Collision Avoidance (Point 1)
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	nav_agent.avoidance_enabled = true 
	nav_agent.radius = 0.5 # Adjust based on your unit size
	nav_agent.neighbor_distance = 5.0
	nav_agent.avoidance_layers = 1
	nav_agent.avoidance_masks = 1

func _physics_process(delta):
	update_attack_timer(delta)
	
	# Prioritize Combat over Movement
	if current_target and is_instance_valid(current_target):
		handle_combat(delta)
	else:
		handle_movement(delta)
		process_command_queue()

# --- MOVEMENT & SMOOTHING LOGIC ---
func handle_movement(delta):
	if nav_agent.is_navigation_finished():
		# Smooth stopping (Point 2)
		velocity = velocity.lerp(Vector3.ZERO, acceleration * delta)
	else:
		var next_path_pos = nav_agent.get_next_path_position()
		var direction = (next_path_pos - global_transform.origin).normalized()
		var target_velocity = direction * max_speed
		
		# Smooth acceleration (Point 2)
		velocity = velocity.lerp(target_velocity, acceleration * delta)
		
		# Smooth rotation to face movement direction
		if direction.length() > 0.1:
			var target_transform = global_transform.looking_at(global_transform.origin + direction, Vector3.UP)
			global_transform = global_transform.interpolate_with(target_transform, rotation_speed * delta)

	# Apply Godot 4 Avoidance (Point 1)
	if nav_agent.avoidance_enabled:
		nav_agent.velocity = velocity
	else:
		move_and_slide()

	# Update Animation Blend based on speed (Point 2)
	if anim_tree:
		var speed_ratio = velocity.length() / max_speed
		anim_tree.set("parameters/BlendSpace1D/blend_position", speed_ratio)

func _on_velocity_computed(safe_velocity):
	# This is called by NavigationAgent3D when avoidance calculates a safe path
	velocity = safe_velocity
	move_and_slide()

# --- COMMAND QUEUE LOGIC (Point 3) ---
func process_command_queue():
	# If no active command, pull the next one from the queue
	if current_command.is_empty() and command_queue.size() > 0:
		current_command = command_queue.pop_front()
		execute_command(current_command)

	# If we reached the target of the current command, clear it
	if not current_command.is_empty() and nav_agent.is_navigation_finished():
		current_command = {}

func move_to(target_pos: Vector3, add_to_queue: bool = false):
	var cmd = {"type": "move", "pos": target_pos}
	
	if add_to_queue:
		command_queue.append(cmd) # Shift+Right Click behavior
	else:
		command_queue.clear()     # Normal Right Click behavior
		command_queue.append(cmd)
		current_command = cmd
		
	nav_agent.target_position = target_pos

func execute_command(cmd: Dictionary):
	if cmd.get("type") == "move":
		nav_agent.target_position = cmd["pos"]

# --- COMBAT LOGIC (Point 5) ---
func attack_target(target: Node3D):
	current_target = target
	command_queue.clear() # Stop moving to focus on combat
	current_command = {}

func handle_combat(delta):
	var dist = global_transform.origin.distance_to(current_target.global_transform.origin)
	
	if dist <= attack_range:
		# In range: Stop moving smoothly and attack
		velocity = velocity.lerp(Vector3.ZERO, acceleration * delta)
		if nav_agent.avoidance_enabled:
			nav_agent.velocity = velocity
			
		# Face the target
		var look_dir = (current_target.global_transform.origin - global_transform.origin).normalized()
		var target_transform = global_transform.looking_at(global_transform.origin + look_dir, Vector3.UP)
		global_transform = global_transform.interpolate_with(target_transform, rotation_speed * delta)

		if attack_timer <= 0:
			deal_damage()
			attack_timer = attack_cooldown
			# TODO: Play attack animation here
	else:
		# Out of range: Chase the target
		nav_agent.target_position = current_target.global_transform.origin
		handle_movement(delta)

func deal_damage():
	if current_target.has_method("take_damage"):
		current_target.take_damage(attack_damage)

func take_damage(amount: int):
	health -= amount
	# TODO: Play hit animation / flash red
	if health <= 0:
		die()

func die():
	# TODO: Play death animation before queue_free()
	queue_free()

func update_attack_timer(delta):
	if attack_timer > 0:
		attack_timer -= delta