pragma Singleton

import QtQuick 2.6

QtObject{

	property color background: "#E3E3E3"
	property color backgroundHeader: "#9FC8D6"
	property color foreground: "#474747"
	property color button: "#0CB5ED"
	property color buttonDisabled: "#CFCFCF"
	property color border: "#474747"

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
