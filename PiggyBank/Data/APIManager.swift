import Foundation

struct APIError: Error { }

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    private let baseURL = "http://piggy-identity.somee.com"
    private let accountsURL = "http://piggy-api.somee.com"
    
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
        guard let url = URL(string: baseURL + "/connect/token") else { return }
        
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
    
    func getAccounts(completion: @escaping (Result<[DomainAccountModel]>) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Accounts") else { return }
        
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
        guard let url = URL(string: accountsURL + "/api/Accounts/\(accountID)") else { return }
        
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
    
    func updateAccount(request: DomainCreateUpdateAccountModel, completion: @escaping (Result<Void>) -> Void) {
        guard let id = request.id else {
            fatalError("APIManager: updateAccount - ID can't be null")
        }
        
        guard let url = URL(string: accountsURL + "/api/Accounts/\(id)") else { return }
        
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
    
    func createAccount(request: DomainCreateUpdateAccountModel, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Accounts") else { return }
        
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
    
    func getCategories(request: APIDTOs.GetCategories.Request, completion: @escaping (APIDTOs.GetCategories.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Categories") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.init(result: .error(APIError())))
            }
            
            if httpResponse.statusCode == 200 {
                guard let model = try? JSONDecoder().decode(Array<CategoryResponse>.self, from: data) else {
                    return completion(.init(result: .error(APIError())))
                }
                
                let accounts = model.map {
                    APIDTOs.GetCategories.Response.Category(
                        id: $0.id, title: $0.title, hexColor: $0.hexColor, type: $0.type, isArchived: false
                    )
                }
                
                completion(.init(result: .success(accounts)))
            } else {
                completion(.init(result: .error(APIError())))
            }
        }.resume()
    }
    
    func createCategory(request: APIDTOs.CreateCategory.Request, completion: @escaping (APIDTOs.CreateCategory.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Categories") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(request)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.init(result: .error(APIError())))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.init(result: .success(())))
            } else {
                completion(.init(result: .error(APIError())))
            }
        }.resume()
    }
    
    func archiveCategory(request: APIDTOs.ArchiveAccount.Request, completion: @escaping (APIDTOs.ArchiveAccount.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Accounts/\(request.id)/Archive") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "PATCH"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.init(result: .error(APIError())))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.init(result: .success(())))
            } else {
                completion(.init(result: .error(APIError())))
            }
        }.resume()
    }
    
    func deleteCategory(request: APIDTOs.DeleteCategory.Request, completion: @escaping (APIDTOs.DeleteCategory.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Categories/\(request.id)") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "DELETE"
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.init(result: .error(APIError())))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.init(result: .success(())))
            } else {
                completion(.init(result: .error(APIError())))
            }
        }.resume()
    }
    
    func changeCategory(request: APIDTOs.ChangeCategory.Request, completion: @escaping (APIDTOs.ChangeCategory.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Accounts/\(request.categoryID)") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "PATCH"
        urlRequst.httpBody = try? JSONEncoder().encode(request)
        urlRequst.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.init(result: .error(APIError())))
            }
            
            if httpResponse.statusCode == 200 {
                completion(.init(result: .success(())))
            } else {
                completion(.init(result: .error(APIError())))
            }
        }.resume()
    }
    
    func getCurrencies(completion: @escaping (Result<[DomainCurrencyModel]>) -> Void) {
        guard let url = URL(string: baseURL + "/users/AvailableCurrencies") else { return }
        
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
    
}
