import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

Rectangle {
	color: Global.ApplicationStyle.frame

	implicitHeight: __layout.implicitHeight + 20
	anchors.centerIn: parent

	property var house: null
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
			implicitHeight: __editNameInput.height + __editAddressInput.height + 60

			Controls.LabelBold {
				text: qsTr("Name")
			}

			Controls.TextInput {
				id: __editNameInput
				text: !!house ? house.name : ""
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Address")
			}

			Controls.TextInput {
				id: __editAddressInput
				text: !!house ? house.address : ""
				Layout.fillWidth: true
			}
		}

		RowLayout {
			Item {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: qsTr("Accept")
				enabled: __editNameInput.text && __editAddressInput.text
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

			Controls.Button {
				text: qsTr("Reject")
				onClicked: {
					canceled()
				}
			}
		}
	}

	function houseEdited(){
		edited()
	}
}
