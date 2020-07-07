import Foundation

struct UseCasesDTOs {
    
    struct SignUp {
        
        struct Request {
            
            let username: String
            let password: String
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct SignIn {
        
        struct Request {
            
            let clientID: String
            let username: String
            let password: String
            let clientSecret: String
            let scope: String
            let grantType: String
            
        }
        
        struct Response {
            
            let result: Result<String>
            
        }
        
    }
    
}
