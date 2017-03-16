import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

ColumnLayout {

	property var house: null
	property var command: null

	anchors.fill: parent

	spacing: 15

	signal removed()

	Item {
		Layout.fillHeight: true
	}

	Controls.LabelBold {
		text: qsTr("Remove command")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: (!!command ? command.name : "undefined") + " " + qsTr("will be removed. Are you sure?")

		wrapMode: Text.WordWrap

		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.Button {
		text: qsTr("Remove command")

		anchors.horizontalCenter: parent.horizontalCenter

		onClicked: {

			var commandRemoveRequestString = "users/" + Global.Application.restProvider.currentUserId()
			commandRemoveRequestString += "/houses/" + house.id
			commandRemoveRequestString += "/commands"

			Global.Application.restProvider.del(commandRemoveRequestString, command.id, undefined, commandRemoved)
		}
	}

	Item {
		Layout.fillHeight: true
	}

	function commandRemoved(){
		removed()
	}
}
