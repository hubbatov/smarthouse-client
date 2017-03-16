import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

ColumnLayout {

	property var house: null
	property var sensor: null

	anchors.fill: parent

	spacing: 15

	signal edited()

	Item {
		Layout.fillHeight: true
	}

	Controls.LabelBold {
		text: qsTr("Edit sensor")
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
		text: !!sensor ? sensor.name : ""
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Tag")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __editTagInput
		text: !!sensor ? sensor.tag : ""
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.Button {
		text: qsTr("Edit sensor")

		enabled: __editNameInput.text && __editTagInput.text
		anchors.horizontalCenter: parent.horizontalCenter

		onClicked: {

			var sensorEditRequestString = "users/" + Global.Application.restProvider.currentUserId()
			sensorEditRequestString += "/houses/" + house.id
			sensorEditRequestString += "/sensors"

			var editedSensor = {
				"name": __editNameInput.text,
				"tag": __editTagInput.text
			}

			Global.Application.restProvider.update(sensorEditRequestString,  sensor.id, JSON.stringify(editedSensor), undefined, sensorEdited)
		}
	}

	Item {
		Layout.fillHeight: true
	}

	function sensorEdited(){
		edited()
	}
}
