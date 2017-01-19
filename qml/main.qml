import QtQuick 2.6
import Qt.labs.controls 1.0

import "Forms" as Forms
import "." as Global

ApplicationWindow {
    id: __window

    visible: true

    width: 720
    height: 600

    title: qsTr("Anybody here?")

    color: "#5EBCDC"

    header: Forms.HeaderForm {
        width: __window.width
        visible: __mainForm.visible

        onLogout: {
            __mainForm.visible = false
            __loginForm.visible = true
        }
    }

    Flickable {

        contentWidth: __content.cntWidth()
        contentHeight: __content.cntHeigth()

        anchors.fill: parent

        Item {
            id: __content

            width: __content.cntWidth()
            height: __content.cntHeigth()

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

            function cntWidth(){
                return __window.width
            }

            function cntHeigth(){
                if(__loginForm.visible) return __loginForm.height
                if(__registerForm.visible) return __registerForm.height
                if(__mainForm.visible) return __mainForm.height
                return 0
            }
        }
    }
}
