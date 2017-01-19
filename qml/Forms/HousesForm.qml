import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import "../Delegates" as Delegates
import ".." as Global

Item{
    implicitHeight: __housesFormLayout.implicitHeight
    implicitWidth: __housesFormLayout.implicitWidth

    ColumnLayout {
        id: __housesFormLayout

        spacing: 10
        anchors.fill: parent
        anchors.margins: 10

        ListView {
            id: __housesView

            model: __housesModel

            delegate: Delegates.HouseDelegate {
                house: __housesModel.get(index)

                Component.onCompleted: {
                    updateModel()
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    ListModel {
        id: __housesModel
    }

    function updateModel(){
        __housesModel.clear()

        var housesRequestString = "users/" + Global.Application.restProvider.currentUserId()
        housesRequestString += "/houses"
        Global.Application.restProvider.list(housesRequestString, undefined, fillModel)
    }

    function fillModel(response){
        console.log("get houses reply: ", JSON.stringify(response))
        if("answer" in response){
            var houses = JSON.parse(response.answer)
            if(houses.length){
                for( var i = 0; i < houses.length; ++i){
                    __housesModel.append(houses[i])
                }
            }
        }
    }
}
