import Foundation

struct AuthDTOs {
    
    struct ViewDidLoad {
        
        struct Request { }
        
        struct Response {
            
            let screenTitle: String
            let hintActionTitle: String
            
        }
        
    }
    
    struct PrimaryAction {
        
        struct Request {
            
            let username: String
            let password: String
            
        }
        
        struct Response {
            
            let message: String
            
        }
        
    }
    
}
