extends TextureProgressBar

# ===== CONFIG =====
@export var drain_speed := 15.0          # how fast it drains per second

@export var full_color := Color(0.2, 1.0, 0.3)   # green
@export var mid_color  := Color(1.0, 0.8, 0.2)   # yellow
@export var low_color  := Color(1.0, 0.2, 0.2)   # red

@export var mid_threshold := 0.6
@export var low_threshold := 0.3

# ===== STATE =====
var running := true   # auto-starts

# ===== SETUP =====
func _ready():
	min_value = 0
	value = max_value
	set_process(true)
	_update_color()

# ===== UPDATE =====
func _process(delta):
	if not running:
		return

	value -= drain_speed * delta
	value = max(value, min_value)

	_update_color()

# ===== COLOR LOGIC =====
func _update_color():
	var t := value / max_value

	if t > mid_threshold:
		tint_progress = full_color
	elif t > low_threshold:
		tint_progress = mid_color
	else:
		tint_progress = low_color

# ===== PUBLIC API =====
func start():
	running = true

func pause():
	running = false

func reset():
	value = max_value
	_update_color()

func add(amount: float):
	value = clamp(value + amount, min_value, max_value)
	_update_color()

func is_empty() -> bool:
	return value <= min_value
