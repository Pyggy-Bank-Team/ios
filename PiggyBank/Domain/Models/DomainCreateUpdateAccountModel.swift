import Foundation

class DomainCreateUpdateAccountModel {
    
    enum AccountType: Int {
        
        case cash
        case card
        
    }
    
    let id: Int?
    let type: AccountType
    let title: String
    let currency: String
    let balance: Double
    let isArchived: Bool
    
    init(id: Int? = nil, type: AccountType, title: String, currency: String, balance: Double, isArchived: Bool) {
        self.id = id
        self.type = type
        self.title = title
        self.currency = currency
        self.balance = balance
        self.isArchived = isArchived
    }
    
}

