import Foundation

enum Account {

    final class Response: Codable {
        let id: Int
        let type: Int
        let title: String
        let currency: String
        let balance: Double
        let isArchived: Bool
        let isDeleted: Bool
    }

}
