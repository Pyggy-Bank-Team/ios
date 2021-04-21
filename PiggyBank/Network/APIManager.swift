import Foundation

struct APIError: Error { }

public final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    let baseURL = "https://dev.piggybank.pro"
    
    private(set) lazy var token = UserDefaults.standard.string(forKey: kCREDENTIALS_STORE_KEY) ?? ""

    func setToken(token: String) {
        self.token = token
    }

    // MARK: - Operations

    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Operations/Budget/\(operationID)") else {
            return
        }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { _, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }
                
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }

    func createTransferOperation(request: DomainCreateUpdateTransferOperationModel, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Operations/Transfer") else {
            return
        }

        let requestModel = GrandConverter.convertToRequestModel(domain: request)

        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")

        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { _, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")

                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }

                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }
    
    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Operations/Transfer/\(operationID)") else {
            return
        }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { _, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }
                
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }
    
    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Operations/Plan/\(operationID)") else {
            return
        }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { _, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }
                
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }

    func getReportsByCategory(
        category: DomainCategoryModel.CategoryType,
        from: Date,
        to: Date,
        completion: @escaping (Result<[DomainCategoryReportModel]>) -> Void
    ) {
        guard let url = URL(string: baseURL + "/api/Reports/Chart/byCategories") else {
            return
        }

        let requestModel = GrandConverter.convertToRequestModel(category: category, fromDate: from, toDate: to)
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")

        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession
            .shared
            .dataTask(with: urlRequst) { data, response, error in
                print("LOGGER: Finish for \(urlRequst.url!)")

                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    return completion(.error(APIError()))
                }
                do {
                    let model = try JSONDecoder().decode([Reports.Response].self, from: data)
                    let operations = model.map { GrandConverter.convertToDomain(response: $0) }
                    completion(.success(operations))
                } catch {
                    print("decode error: \(error)")
                    assertionFailure("getReportsByCategory decode error")
                    return completion(.error(APIError()))
                }
            }
            .resume()
    }
}

extension APIManager: SignInDataSource {
    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        guard let url = URL(string: baseURL + "/api/tokens/connect") else {
            return
        }

        let requestModel = GrandConverter.convertToRequestModel(domain: request)

        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession
            .shared
            .dataTask(with: urlRequst) { data, response, error in
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    return completion(.error(APIError()))
                }

                if httpResponse.statusCode == 200 {
                    guard let response = try? JSONDecoder().decode(UserCredentials.Response.self, from: data) else {
                        return completion(.error(APIError()))
                    }

                    let authModel = GrandConverter.convertToDomainModel(authResponse: response)

                    self.token = authModel.accessToken

                    completion(.success(authModel))
                } else {
                    completion(.error(APIError()))
                }
            }
            .resume()
    }
}
