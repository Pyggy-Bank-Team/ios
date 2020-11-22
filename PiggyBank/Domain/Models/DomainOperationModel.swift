import Foundation

final class DomainOperationModel {
    
    enum OperationType: UInt {
        
        case budget = 1
        case transfer
        case plan
        
    }

    let id: UInt
    let categoryID: Int
    let categoryHexColor: String?
    let amount: Double
    let accountID: UInt
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
        categoryID: Int,
        categoryHexColor: String?,
        amount: Double,
        accountID: UInt,
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
        self.categoryID = categoryID
        self.categoryHexColor = categoryHexColor
        self.amount = amount
        self.accountID = accountID
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
