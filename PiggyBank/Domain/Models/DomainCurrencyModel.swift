import Foundation

final class DomainCurrencyModel: Codable {

    let code: String
    let symbol: String
    
    init(code: String, symbol: String) {
        self.code = code
        self.symbol = symbol
    }
    
}
