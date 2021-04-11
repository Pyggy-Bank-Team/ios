import Foundation

final class DomainOperationModel {
    
    enum OperationType: UInt {
        case undefined
        case budget
        case transfer
        case plan
    }

    let id: UInt
    let categoryHexColor: String?
    let amount: Double
    let accountTitle: String?
    let comment: String?
    let type: OperationType
    let createdOn: Date
    let planDate: Date?
    let fromTitle: String?
    let toTitle: String?
    let isDeleted: Bool
    
    init(
        id: UInt,
        categoryHexColor: String?,
        amount: Double,
        accountTitle: String?,
        comment: String?,
        type: UInt,
        createdOn: String,
        planDate: String?,
        fromTitle: String?,
        toTitle: String?,
        isDeleted: Bool
    ) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        var planDateResult: Date?
        if let plan = planDate, let date = formatter.date(from: plan) {
            planDateResult = date
        }

        self.id = id
        self.categoryHexColor = categoryHexColor
        self.amount = amount
        self.accountTitle = accountTitle
        self.comment = comment
        self.type = OperationType(rawValue: type)!
        self.createdOn = formatter.date(from: createdOn)!
        self.planDate = planDateResult
        self.fromTitle = fromTitle
        self.toTitle = toTitle
        self.isDeleted = isDeleted
    }
    
}
