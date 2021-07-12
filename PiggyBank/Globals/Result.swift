import Foundation

public enum Result<T> {
    
    case success(T)
    case error(Error)

    var value: T? {
        switch self {
        case let .success(value):
            return value
        default:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case let .error(error):
            return error
        default:
            return nil
        }
    }
}
