import Foundation

final class DomainUserCredentialsModel: Codable {
    
    private let nickname: String
    private let accessToken: String
    private let refreshToken: String
    
    init(nickname: String, accessToken: String, refreshToken: String) {
        self.nickname = nickname
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
}
