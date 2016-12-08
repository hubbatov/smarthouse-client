import QtQuick 2.6
import Qt.labs.controls 1.0

Rectangle{
	radius: 5
	width: 300
	height: 30

	property alias text: __input.text
	property alias echoMode: __input.echoMode

	TextInput {
		id: __input
		font.bold: true
		font.pixelSize: 14
		verticalAlignment: TextInput.AlignVCenter
		horizontalAlignment: TextInput.AlignHCenter

		anchors.fill: parent
	}
}
