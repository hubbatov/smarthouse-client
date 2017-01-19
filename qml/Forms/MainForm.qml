import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

Item {
    implicitHeight: __layout.implicitHeight

    ColumnLayout {
        id: __layout

        spacing: 10
        anchors.fill: parent

        HousesForm {
            id: __housesForm

            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    function showHouses(){
        __housesForm.updateModel()
    }
}
