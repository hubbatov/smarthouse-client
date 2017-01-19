import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

Rectangle{
    color: "#4b7380"
    height: 50

    signal logout()

    RowLayout {

        anchors.fill: parent

        Item {
            width: 5
        }

        Controls.LabelBold {
            text: Global.Application.restProvider.currentUserName()
            anchors.verticalCenter: parent.verticalCenter
        }

        Item {
            Layout.fillWidth: true
        }

        Controls.Button {
            text: qsTr("Logout")

            width: 90

            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                console.log("logout...")
                Global.Application.restProvider.logout()
                logout()
            }
        }

        Item {
            width: 5
        }
    }
}
