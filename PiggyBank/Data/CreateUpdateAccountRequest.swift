import Foundation

final class CreateUpdateAccountRequest: Codable {
    
    let type: Int
    let title: String
    let currency: String
    let balance: Double
    let isArchived: Bool
    
    init(type: Int, title: String, currency: String, balance: Double, isArchived: Bool) {
        self.type = type
        self.title = title
        self.currency = currency
        self.balance = balance
        self.isArchived = isArchived
    }
    
}
