import Foundation

enum CreateUpdateAccount {

    struct Request: Codable {
        let type: Int
        let title: String
        let balance: Double
        let isArchived: Bool

        init(type: Int, title: String, balance: Double, isArchived: Bool) {
            self.type = type
            self.title = title
            self.balance = balance
            self.isArchived = isArchived
        }
    }

}
