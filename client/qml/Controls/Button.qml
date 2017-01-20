import QtQuick 2.6

import ".." as Global

Rectangle{
	id: __button

	width: Global.ApplicationStyle.style().control_width
	height: Global.ApplicationStyle.style().control_height
	radius: 5

	color: enabled ? Global.ApplicationStyle.button : Global.ApplicationStyle.buttonDisabled
	border.color: Global.ApplicationStyle.border

	property alias text: __label.text
	signal clicked()

	LabelBold {
		id: __label

		anchors.centerIn: parent

		font.bold: true
		font.pixelSize: Global.ApplicationStyle.style().font_pixel_size

		color: Global.ApplicationStyle.foreground
	}

	MouseArea {
		anchors.fill: parent

		onClicked: {
			__button.clicked()
		}
	}
}

