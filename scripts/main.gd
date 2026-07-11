extends Node2D

const GRID_SIZE := 20
const CELL_SIZE := 32.0
const BOARD_MARGIN := 40.0
const MOVE_INTERVAL := 0.16

const GROUND_COLOR := Color("303744")
const HEAD_COLOR := Color("f1f5f9")
const BODY_COLOR := Color("94a3b8")
const FOOD_COLOR := Color("fb7185")
const DIRECTION_COLOR := Color("0f172a")
const OVERLAY_COLOR := Color(0.06, 0.07, 0.09, 0.78)
const TEXT_COLOR := Color("f8fafc")

const DIRECTIONS := {
	"left": Vector2i.LEFT,
	"down": Vector2i.DOWN,
	"up": Vector2i.UP,
	"right": Vector2i.RIGHT,
}

var worm: Array[Vector2i] = []
var direction := Vector2i.RIGHT
var pending_direction := Vector2i.RIGHT
var food := Vector2i.ZERO
var elapsed := 0.0
var game_over := false
var random := RandomNumberGenerator.new()


func _ready() -> void:
	random.randomize()
	reset_game()


func _process(delta: float) -> void:
	if game_over:
		if Input.is_action_just_pressed("restart"):
			reset_game()
		queue_redraw()
		return

	read_direction()
	elapsed += delta

	if elapsed >= MOVE_INTERVAL:
		elapsed -= MOVE_INTERVAL
		move_worm()

	queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func reset_game() -> void:
	var center := Vector2i(GRID_SIZE / 2, GRID_SIZE / 2)
	worm = [
		center,
		center + Vector2i.LEFT,
		center + Vector2i.LEFT * 2,
	]
	direction = Vector2i.RIGHT
	pending_direction = direction
	elapsed = 0.0
	game_over = false
	place_food()
	queue_redraw()


func read_direction() -> void:
	var requested := pending_direction

	if Input.is_action_just_pressed("move_left"):
		requested = DIRECTIONS.left
	elif Input.is_action_just_pressed("move_down"):
		requested = DIRECTIONS.down
	elif Input.is_action_just_pressed("move_up"):
		requested = DIRECTIONS.up
	elif Input.is_action_just_pressed("move_right"):
		requested = DIRECTIONS.right

	if requested + direction != Vector2i.ZERO:
		pending_direction = requested


func move_worm() -> void:
	direction = pending_direction
	var new_head := worm[0] + direction

	if is_outside_board(new_head) or new_head in worm:
		game_over = true
		return

	worm.push_front(new_head)

	if new_head == food:
		place_food()
	else:
		worm.pop_back()


func is_outside_board(cell: Vector2i) -> bool:
	return (
		cell.x < 0
		or cell.y < 0
		or cell.x >= GRID_SIZE
		or cell.y >= GRID_SIZE
	)


func place_food() -> void:
	var candidates: Array[Vector2i] = []

	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):
			var cell := Vector2i(x, y)
			if cell not in worm:
				candidates.append(cell)

	if candidates.is_empty():
		game_over = true
		return

	food = candidates[random.randi_range(0, candidates.size() - 1)]


func _draw() -> void:
	draw_ground()
	draw_food()
	draw_worm()

	if game_over:
		draw_game_over()


func draw_ground() -> void:
	var radius := CELL_SIZE * 0.34

	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):
			draw_circle(cell_center(Vector2i(x, y)), radius, GROUND_COLOR)


func draw_food() -> void:
	draw_circle(cell_center(food), CELL_SIZE * 0.34, FOOD_COLOR)


func draw_worm() -> void:
	for index in range(worm.size()):
		var cell := worm[index]
		var color := HEAD_COLOR if index == 0 else BODY_COLOR
		draw_circle(cell_center(cell), CELL_SIZE * 0.34, color)

	draw_head_direction_marker()


func draw_head_direction_marker() -> void:
	var head_center := cell_center(worm[0])
	var head_radius := CELL_SIZE * 0.34
	var marker_radius := head_radius * 0.25
	var marker_offset := direction_vector() * (head_radius - marker_radius)

	draw_circle(
		head_center + marker_offset,
		marker_radius,
		DIRECTION_COLOR
	)


func direction_vector() -> Vector2:
	return Vector2(direction.x, direction.y)


func cell_center(cell: Vector2i) -> Vector2:
	return Vector2(
		BOARD_MARGIN + cell.x * CELL_SIZE + CELL_SIZE / 2.0,
		BOARD_MARGIN + cell.y * CELL_SIZE + CELL_SIZE / 2.0
	)


func draw_game_over() -> void:
	var board_size := GRID_SIZE * CELL_SIZE
	var rect := Rect2(
		Vector2(BOARD_MARGIN, BOARD_MARGIN),
		Vector2(board_size, board_size)
	)
	draw_rect(rect, OVERLAY_COLOR)

	var font := ThemeDB.fallback_font
	var center_x := BOARD_MARGIN + board_size / 2.0
	var center_y := BOARD_MARGIN + board_size / 2.0

	var title := "GAME OVER"
	var restart := "R: RESTART   ESC: QUIT"
	var title_size := font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, 34)
	var restart_size := font.get_string_size(restart, HORIZONTAL_ALIGNMENT_LEFT, -1, 18)

	draw_string(
		font,
		Vector2(center_x - title_size.x / 2.0, center_y - 12.0),
		title,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		34,
		TEXT_COLOR
	)
	draw_string(
		font,
		Vector2(center_x - restart_size.x / 2.0, center_y + 28.0),
		restart,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		18,
		TEXT_COLOR
	)
