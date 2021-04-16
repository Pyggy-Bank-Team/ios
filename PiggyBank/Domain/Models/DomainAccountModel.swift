import Foundation

final class DomainAccountModel {
    
    enum AccountType: Int {
        case undefined = 0
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
    
}
