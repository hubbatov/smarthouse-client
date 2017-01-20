import QtQuick 2.5
import ".." as Global

Item{
    id: __control

    property color background: Global.ApplicationStyle.background
    property color foreground: Global.ApplicationStyle.foreground

    property int value: 0

    implicitWidth: 200
    implicitHeight: 200

    Rectangle {
        id: __backgroundCircle

        color: background

        anchors.centerIn: parent

        width: __control.width
        height: __control.height

        Text {
            color: foreground
            font.pixelSize: parent.width * 0.15
            text: value + "°C"

            anchors.centerIn: parent
        }
    }
}
