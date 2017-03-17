import QtQuick 2.6
import QtQuick.Layouts 1.1

import "Forms" as DialogForms

import "../../Controls" as Controls
import "../../Controls/FunctionalButtons" as Buttons

import "../.." as Global

AbstractDialog{
	id: __dialog

	property var house: null
	property var sensor: null

	Component{
		id: __addFormComponent
		DialogForms.SensorAddForm {
			house: __dialog.house
			onAdded: success()
			onCanceled: closeDialog()
		}
	}

	Component {
		id: __editFormComponent
		DialogForms.SensorEditForm {
			house: __dialog.house
			sensor: __dialog.sensor
			onEdited: success()
			onCanceled: closeDialog()
		}
	}

	Component {
		id: __removeFormComponent
		DialogForms.SensorRemoveForm {
			house: __dialog.house
			sensor: __dialog.sensor
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
		if(mode === mADD_MODE) return qsTr("New sensor")
		if(mode === mEDIT_MODE) return qsTr("Edit sensor")
		if(mode === mREMOVE_MODE) return qsTr("Remove sensor")
		return ""
	}
}

