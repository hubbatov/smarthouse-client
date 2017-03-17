import QtQuick 2.6
import Qt.labs.controls 1.0

import ".." as Global

Rectangle{
	property alias text: __input.text
	property alias echoMode: __input.echoMode

	width: 200
	height: 30
	radius: 5

	border.color: Global.ApplicationStyle.border

	TextInput {
		id: __input
		font: Global.ApplicationStyle.regularFont

		clip: true

		verticalAlignment: TextInput.AlignVCenter
		horizontalAlignment: TextInput.AlignHCenter

		anchors.fill: parent
	}
}
