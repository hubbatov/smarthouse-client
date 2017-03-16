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
	property var command: null

	property int mode: mADD_MODE

	signal close()
	signal needUpdateCommands()

	Buttons.CloseButton {
		anchors.top: parent.top; anchors.topMargin: 5
		anchors.right: parent.right; anchors.rightMargin: 5

		onClicked: {
			__dialog.close()
		}
	}

	DialogForms.CommandAddForm {
		visible: mode === mADD_MODE

		house: __dialog.house

		onAdded: {
			success()
		}
	}

	DialogForms.CommandEditForm {
		visible: mode === mEDIT_MODE

		house: __dialog.house
		command: __dialog.command

		onEdited: {
			success()
		}
	}

	DialogForms.CommandRemoveForm {
		visible: mode === mREMOVE_MODE

		house: __dialog.house
		command: __dialog.command

		onRemoved: {
			success()
		}
	}

	function success(){
		__dialog.needUpdateCommands()
		__dialog.close()
	}
}

