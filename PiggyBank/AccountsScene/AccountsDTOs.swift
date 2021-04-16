import Foundation

enum AccountsDTOs {
    
    enum ViewDidLoad {
        
        struct Request { }
        
        enum Response {
            
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
    
    enum OnAdd {
        
        struct Request {
            
            let title: String
            
        }
        
        struct Response {
            
            let title: String
            
        }
        
    }
    
}
