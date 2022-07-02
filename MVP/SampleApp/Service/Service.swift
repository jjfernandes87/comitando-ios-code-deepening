import Foundation

protocol ServiceProtocol {
    func load<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, ServiceError>) -> Void)
    func cancel()
}

final class Service: ServiceProtocol {
    private let session: URLSession
    private var dataTask: URLSessionDataTask?
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func load<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, ServiceError>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/jjfernandes87/comitando-ios-code-deepening/main/MVP/api/\(endpoint.rawValue).json") else {
            DispatchQueue.main.async {
                completion(.failure(ServiceError.invalidURL))
            }
            return
        }
        let request = URLRequest(url: url)

        dataTask = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ServiceError.invalidData))
                }
                return
            }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(ServiceError.decode))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(decodedData))
            }
        })

        dataTask?.resume()
    }

    func cancel() {
        self.dataTask?.cancel()
    }
	
}
