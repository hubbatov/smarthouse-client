import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

import "./Graphs" as Graphs
import "./Controls" as Controls

Window {
	visible: true
	width: 640
	height: 480
	title: qsTr("SmartHouse widgets")

	Flickable{

		anchors.fill: parent

		contentHeight: __layout.implicitHeight
		contentWidth: parent.width

		Flow{
			id: __layout
			spacing: 10

			anchors.fill: parent

			Controls.RoundPercents {
				id: __percents

				Timer {
					interval: 1000
					repeat: true
					running: true
					onTriggered: {
						var value = Math.abs(Math.random()) * 100
						parent.value = value
						__graph.addValue(Date.now().toString(), value)
					}
				}
			}

			Graphs.NumericChart {
				id: __graph

				Component.onCompleted: {
					for(var i = 0; i < 100; ++i){
						var value = Math.abs(Math.random()) * 100
						__graph.addValue(Date.now().toString(), value)
					}
				}
			}

			ControlsExternal.TextInput{
				width: 200
			}
		}
	}
}
