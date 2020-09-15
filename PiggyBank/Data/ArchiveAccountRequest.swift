import Foundation

final class ArchiveAccountRequest: Codable {
    
    let id: Int
    let isArchived: Bool
    
    init(id: Int, isArchived: Bool) {
        self.id = id
        self.isArchived = isArchived
    }
    
}
