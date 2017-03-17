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
	color: Global.ApplicationStyle.frame

	height: __mainLayout.implicitHeight + 30

	signal editRequest(var house, var command)
	signal removeRequest(var house, var command)

	ListModel {
		id: __controlsModel
	}

	ColumnLayout {
		id: __mainLayout
		spacing: 10

		anchors.verticalCenter: parent.verticalCenter
		anchors.left: __delegate.left; anchors.leftMargin: 10
		anchors.right: __delegate.right; anchors.rightMargin: 10

		RowLayout{
			Layout.fillWidth: true

			Controls.LabelBold {
				id: __commandLabel
				text: !!command ? command.name : ""
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

		Flow {
			spacing: 10
			Layout.fillWidth: true

			Repeater {
				model: __controlsModel

				delegate: Controls.Button{
					text: name

					onClicked: {
						var commandRunString = "commands/do"

						var cmd = {
							"id": __delegate.command.id,
							"query": __delegate.command.query,
							"suffix": suffix,
							"type": __delegate.command.command_type,
							"body": ""
						}

						Global.Application.restProvider.post(commandRunString, JSON.stringify(cmd), parseAnswer)
					}
				}
			}
		}
	}

	function parseAnswer(ret){
		console.log(JSON.stringify(ret))
	}

	function updateControls(){
		__controlsModel.clear()

		if(!command) return
		if(!command.available_values) return

		var array = JSON.parse(command.available_values)
		if(array.length > 0){
			array.forEach(function(action, i, array){
				__controlsModel.append(action)
			})
		}
	}
}
