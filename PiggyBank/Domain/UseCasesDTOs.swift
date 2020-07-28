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
        
        struct Request {
            
            let title: String
            
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
            
            struct Account {
                
                let id: Int
                let type: Int
                let title: String
                let currency: String
                let balance: Double
                
            }
            
            let title: String
            let account: Account
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
}
