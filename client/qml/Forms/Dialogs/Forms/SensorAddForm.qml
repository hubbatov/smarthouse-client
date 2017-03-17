import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

Rectangle{
	color: Global.ApplicationStyle.frame

	implicitHeight: __layout.implicitHeight + 20
	anchors.centerIn: parent

	property var house: null
	signal added()
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
			implicitHeight: __addNameInput.height + __addTagInput.height + 60

			Controls.LabelBold {
				text: qsTr("Name")
			}

			Controls.TextInput {
				id: __addNameInput
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Tag")
			}

			Controls.TextInput {
				id: __addTagInput
				Layout.fillWidth: true
			}
		}

		RowLayout {
			Item {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: qsTr("Accept")

				enabled: __addNameInput.text && __addTagInput.text

				onClicked: {
					var sensorAddRequestString = "users/" + Global.Application.restProvider.currentUserId()
					sensorAddRequestString += "/houses/" + house.id
					sensorAddRequestString += "/sensors"

					var newSensor = {
						"name": __addNameInput.text,
						"tag": __addTagInput.text
					}

					Global.Application.restProvider.create(sensorAddRequestString, JSON.stringify(newSensor), undefined, sensorAdded)
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
	function sensorAdded(){
		added()
	}
}
