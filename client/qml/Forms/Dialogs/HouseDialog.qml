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

	Buttons.CloseButton {
		anchors.top: parent.top; anchors.topMargin: 5
		anchors.right: parent.right; anchors.rightMargin: 5

		onClicked: {
			__dialog.close()
		}
	}

	DialogForms.HouseAddForm {
		visible: mode === mADD_MODE

		onAdded: {
			success()
		}
	}

	DialogForms.HouseEditForm {
		visible: mode === mEDIT_MODE

		house: __dialog.house

		onEdited: {
			success()
		}
	}

	DialogForms.HouseRemoveForm {
		visible: mode === mREMOVE_MODE

		house: __dialog.house

		onRemoved: {
			success()
		}
	}

	function success(){
		__dialog.needUpdateHouses()
		__dialog.close()
	}
}

