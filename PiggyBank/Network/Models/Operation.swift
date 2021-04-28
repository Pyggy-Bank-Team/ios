import Foundation

enum Operation {

    struct Response: Codable {
        struct AccountInfo: Codable {
            let title: String
            let currency: String
        }

        struct CategoryInfo: Codable {
            let type: Int
            let hexColor: String
            let title: String
        }

        let id: UInt
        let isDeleted: Bool
        let account: AccountInfo
        let toAcount: AccountInfo?
        let category: CategoryInfo?
        let amount: Double
        let type: UInt
        let date: String
        let comment: String?
    }
}
