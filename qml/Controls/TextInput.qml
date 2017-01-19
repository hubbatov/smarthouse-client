import QtQuick 2.6
import Qt.labs.controls 1.0

import ".." as Global

Rectangle{
	property alias text: __input.text
	property alias echoMode: __input.echoMode

    width: Global.ApplicationStyle.style().control_width
    height: Global.ApplicationStyle.style().control_height
    radius: 5

	TextInput {
		id: __input
		font.bold: true
        font.pixelSize: Global.ApplicationStyle.style().font_pixel_size
		verticalAlignment: TextInput.AlignVCenter
		horizontalAlignment: TextInput.AlignHCenter

		anchors.fill: parent
	}
}
