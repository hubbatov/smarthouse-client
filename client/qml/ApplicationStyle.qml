pragma Singleton

import QtQuick 2.6

QtObject{

	property size screenSize: Qt.size(720, 1280)

	function style(){
		var style_object = {
			"control_width": 500,
			"control_height": 30,
			"font_pixel_size": 16
		}
		return style_object
	}
}
