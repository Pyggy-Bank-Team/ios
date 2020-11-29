import Foundation

final class DomainAuthModel: Codable {
    
    let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
}
