pragma Singleton

import QtQuick 2.6

import "REST" as REST

QtObject{

	property string servicePath: "http://localhost:12345"

	property var usersProvider: REST.RESTProvider {
		path: servicePath + "/users"
	}
}
