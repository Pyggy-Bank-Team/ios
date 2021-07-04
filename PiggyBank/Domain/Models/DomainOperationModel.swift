import Foundation

final class DomainOperationModel {
    
    enum OperationType: UInt {

        case budget = 1
        case transfer = 2

    }

    let id: UInt
    let amount: Double
    let comment: String?
    let type: OperationType
    let date: Date
    let isDeleted: Bool
    let category: DomainCategoryModel?
    let fromAccount: DomainAccountModel
    let toAccount: DomainAccountModel?
    
    init(
        id: UInt,
        amount: Double,
        comment: String?,
        type: UInt,
        date: String,
        category: DomainCategoryModel?,
        fromAccount: DomainAccountModel,
        toAccount: DomainAccountModel?,
        isDeleted: Bool
    ) {
        self.id = id
        self.amount = amount
        self.comment = comment
        self.type = OperationType(rawValue: type)!
        self.date = date.dateFromString() ?? Date()
        self.category = category
        self.fromAccount = fromAccount
        self.toAccount = toAccount
        self.isDeleted = isDeleted
    }
    
}
