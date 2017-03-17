import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

Rectangle {
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
			implicitHeight: __addNameInput.height +
							__addQueryInput.height +
							__addTypeInput.height +
							__addValuesInput.height + 100

			Controls.LabelBold {
				text: qsTr("Name")
			}

			Controls.TextInput {
				id: __addNameInput
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Query")
			}

			Controls.TextInput {
				id: __addQueryInput
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Type")
			}

			Controls.TextInput {
				id: __addTypeInput
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Values")
			}

			Controls.TextInput {
				id: __addValuesInput
				Layout.fillWidth: true
			}
		}

		RowLayout {
			Item {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: qsTr("Accept")

				enabled: __addNameInput.text && __addQueryInput.text && __addTypeInput.text

				onClicked: {
					var commandAddRequestString = "users/" + Global.Application.restProvider.currentUserId()
					commandAddRequestString += "/houses/" + house.id
					commandAddRequestString += "/commands"

					var newCommand = {
						"name": __addNameInput.text,
						"query": __addQueryInput.text,
						"command_type": __addTypeInput.text,
						"available_values": __addValuesInput.text
					}

					Global.Application.restProvider.create(commandAddRequestString, JSON.stringify(newCommand), undefined, commandAdded)
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

	function commandAdded(){
		added()
	}
}
