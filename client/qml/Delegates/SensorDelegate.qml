import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import "../Views" as Views
import ".." as Global

Rectangle {
	id: __delegate

	property var house: null
	property var sensor: null

	radius: 4
	color: Global.ApplicationStyle.background

	height: __mainLayout.height + 30
	width: 200

	ListModel{
		id: __sensorDataModel
	}

	ColumnLayout {
		id: __mainLayout
		spacing: 10

		anchors.top: __delegate.top; anchors.topMargin: 10
		anchors.left: __delegate.left; anchors.leftMargin: 10
		anchors.right: __delegate.right; anchors.rightMargin: 10

		Controls.LabelBold {
			id: __sensorLabel
			text: !!sensor ? qsTr("%1").arg(sensor.name) : ""
		}

		RowLayout {
			id: __dataLayout
			spacing: 10

			Views.RoundPercents {
				id: __percents
				Layout.minimumHeight: 80
				Layout.minimumWidth: 80
				visible: false
			}

			Views.Temperature {
				id: __temperature
				Layout.minimumHeight: 80
				Layout.minimumWidth: 80
			}

			Views.NumericChart {
				id: __chart
				Layout.minimumHeight: 80
				Layout.fillWidth: true
			}
		}
	}

	Component.onCompleted: {
		var sensorsRequestString = "users/" + Global.Application.restProvider.currentUserId()
		sensorsRequestString += "/houses/" + house.id
		sensorsRequestString += "/sensors/" + sensor.id + "/sensordata"
		Global.Application.restProvider.list(sensorsRequestString, undefined, fillModel)
	}

	function fillModel(response){
		if("answer" in response){
			var sensorDatas = JSON.parse(response.answer)
			if(sensorDatas.length){
				for( var i = 0; i < sensorDatas.length; ++i){
					__sensorDataModel.append(sensorDatas[i])

					var data = JSON.parse(sensorDatas[i].data)

					__chart.addValue(sensorDatas[i].time, data.temperature)
					__temperature.value = data.temperature
				}
			}
		}
	}
}
