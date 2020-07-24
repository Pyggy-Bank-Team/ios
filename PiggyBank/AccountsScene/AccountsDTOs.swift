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
                    
                    let title: String
                    let currency: String
                    let total: Double
                    
                }
                
                let accounts: [Account]
                
            }
            
        }
        
    }
    
}
