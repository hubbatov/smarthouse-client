import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

ColumnLayout {

	property var house: null

	anchors.fill: parent

	spacing: 15

	signal removed()

	Item {
		Layout.fillHeight: true
	}

	Controls.LabelBold {
		text: qsTr("Remove house")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: !!house ? house.name : "undefined" + " " + qsTr("Will be removed. Are you sure?")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.Button {
		text: qsTr("Remove house")

		anchors.horizontalCenter: parent.horizontalCenter

		onClicked: {

			var houseEditRequestString = "users/" + Global.Application.restProvider.currentUserId()
			houseEditRequestString += "/houses"

			Global.Application.restProvider.del(houseEditRequestString,  house.id, undefined, houseRemoved)
		}
	}

	Item {
		Layout.fillHeight: true
	}

	function houseRemoved(){
		removed()
	}
}
