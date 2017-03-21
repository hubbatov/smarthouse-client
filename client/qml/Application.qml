pragma Singleton

import QtQuick 2.6

import "REST" as REST

QtObject{
	id: __root

	property string servicePath: "http://192.168.1.100:12345"
	signal loggedIn()

	property var restProvider: REST.RESTProvider {
		path: servicePath
		onLoggedIn: __root.loggedIn()
	}
}
