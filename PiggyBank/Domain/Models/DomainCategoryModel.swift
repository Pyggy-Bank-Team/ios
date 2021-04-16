import Foundation

final class DomainCategoryModel {

    enum CategoryType: Int {
        case undefined
        case income
        case outcome
    }

    let id: Int?
    let title: String
    let hexColor: String
    let type: CategoryType
    let isArchived: Bool
    let isDeleted: Bool
    
    init(id: Int?, title: String, hexColor: String, type: Int, isArchived: Bool, isDeleted: Bool) {
        self.id = id
        self.title = title
        self.hexColor = hexColor
        self.type = CategoryType(rawValue: type) ?? .income
        self.isArchived = isArchived
        self.isDeleted = isDeleted
    }
    
}
