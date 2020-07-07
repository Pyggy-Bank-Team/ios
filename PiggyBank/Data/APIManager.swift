import Foundation

struct APIError: Error { }

final class APIManager {
    
    private let baseURL = "http://dtrest1-001-site1.itempurl.com"
    
    func signUp(request: APIDTOs.SignUp.Request, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/users") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        urlRequst.httpBody = try? JSONEncoder().encode(request)
        urlRequst.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
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
    
    func getToken(request: APIDTOs.GetToken.Request, completion: @escaping (Result<Void>) -> Void) {
        guard let url = URL(string: baseURL + "/connect/token") else { return }
        
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = "POST"
        
        let params = "client_id=client&username=vasyapupkin&password=qwerty123&client_secret=secret&scope=api1&grant_type=password"
        
        urlRequst.httpBody = params.data(using: .utf8)
        urlRequst.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequst) { data, response, error in
            print(data)
            print(response)
            print(error)
        }.resume()
    }
    
}
