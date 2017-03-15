import QtQuick 2.6
import QtGraphicalEffects 1.0

import "../.." as Global

Item {
	id: __button

	width: 40
	height: 40

	property int padding: 20

	property string icon
	property color color: "black"

	signal clicked()

	Image{
		id: __image
		source: __button.icon
		visible: false
		smooth: true

		width: sourceSize.width
		height: sourceSize.height
		sourceSize: Qt.size(__button.width - padding, __button.height - padding)

		anchors.centerIn: parent
	}

	ColorOverlay {
		id: __overlay
		cached: true
		color: __button.color
		source: __image
		anchors.fill: __image
		visible: true
	}

	DropShadow {
		anchors.fill: __overlay
		horizontalOffset: __mouseArea.pressed ? 0 : 1
		verticalOffset: __mouseArea.pressed ? 0 : 1
		radius: 3.0
		samples: 17
		color: __button.color
		source: __overlay
	}

	MouseArea{
		id: __mouseArea

		onClicked: {
			__button.clicked()
		}

		anchors.fill: __image
	}
}
