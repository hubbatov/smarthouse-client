import QtQuick 2.6
import QtQuick.Layouts 1.1

import "Forms" as DialogForms

import "../../Controls" as Controls
import "../../Controls/FunctionalButtons" as Buttons

import "../.." as Global

AbstractDialog{
	id: __dialog

	property var house: null
	property var command: null

	Component{
		id: __addFormComponent
		DialogForms.CommandAddForm {
			house: __dialog.house
			onAdded: success()
			onCanceled: closeDialog()
		}
	}

	Component {
		id: __editFormComponent
		DialogForms.CommandEditForm {
			house: __dialog.house
			command: __dialog.command
			onEdited: success()
			onCanceled: closeDialog()
		}
	}

	Component {
		id: __removeFormComponent
		DialogForms.CommandRemoveForm {
			house: __dialog.house
			command: __dialog.command
			onRemoved: success()
			onCanceled: closeDialog()
		}
	}

	currentComponent: function(){
		if(mode === mADD_MODE) return __addFormComponent
		if(mode === mEDIT_MODE) return __editFormComponent
		if(mode === mREMOVE_MODE) return __removeFormComponent
		return null
	}

	currentTitle: function(){
		if(mode === mADD_MODE) return qsTr("New command")
		if(mode === mEDIT_MODE) return qsTr("Edit command")
		if(mode === mREMOVE_MODE) return qsTr("Remove command")
		return ""
	}
}

