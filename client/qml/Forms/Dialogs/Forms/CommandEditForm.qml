import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

ColumnLayout {

	property var house: null
	property var command: null

	anchors.fill: parent

	spacing: 15

	signal edited()

	Item {
		Layout.fillHeight: true
	}

	Controls.LabelBold {
		text: qsTr("Edit command")
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
		text: !!command ? command.name : ""
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Query")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __editQueryInput
		text: !!command ? command.query : ""
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Type")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __editTypeInput
		text: !!command ? command.command_type : ""
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Values")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __editValuesInput
		text: !!command ? command.available_values : ""
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.Button {
		text: qsTr("Edit command")

		enabled: __editNameInput.text && __editQueryInput.text && __editTypeInput
		anchors.horizontalCenter: parent.horizontalCenter

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

	Item {
		Layout.fillHeight: true
	}

	function commandEdited(){
		edited()
	}
}
