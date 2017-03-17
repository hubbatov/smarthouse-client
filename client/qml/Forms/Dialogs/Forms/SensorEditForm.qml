import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

Rectangle{
	color: Global.ApplicationStyle.frame

	implicitHeight: __layout.implicitHeight + 20
	anchors.centerIn: parent

	property var house: null
	property var sensor: null
	signal edited()
	signal canceled()

	ColumnLayout {
		id: __layout

		anchors.margins: 10
		anchors.fill: parent

		spacing: 15

		GridLayout {
			columns: 2

			columnSpacing: 10
			rowSpacing: 20

			Layout.fillWidth: true
			implicitHeight: __editNameInput.height + __editTagInput.height + 60

			Controls.LabelBold {
				text: qsTr("Name")
			}

			Controls.TextInput {
				id: __editNameInput
				text: !!sensor ? sensor.name : ""
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Tag")
			}

			Controls.TextInput {
				id: __editTagInput
				text: !!sensor ? sensor.tag : ""
				Layout.fillWidth: true
			}

		}

		RowLayout {
			Item {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: qsTr("Accept")
				enabled: __editNameInput.text && __editTagInput.text
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

			Controls.Button {
				text: qsTr("Reject")
				onClicked: {
					canceled()
				}
			}
		}
	}

	function sensorEdited(){
		edited()
	}
}
