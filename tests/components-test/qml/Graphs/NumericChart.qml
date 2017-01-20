import QtQuick 2.5

Item{
	id: __chart

	implicitWidth: 400
	implicitHeight: 200

	property color background: "#7A7A7A"
	property color foreground: "#FFB845"
	readonly property alias chartData: __data

	ListModel { id: __data }

	property var checkMaximum: function(value, oldMaximum){
		if(value > oldMaximum)
			__private.maximum = value
	}

	property var checkMinimum: function(value, oldMinimum){
		if(value < oldMinimum)
			__private.minimum = value
	}

	QtObject {
		id: __private

		property double maximum: 0.0
		property double minimum: 0.0

		property point hoveredValue: Qt.point(-1, -1)
		property int hoveredPointRadius: 5
	}

	function clear(){
		__data.clear()
		__private.maximum = 0
		__private.minimum = 0
		__chartCanvas.requestPaint()
	}

	function addValue(label, value){
		var newData = {
			"label": label,
			"value": value
		}

		checkMaximum(value, __private.maximum)
		checkMinimum(value, __private.minimum)

		__data.append(newData)

		__chartCanvas.requestPaint()
	}

	function toEnd(){
		__flickable.contentX = __flickable.contentWidth - __flickable.width
	}

	Flickable {
		id: __flickable

		anchors.fill: parent

		clip: true

		contentWidth: __data.count * 5
		contentHeight: parent.height

		Canvas {
			id: __chartCanvas

			property double xStep: width  / __data.count
			property double yStep: height / (__private.maximum - __private.minimum)

			height: parent.height
			width: Math.max(__data.count * 5, __chart.width)

			onPaint: {
				var ctx = getContext("2d")

				ctx.beginPath();
				ctx.fillStyle = background
				ctx.fillRect(0, 0, width, height);
				ctx.fill();

				ctx.beginPath()
				ctx.lineWidth = 2
				ctx.strokeStyle = foreground

				for(var i = 0; i < __data.count - 1; ++i){
					var value = __data.get(i).value
					var nextValue = __data.get(i + 1).value

					ctx.moveTo(i * xStep, value * yStep)
					ctx.lineTo((i + 1) * xStep, nextValue * yStep)
				}

				ctx.closePath();
				ctx.stroke()

				ctx.beginPath();
				ctx.fillStyle = foreground
				ctx.arc(__private.hoveredValue.x, __private.hoveredValue.y, __private.hoveredPointRadius, 0, Math.PI*2, true);
				ctx.closePath();
				ctx.fill();

			}

			MouseArea {
				anchors.fill: parent
				hoverEnabled: true

				onPositionChanged: {

					var index = ((mouseX / width) * __data.count) | 0

					var value = __data.get(index).value

					var xx = index * __chartCanvas.xStep
					var yy =  value * __chartCanvas.yStep

					__private.hoveredValue = Qt.point(xx,yy)

					__chartCanvas.requestPaint()
				}

				onContainsMouseChanged: {
					if(!containsMouse){
						__private.hoveredValue = Qt.point(-1, -1)
						__chartCanvas.requestPaint()
					}
				}
			}
		}
	}
}
