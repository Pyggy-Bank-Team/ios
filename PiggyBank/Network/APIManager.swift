import Foundation

struct APIError: Error { }

public final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    let baseURL = "https://dev.piggybank.pro"
    
    private(set) lazy var token = UserDefaults.standard.string(forKey: kCREDENTIALS_STORE_KEY) ?? ""

    func setToken(token: String) {
        self.token = token
    }
}
