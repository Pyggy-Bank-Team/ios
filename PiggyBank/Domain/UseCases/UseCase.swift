import Foundation

class UseCase<Request, Response> {
    
    func execute(request: Request, completion: @escaping (Response) -> Void) {
        assert(true, "Should be overrided")
    }
    
}
