import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Forms/Dialogs" as Dialogs

import "../Controls" as Controls
import "../Controls/FunctionalButtons" as Buttons
import ".." as Global

Rectangle {
	id: __delegate

	property var house: null

	radius: 4
	color: Global.ApplicationStyle.background

	height: __layout.implicitHeight

	signal editRequest(var house)
	signal removeRequest(var house)

	signal addSensorRequest(var house)
	signal editSensorRequest(var house, var sensor)
	signal removeSensorRequest(var house, var sensor)

	ListModel {
		id: __sensorsModel
	}

	RowLayout{
		anchors.top: __delegate.top; anchors.topMargin: 5
		anchors.right: __delegate.right; anchors.rightMargin: 5

		Buttons.AddButton{
			iconSize: 20
			color: "#787878"

			onClicked: {
				addSensorRequest(house)
			}
		}

		Buttons.EditButton {
			onClicked: {
				editRequest(house)
			}
		}

		Buttons.RemoveButton {
			onClicked: {
				removeRequest(house)
			}
		}
	}

	ColumnLayout {
		id: __layout

		spacing: 10

		anchors.top: __delegate.top; anchors.topMargin: 10
		anchors.left: __delegate.left; anchors.leftMargin: 10
		anchors.right: __delegate.right; anchors.rightMargin: 10

		Controls.LabelBold {
			id: __houseLabel
			text: !!house ? qsTr("%1").arg(house.name) : ""
		}

		Controls.LabelBold {
			id: __houseDescriptionLabel
			font.bold: false
			font.pixelSize: 12
			text: !!house ? qsTr("%1").arg(house.address) : ""
		}

		Controls.LabelBold {
			id: __houseNoSensorsLabel
			font.bold: false
			font.italic: true
			text: qsTr("No sensors available")
			visible: __sensorsModel.count === 0
		}

		Repeater {
			id: __sensorsView

			clip: true

			model: __sensorsModel.count

			property var lastSelectedSensor: null

			delegate: SensorDelegate{
				implicitHeight: height

				Layout.fillWidth: true

				house: __delegate.house
				sensor: __sensorsModel.get(index)

				onEditRequest: {
					editSensorRequest(house, sensor)
				}

				onRemoveRequest: {
					removeSensorRequest(house, sensor)
				}
			}
		}
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
		if("answer" in response){
			var sensors = JSON.parse(response.answer)
			if(sensors.length){
				sensors.forEach(function(sensor, i, sensors){
					__sensorsModel.append(sensor)
				})
			}
		}
	}
}
