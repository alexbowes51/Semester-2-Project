class_name Day_Night_Manager extends Node2D

signal time_change(hour: float, time_string: String)

@onready var canvas_modulate: CanvasModulate = $CanvasModulate

@export_group("Time Settings")
@export var day_duration: float = 60.0
@export var starting_hour: float = 8.0
@export_range(0,23) var sunrise_hour : int = 6
@export_range(0,23) var sunset_hour : int = 20

@export_group("Color Settings")
@export var day_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export var night_color: Color = Color(0.6, 0.6, 0.8, 0.6)
@export var sunrise_color: Color = Color(0.84, 0.58, 0.28, 1.0)
@export var sunset_color: Color = Color(0.86, 0.7, 0.7, 1.0)

var elapsed_time : float = 0.0
var current_time : float = 0.0

var intro_stop_index = 0

func ready():
	current_time = starting_hour
	change_world_Color()
	time_change.emit(current_time,get_Time_String())
	
func _process(delta):
	elapsed_time += delta
	
	current_time = fmod(starting_hour + (elapsed_time * 24.0 / day_duration), 24.0)
	change_world_Color()
	time_change.emit(current_time,get_Time_String())
	
func change_world_Color():
	var current_Color : Color
	
	if current_time >= sunrise_hour and current_time < sunrise_hour + 2:
		var c = (current_time - sunrise_hour) / 2
		current_Color = night_color.lerp(sunrise_color,c)
		
	elif current_time >= sunrise_hour + 2 and current_time < sunrise_hour + 4:
		var c = (current_time - (sunrise_hour + 2)) / 2
		current_Color = sunrise_color.lerp(day_color,c)
	
	elif  current_time >= sunrise_hour + 4 and current_time < sunset_hour - 2:
		current_Color = day_color
		
	elif current_time >= sunset_hour - 2 and current_time < sunset_hour:
		var c = (current_time - (sunset_hour - 2)) / 2
		current_Color = day_color.lerp(sunrise_color,c)
		
	elif current_time >= sunset_hour and current_time < sunset_hour + 2:
		var c = (current_time - sunset_hour) / 2
		current_Color = sunset_color.lerp(night_color,c)
		
	else:
		current_Color = night_color
		
	
	canvas_modulate.color = current_Color
	
func get_Time_String():
	var hour := floori(current_time)
	var minute := floori((current_time - hour) * 60)
	var ampm := "AM" if hour < 12 else "PM"
	
	if hour == 0:
		hour = 12
	elif hour > 12:
		hour -= 12
		
	return "%d:%02d %s" % [hour, minute,ampm]
	
func pauseCycle():
	set_process(false)
	
func resumeCycle():
	set_process(true)
	
func setTime(hour : float):
	current_time = hour
	change_world_Color()
	time_change.emit(current_time,get_Time_String())

	
