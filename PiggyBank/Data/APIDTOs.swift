import Foundation

struct APIDTOs {
    
    struct SignUp {
        
        struct Request: Codable {
            
            let userName: String
            let password: String
            
        }
        
    }
    
    struct GetToken {
        
        struct Request: Codable {
            
            let client_id: String
            let username: String
            let password: String
            let client_secret: String
            let scope: String
            let grant_type: String
            
        }
        
    }
    
}
