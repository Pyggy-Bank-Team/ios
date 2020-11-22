import Foundation

struct APIError: Error { }

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    private let baseURL = "https://dev.piggybank.pro"
    //private let accountsURL = "http://piggy-api.somee.com"
    
    private var token = ""
    
    func signUp(request: DomainSignUpModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        guard let url = URL(string: baseURL + "/users") else { return }
        
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                guard let response = try? JSONDecoder().decode(UserCredentialsResponse.self, from: data) else {
                    return completion(.error(APIError()))
                }
                
                let authModel = GrandConverter.convertToDomainModel(authResponse: response)
                
                completion(.success((authModel)))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        guard let url = URL(string: baseURL + "/api/tokens/connect") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        
        var params = ""
        params += "client_id=client"
        params += "&username=\(request.nickname)"
        params += "&password=\(request.password)"
        params += "&client_secret=secret"
        params += "&scope=api1 offline_access"
        params += "&grant_type=password"
        
        urlRequst.httpBody = params.data(using: .utf8)
        urlRequst.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                guard let response = try? JSONDecoder().decode(UserCredentialsResponse.self, from: data) else {
                    return completion(.error(APIError()))
                }
                
                let authModel = GrandConverter.convertToDomainModel(authResponse: response)
                
                self.token = authModel.accessToken
                
                completion(.success(authModel))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    // MARK: - Accounts
    
    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Accounts") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                guard let model = try? JSONDecoder().decode(Array<AccountResponse>.self, from: data) else {
                    return completion(.error(APIError()))
                }
                
                let accounts = model.map { GrandConverter.convertToDomain(response: $0) }
                completion(.success(accounts))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func deleteAccount(accountID: Int, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Accounts/\(accountID)") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func updateAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        guard let id = request.id else {
            fatalError("APIManager: updateAccount - ID can't be null")
        }
        
        guard let url = URL(string: baseURL + "/api/Accounts/\(id)") else { return }
        
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "PATCH"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func createAccount(request: DomainAccountModel, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Accounts") else { return }
        
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    // MARK: - Categories
    
    func getCategories(completion: @escaping (Result<[DomainCategoryModel]>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Categories") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                guard let model = try? JSONDecoder().decode(Array<CategoryResponse>.self, from: data) else {
                    return completion(.error(APIError()))
                }
                
                let categories = model.map { GrandConverter.convertToDomain(response: $0) }
                
                completion(.success(categories))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func createCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Categories") else { return }
        
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func updateCategory(request: DomainCategoryModel, completion: @escaping (Result<Void>) -> Void) {
        guard let id = request.id else {
            fatalError("APIManager: updateCategory - ID can't be null")
        }
        
        guard let url = URL(string: baseURL + "/api/Categories/\(id)") else { return }
        
        let requestModel = GrandConverter.convertToRequestModel(domain: request)
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "PATCH"
        urlRequst.httpBody = try? JSONEncoder().encode(requestModel)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func deleteCategory(categoryID: Int, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Categories/\(categoryID)") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    // MARK: - Currencies
    
    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Currencies") else { return }
        
        let urlRequst = URLRequest(url: url)
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                guard let models = try? JSONDecoder().decode(Array<CurrencyResponse>.self, from: data) else {
                    return completion(.error(APIError()))
                }
                
                let domainCurrencies = models.map { GrandConverter.convertToDomainModel(currencyResponse: $0) }
                
                completion(.success(domainCurrencies))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    // MARK: - Operations
    
    func getOperations(completion: @escaping (Result<[DomainOperationModel]>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Operations") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                guard let model = try? JSONDecoder().decode(PaginatedResponse<OperationResponse>.self, from: data) else {
                    return completion(.error(APIError()))
                }
                
                let categories = model.result.map { GrandConverter.convertToDomain(response: $0) }
                completion(.success(categories))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func deleteBudgetOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Operations/Budget/\(operationID)") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func deleteTransferOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Operations/Transfer/\(operationID)") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
    func deletePlanOperation(operationID: UInt, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/api/Operations/Plan/\(operationID)") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.error(APIError()))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.error(APIError()))
            }
        }.resume()
    }
    
}
