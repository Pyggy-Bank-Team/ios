import Foundation

final class DomainSignUpModel {
    
    let nickname: String
    let password: String
    let currency: String
    
    init(nickname: String, password: String, currency: String) {
        self.nickname = nickname
        self.password = password
        self.currency = currency
    }
    
}
