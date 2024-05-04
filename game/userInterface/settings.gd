extends Control

@onready var master_slider = %MasterHSlider
@onready var music_slider = %MusicHSlider
@onready var sfx_slider = %SfxHSlider

@onready var window_option_button = %WindowOptionButton
@onready var v_sync_check_box = %VSyncCheckBox
@onready var scaling_option_button = %ScalingOptionButton
@onready var taa_check_box = %TAACheckBox
@onready var msaa_2d_option_button = %MSAA2DOptionButton
@onready var msaa_3d_option_button = %MSAA3DOptionButton


var on_audio_slider = func(value: float, bus: int):
	AudioServer.set_bus_volume_db(bus, value)

func _ready():
	master_slider.value_changed.connect(on_audio_slider.bind(0))
	sfx_slider.value_changed.connect(on_audio_slider.bind(1))
	music_slider.value_changed.connect(on_audio_slider.bind(2))
	master_slider.value_changed.emit(AudioServer.get_bus_volume_db(0), 0)
	sfx_slider.value_changed.emit(AudioServer.get_bus_volume_db(1), 1)
	music_slider.value_changed.emit(AudioServer.get_bus_volume_db(2), 2)
	
	window_option_button.item_selected.connect(func(selected):
		match selected:
			0:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			1:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	)
	
	window_option_button.item_selected.emit(window_option_button.selected)
	
	v_sync_check_box.toggled.connect(func(value):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if value else DisplayServer.VSYNC_DISABLED)
	)
	
	v_sync_check_box.button_pressed = DisplayServer.window_get_vsync_mode()
	
	scaling_option_button.item_selected.connect(func(selected):
		var rid = get_viewport().get_viewport_rid()
		match selected:
			0:
				RenderingServer.viewport_set_scaling_3d_mode(rid, RenderingServer.VIEWPORT_SCALING_3D_MODE_BILINEAR)
			1:
				RenderingServer.viewport_set_scaling_3d_mode(rid, RenderingServer.VIEWPORT_SCALING_3D_MODE_FSR)
			2:
				RenderingServer.viewport_set_scaling_3d_mode(rid, RenderingServer.VIEWPORT_SCALING_3D_MODE_FSR2)
	)
	
	scaling_option_button.item_selected.emit(scaling_option_button.selected)
	
	taa_check_box.toggled.connect(func(value):
		RenderingServer.viewport_set_use_taa(get_viewport().get_viewport_rid(), value)
	)
	
	msaa_2d_option_button.item_selected.connect(func(selected):
		var rid = get_viewport().get_viewport_rid()
		match selected:
			0:
				RenderingServer.viewport_set_msaa_2d(rid, RenderingServer.VIEWPORT_MSAA_DISABLED)
			1:
				RenderingServer.viewport_set_msaa_2d(rid, RenderingServer.VIEWPORT_MSAA_2X)
			2:
				RenderingServer.viewport_set_msaa_2d(rid, RenderingServer.VIEWPORT_MSAA_4X)
			3:
				RenderingServer.viewport_set_msaa_2d(rid, RenderingServer.VIEWPORT_MSAA_8X)
	)
	
	msaa_3d_option_button.item_selected.emit(msaa_2d_option_button.selected)
	msaa_3d_option_button.item_selected.connect(func(selected):
		var rid = get_viewport().get_viewport_rid()
		match selected:
			0:
				RenderingServer.viewport_set_msaa_3d(rid, RenderingServer.VIEWPORT_MSAA_DISABLED)
			1:
				RenderingServer.viewport_set_msaa_3d(rid, RenderingServer.VIEWPORT_MSAA_2X)
			2:
				RenderingServer.viewport_set_msaa_3d(rid, RenderingServer.VIEWPORT_MSAA_4X)
			3:
				RenderingServer.viewport_set_msaa_3d(rid, RenderingServer.VIEWPORT_MSAA_8X)
	)
	
	msaa_3d_option_button.item_selected.emit(msaa_3d_option_button.selected)
	
	taa_check_box.button_pressed = false
	taa_check_box.toggled.emit(taa_check_box.button_pressed)
