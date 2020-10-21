extends Control


onready var scene_tree: SceneTree = get_tree()
onready var score_label: Label = $Score
onready var pause_overlay: ColorRect = $PauseOverlay
onready var title_label: Label = $PauseOverlay/Title
onready var retry_button: Button = $PauseOverlay/PauseMenu/RetryButton

const MESSAGE_DIED: = "You died"

var paused: = false setget set_paused

func _ready():
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("died", self, "_on_Player_died")
	update_interface()

func update_interface() -> void:
	score_label.text = "Score: %s" % PlayerData.score

func _on_Player_died() -> void:
	self.paused = true
	title_label.text = MESSAGE_DIED


func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
