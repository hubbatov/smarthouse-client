import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

Rectangle {
	color: Global.ApplicationStyle.frame

	implicitHeight: __layout.implicitHeight + 20
	anchors.centerIn: parent

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
			implicitHeight: __nameLabel.height + __addressLabel.height + 60

			Controls.LabelBold {
				id: __nameLabel
				text: qsTr("Name")
				color: Global.ApplicationStyle.foreground
			}

			Controls.TextInput {
				id: __addNameInput
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				id: __addressLabel
				text: qsTr("Address")
				color: Global.ApplicationStyle.foreground
			}

			Controls.TextInput {
				id: __addAddressInput
				Layout.fillWidth: true
			}
		}

		RowLayout {
			Item {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: qsTr("Accept")

				enabled: __addNameInput.text && __addAddressInput.text

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

			Controls.Button {
				text: qsTr("Reject")

				onClicked: {
					canceled()
				}
			}
		}
	}

	function houseAdded(){
		added()
	}
}
