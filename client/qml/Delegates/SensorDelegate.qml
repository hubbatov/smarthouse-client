import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import "../Views" as Views
import ".." as Global

Rectangle {
	id: __delegate

	property var sensor: null

	radius: 4
	color: Global.ApplicationStyle.background

	height: __mainLayout.height + 30
	width: 200

	ColumnLayout {
		id: __mainLayout
		spacing: 10

		anchors.top: __delegate.top; anchors.topMargin: 10
		anchors.left: __delegate.left; anchors.leftMargin: 10
		anchors.right: __delegate.right; anchors.rightMargin: 10

		Controls.LabelBold {
			id: __sensorLabel
			text: !!sensor.name ? qsTr("%1").arg(sensor.name) : ""
		}

		RowLayout {
			id: __dataLayout
			spacing: 10


			Views.RoundPercents {
				Layout.preferredHeight: 80
				Layout.preferredWidth: 80
			}

			Views.NumericChart {
				Layout.preferredHeight: 80
				Layout.fillWidth: true
			}
		}

	}
}
