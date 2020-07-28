import Foundation

struct APIDTOs {
    
    struct SignUp {
        
        struct Request: Codable {
            
            let userName: String
            let password: String
            
        }
        
        struct Response  {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct SignIn {
        
        struct Request: Codable {
            
            let client_id: String
            let username: String
            let password: String
            let client_secret: String
            let scope: String
            let grant_type: String
            
        }
        
        struct Response  {
            
            let result: Result<String>
            
        }
        
    }
    
    struct GetAccounts {
        
        struct Request { }
        
        struct Response {
            
            struct Account {
                
                let id: Int
                let type: Int
                let title: String
                let currency: String
                let balance: Double
                let isArchived: Bool
                
            }
            
            let result: Result<[Account]>
            
        }
        
    }
    
    struct CreateAccount {
        
        struct Request: Codable {
            
            let title: String
            let type: Int
            let currency: String
            let balance: Double
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct ArchiveAccount {
        
        struct Request {
            
            let id: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct DeleteAccount {
        
        struct Request {
            
            let id: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct RenameAccount {
        
        struct Request {
            
            struct Account: Codable {
                
                let id: Int
                let type: Int
                let title: String
                let currency: String
                let balance: Double
                
            }
            
            let account: Account
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
}
