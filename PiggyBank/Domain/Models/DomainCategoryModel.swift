import Foundation

final class DomainCategoryModel {

    enum CategoryType: Int {

        case income = 1
        case outcome = 2

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
    
    // swiftlint:disable discouraged_optional_boolean
    func update(title: String? = nil, hexColor: String? = nil, isArchived: Bool? = nil) -> DomainCategoryModel {
        let newTitle = title ?? self.title
        let newColor = hexColor ?? self.hexColor
        let newArchived = isArchived ?? self.isArchived
        
        return DomainCategoryModel(id: id,
                                   title: newTitle,
                                   hexColor: newColor,
                                   type: type.rawValue,
                                   isArchived: newArchived,
                                   isDeleted: isDeleted)
    }
    
}
