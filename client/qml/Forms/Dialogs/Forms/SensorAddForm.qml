import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

ColumnLayout {

	anchors.fill: parent

	spacing: 15

	property var house: null

	signal added()

	Item {
		Layout.fillHeight: true
	}

	Controls.LabelBold {
		text: qsTr("Add sensor")
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


	Controls.Button {
		text: qsTr("Add sensor")

		enabled: __addNameInput.text
		anchors.horizontalCenter: parent.horizontalCenter

		onClicked: {

			var sensorAddRequestString = "users/" + Global.Application.restProvider.currentUserId()
			sensorAddRequestString += "/houses/" + house.id
			sensorAddRequestString += "/sensors"

			var newSensor = {
				"name": __addNameInput.text
			}

			Global.Application.restProvider.create(sensorAddRequestString, JSON.stringify(newSensor), undefined, sensorAdded)
		}
	}

	Item {
		Layout.fillHeight: true
	}

	function sensorAdded(){
		added()
	}
}
