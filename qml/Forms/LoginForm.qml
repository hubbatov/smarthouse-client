import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

ColumnLayout {
	spacing: 10

	signal loggedIn()
	signal needRegister()

	Controls.LabelBold {
		text: qsTr("Username")
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __loginInput
	}

	Controls.LabelBold {
		text: qsTr("Password")
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __passwordInput
		echoMode: TextInput.Password
	}

	Controls.Button {
		text: qsTr("Login")

		enabled: __loginInput.text && __passwordInput.text

		onClicked: {
			console.log("login...")

			var userdata = {
				"login": __loginInput.text,
				"password": __passwordInput.text
			}

			Global.Application.usersProvider.login(userdata, undefined, processLoginReply)
		}
	}

	Controls.Button {
		text: qsTr("Register")

		onClicked: {
			console.log("register request...")
			needRegister()
			clearFields()
		}
	}

	Item {
		Layout.fillHeight: true
	}


	function processLoginReply(reply, error){
		console.log(JSON.stringify(reply))

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
