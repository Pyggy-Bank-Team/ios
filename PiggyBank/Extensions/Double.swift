import Foundation

extension Double {
    
    var formatSign: String {
        self > 0 ? "+\(description)" : description
    }

}
