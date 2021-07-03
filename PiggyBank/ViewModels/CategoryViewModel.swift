import Foundation

public final class CategoryViewModel {
    
    enum CategoryType: Int {
        
        case income = 1
        case outcome = 2
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
