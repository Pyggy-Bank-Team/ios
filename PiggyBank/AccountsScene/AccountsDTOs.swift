import Foundation

struct AccountsDTOs {
    
    struct ViewDidLoad {
        
        struct Request { }
        
        struct Response {
            
            struct Title {
                
                let title: String
                
            }
            
            struct Accounts {
                
                struct Account {
                    
                    let id: Int
                    let type: Int
                    let title: String
                    let currency: String
                    let total: Double
                    let isArchived: Bool
                    
                }
                
                let accounts: [Account]
                
            }
            
        }
        
    }
    
    struct OnAdd {
        
        struct Request {
            
            let title: String
            
        }
        
        struct Response {
            
            let title: String
            
        }
        
    }
    
    struct OnArchiveAccount {
        
        struct Request {
            
            let index: Int
            
        }
        
        struct Response { }
        
    }
    
    struct OnDeleteAccount {
        
        struct Request {
            
            let index: Int
            
        }
        
        struct Response { }
        
    }
    
    struct OnRenameAccount {
        
        struct Request {
            
            let index: Int
            let title: String
            
        }
        
        struct Response { }
        
    }
    
}
