import Foundation


class LoginViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var isValid: Bool = false
    @Published var loginResponseHasError: Bool = false
    
    var loginEndPoint = "user/login"
    
    func validateInputs(email: String, password: String) {
        isValid = false
        
        if email.isEmpty && password.isEmpty {
            errorMessage = "Please enter both fields"
            return
        }
        
        if !isValidEmail(email) {
            errorMessage = "Please enter a valid email."
            return
        }
        
        if password.isEmpty || password.count < 4 {
            errorMessage = "Password must be at least 4 characters."
            return
        }
        
        isValid = true
        
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    
    func LoginVerify(email: String, password: String, completion: @escaping (_ success: Bool) -> ()) {
        print("LoginApiCalled")
        
        let apiEndPoint = "\(Constants.baseUrl)\(loginEndPoint)"
        
        
        guard let url = URL(string: apiEndPoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let postData = Login(email: email, password: password)
        do {
            let jsonData = try JSONEncoder().encode(postData)
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error during request: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid HTTP response or status code")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                let loginResponseHasError = decodedResponse.hasError

                let accessToken = decodedResponse.response.auth?.accessToken
                UserDefaults.standard.set(accessToken, forKey: "LoginAccessToken")
                
                DispatchQueue.main.async {
                    self.loginResponseHasError = loginResponseHasError
                    completion(!loginResponseHasError)
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error decoding JSONs: \(error)")
                    completion(false)
                }
            }
        }.resume()
        
    }
    
}


//replace instead of navigation
