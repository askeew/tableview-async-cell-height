import Foundation

class NetworkManager {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func loadData(from request: URLRequest, completionHandler: @escaping (Data?) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if error != nil { completionHandler(nil); return }
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else { completionHandler(nil); return }
            if httpResponse.statusCode == 204 {completionHandler(nil); return }
            guard let data = data else { completionHandler(nil); return }
            completionHandler(data)
            }.resume()
    }
}
