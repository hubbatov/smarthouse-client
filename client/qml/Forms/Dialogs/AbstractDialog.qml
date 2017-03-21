import QtQuick 2.6
import QtQuick.Layouts 1.1

import "Forms" as DialogForms

import "../../Controls" as Controls
import "../../Controls/FunctionalButtons" as Buttons

import "../.." as Global

Rectangle{
	id: __dialog

	color: Global.ApplicationStyle.background
	opacity: 0.95

	readonly property int mADD_MODE: 1
	readonly property int mEDIT_MODE: 2
	readonly property int mREMOVE_MODE: 3

	property int mode: mADD_MODE

	signal close()
	signal needUpdate()

	property var currentComponent: function() { return null }
	property var currentTitle: function() { return "" }

	Rectangle {

		width: parent.width - 20
		height: __mainLayout.implicitHeight

		color: Global.ApplicationStyle.header

		anchors.centerIn: parent

		Rectangle {
			width: parent.width
			height: 20
			radius: 10
			color: Global.ApplicationStyle.header

			anchors.top: parent.top
			anchors.topMargin: -10
		}

		ColumnLayout {
			id: __mainLayout

			anchors.fill: parent

			RowLayout {
				id: __headerLayout

				Component.onCompleted: {
					implicitHeight = __headerLabel.height + 40
				}

				Item {
					width: 5
				}

				Controls.LabelBold {
					id: __headerLabel
					text: currentTitle()
					color: Global.ApplicationStyle.foreground
				}

				Item {
					Layout.fillWidth: true
				}
			}

			Loader {
				id: __formLoader
				Layout.fillWidth: true
				sourceComponent: currentComponent()
			}
		}
	}

	function enterAddMode() {
		mode = mADD_MODE
		visible = true
	}

	function enterEditMode() {
		mode = mEDIT_MODE
		visible = true
	}

	function enterRemoveMode() {
		mode = mREMOVE_MODE
		visible = true
	}

	function success(){
		__dialog.needUpdate()
		closeDialog()
	}

	function closeDialog(){
		visible = false
		__dialog.close()
	}
}

