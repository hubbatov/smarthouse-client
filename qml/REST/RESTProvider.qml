import QtQuick 2.6

Item {
	id: root

	property string path
	property string idField: "id"

	function list(suffix, params, callback) {
		__p.sendRequest("GET", __p.makeRequest(path, suffix, undefined, params), undefined, callback)
	}

	function get(suffix, id, params, callback) {
		if(__p.idPresent(id)) {
			__p.sendRequest("GET", __p.makeRequest(path, suffix, id, params), undefined, callback)
		}
		else {
			callback(undefined, qsTr("Invalid ") + idField)
		}
	}

	function login(value, params, callback){
		__p.sendRequest("POST", __p.makeRequest(path + "/login", undefined, undefined, params), value, callback)
	}

	function logout(){
		__p.login = ""
		__p.password = ""
	}

	function create(suffix, value, params, callback) {
		__p.sendRequest("POST", __p.makeRequest(path, suffix, undefined, params), value, callback)
	}

	function update(suffix, id, newValue, params, callback) {
		if(__p.idPresent(id)) {
			__p.sendRequest("PUT", __p.makeRequest(path, suffix, id, params), newValue, callback)
		}
		else {
			callback(undefined, qsTr("Invalid ") + idField)
		}
	}

	function del(suffix, id, params, callback) {
		if(__p.idPresent(id)) {
			__p.sendRequest("DELETE", __p.makeRequest(path, suffix, id, params), undefined, callback)
		}
		else {
			callback(undefined, qsTr("Invalid ") + idField)
		}
	}

	QtObject {
		id: __p

		property string login: ""
		property string password: ""
		property string accessToken: (login && password) ? Qt.btoa(login + ":" + password) : ""

		function sendRequest(type, path, value, callback) {
			var request = new XMLHttpRequest()
			request.open(type, path, true)
			request.onreadystatechange = function () {
				if (request.readyState === XMLHttpRequest.DONE) {
					var res = {}
					if(successStatus(request.status)) {
						res["answer"] = request.responseText
					}else if(authorizedStatus(request.status)){
						login = value.login
						password = value.password
						res["answer"] = request.responseText
					}else {
						res["error"] = request.statusText
						res["errorText"] = request.responseText
					}
					callback(res)
				}
			}

			if(!!accessToken)
				request.setRequestHeader("Authorization", "Basic " + accessToken)

			if(!!value) {
				var arg = (typeof value !== "string") ? JSON.stringify(value) : value
				request.setRequestHeader("Content-Type", "application/json")
				request.setRequestHeader("Content-Length", arg.length)
				request.send(arg)
			}
			else {
				request.send()
			}
		}
		function makeRequest(path, suffix, id, params) {
			var ret = path

			if(typeof suffix === "string" && suffix.length > 0){
				ret += ("/" + suffix)
			}

			if(typeof id === "string" && id.length > 0) {
				ret += ("/" + id)
			}
			else if(typeof id === "number") {
				ret += ("/" + String(id))
			}
			if(typeof params === "string") {
				ret += "?" + params
			}
			else {
				ret += ""
			}
			return ret
		}
		function successStatus(status) {
			return [ 200, 201, 301, 304 ].some(function(s) { return s === status });
		}
		function authorizedStatus(status) {
			return [ 202 ].some(function(s) { return s === status });
		}

		function idPresent(id) {
			return id !== undefined;
		}
	}
}
