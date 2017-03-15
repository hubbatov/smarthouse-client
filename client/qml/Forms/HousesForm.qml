import QtQuick 2.6
import QtQuick.Layouts 1.1

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

		anchors.fill: parent

		model: __housesModel

		property var lastSelectedHouse: null

		delegate: Delegates.HouseDelegate {

			house: __housesModel.get(index)
			width: parent.width

			onEditRequest: {
				__housesList.lastSelectedHouse = houseToEdit
				__houseDialogEditLoader.active = true
			}

			onRemoveRequest: {
				__housesList.lastSelectedHouse = houseToRemove
				__houseDialogRemoveLoader.active = true
			}

			Component.onCompleted: {
				updateModel()
			}
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

	function updateModel(){
		__housesModel.clear()

		var housesRequestString = "users/" + Global.Application.restProvider.currentUserId()
		housesRequestString += "/houses"
		Global.Application.restProvider.list(housesRequestString, undefined, fillModel)
	}

	function fillModel(response){
		console.log("get houses reply: ", JSON.stringify(response))
		if("answer" in response){
			var houses = JSON.parse(response.answer)
			if(houses.length){
				for( var i = 0; i < houses.length; ++i){
					__housesModel.append(houses[i])
				}
			}
		}
	}
}
