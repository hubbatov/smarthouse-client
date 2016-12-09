import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

ColumnLayout {

	spacing: 10

	signal logout()

	Controls.LabelBold {
		text: qsTr("Welcome %1").arg("${user}")
	}

	Controls.Button {
		text: qsTr("Logout")

		onClicked: {
			console.log("logout...")
			Global.Application.restProvider.logout()
			logout()
		}
	}

	Item {
		Layout.fillHeight: true
	}
}
