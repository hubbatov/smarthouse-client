import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import "../Delegates" as Delegates
import ".." as Global

Item{

	ListModel {
		id: __housesModel
	}

	ListView {
		anchors.fill: parent

		model: __housesModel

		delegate: Delegates.HouseDelegate {

			house: __housesModel.get(index)
			width: parent.width

			Component.onCompleted: {
				updateModel()
			}
		}
	}

	Controls.AddButton {
		anchors.right: parent.right; anchors.rightMargin: 5
		anchors.bottom: parent.bottom; anchors.bottomMargin: 5

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
