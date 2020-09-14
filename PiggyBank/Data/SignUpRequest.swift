import Foundation

final class SignUpRequest: Codable {
    
    let userName: String
    let password: String
    let currencyBase: String
    
    init(nickname: String, password: String, currency: String) {
        self.userName = nickname
        self.password = password
        self.currencyBase = currency
    }
    
}
