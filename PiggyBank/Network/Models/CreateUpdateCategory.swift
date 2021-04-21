import Foundation

enum CreateUpdateCategory {

    struct Request: Codable {

        let title: String
        let hexColor: String
        let type: Int
        let isArchived: Bool
    
        init(title: String, hexColor: String, type: Int, isArchived: Bool) {
            self.title = title
            self.hexColor = hexColor
            self.type = type
            self.isArchived = isArchived
        }
    }
    
}
