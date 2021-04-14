//
//  ReportsByCategoryResponse.swift
//  PiggyBank
//

struct ReportsByCategoryResponse: Codable {
    let categoryId: Int
    let categoryTitle: String
    let categoryHexColor: String
    let amount: Int
}
