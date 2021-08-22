import Foundation

final class DomainSignUpModel: DomainSignInModel {
    
    let currency: String
    let email: String

    init(nickname: String, password: String, currency: String, email: String) {
        self.currency = currency
        self.email = email
        super.init(nickname: nickname, password: password)
    }
}
