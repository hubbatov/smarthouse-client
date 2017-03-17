import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

Rectangle{
	color: Global.ApplicationStyle.backgroundHeader
	height: __layout.implicitHeight

	signal logout()

	ColumnLayout {
		id: __layout
		anchors.fill: parent

		Item {
			height: 5
		}

		RowLayout {

			Layout.fillWidth: true

			Item {
				width: 5
			}

			Controls.LabelHeader {
				text: qsTr("Smarthouse")
				anchors.verticalCenter: parent.verticalCenter
			}

			Item {
				Layout.fillWidth: true
			}

			Controls.Button {
				text: qsTr("Logout")
				anchors.verticalCenter: parent.verticalCenter

				color: Global.ApplicationStyle.negative

				onClicked: {
					Global.Application.restProvider.logout()
					logout()
				}
			}

			Item {
				width: 5
			}
		}

		Rectangle {
			color: Global.ApplicationStyle.contrast
			Layout.fillWidth: true
			height: 3
			radius: 1.
		}

		Item {
			height: 5
		}
	}
}
