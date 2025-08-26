import SwiftUI


class RegisterViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var isValid: Bool = false
    @Published var responseDataTempUserId: Int = 0
    @Published var email: String = ""
    @Published var tempUserId: Int = 0
    
    
    var regsitrationEndPoint = "user/registration"
    
    func validateInputs(fullName: String, email: String, password: String, confirmPassword: String) {
        
        if fullName.isEmpty && email.isEmpty && password.isEmpty && confirmPassword.isEmpty {
            errorMessage = "Please enter all fields"
            return
        }
        
        if fullName.isEmpty {
            errorMessage = "Full Name is required."
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
        
        if confirmPassword != password {
            errorMessage = "Passwords doesn't matches "
            return
        }
        
        isValid = true
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    
    func signUp(fullName: String, email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        print("Signup called")
        let user = Register(name: fullName, email: email, profileImage: "", password: password, designation: "Test", company: "Testting")
        let apiEndPoint = "\(Constants.baseUrl)\(regsitrationEndPoint)"
        
        guard let url = URL(string: apiEndPoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            let requestData = try encoder.encode(user)
            
            request.httpBody = requestData
        }
        catch {
            print("Error encoding request body: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
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
                let decoded = try JSONDecoder().decode(RegisterResponse.self, from: data)
                if !decoded.hasError{
                    
                    let tempUserId = decoded.response.tempUserId
                    let email = decoded.response.email
                    
                    DispatchQueue.main.async {
                        self.tempUserId = tempUserId
                        self.email = email
                    }
                    
                    print("TempUserId: \(tempUserId)")
                    print("Email: \(email)")
                    completion(true)
                }
                else {
                    completion(false)
                }
            }
            catch {
                completion(false)
                print("Failed to decode JSON:", error)
            }
        }
        task.resume()
    }
}

