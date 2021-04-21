import Foundation

enum Paginated {
    struct Response<T>: Codable where T: Codable {
        let totalPages: UInt
        let currentPage: UInt
        let countItemsOnPage: UInt?
        let result: [T]
    }
}
