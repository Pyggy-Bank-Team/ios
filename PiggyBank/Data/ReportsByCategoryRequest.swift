//
//  ReportsByCategoryRequest.swift
//  PiggyBank
//

public struct ReportsByCategoryRequest: Codable {
    let type: Int
    let from: String
    let to: String
}
