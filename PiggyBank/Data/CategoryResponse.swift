import Foundation

final class CategoryResponse: Codable {
    
    let id: Int
    let title: String
    let hexColor: String
    let type: Int
    let isArchived: Bool
    let isDeleted: Bool
    
}
