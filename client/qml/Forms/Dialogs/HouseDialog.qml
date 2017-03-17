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

	property var house: null

	property int mode: mADD_MODE

	signal close()
	signal needUpdateHouses()

	Component{
		id: __addFormComponent
		DialogForms.HouseAddForm {
			onAdded: {
				success()
			}
			onCanceled: {
				visible = false
				closeDialog()
			}
		}
	}

	Component{
		id: __editFormComponent
		DialogForms.HouseEditForm {
			house: __dialog.house
			onEdited: {
				success()
			}
			onCanceled: {
				visible = false
				closeDialog()
			}
		}
	}

	Component{
		id: __removeFormComponent
		DialogForms.HouseRemoveForm {
			house: __dialog.house
			onRemoved: {
				success()
			}
			onCanceled: {
				closeDialog()
			}
		}
	}

	Rectangle {

		width: parent.width - 20
		height: __mainLayout.implicitHeight

		color: "#1F1E26"

		anchors.centerIn: parent

		Rectangle {
			width: parent.width
			height: 20
			radius: 10
			color: "#1F1E26"

			anchors.top: parent.top
			anchors.topMargin: -10
		}

		ColumnLayout {
			id: __mainLayout

			anchors.fill: parent

			RowLayout {
				id: __headerLayout

				implicitHeight: __headerLabel.height + 40

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

				Buttons.CloseButton {
					onClicked: {
						closeDialog()
					}
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

	function currentComponent(){
		if(mode === mADD_MODE) return __addFormComponent
		if(mode === mEDIT_MODE) return __editFormComponent
		if(mode === mREMOVE_MODE) return __removeFormComponent
		return null
	}

	function currentTitle(){
		if(mode === mADD_MODE) return qsTr("New house")
		if(mode === mEDIT_MODE) return qsTr("Edit house")
		if(mode === mREMOVE_MODE) return qsTr("Remove house")
		return ""
	}

	function success(){
		__dialog.needUpdateHouses()
		closeDialog()
	}

	function closeDialog(){
		visible = false
		__dialog.close()
	}
}

