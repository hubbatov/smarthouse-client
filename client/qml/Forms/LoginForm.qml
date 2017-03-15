import QtQuick 2.6
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

import "../Controls" as Controls
import ".." as Global

Item{
	implicitHeight: __loginFormLayout.implicitHeight

	signal loggedIn()
	signal needRegister()

	ColumnLayout {
		id: __loginFormLayout
		spacing: 10
		anchors.fill: parent

		Settings {
			id: __settings
			property alias login: __loginInput.text
		}

		Item {
			Layout.fillHeight: true
		}

		Controls.LabelBold {
			text: qsTr("Username")
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Controls.TextInput {
			id: __loginInput
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Controls.LabelBold {
			text: qsTr("Password")
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Controls.TextInput {
			id: __passwordInput
			echoMode: TextInput.Password
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Controls.Button {
			id: __loginButton

			text: qsTr("Login")

			enabled: __loginInput.text && __passwordInput.text
			anchors.horizontalCenter: parent.horizontalCenter

			onClicked: {
				console.log("login...")

				var userdata = {
					"login": __loginInput.text,
					"password": __passwordInput.text
				}

				Global.Application.restProvider.login(userdata, undefined, processLoginReply)
			}
		}

		Controls.Button {
			text: qsTr("Register")
			anchors.horizontalCenter: parent.horizontalCenter

			onClicked: {
				console.log("register request...")
				needRegister()
				clearFields()
			}
		}

		Item {
			Layout.fillHeight: true
		}
	}

	function processLoginReply(reply, error){
		if("error" in reply){
		}else{
			loggedIn()
		}
		clearFields()
	}

	function clearFields(){
		__passwordInput.text = ""
	}
}
