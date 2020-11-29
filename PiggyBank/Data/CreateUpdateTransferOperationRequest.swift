import Foundation

final class CreateUpdateTransferOperationRequest: Codable {

    let createdOn: String
    let from: Int
    let to: Int
    let amount: Int
    let comment: String

    init(createdOn: String, from: Int, to: Int, amount: Int, comment: String) {
        self.createdOn = createdOn
        self.from = from
        self.to = to
        self.amount = amount
        self.comment = comment
    }

}
