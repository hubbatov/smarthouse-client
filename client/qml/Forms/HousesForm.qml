import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

import "Dialogs" as Dialogs

import "../Controls" as Controls
import "../Controls/FunctionalButtons" as Buttons
import "../Delegates" as Delegates

import ".." as Global

Item{
	ListModel {
		id: __housesModel
	}

	ListView {
		id: __housesList

		spacing: 10

		anchors.fill: parent
		anchors.bottomMargin: __footer.height

		model: __housesModel

		enabled: needEnable()

		function needEnable(){
			return !__houseDialogAddLoader.active
					&& !__houseDialogEditLoader.active
					&& !__houseDialogRemoveLoader.active
					&& !__sensorDialogAddLoader.active
					&& !__sensorDialogEditLoader.active
					&& !__sensorDialogRemoveLoader.active
		}

		property var lastSelectedHouse: null
		property var lastSelectedSensor: null

		delegate: Delegates.HouseDelegate {

			house: __housesModel.get(index)
			width: parent.width

			onEditRequest: {
				__housesList.lastSelectedHouse = house
				__houseDialogEditLoader.active = true
			}

			onRemoveRequest: {
				__housesList.lastSelectedHouse = house
				__houseDialogRemoveLoader.active = true
			}

			onAddSensorRequest: {
				__housesList.lastSelectedHouse = house
				__sensorDialogAddLoader.active = true
			}

			onEditSensorRequest: {
				__housesList.lastSelectedHouse = house
				__housesList.lastSelectedSensor = sensor
				__sensorDialogEditLoader.active = true
			}

			onRemoveSensorRequest: {
				__housesList.lastSelectedHouse = house
				__housesList.lastSelectedSensor = sensor
				__sensorDialogRemoveLoader.active = true
			}

			Component.onCompleted: {
				updateModel()
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
		anchors.right: parent.right; anchors.rightMargin: 5
		anchors.bottom: parent.bottom; anchors.bottomMargin: 5

		onClicked: {
			__houseDialogAddLoader.active = true
		}
	}

	Component {
		id: __houseDialogAddComponent
		Dialogs.HouseDialog {
			mode: mADD_MODE
			onClose: __houseDialogAddLoader.active = false
			onNeedUpdateHouses: updateModel()
		}
	}

	Component {
		id: __houseDialogEditComponent
		Dialogs.HouseDialog {
			mode: mEDIT_MODE
			onClose: __houseDialogEditLoader.active = false
			onNeedUpdateHouses: updateModel()
		}
	}

	Component {
		id: __houseDialogRemoveComponent
		Dialogs.HouseDialog {
			mode: mREMOVE_MODE
			onClose: __houseDialogRemoveLoader.active = false
			onNeedUpdateHouses: updateModel()
		}
	}

	Loader {
		id: __houseDialogAddLoader
		sourceComponent: __houseDialogAddComponent
		active: false
		anchors.fill: parent
	}

	Loader {
		id: __houseDialogEditLoader
		sourceComponent: __houseDialogEditComponent
		active: false
		anchors.fill: parent

		onItemChanged: {
			if(!!item)
				item.house = __housesList.lastSelectedHouse
		}
	}

	Loader {
		id: __houseDialogRemoveLoader
		sourceComponent: __houseDialogRemoveComponent
		active: false
		anchors.fill: parent

		onItemChanged: {
			if(!!item)
				item.house = __housesList.lastSelectedHouse
		}
	}

	Component {
		id: __sensorDialogAddComponent
		Dialogs.SensorDialog {
			mode: mADD_MODE
			onClose: __sensorDialogAddLoader.active = false
			onNeedUpdateSensors: updateModel()
		}
	}

	Component {
		id: __sensorDialogEditComponent
		Dialogs.SensorDialog {
			mode: mEDIT_MODE
			onClose: __sensorDialogEditLoader.active = false
			onNeedUpdateSensors: updateModel()
		}
	}

	Component {
		id: __sensorDialogRemoveComponent
		Dialogs.SensorDialog {
			mode: mREMOVE_MODE
			onClose: __sensorDialogRemoveLoader.active = false
			onNeedUpdateSensors: updateModel()
		}
	}

	Loader {
		id: __sensorDialogAddLoader
		sourceComponent: __sensorDialogAddComponent
		active: false
		anchors.fill: parent

		onItemChanged: {
			if(!!item){
				item.house = __housesList.lastSelectedHouse
			}
		}
	}

	Loader {
		id: __sensorDialogEditLoader
		sourceComponent: __sensorDialogEditComponent
		active: false
		anchors.fill: parent

		onItemChanged: {
			if(!!item){
				item.house = __housesList.lastSelectedHouse
				item.sensor = __housesList.lastSelectedSensor
			}
		}
	}

	Loader {
		id: __sensorDialogRemoveLoader
		sourceComponent: __sensorDialogRemoveComponent
		active: false
		anchors.fill: parent

		onItemChanged: {
			if(!!item){
				item.house = __housesList.lastSelectedHouse
				item.sensor = __housesList.lastSelectedSensor
			}
		}
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
