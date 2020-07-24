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
            
            let username: String
            let password: String
            
        }
        
        struct Response {
            
            let result: Result<String>
            
        }
        
    }
    
    struct GetAccounts {
        
        struct Request { }
        
        struct Response {
            
            struct Account {
                
                let title: String
                let currency: String
                let balance: Double
                
            }
            
            let result: Result<[Account]>
            
        }
        
    }
    
}
