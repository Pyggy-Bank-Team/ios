import Foundation

final class DomainSignUpModel: DomainSignInModel {
    
    let currency: String
    
    init(nickname: String, password: String, currency: String) {
        self.currency = currency
        super.init(nickname: nickname, password: password)
    }
}
