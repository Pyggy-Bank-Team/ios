import Foundation

final class OperationResponse: Codable {
    
    let id: UInt
    let categoryID: Int
    let categoryHexColor: String?
    let amount: Double
    let accountID: UInt
    let accountTitle: String?
    let comment: String?
    let type: UInt
    let createdOn: String
    let planDate: String?
    let fromTitle: String?
    let toTitle: String?
    let isDeleted: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case categoryID = "categoryId"
        case categoryHexColor
        case amount
        case accountID = "accountId"
        case accountTitle
        case comment
        case type
        case createdOn
        case planDate
        case fromTitle
        case toTitle
        case isDeleted
        
    }
    
}
