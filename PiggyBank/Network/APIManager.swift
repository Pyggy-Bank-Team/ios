import Foundation

struct APIError: Error { }

enum RequestType {
    // Authorization APIs
    case SignUp(SignUp.Request)
    case SignIn(SignIn.Request)
    // Accounts APIs
    case GetAccounts
    case UpdateAccount(Int, CreateUpdateAccount.Request)
    case CreateAccount(CreateUpdateAccount.Request)
    case DeleteAccount(Int)
    // Categories APIs
    case GetCategories
    case CreateCategory(CreateUpdateCategory.Request)
    case UpdateCategory(Int, CreateUpdateCategory.Request)
    case DeleteCategory(Int)
    // Currency APIs
    case GetCurrencies
    // Operations APIs
    case GetOperations
    case DeleteBudgetOperation(UInt)
    case DeleteTransferOperation(UInt)
    case DeletePlanOperation(UInt)
    case CreateTransferOperation(CreateUpdateTransferOperation.Request)
    // Reports APIs
    case GetReportsByCategory(Reports.Request)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

public final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }

    private let baseURL = "https://dev.piggybank.pro"
    private lazy var token = UserDefaults.standard.string(forKey: kCREDENTIALS_STORE_KEY) ?? ""

    func setToken(token: String) {
        self.token = token
    }

    // swiftlint:disable cyclomatic_complexity
    private func getUrlRequst(from requestType: RequestType) -> URLRequest? {
        var urlRequst: URLRequest!
        switch requestType {
        case .SignUp(let requestModel):
            let data = try? JSONEncoder().encode(requestModel)
            urlRequst = prepareRequest(apiUrl: "/api/users", httpMethod: .post, data: data)
        case .SignIn(let requestModel):
            let data = try? JSONEncoder().encode(requestModel)
            urlRequst = prepareRequest(apiUrl: "/api/tokens/connect", httpMethod: .post, data: data)
        case .GetAccounts:
            urlRequst = prepareRequest(apiUrl: "/api/Accounts")
        case let .UpdateAccount(id, requestModel):
            let data = try? JSONEncoder().encode(requestModel)
            urlRequst = prepareRequest(apiUrl: "/api/Accounts/\(id)", httpMethod: .patch, data: data)
        case .CreateAccount(let requestModel):
            let data = try? JSONEncoder().encode(requestModel)
            urlRequst = prepareRequest(apiUrl: "/api/Accounts", httpMethod: .post, data: data)
        case .DeleteAccount(let id):
            urlRequst = prepareRequest(apiUrl: "/api/Accounts/\(id)", httpMethod: .delete)
        case .GetCategories:
            urlRequst = prepareRequest(apiUrl: "/api/Categories")
        case .CreateCategory(let requestModel):
            let data = try? JSONEncoder().encode(requestModel)
            urlRequst = prepareRequest(apiUrl: "/api/Categories", httpMethod: .post, data: data)
        case let .UpdateCategory(id, requestModel):
            let data = try? JSONEncoder().encode(requestModel)
            urlRequst = prepareRequest(apiUrl: "/api/Categories/\(id)", httpMethod: .patch, data: data)
        case .DeleteCategory(let id):
            urlRequst = prepareRequest(apiUrl: "/api/Categories/\(id)", httpMethod: .delete)
        case .GetCurrencies:
            urlRequst = prepareRequest(apiUrl: "/api/Currencies")
        case .GetOperations:
            urlRequst = prepareRequest(apiUrl: "/api/Operations", query: [URLQueryItem(name: "all", value: "true")])
        case .DeleteBudgetOperation(let id):
            urlRequst = prepareRequest(apiUrl: "/api/Operations/Budget/\(id)", httpMethod: .delete)
        case .DeleteTransferOperation(let id):
            urlRequst = prepareRequest(apiUrl: "/api/Operations/Transfer/\(id)", httpMethod: .delete)
        case .DeletePlanOperation(let id):
            urlRequst = prepareRequest(apiUrl: "/api/Operations/Plan/\(id)", httpMethod: .delete)
        case .CreateTransferOperation(let requestModel):
            let data = try? JSONEncoder().encode(requestModel)
            urlRequst = prepareRequest(apiUrl: "/api/Operations/Transfer", httpMethod: .post, data: data)
        case .GetReportsByCategory(let requestModel):
            let data = try? JSONEncoder().encode(requestModel)
            urlRequst = prepareRequest(apiUrl: "/api/Reports/Chart/byCategories", httpMethod: .post, data: data)
        }
        return urlRequst
    }

    private func prepareRequest(
        apiUrl: String,
        httpMethod: HTTPMethod = .get,
        data: Data? = nil,
        query: [URLQueryItem] = []
    ) -> URLRequest? {
        guard var components = URLComponents(string: baseURL + apiUrl) else {
            return nil
        }
        components.queryItems = query
        guard let url = components.url else {
            return nil
        }

        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = httpMethod.rawValue
        if !self.token.isEmpty {
            urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        if let httpBody = data {
            urlRequst.httpBody = httpBody
            urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return urlRequst
    }

    func perform<ResultType: Decodable>(
        request: RequestType,
        completion: @escaping (Result<ResultType>) -> Void
    ) {
        guard let urlRequst = getUrlRequst(from: request) else {
            return completion(.error(APIError()))
        }

        URLSession
            .shared
            .dataTask(with: urlRequst) { data, response, error in
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let responseModel = try? JSONDecoder().decode(ResultType.self, from: data)
                else {
                    return completion(.error(APIError()))
                }
                completion(.success(responseModel))
            }
            .resume()
    }

    func perform(
        request: RequestType,
        completion: @escaping (Result<Void>) -> Void
    ) {
        guard let urlRequst = getUrlRequst(from: request) else {
            return completion(.error(APIError()))
        }

        URLSession
            .shared
            .dataTask(with: urlRequst) { _, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    return completion(.error(APIError()))
                }
                completion(.success(()))
            }
            .resume()
    }
}
