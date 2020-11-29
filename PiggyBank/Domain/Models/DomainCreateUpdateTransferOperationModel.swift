import Foundation

final class DomainCreateUpdateTransferOperationModel {

    let createdOn: Date
    let from: Int
    let to: Int
    let amount: Int
    let comment: String

    init(createdOn: Date, from: Int, to: Int, amount: Int, comment: String) {
        self.createdOn = createdOn
        self.from = from
        self.to = to
        self.amount = amount
        self.comment = comment
    }

}
