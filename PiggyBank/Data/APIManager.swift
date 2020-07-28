import Foundation

struct APIError: Error { }

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    private let baseURL = "http://dtrest1-001-site1.itempurl.com"
    private let accountsURL = "http://dtrest-001-site1.etempurl.com"
    
    private var token = ""
    
    func signUp(request: APIDTOs.SignUp.Request, completion: @escaping (APIDTOs.SignUp.Response) -> Void) {
        guard let url = URL(string: baseURL + "/users") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(request)
        urlRequst.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
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
    
    func signIn(request: APIDTOs.SignIn.Request, completion: @escaping (APIDTOs.SignIn.Response) -> Void) {
        guard let url = URL(string: baseURL + "/connect/token") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        
        let params = "client_id=\(request.client_id)&username=\(request.username)&password=\(request.password)&client_secret=\(request.client_secret)&scope=\(request.scope)&grant_type=\(request.grant_type)"
        
        urlRequst.httpBody = params.data(using: .utf8)
        urlRequst.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.init(result: .error(APIError())))
            }
            
            if httpResponse.statusCode == 200 {
                guard let model = try? JSONDecoder().decode(SignInResponse.self, from: data) else {
                    return completion(.init(result: .error(APIError())))
                }
                
                self.token = model.access_token
                
                completion(.init(result: .success(model.access_token)))
            } else {
                completion(.init(result: .error(APIError())))
            }
        }.resume()
    }
    
    func getAccounts(request: APIDTOs.GetAccounts.Request, completion: @escaping (APIDTOs.GetAccounts.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Accounts") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("LOGGER: Start for \(urlRequst.url!)")
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print("LOGGER: Finish for \(urlRequst.url!)")
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return completion(.init(result: .error(APIError())))
            }
            
            if httpResponse.statusCode == 200 {
                guard let model = try? JSONDecoder().decode(Array<AccountResponse>.self, from: data) else {
                    return completion(.init(result: .error(APIError())))
                }
                
                let accounts = model.map {
                    APIDTOs.GetAccounts.Response.Account(
                        id: $0.id, type: $0.type, title: $0.title, currency: $0.currency, balance: $0.balance, isArchived: $0.isArchived
                    )
                }
                
                completion(.init(result: .success(accounts)))
            } else {
                completion(.init(result: .error(APIError())))
            }
        }.resume()
    }
    
    func createAccount(request: APIDTOs.CreateAccount.Request, completion: @escaping (APIDTOs.CreateAccount.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Accounts") else { return }
        
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
    
    func archiveAccount(request: APIDTOs.ArchiveAccount.Request, completion: @escaping (APIDTOs.ArchiveAccount.Response) -> Void) {
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
    
    func deleteAccount(request: APIDTOs.DeleteAccount.Request, completion: @escaping (APIDTOs.DeleteAccount.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Accounts/\(request.id)/Delete") else { return }
        
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
    
    func renameAccount(request: APIDTOs.RenameAccount.Request, completion: @escaping (APIDTOs.RenameAccount.Response) -> Void) {
        guard let url = URL(string: accountsURL + "/api/Accounts/\(request.account.id)/Update") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequst.httpMethod = "PATCH"
        urlRequst.httpBody = try? JSONEncoder().encode(request.account)
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
    
}
