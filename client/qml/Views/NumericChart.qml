import QtQuick 2.5
import ".." as Global

Item{
	id: __chart

	implicitWidth: 400
	implicitHeight: 200

	property color background: Global.ApplicationStyle.background
	property color foreground: Global.ApplicationStyle.foreground

	readonly property alias chartData: __data

	ListModel { id: __data }

	Text {
		id: __text
		font.pixelSize: 12
		visible: false
	}

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
		property double minimum: 999999

		property point hoveredValue: Qt.point(-1, -1)
		property int hoveredPointRadius: 5
	}

	function clear(){
		__data.clear()
		__private.maximum = 0
		__private.minimum = 999999
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

		contentWidth: Math.max(width, __data.count * 5)
		contentHeight: parent.height

		Canvas {
			id: __chartCanvas

			property int yLabesWidth: 20
			property int bufferSize: 20
			property double xStep: (width - yLabesWidth)  / __data.count
			property double yStep: (__private.maximum == __private.minimum) ? height / 2 : (height - bufferSize) / Math.abs(__private.maximum - __private.minimum)

			height: parent.height
			width: Math.max(__data.count * 5, __chart.width)

			function centerY(){
				var cY = height /(__private.maximum - __private.minimum)*__private.maximum
				if(__private.minimum > 0) {
					cY = height - bufferSize / 2
				}
				if(__private.maximum < 0){
					cY = bufferSize / 2
				}
				if(__private.minimum == __private.maximum){
					cY = height / 2
				}

				return cY
			}

			onPaint: {
				var ctx = getContext("2d")

				var cY = centerY()

				ctx.beginPath()
				ctx.fillStyle = background
				ctx.fillRect(0, 0, width, height)
				ctx.fill()

				ctx.beginPath()
				ctx.lineWidth = 2
				ctx.strokeStyle = foreground

				ctx.fillStyle = foreground
				ctx.fillText(__private.minimum | 0, 5, height - 10)
				ctx.fillText(__private.maximum | 0, 5, 10)

				for(var i = 0; i < __data.count - 1; ++i){
					var value = __data.get(i).value
					var nextValue = __data.get(i + 1).value

					if(__private.minimum > 0){
						value = __data.get(i).value - __private.minimum
						nextValue = __data.get(i + 1).value - __private.minimum
					}

					ctx.moveTo(__chartCanvas.yLabesWidth + i * xStep, cY - value * yStep)
					ctx.lineTo(__chartCanvas.yLabesWidth + (i + 1) * xStep, cY - nextValue * yStep)
				}

				ctx.stroke()

				if(__private.hoveredValue != Qt.point(-1, -1)){
					ctx.beginPath()
					ctx.fillStyle = foreground
					ctx.arc(__private.hoveredValue.x, __private.hoveredValue.y, __private.hoveredPointRadius, 0, Math.PI*2, true)
					ctx.closePath()
					ctx.fill()

					var index = ((__private.hoveredValue.x / width) * __data.count) | 0
					var data = __data.get(index)
					ctx.fillText(data.label, __private.hoveredValue.x, height)
				}
			}

			MouseArea {
				anchors.fill: parent
				hoverEnabled: true

				onPositionChanged: {
					if(__data.count == 0){
						return
					}

					var cY = __chartCanvas.centerY()

					var index = ((mouseX / width) * __data.count) | 0

					var value = __data.get(index).value
					if(__private.minimum > 0){
						value = __data.get(index).value - __private.minimum
					}

					var xx = __chartCanvas.yLabesWidth + index * __chartCanvas.xStep
					var yy = cY - value * __chartCanvas.yStep

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
