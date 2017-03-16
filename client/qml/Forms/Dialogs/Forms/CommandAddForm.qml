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
		text: qsTr("Add command")
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
		text: qsTr("Query")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __addQueryInput
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Type")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __addTypeInput
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: qsTr("Values")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __addValuesInput
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.Button {
		text: qsTr("Add command")

		enabled: __addNameInput.text && __addQueryInput.text && __addTypeInput.text
		anchors.horizontalCenter: parent.horizontalCenter

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

	Item {
		Layout.fillHeight: true
	}

	function commandAdded(){
		added()
	}
}
