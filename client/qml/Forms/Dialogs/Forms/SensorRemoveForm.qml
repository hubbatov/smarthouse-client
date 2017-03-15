import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

ColumnLayout {

	property var house: null
	property var sensor: null

	anchors.fill: parent

	spacing: 15

	signal removed()

	Item {
		Layout.fillHeight: true
	}

	Controls.LabelBold {
		text: qsTr("Remove sensor")
		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.LabelBold {
		text: (!!sensor ? sensor.name : "undefined") + " " + qsTr("will be removed. Are you sure?")

		wrapMode: Text.WordWrap

		color: Global.ApplicationStyle.foreground
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.Button {
		text: qsTr("Remove sensor")

		anchors.horizontalCenter: parent.horizontalCenter

		onClicked: {

			var sensorRemoveRequestString = "users/" + Global.Application.restProvider.currentUserId()
			sensorRemoveRequestString += "/houses/" + house.id
			sensorRemoveRequestString += "/sensors"

			Global.Application.restProvider.del(sensorRemoveRequestString, sensor.id, undefined, sensorRemoved)
		}
	}

	Item {
		Layout.fillHeight: true
	}

	function sensorRemoved(){
		removed()
	}
}
