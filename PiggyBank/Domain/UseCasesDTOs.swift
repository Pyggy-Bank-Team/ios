import Foundation

enum UseCasesDTOs {
    
    enum SignUp {
        
        struct Request {
            
            let username: String
            let password: String
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    enum SignIn {
        
        struct Request {
            
            let username: String
            let password: String
            
        }
        
        struct Response {
            
            let result: Result<String>
            
        }
        
    }
    
    enum GetAccounts {
        
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
    
    enum CreateAccount {
        
        struct Request {
            
            let title: String
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    enum ArchiveAccount {
        
        struct Request {
            
            let id: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    enum DeleteAccount {
        
        struct Request {
            
            let id: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    enum RenameAccount {
        
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
    
    enum GetCategories {
        
        struct Request { }
        
        struct Response {
            
            struct Category {
                
                enum CategoryType: Int {
                    
                    case income = 0
                    case outcome = 1
                    
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
    
    enum CreateCategory {
        
        struct Request {
            
            let title: String
            let hexColor: String
            let type: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    enum ArchiveCategory {
        
        struct Request {
            
            let id: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    enum DeleteCategory {
        
        struct Request {
            
            let id: Int
            
        }
        
        struct Response {
            
            let result: Result<Void>
            
        }
        
    }
    
    enum ChangeCategory {
        
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
