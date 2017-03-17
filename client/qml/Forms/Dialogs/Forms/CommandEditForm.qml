import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

Rectangle {
	color: Global.ApplicationStyle.frame

	implicitHeight: __layout.implicitHeight + 20
	anchors.centerIn: parent

	property var house: null
	property var command: null
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
			implicitHeight: __editNameInput.height +
							__editQueryInput.height +
							__editTypeInput.height +
							__editValuesInput.height + 100

			Controls.LabelBold {
				text: qsTr("Name")
			}

			Controls.TextInput {
				id: __editNameInput
				text: !!command ? command.name : ""
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Query")
			}

			Controls.TextInput {
				id: __editQueryInput
				text: !!command ? command.query : ""
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Type")
			}

			Controls.TextInput {
				id: __editTypeInput
				text: !!command ? command.command_type : ""
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Values")
			}

			Controls.TextInput {
				id: __editValuesInput
				text: !!command ? command.available_values : ""
				Layout.fillWidth: true
			}
		}

		RowLayout {
			Item {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: qsTr("Accept")
				enabled: __editNameInput.text && __editQueryInput.text && __editTypeInput
				onClicked: {
					var commandEditRequestString = "users/" + Global.Application.restProvider.currentUserId()
					commandEditRequestString += "/houses/" + house.id
					commandEditRequestString += "/commands"

					var editedCommand = {
						"name": __editNameInput.text,
						"query": __editQueryInput.text,
						"command_type": __editTypeInput.text,
						"available_values": __editValuesInput.text
					}

					Global.Application.restProvider.update(commandEditRequestString,  command.id, JSON.stringify(editedCommand), undefined, commandEdited)
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

	function commandEdited(){
		edited()
	}
}
