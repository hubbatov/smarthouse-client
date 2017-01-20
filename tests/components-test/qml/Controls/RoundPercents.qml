import QtQuick 2.5

Item{
	id: __control

	property color background: "#7A7A7A"
	property color foreground: "#FFB845"

	property int value: 0

	Behavior on value {
		NumberAnimation {
			duration: 1000
			easing.type: Easing.OutElastic
		}
	}

	implicitWidth: 200
	implicitHeight: 200

	onValueChanged: {
		if(value < 0) value = 0
		if(value > 100) value = 100
	}

	Rectangle {
		id: __backgroundCircle

		color: background

		anchors.centerIn: parent

		width: __control.width
		height: __control.height

		function borderLength(){
			return Math.PI * 2 * __backgroundCircle.width
		}

		Text {
			color: foreground
			font.pixelSize: parent.width * 0.15
			text: value + "%"

			anchors.centerIn: parent
		}

		Repeater{
			model: value * 2
			delegate: Rectangle {
				id: __mark

				color: foreground

				radius: 3
				width: 5
				height: 5

				function takePostition(){
					var angleDegrees = 3.6 / 2 * index - 137.5
					var angleRadians = angleDegrees * Math.PI / 180

					var x0 = __backgroundCircle.width / 2
					var y0 = __backgroundCircle.height / 2
					var rx = x0 / 2
					var ry = y0 / 2
					var c = Math.cos(angleRadians)
					var s = Math.sin(angleRadians)
					x = x0 + rx * c - ry * s
					y = y0 + rx * s + ry * c
				}

				Component.onCompleted: {
					takePostition()
				}
			}
		}
	}
}
