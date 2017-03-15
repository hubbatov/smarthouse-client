import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

ColumnLayout {

	anchors.fill: parent

	spacing: 15

	signal added()

	Item {
		Layout.fillHeight: true
	}

	Controls.LabelBold {
		text: qsTr("Add house")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Name")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __addNameInput
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Address")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __addAddressInput
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.Button {
		text: qsTr("Add house")

		enabled: __addNameInput.text && __addAddressInput.text
		anchors.horizontalCenter: parent.horizontalCenter

		onClicked: {

			var houseAddRequestString = "users/" + Global.Application.restProvider.currentUserId()
			houseAddRequestString += "/houses"

			var newHouse = {
				"name": __addNameInput.text,
				"address": __addAddressInput.text
			}

			Global.Application.restProvider.create(houseAddRequestString, JSON.stringify(newHouse), undefined, houseAdded)
		}
	}

	Item {
		Layout.fillHeight: true
	}

	function houseAdded(){
		added()
	}
}
