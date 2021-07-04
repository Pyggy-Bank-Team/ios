import Foundation

final class DomainAccountModel {
    
    enum AccountType: Int {
        
        case cash = 1
        case card = 2
        
    }

    let id: Int?
    let type: AccountType
    let title: String
    let currency: String?
    let balance: Double
    let isArchived: Bool
    let isDeleted: Bool
    
    init(id: Int?, type: Int, title: String, currency: String?, balance: Double, isArchived: Bool, isDeleted: Bool) {
        self.id = id
        self.type = AccountType(rawValue: type)!
        self.title = title
        self.currency = currency
        self.balance = balance
        self.isArchived = isArchived
        self.isDeleted = isDeleted
    }
    
    init(title: String, currency: String) {
        self.id = nil
        self.type = .cash
        self.title = title
        self.currency = currency
        self.balance = 0
        self.isArchived = false
        self.isDeleted = false
    }
    
    // swiftlint:disable discouraged_optional_boolean
    func update(type: AccountType? = nil, title: String? = nil, isArchived: Bool? = nil) -> DomainAccountModel {
        let newType = type ?? self.type
        let newTitle = title ?? self.title
        let newArchived = isArchived ?? self.isArchived
        
        return DomainAccountModel(id: id,
                                  type: newType.rawValue,
                                  title: newTitle,
                                  currency: currency,
                                  balance: balance,
                                  isArchived: newArchived,
                                  isDeleted: isDeleted)
    }
    
}
