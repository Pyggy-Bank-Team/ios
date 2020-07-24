import Foundation

final class SignInResponse: Codable {
    
    let access_token: String
    let expires_in: Date
    let token_type: String
    let refresh_token: String
    let scope: String
    
}
