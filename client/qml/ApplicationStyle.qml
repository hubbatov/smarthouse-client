pragma Singleton

import QtQuick 2.6

QtObject{

	property color background: "#2D2B36"
	property color backgroundHeader: "#2D2B36"
	property color foreground: "#BABABC"
	property color contrast: "#3E91DF"
	property color disabled: "#CFCFCF"
	property color border: "#3E91DF"
	property color positive: "#64C11D"
	property color negative: "#FC4A3A"
	property color frame: "#524F63"
	property color header: "#1F1E26"

	property int baseFontSize: 20
	property int iconSize: 32

	readonly property string primary_family: "Open Sans"
	readonly property string secondary_family: "PT Sans"

	readonly property font regularFont: Qt.font({
													family: primary_family,
													pixelSize: baseFontSize,
													weight: Font.Normal
												})
	readonly property font boldFont: Qt.font({
												 family: primary_family,
												 pixelSize: baseFontSize,
												 weight: Font.Bold
											 })
	readonly property font italicFont: Qt.font({
												   family: primary_family,
												   pixelSize: baseFontSize,
												   weight: Font.Normal,
												   italic: true
											   })
	readonly property font smallFont: Qt.font({
												  family: primary_family,
												  pixelSize: baseFontSize - 4,
												  weight: Font.Normal
											  })
	readonly property font bigFont: Qt.font({
												family: primary_family,
												pixelSize: baseFontSize + 2,
												weight: Font.Normal
											})
	readonly property font heading_1Font: Qt.font({
													  family: primary_family,
													  pixelSize: baseFontSize + 10,
													  weight: Font.Bold
												  })
	readonly property font heading_2Font: Qt.font({
													  family: primary_family,
													  pixelSize: baseFontSize + 8,
													  weight: Font.Bold
												  })
	readonly property font heading_3Font: Qt.font({
													  family: primary_family,
													  pixelSize: baseFontSize + 6,
													  weight: Font.Bold
												  })

	Component.onCompleted: {
		if(Qt.platform.os === "linux" || Qt.platform.os === "windows" || Qt.platform.os === "osx" || Qt.platform.os === "unix"){
			baseFontSize = 20
			iconSize = 32
		}else{
			baseFontSize = 36
			iconSize = 64
		}
	}
}
