import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

import "Dialogs" as Dialogs

import "../Controls" as Controls
import "../Controls/FunctionalButtons" as Buttons
import "../Delegates" as Delegates

import ".." as Global

Item{
	id: __root

	ListModel {
		id: __housesModel
	}

	ListView {
		id: __housesList

		spacing: 20

		anchors.fill: parent
		anchors.bottomMargin: __footer.height

		model: __housesModel

		enabled: needEnable()

		function needEnable(){
			return !__houseDialog.visible && !__sensorDialog.visible && !__commandDialog.visible
		}

		property var lastSelectedHouse: null
		property var lastSelectedSensor: null
		property var lastSelectedCommand: null

		delegate: Delegates.HouseDelegate {

			house: __housesModel.get(index)
			width: parent.width

			onEditRequest: {
				__housesList.lastSelectedHouse = house
				__houseDialog.enterEditMode()
			}

			onRemoveRequest: {
				__housesList.lastSelectedHouse = house
				__houseDialog.enterRemoveMode()
			}

			onAddCommandRequest: {
				__housesList.lastSelectedHouse = house
				__commandDialog.enterAddMode()
			}

			onEditCommandRequest: {
				__housesList.lastSelectedHouse = house
				__housesList.lastSelectedCommand = command
				__commandDialog.enterEditMode()
			}

			onRemoveCommandRequest: {
				__housesList.lastSelectedHouse = house
				__housesList.lastSelectedCommand = command
				__commandDialog.enterRemoveMode()
			}

			onAddSensorRequest: {
				__housesList.lastSelectedHouse = house
				__sensorDialog.enterAddMode()
			}

			onEditSensorRequest: {
				__housesList.lastSelectedHouse = house
				__housesList.lastSelectedSensor = sensor
				__sensorDialog.enterEditMode()
			}

			onRemoveSensorRequest: {
				__housesList.lastSelectedHouse = house
				__housesList.lastSelectedSensor = sensor
				__sensorDialog.enterRemoveMode()
			}

			Component.onCompleted: {
				updateCommandsModel()
				updateSensorsModel()
			}
		}
	}

	LinearGradient {
		id: __footer

		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right

		height: 80

		start: Qt.point(0, 0)
		end: Qt.point(0, height)
		gradient: Gradient {
			GradientStop { position: 0.0; color: "transparent" }
			GradientStop { position: 0.3; color: Global.ApplicationStyle.background }
			GradientStop { position: 1.0; color: Global.ApplicationStyle.background }
		}
	}

	Buttons.AddButton {
		anchors.right: parent.right; anchors.rightMargin: Global.ApplicationStyle.iconSize / 2
		anchors.bottom: parent.bottom; anchors.bottomMargin: Global.ApplicationStyle.iconSize / 2

		onClicked: {
			__houseDialog.enterAddMode()
		}
	}

	Dialogs.HouseDialog {
		id: __houseDialog
		house: __housesList.lastSelectedHouse
		visible: false

		anchors.fill: parent

		onNeedUpdate: updateModel()
	}

	Dialogs.SensorDialog {
		id: __sensorDialog
		house:  __housesList.lastSelectedHouse
		sensor: __housesList.lastSelectedSensor
		visible: false

		anchors.fill: parent

		onNeedUpdate: updateModel()
	}

	Dialogs.CommandDialog {
		id: __commandDialog
		house: __housesList.lastSelectedHouse
		command: __housesList.lastSelectedCommand

		visible: false

		anchors.fill: parent

		onNeedUpdate: updateModel()
	}

	function updateModel(){
		__housesModel.clear()

		var housesRequestString = "users/" + Global.Application.restProvider.currentUserId()
		housesRequestString += "/houses"
		Global.Application.restProvider.list(housesRequestString, undefined, fillModel)
	}

	function fillModel(response){
		if("answer" in response){
			if(!__housesModel) return

			var houses = JSON.parse(response.answer)
			if(houses.length){
				houses.forEach(function(house, i, houses){
					__housesModel.append(houses[i])
				})
			}
		}
	}
}
