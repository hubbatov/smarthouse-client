import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

Rectangle {
    id: __delegate

    property var sensor: null

    radius: 4
    color: "transparent"
    border.color: "black"

    implicitHeight: 40
    implicitWidth: Global.ApplicationStyle.screenSize.width - 40

    ColumnLayout {
        id: __sensorDelegateLayout

        spacing: 5
        anchors.fill: parent
        anchors.margins: 10

        Controls.LabelBold {
            text: !!sensor.name ? qsTr("* %1").arg(sensor.name) : ""
        }
    }
}
