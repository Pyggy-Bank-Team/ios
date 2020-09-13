import Foundation

final class DomainAccountModel {
    
    enum AccountType: Int {
        
        case cash
        case card
        
    }
    
    let id: Int
    let type: AccountType
    let title: String
    let currency: String
    let balance: Double
    let isArchived: Bool
    let isDeleted: Bool
    
    init(id: Int, type: AccountType, title: String, currency: String, balance: Double, isArchived: Bool, isDeleted: Bool) {
        self.id = id
        self.type = type
        self.title = title
        self.currency = currency
        self.balance = balance
        self.isArchived = isArchived
        self.isDeleted = isDeleted
    }
    
}
