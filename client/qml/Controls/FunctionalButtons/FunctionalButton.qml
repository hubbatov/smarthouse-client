import QtQuick 2.6
import QtGraphicalEffects 1.0

import "../.." as Global

Item {
	id: __button

	width: iconSize
	height: iconSize

	property int iconSize: Global.ApplicationStyle.iconSize

	property bool withShadow: false

	property string icon
	property color color: "black"
	property color shadowColor: "black"

	signal clicked()

	Image{
		id: __image
		source: __button.icon
		visible: false
		smooth: true

		sourceSize: Qt.size(iconSize, iconSize)

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
		color: __button.shadowColor
		source: __overlay
		visible: __button.withShadow
	}

	MouseArea{
		id: __mouseArea

		onClicked: {
			__button.clicked()
		}

		anchors.fill: __image
	}
}
