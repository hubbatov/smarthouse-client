import QtQuick 2.6
import QtQuick.Layouts 1.1

import "Forms" as DialogForms

import "../../Controls" as Controls
import "../../Controls/FunctionalButtons" as Buttons

import "../.." as Global

AbstractDialog{
	id: __dialog

	property var house: null

	Component{
		id: __addFormComponent
		DialogForms.HouseAddForm {
			onAdded: success()
			onCanceled: closeDialog()
		}
	}

	Component{
		id: __editFormComponent
		DialogForms.HouseEditForm {
			house: __dialog.house
			onEdited: success()
			onCanceled: closeDialog()
		}
	}

	Component{
		id: __removeFormComponent
		DialogForms.HouseRemoveForm {
			house: __dialog.house
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
		if(mode === mADD_MODE) return qsTr("New house")
		if(mode === mEDIT_MODE) return qsTr("Edit house")
		if(mode === mREMOVE_MODE) return qsTr("Remove house")
		return ""
	}
}

