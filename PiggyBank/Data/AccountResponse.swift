import Foundation

final class AccountResponse: Codable {
    
    let id: Int
    let type: Int
    let title: String
    let currency: String
    let balance: Double
    let isArchived: Bool
    
}
