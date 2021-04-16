import Foundation

final class CategoryViewModel {
    
    enum CategoryType: Int {
        case undefined
        case income
        case outcome
    }
    
    let id: Int
    let title: String
    let hexColor: String
    let type: CategoryType
    let isArchived: Bool
    
    init(id: Int, title: String, hexColor: String, type: CategoryType, isArchived: Bool) {
        self.id = id
        self.title = title
        self.hexColor = hexColor
        self.type = type
        self.isArchived = isArchived
    }
    
}
