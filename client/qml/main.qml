import QtQuick 2.6
import Qt.labs.controls 1.0

import "Forms" as Forms
import "." as Global

ApplicationWindow {
	id: __window

	visible: true

	width: 720
	height: 600

	title: qsTr("Smarthouse")

	color: Global.ApplicationStyle.background

	header: Forms.HeaderForm {
		width: __window.width
		visible: __mainForm.visible

		onLogout: {
			__mainForm.visible = false
			__loginForm.visible = true
		}
	}

	Item {
		id: __content

		anchors.fill: parent

		Forms.LoginForm {
			id: __loginForm
			visible: true
			anchors.fill: parent

			onLoggedIn: {
				__loginForm.visible = false
				__mainForm.visible = true

				__mainForm.showHouses()
			}

			onNeedRegister: {
				__loginForm.visible = false
				__registerForm.visible = true
			}
		}

		Forms.RegisterForm {
			id: __registerForm
			visible: false
			anchors.fill: parent

			onCanLogin: {
				__registerForm.visible = false
				__loginForm.visible = true
			}
		}

		Forms.MainForm {
			id: __mainForm
			visible: false
			anchors.fill: parent
		}
	}
}
