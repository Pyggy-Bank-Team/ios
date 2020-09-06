import Foundation

struct CategoriesDTOs {
    
    struct ViewDidLoad {
        
        struct Request { }
        
        struct Response {
            
            let categories: [CategoryViewModel]
            
        }
        
    }
    
    struct CreateCategory {
        
        struct Request {
            
            let title: String
            let type: Int
            let color: String
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct OnArchiveCategory {
        
        struct Request {
            
            let index: Int
            
        }
        
        struct Response { }
        
    }
    
    struct OnDeleteCategory {
        
        struct Request {
            
            let index: Int
            
        }
        
        struct Response { }
        
    }
    
    struct OnChangeCategory {
        
        struct Request {
            
            let index: Int
            let title: String
            let color: String
            
        }
        
        struct Response { }
        
    }
    
}
