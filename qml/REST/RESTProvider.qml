import QtQuick 2.6

Item {
	id: root

	property string path
	property string idField: "id"

	function list(params, callback) {
		__p.sendRequest("GET", __p.makeRequest(path, undefined, params), undefined, callback)
	}

	function get(id, params, callback) {
		if(__p.idPresent(id)) {
			__p.sendRequest("GET", __p.makeRequest(path, id, params), undefined, callback)
		}
		else {
			callback(undefined, qsTr("Invalid ") + idField)
		}
	}

	function login(value, params, callback){
		__p.sendRequest("POST", __p.makeRequest(path + "/login", undefined, params), value, callback)
	}

	function create(value, params, callback) {
		__p.sendRequest("POST", __p.makeRequest(path, undefined, params), value, callback)
	}

	function update(id, newValue, params, callback) {
		if(__p.idPresent(id)) {
			__p.sendRequest("PUT", __p.makeRequest(path, id, params), newValue, callback)
		}
		else {
			callback(undefined, qsTr("Invalid ") + idField)
		}
	}

	function del(id, params, callback) {
		if(__p.idPresent(id)) {
			__p.sendRequest("DELETE", __p.makeRequest(path, id, params), undefined, callback)
		}
		else {
			callback(undefined, qsTr("Invalid ") + idField)
		}
	}

	QtObject {
		id: __p
		function sendRequest(type, path, value, callback) {
			var request = new XMLHttpRequest()
			request.open(type, path, true)
			request.onreadystatechange = function () {
				if (request.readyState === XMLHttpRequest.DONE) {
					var res = {}
					if(successStatus(request.status)) {
						res["answer"] = request.responseText
					}else if(authorizedStatus(request.status)){
						res["answer"] = request.responseText
					}else {
						res["error"] = request.statusText
						res["errorText"] = request.responseText
					}
					callback(res)
				}
			}

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
		function makeRequest(path, id, params) {
			var ret = path
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
