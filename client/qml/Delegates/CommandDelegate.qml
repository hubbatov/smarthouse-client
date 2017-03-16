import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import "../Controls/FunctionalButtons" as Buttons
import "../Views" as Views
import ".." as Global

Rectangle {
	id: __delegate

	property var house: null
	property var command: null

	radius: 4
	color: Global.ApplicationStyle.background

	height: __mainLayout.implicitHeight + 30

	signal editRequest(var house, var command)
	signal removeRequest(var house, var command)

	ListModel {
		id: __controlsModel
	}

	ColumnLayout {
		id: __mainLayout
		spacing: 10

		anchors.top: __delegate.top; anchors.topMargin: 10
		anchors.left: __delegate.left; anchors.leftMargin: 10
		anchors.right: __delegate.right; anchors.rightMargin: 10

		RowLayout{
			Layout.fillWidth: true

			Controls.LabelBold {
				id: __commandLabel
				text: !!command ? command.name : ""
			}

			Repeater {
				model: __controlsModel

				delegate: Rectangle {
					border.color: "black"
					radius: 3

					implicitWidth: __textAction.width + 10
					implicitHeight: 20

					Controls.LabelBold {
						id: __textAction
						text: name
						anchors.centerIn: parent
					}

					MouseArea {
						anchors.fill: parent

						onClicked: {
							console.log(command.query + suffix)
						}
					}
				}
			}

			Item{
				Layout.fillWidth: true
			}

			Buttons.EditButton {
				onClicked: {
					editRequest(house, command)
				}
			}

			Buttons.RemoveButton {
				onClicked: {
					removeRequest(house, command)
				}
			}
		}
	}

	function updateControls(){
		__controlsModel.clear()

		if(!command) return

		var array = JSON.parse(command.available_values)
		if(array.length > 0){
			array.forEach(function(action, i, array){
				__controlsModel.append(action)
			})
		}
	}
}
