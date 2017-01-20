import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

Rectangle {
	id: __delegate

	property var house: null

	radius: 4
	color: "transparent"
	border.color: "black"

	implicitHeight: __houseDelegateLayout.implicitHeight
	implicitWidth: Global.ApplicationStyle.screenSize.width - 20

	ColumnLayout {
		id: __houseDelegateLayout

		spacing: 5
		anchors.fill: parent
		anchors.margins: 10

		implicitHeight: 40 * __sensorsModel.count + 40

		Controls.LabelBold {
			text: !!house.name ? qsTr("%1").arg(house.name) : ""
		}

		ListView {
			id: __sensorsView

			model: __sensorsModel

			Layout.fillHeight: true

			delegate: SensorDelegate{
				sensor: __sensorsModel.get(index)
			}
		}
	}

	ListModel {
		id: __sensorsModel
	}

	function updateModel(){
		__sensorsModel.clear()

		if(!house) return

		var sensorsRequestString = "users/" + Global.Application.restProvider.currentUserId()
		sensorsRequestString += "/houses/" + house.id
		sensorsRequestString += "/sensors"
		Global.Application.restProvider.list(sensorsRequestString, undefined, fillModel)
	}

	function fillModel(response){
		console.log("get sensors reply: ", JSON.stringify(response))
		if("answer" in response){
			var sensors = JSON.parse(response.answer)
			if(sensors.length){
				for( var i = 0; i < sensors.length; ++i){
					__sensorsModel.append(sensors[i])
				}
			}
		}
	}
}
