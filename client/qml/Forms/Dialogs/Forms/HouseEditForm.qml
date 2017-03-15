import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

ColumnLayout {

	property var house: null

	anchors.fill: parent

	spacing: 15

	signal edited()

	Item {
		Layout.fillHeight: true
	}

	Controls.LabelBold {
		text: qsTr("Edit house")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Name")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __editNameInput
		text: !!house ? house.name : ""
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Address")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __editAddressInput
		text: !!house ? house.address : ""
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.Button {
		text: qsTr("Edit house")

		enabled: __editNameInput.text && __editAddressInput.text
		anchors.horizontalCenter: parent.horizontalCenter

		onClicked: {

			var houseEditRequestString = "users/" + Global.Application.restProvider.currentUserId()
			houseEditRequestString += "/houses"

			var editedHouse = {
				"name": __editNameInput.text,
				"address": __editAddressInput.text
			}

			Global.Application.restProvider.update(houseEditRequestString,  house.id, JSON.stringify(editedHouse), undefined, houseEdited)
		}
	}

	Item {
		Layout.fillHeight: true
	}

	function houseEdited(){
		edited()
	}
}
