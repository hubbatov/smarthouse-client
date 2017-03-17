import QtQuick 2.6

import ".." as Global

Rectangle{
	id: __button

	implicitWidth: __label.width + 10
	implicitHeight: __label.height + 10
	radius: 5

	color: enabled ? Global.ApplicationStyle.contrast : Global.ApplicationStyle.disabled
	border.color: color

	property alias text: __label.text
	signal clicked()

	LabelBold {
		id: __label

		anchors.centerIn: parent

		color: Global.ApplicationStyle.background
	}

	MouseArea {
		anchors.fill: parent

		onClicked: {
			__button.clicked()
		}
	}
}
