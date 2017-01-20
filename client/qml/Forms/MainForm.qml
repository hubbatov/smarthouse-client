import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

Item {
	HousesForm {
		id: __housesForm

		anchors.fill: parent
	}

	function showHouses(){
		__housesForm.updateModel()
	}
}
