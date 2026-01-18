//import Foundation
//
//// ======================
//// MARK: - MODELS
//// ======================
//
//// ======================
//// MARK: - API SERVICE
//// ======================
//final class APIService {
//    static let shared = APIService()
//    private init() {}
//
//    private let baseURL = "http://localhost:5000/api"
//
//    private let decoder: JSONDecoder = {
//        let d = JSONDecoder()
//        d.dateDecodingStrategy = .iso8601
//        return d
//    }()
//
//    func get<T: Codable>(_ path: String, completion: @escaping (T) -> Void) {
//        let url = URL(string: baseURL + path)!
//        URLSession.shared.dataTask(with: url) { data, _, _ in
//            if let data = data,
//               let result = try? self.decoder.decode(T.self, from: data) {
//                DispatchQueue.main.async { completion(result) }
//            }
//        }.resume()
//    }
//
//    func post<T: Codable, U: Codable>(_ path: String, body: T, completion: @escaping (U) -> Void) {
//        let url = URL(string: baseURL + path)!
//        var req = URLRequest(url: url)
//        req.httpMethod = "POST"
//        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        req.httpBody = try? JSONEncoder().encode(body)
//
//        URLSession.shared.dataTask(with: req) { data, _, _ in
//            if let data = data,
//               let result = try? self.decoder.decode(U.self, from: data) {
//                DispatchQueue.main.async { completion(result) }
//            }
//        }.resume()
//    }
//}
