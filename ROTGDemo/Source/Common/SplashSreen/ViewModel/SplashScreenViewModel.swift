import Foundation


class SplashScreenViewModel: ObservableObject {
    
    
    func SaveResponse(_ obj: GenericUserDetail) {
        do {
            let encodedData = try JSONEncoder().encode(obj)
            UserDefaults.standard.set(encodedData, forKey: "UserResponse")
            print("Response saved to UserDefaults")
        } catch {
            print("Failed to encode response for UserDefaults: \(error)")
        }
    }

    
    func postGeneric() {
        print("Splash response called")
        let regsitrationEndPoint = "generic/user-check"
        let apiEndPoint = "\(Constants.baseUrl)\(regsitrationEndPoint)"
        
        guard let url = URL(string: apiEndPoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            let requestData = try encoder.encode(" { uuid: CEB31AF3-C520-4AF9-888F-316165A0030A}")
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
                print("Server error or invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(GenericCheckResponse.self, from: data)
                self.SaveResponse(decodedResponse.response)
            } catch {
                print("Decoding Error: \(error)")
            }
        }
        task.resume()
    }
}
