import Foundation

final class UserCredentialsResponse: Decodable {
    
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken
        case refreshToken
        
        case access_token
        case refresh_token
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? values.decodeIfPresent(String.self, forKey: .accessToken) {
            accessToken = value
        } else {
            accessToken = try! values.decode(String.self, forKey: .access_token)
        }
        
        if let value = try? values.decodeIfPresent(String.self, forKey: .refreshToken) {
            refreshToken = value
        } else {
            refreshToken = try! values.decode(String.self, forKey: .refresh_token)
        }
    }
    
}
