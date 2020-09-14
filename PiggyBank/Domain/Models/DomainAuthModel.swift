import Foundation

final class DomainAuthModel: Codable {
    
    let accessToken: String
    let refreshToken: String
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
}
