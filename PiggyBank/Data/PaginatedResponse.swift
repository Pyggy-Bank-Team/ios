import Foundation

final class PaginatedResponse<T>: Codable where T: Codable {
    
    let totalPages: UInt
    let currentPage: UInt
    let countItemsOnPage: UInt?
    let result: [T]
    
}
