import Foundation

// expected on server side
// {
//  "userName": "string",
//  "password": "string",
//  "currencyBase": "string",
//  "email": "string",
//  "locale": "string"
// }

enum SignUp {

    struct Request: Codable {

        let userName: String
        let password: String
        let currencyBase: String
        let email: String

        init(nickname: String, password: String, currency: String, email: String) {
            self.userName = nickname
            self.password = password
            self.currencyBase = currency
            self.email = email
        }
    }

}
