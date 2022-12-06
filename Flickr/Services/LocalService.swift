import UIKit

class LocalService: ServiceProtocol {
    required init() {}
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        guard let path = Bundle.main.path(forResource:"flickr", ofType: "json") else {
            fatalError("Resource file \(resource) not found")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let model = try JSONDecoder().decode(T.self, from: data)
        return model
    }
}
