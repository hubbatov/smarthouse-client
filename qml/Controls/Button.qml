import QtQuick 2.6

Rectangle{
	id: __button

	width: 300
	height: 30
	radius: 5

	color: enabled ? "#CFCD59" : "#CFCFCF"
	border.color: "#919191"

	property alias text: __label.text
	signal clicked()

	LabelBold {
		id: __label

		anchors.centerIn: parent

		font.bold: true
		font.pixelSize: 14
	}

	MouseArea {
		anchors.fill: parent

		onClicked: {
			__button.clicked()
		}
	}
}

