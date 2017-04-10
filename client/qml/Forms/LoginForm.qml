import QtQuick 2.6
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

import "../Controls" as Controls
import ".." as Global

Item{
	implicitHeight: __loginFormLayout.implicitHeight

	signal loggedIn()
	signal needRegister()

	Connections {
		target: Global.Application
		onLoggedIn: {
			loggedIn()
		}
	}

	Settings {
		id: __settings
		property alias login: __loginInput.text
		property alias password: __passwordInput.text
	}

	ColumnLayout {
		id: __loginFormLayout
		spacing: 10

		anchors.margins: 10
		anchors.fill: parent

		Item{
			Layout.fillHeight: true
		}

		GridLayout {
			columns: 2

			columnSpacing: 10
			rowSpacing: 20

			Layout.fillWidth: true
			Component.onCompleted: {
				implicitHeight = __loginInput.height +
							__passwordInput.height + 60
			}

			Controls.LabelBold {
				text: qsTr("Username")
			}

			Controls.TextInput {
				id: __loginInput
				Layout.fillWidth: true
			}

			Controls.LabelBold {
				text: qsTr("Password")
			}

			Controls.TextInput {
				id: __passwordInput
				echoMode: TextInput.Password
				Layout.fillWidth: true
			}
		}

		RowLayout {
			Controls.Button {
				text: qsTr("Login")
				enabled: __loginInput.text && __passwordInput.text
				Layout.fillWidth: true

				onClicked: {
					tryLogin()
				}
			}

			Controls.Button {
				text: qsTr("Register")
				Layout.fillWidth: true

				onClicked: {
					console.log("register request...")
					needRegister()
					clearFields()
				}
			}
		}

		Item{
			Layout.fillHeight: true
		}
	}

	function tryLogin(){
		if(Global.Application.restProvider.currentUserId() !== 0) return

		var userdata = {
			"login": __loginInput.text,
			"password": __passwordInput.text
		}

		Global.Application.restProvider.login(userdata, undefined, processLoginReply)
	}

	function processLoginReply(reply){
		clearFields()
	}

	function clearFields(){
		__passwordInput.text = ""
	}

	Component.onCompleted: {
		if(__settings.login && __settings.password){
			tryLogin()
		}
	}

	Component.onDestruction: {
		__settings.login = Global.Application.restProvider.currentUserLogin()
		__settings.password = Global.Application.restProvider.currentUserPassword()
	}
}
