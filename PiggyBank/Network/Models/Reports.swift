//
//  ReportsByCategoryRequest.swift
//  PiggyBank
//

enum Reports {

    struct Request: Codable {
        let type: Int
        let from: String
        let to: String
    }

    struct Response: Codable {
        let categoryId: Int
        let categoryTitle: String
        let categoryHexColor: String
        let amount: Int
        let currency: String
    }
}
