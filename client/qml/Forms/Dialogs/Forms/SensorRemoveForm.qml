import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../../../Controls" as Controls
import "../../.." as Global

Rectangle{
	color: Global.ApplicationStyle.frame

	implicitHeight: __layout.height + 20
	anchors.centerIn: parent

	property var house: null
	property var sensor: null
	signal removed()
	signal canceled()

	ColumnLayout {
		id: __layout

		anchors.margins: 10
		anchors.fill: parent

		spacing: 15

		implicitHeight: __questionLabel.height + 20

		Controls.LabelBold {
			id: __questionLabel
			text: (!!sensor ? sensor.name : "undefined") + " " + qsTr("will be removed. Are you sure?")

			wrapMode: Text.WordWrap
			anchors.horizontalCenter: parent.horizontalCenter
		}

		RowLayout {
			Item {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: qsTr("Accept")
				onClicked: {
					var sensorRemoveRequestString = "users/" + Global.Application.restProvider.currentUserId()
					sensorRemoveRequestString += "/houses/" + house.id
					sensorRemoveRequestString += "/sensors"

					Global.Application.restProvider.del(sensorRemoveRequestString, sensor.id, undefined, sensorRemoved)
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
	function sensorRemoved(){
		removed()
	}
}
