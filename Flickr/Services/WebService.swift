import Foundation

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
    case badRequest
    case unsupportedImage
   
}

struct Resource<T: Codable> {
    let url: URL
}

final class WebService: ServiceProtocol {
    
    public init(){}
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        if resource.url.pathComponents.count == 0 {
            throw NetworkError.badUrl
        }
        request = URLRequest(url: resource.url)
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type":"application/json"]
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
