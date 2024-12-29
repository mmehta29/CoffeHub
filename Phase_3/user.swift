

import Foundation

class User: Identifiable {
    var id: String
    var name: String
    var email: String
    var username: String
    var password: String

    init() {
        id = ""
        name = ""
        email = ""
        username = ""
        password = ""
    }

    init(name: String, email: String, username: String, password: String) {
        self.id = ""
        self.name = name
        self.email = email
        self.username = username
        self.password = password
    }

    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as! String
        self.email = data["email"] as! String
        self.username = data["username"] as! String
        self.password = (data["password"] as? String) ?? ""
    }

    func toDict() -> [String: Any] {
        return [
            "name": name,
            "email": email,
            "username": username,
            "password": password
        ]
    }
}



