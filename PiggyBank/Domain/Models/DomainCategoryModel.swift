import Foundation

final class DomainCategoryModel {

    enum CategoryType: Int {
        
        case income
        case outcome
        
    }
    
    let id: Int
    let title: String
    let hexColor: String
    let type: CategoryType
    let isArchived: Bool
    
    init(id: Int, title: String, hexColor: String, type: Int, isArchived: Bool) {
        self.id = id
        self.title = title
        self.hexColor = hexColor
        self.type = CategoryType(rawValue: type) ?? .income
        self.isArchived = isArchived
    }
    
}
