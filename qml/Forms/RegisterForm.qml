import QtQuick 2.6
import QtQuick.Layouts 1.1

import "../Controls" as Controls
import ".." as Global

ColumnLayout {
	spacing: 10

	signal canLogin()

	Controls.LabelBold {
		text: qsTr("Username")
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __usernameInput
	}

	Controls.LabelBold {
		text: qsTr("Login")
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

	Controls.LabelBold {
		text: qsTr("Repeat password")
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Controls.TextInput {
		id: __passwordRepeatInput
		echoMode: TextInput.Password
	}

	Controls.Button {
		text: qsTr("Register")

		enabled: validateForm()

		onClicked: {
			console.log("register...")

			var userdata = {
				"name": __usernameInput.text,
				"login": __loginInput.text,
				"password": __passwordInput.text
			}

			Global.Application.usersProvider.create("users", userdata, undefined, processRegisterReply)
		}
	}

	Controls.Button {
		text: qsTr("Login")

		enabled: __loginInput.text && __passwordInput.text

		onClicked: {
			console.log("can login...")
			canLogin()
			clearFields()
		}
	}

	Item {
		Layout.fillHeight: true
	}

	function processRegisterReply(reply, error){
		console.log(JSON.stringify(reply))

		if("error" in reply){

		}else{
			canLogin()
		}
		clearFields()
	}

	function validateForm(){
		var a = __loginInput.text && __passwordInput.text && __passwordRepeatInput.text && __usernameInput.text
		var b = __passwordInput.text == __passwordRepeatInput.text

		return a && b
	}

	function clearFields(){
		__usernameInput.text = ""
		__loginInput.text = ""
		__passwordInput.text = ""
		__passwordRepeatInput.text = ""
	}
}
