import Foundation


class OtpViewModel: ObservableObject {
    
    @Published var otp: String = ""
    @Published var tempUserId: Int
    @Published var email: String
    @Published var otpResponseHasError: Bool = false
    
    var emailVerifyEndPoint = "user/email-verify"
    
    init(tempUserId: Int, email: String) {
        self.tempUserId = tempUserId
        self.email = email
    }

    
    func otpSubmit(completion: @escaping (_ success: Bool) -> ()) {
        print("otpSubmit called")
        
        let apiEndPoint = "\(Constants.baseUrl)\(emailVerifyEndPoint)"
        let otp = Otp(tempUserId: self.tempUserId, email: self.email, otp: self.otp)
        
        guard let url = URL(string: apiEndPoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            let requestData = try encoder.encode(otp)
            request.httpBody = requestData
        } catch {
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
                let decodedResponse = try JSONDecoder().decode(OtpResponse.self, from: data)
                let otpResponseHasError = decodedResponse.hasError
                
                let accessToken = decodedResponse.response.auth?.accessToken
                UserDefaults.standard.set(accessToken, forKey: "OtpAccessToken")
                
                DispatchQueue.main.async {
                    self.otpResponseHasError = otpResponseHasError
                    completion(!otpResponseHasError)
                }
            } catch {
                print("Failed to decode JSONs:", error)
                completion(false)
            }
        }
        task.resume()
    }
}
