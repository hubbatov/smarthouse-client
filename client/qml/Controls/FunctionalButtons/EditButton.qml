import QtQuick 2.6
import QtGraphicalEffects 1.0

import "../.."  as Global

Item {
	id: __button

	width: 20
	height: 20

	signal clicked()

	Image{
		id: __image
		source: "qrc:/icons/edit.png"
		visible: false
		smooth: true
		anchors.centerIn: parent
	}

	ColorOverlay {
		id: __overlay
		cached: true
		color: Global.ApplicationStyle.foreground
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
		color: "#80000000"
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
