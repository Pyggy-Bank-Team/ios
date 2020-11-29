import Foundation

final class SignInRequest: Codable {

    let userName: String
    let password: String

    init(nickname: String, password: String) {
        self.userName = nickname
        self.password = password
    }
}
