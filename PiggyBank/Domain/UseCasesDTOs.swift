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
    
    struct GetCategories {
        
        struct Request { }
        
        struct Response {
            
            struct Category {
                
                enum CategoryType: Int {
                    
                    case income = 0
                    case outcome
                    
                }
                
                let id: Int
                let title: String
                let hexColor: String
                let type: CategoryType
                let isArchived: Bool
                
                init(id: Int, title: String, hexColor: String, type: Int, isArchived: Bool) {
                    self.id = id
                    self.title = title
                    self.hexColor = hexColor
                    self.type = CategoryType(rawValue: type) ?? .income
                    self.isArchived = isArchived
                }
                
            }
            
            let result: Result<[DomainCategoryModel]>
            
        }
        
    }
    
    struct CreateCategory {
        
        struct Request {
            
            let title: String
            let hexColor: String
            let type: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct ArchiveCategory {
        
        struct Request {
            
            let id: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct DeleteCategory {
        
        struct Request {
            
            let id: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    struct ChangeCategory {
        
        struct Request {
            
            let categoryID: Int
            let categoryTitle: String
            let categoryColor: String
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
}
