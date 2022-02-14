import Foundation



class ApiService {
    private static var token = "keyHFsqSMPyhxtdOW"
    
    static func call<T: Decodable>(_ returning: T.Type, url: String, completionHandler: @escaping (T?) -> Void, errorHandler: @escaping (ApiError?) -> Void) {
        let url = URL(string: url)
        
        var request = URLRequest(url: url!)
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                errorHandler(ApiError.httpError(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let httpCode: String = String((response as? HTTPURLResponse)?.statusCode ?? 0)
                errorHandler(ApiError.apiError(httpCode, String(bytes: data ?? Data(), encoding: .utf8) ?? ""))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
                    dateFormatter.locale = Locale(identifier: "en_US")
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let decoded = try decoder.decode(T.self, from: data)
                    completionHandler(decoded)
                } catch {
                    errorHandler(ApiError.parseError(error, String(bytes: data, encoding: .utf8) ?? ""))
                }
            }
        })
        
        task.resume()
    }
}
