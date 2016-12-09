import QtQuick 2.6
import QtQuick.Window 2.2

import "Forms" as Forms
import "." as Global

Window {
	visible: true
	width: 480
	height: 720

	minimumHeight: 480
	minimumWidth: 360

	title: qsTr("Anybody here?")

	color: "#5EBCDC"

	Item {
		anchors.fill: parent

		Forms.LoginForm {
			id: __loginForm
			visible: true
			anchors.centerIn: parent

			onLoggedIn: {
				__loginForm.visible = false
				__mainForm.visible = true
			}

			onNeedRegister: {
				__loginForm.visible = false
				__registerForm.visible = true
			}
		}

		Forms.RegisterForm {
			id: __registerForm
			visible: false
			anchors.centerIn: parent

			onCanLogin: {
				__registerForm.visible = false
				__loginForm.visible = true
			}
		}

		Forms.MainForm {
			id: __mainForm
			visible: false
			anchors.centerIn: parent

			onLogout: {
				__mainForm.visible = false
				__loginForm.visible = true
			}
		}
	}

}
