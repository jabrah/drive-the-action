class_name Modal
extends Control

@warning_ignore("unused_signal")
signal ok_btn_pressed

@onready var ok_btn := %OkButton

func _on_ok_button_pressed() -> void:
	EventBus.emit("ok_btn_pressed", { "name": "Level1", "modal": self })
